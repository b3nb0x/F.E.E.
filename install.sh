#!/bin/sh
# F.E.E. – Fully Examine Everything | Installer
# Läuft mit sh und bash auf allen gängigen Distributionen (Ubuntu, Mint, Debian,
# Fedora, RHEL, Arch, Manjaro, openSUSE, Nobara ...).
#
# Installation:  curl -fsSL https://raw.githubusercontent.com/b3nb0x/F.E.E.---Fully-Examine-Everything/main/install.sh | sh
# Alternativ:    sh install.sh [--optionen]
#
# Optionen:
#   --agent <hermes|claude|vibe|codex|cursor|all>   Ziel-Agent (Standard: alle erkannten)
#   --deps          OCR-/Dokumenten-Werkzeuge installieren (tesseract, poppler, libreoffice)
#   --mandate-dir <pfad>   Basisordner für Mandate (Standard: ~/FEE-Mandate)
#   --update        Bestehende Installation aktualisieren
#   --uninstall     F.E.E. entfernen
#   --list-agents   Nur erkannte Agenten anzeigen
#   -h | --help     Diese Hilfe

set -eu

REPO_URL="https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything"
BRANCH="${FEE_BRANCH:-main}"
TMPDIR_FEE="$(mktemp -d)"
MANDATE_DIR="${FEE_MANDATE_DIR:-$HOME/FEE-Mandate}"
ACTION="install"
WANT_AGENT=""
INSTALL_DEPS=0

# ---------------------------------------------------------------- Erkennung

detect_distro() {
    # /etc/os-release ist der Standard auf allen modernen Distributionen
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO_ID="${ID:-unknown}"
        DISTRO_LIKE="${ID_LIKE:-}"
        DISTRO_PRETTY="${PRETTY_NAME:-unbekannt}"
    else
        DISTRO_ID="unknown"; DISTRO_LIKE=""; DISTRO_PRETTY="unbekannt"
    fi
}

pkg_manager() {
    case "$DISTRO_ID $DISTRO_LIKE" in
        *debian*|*ubuntu*|*mint*|*pop*|*nobara*) echo "apt" ;;
        *fedora*|*rhel*|*centos*)                echo "dnf" ;;
        *suse*)                                  echo "zypper" ;;
        *arch*|*manjaro*)                        echo "pacman" ;;
        *)                                       echo "" ;;
    esac
}

install_deps() {
    PM="$(pkg_manager)"
    echo ">> OCR-/Dokumenten-Werkzeuge installieren (Distro: $DISTRO_PRETTY)"
    case "$PM" in
        apt)
            sudo apt-get update &&
            sudo apt-get install -y git tesseract-ocr tesseract-ocr-deu poppler-utils libreoffice catdoc ;;
        dnf)
            sudo dnf install -y git tesseract tesseract-langpack-deu poppler-utils libreoffice-office catdoc ;;
        zypper)
            sudo zypper install -y git tesseract tesseract-ocr-langpack-deu poppler-tools libreoffice catdoc ;;
        pacman)
            sudo pacman -S --needed --noconfirm git tesseract tesseract-data-deu poppler libreoffice-fresh catdoc ;;
        "")
            echo "!! Paketmanager nicht erkannt. Bitte manuell installieren:"
            echo "   git, tesseract (+ deutsche Sprache), poppler-utils/pdftotext, libreoffice" ;;
    esac
}

detect_agents() {
    FOUND=""
    command -v hermes >/dev/null 2>&1 || [ -d "$HOME/.hermes" ] && FOUND="$FOUND hermes"
    [ -d "$HOME/.claude" ] && FOUND="$FOUND claude"
    [ -d "$HOME/.vibe" ]   && FOUND="$FOUND vibe"
    [ -d "$HOME/.codex" ]  && FOUND="$FOUND codex"
    [ -d "$HOME/.cursor" ] && FOUND="$FOUND cursor"
    # sh-sicher: found-liste normalisieren
    FOUND="$(echo "$FOUND" | tr -s ' ')"
}

agent_dest() {
    case "$1" in
        hermes) echo "$HOME/.hermes/skills/fee" ;;
        claude) echo "$HOME/.claude/plugins/fee" ;;
        vibe)   echo "$HOME/.vibe/skills/fee" ;;
        codex)  echo "$HOME/.codex/skills/fee" ;;
        cursor) echo "$HOME/.cursor/skills/fee" ;;
    esac
}

# ---------------------------------------------------------------- Download

fetch_repo() {
    echo ">> Lade F.E.E. herunter ($BRANCH) ..."
    if command -v git >/dev/null 2>&1; then
        git clone --depth 1 -b "$BRANCH" "$REPO_URL" "$TMPDIR_FEE/repo"
    elif command -v curl >/dev/null 2>&1; then
        mkdir -p "$TMPDIR_FEE/repo"
        curl -fsSL "https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything/archive/$BRANCH.tar.gz" \
            | tar -xz --strip-components=1 -C "$TMPDIR_FEE/repo"
    else
        echo "!! Weder git noch curl gefunden. Bitte installieren (git oder curl)." >&2
        exit 1
    fi
}

# ---------------------------------------------------------------- Installation

install_to_agent() {
    AGENT="$1"
    DEST="$(agent_dest "$AGENT")"
    echo ">> Installiere für Agent: $AGENT -> $DEST"
    mkdir -p "$(dirname "$DEST")"
    rm -rf "$DEST"
    cp -r "$TMPDIR_FEE/repo" "$DEST"
    rm -rf "$DEST/.git"
    # Mandats-Basisordner anlegen (pro Agent identisch, zentral konfigurierbar)
    mkdir -p "$MANDATE_DIR"
    printf 'mandate_dir=%s\n' "$MANDATE_DIR" > "$DEST/.fee-config"
}

setup_mandate_base() {
    mkdir -p "$MANDATE_DIR"
    echo ">> Mandaten-Basisordner: $MANDATE_DIR"
    if [ ! -f "$MANDATE_DIR/README.txt" ]; then
        cat > "$MANDATE_DIR/README.txt" <<'EOF'
F.E.E. Mandate – pro Mandat ein Ordner:
  JJJJ-MM-TT_<MANDATS-ID>_<ANZEIGENAME>/
  z. B. 2026-11-06_M-001_Herr_Mustermann/
      MANDAT.md   – Memory des Mandats (Vorlage: plugin memory/mmandate/vorlage-mandat.md)
      fristen.md  – Fristen des Mandats
      eingang/    – hochgeladene Original-Dokumente
      dokumente/  – OCR-verarbeitete Volltexte (Skill 16)
      notizen/    – Arbeitsnotizen
      1_<Rechtsgebiet>/ ... – Sachgebiete des Mandats
Fälle zusammenführen: Skill 14 (mandatsverwaltung) – Abschnitt "Mandate zusammenführen".
EOF
    fi
}

do_install() {
    fetch_repo
    if [ "$WANT_AGENT" = "all" ]; then
        TARGETS="hermes claude vibe codex cursor"
    elif [ -n "$WANT_AGENT" ]; then
        TARGETS="$WANT_AGENT"
    else
        TARGETS="$FOUND"
        if [ -z "$TARGETS" ]; then
            echo "!! Kein Agent erkannt (Hermes, Claude Code, Vibe, Codex, Cursor)."
            echo "   Installation mit: sh install.sh --agent <name>"
            exit 1
        fi
    fi
    for A in $TARGETS; do
        install_to_agent "$A"
    done
    setup_mandate_base
    echo ""
    echo "F.E.E. installiert. Nächste Schritte:"
    echo "  1. Agent neu starten, dann:  /fee <frage>"
    echo "  2. Erstes Mandat anlegen:    /mandant neu <slug>"
    echo "  3. Mandaten-Ordner:          $MANDATE_DIR"
    [ "$INSTALL_DEPS" = "1" ] && install_deps
}

do_update() {
    fetch_repo
    for A in hermes claude vibe codex cursor; do
        DEST="$(agent_dest "$A")"
        if [ -d "$DEST" ]; then
            echo ">> Aktualisiere $DEST"
            rm -rf "$DEST"
            cp -r "$TMPDIR_FEE/repo" "$DEST"
            rm -rf "$DEST/.git"
        fi
    done
    echo ">> Update fertig."
}

do_uninstall() {
    for A in hermes claude vibe codex cursor; do
        DEST="$(agent_dest "$A")"
        if [ -d "$DEST" ]; then
            echo ">> Entferne $DEST"
            rm -rf "$DEST"
        fi
    done
    echo ">> F.E.E. entfernt. Mandaten-Ordner ($MANDATE_DIR) bleibt unangetastet."
}

# ---------------------------------------------------------------- Argumente

while [ $# -gt 0 ]; do
    case "$1" in
        --agent)       WANT_AGENT="$2"; shift 2 ;;
        --agent=*)     WANTAGENT="${1#*=}"; WANT_AGENT="$WANTAGENT"; shift ;;
        --deps)        INSTALL_DEPS=1; shift ;;
        --mandate-dir) MANDATE_DIR="$2"; shift 2 ;;
        --update)      ACTION="update"; shift ;;
        --uninstall)   ACTION="uninstall"; shift ;;
        --list-agents) ACTION="list"; shift ;;
        -h|--help)     sed -n '2,15p' "$0"; exit 0 ;;
        *) echo "Unbekannte Option: $1 (siehe --help)" >&2; exit 1 ;;
    esac
done

detect_distro
detect_agents

echo "F.E.E. – Fully Examine Everything"
echo "Distro : $DISTRO_PRETTY"
echo "Agenten: ${FOUND:-keine erkannt}"
echo ""

case "$ACTION" in
    install)   do_install ;;
    update)    do_update ;;
    uninstall) do_uninstall ;;
    list)      echo "Erkannte Agenten: ${FOUND:-keine}" ;;
esac

rm -rf "$TMPDIR_FEE"
