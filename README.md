# F.E.E. – Fully Examine Everything

<p align="center">
  <img src="assets/banner.png" alt="F.E.E. – Paragraph gegen Richterhammer im epischen Showdown" width="720">
</p>

**F.E.E. ist ein Rechts-Addon für KI-Agenten** – spezialisiert auf deutsches Recht: Gesetze, Rechtsprechung (u. a. BGH), Verfahrensarten, Vorabberatung, Mandatsverwaltung und Dokumentenverarbeitung.

> ⚠️ **Wichtiger Hinweis:** F.E.E. ist ein Recherche- und Analyse-Werkzeug. Es ersetzt **keine Rechtsberatung** im Sinne des RDG. Alle Ausgaben sind unverbindliche Informationen und Orientierung – keine verbindliche Rechtsauskunft. Jede Antwort des Agenten endet deshalb mit einem entsprechenden Hinweis.

---

## 🤔 Für Einsteiger: Was ist das überhaupt?

| Begriff | Einfach erklärt |
|---|---|
| **KI-Agent** | Ein Chat-Programm mit Fähigkeiten über das reine Schreiben hinaus – es kann im Internet recherchieren, Dateien lesen und Befehle ausführen. Beispiele: **Hermes**, **Claude Code**, **Codex**, **Vibe**. |
| **Skill** | Eine Anleitung (Markdown-Datei), die dem Agenten beibringt, **wie** er eine bestimmte Aufgabe löst – z. B. „wie recherchiere ich ein BGH-Urteil korrekt". |
| **Plugin / Addon** | Ein installierbares Paket, das dem Agenten neue Fähigkeiten (Skills, Befehle) hinzufügt. **F.E.E. ist genau das: ein Rechts-Plugin.** |
| **Mandat** | Ein einzelner Fall/Auftrag (z. B. „Kündigungsschutzklage Herr Mustermann"). F.E.E. verwaltet mehrere Mandate getrennt – wie Aktenordner in einer Kanzlei. |

**Konkret gesagt:** Du installierst F.E.E. einmal in deinen Agenten – und ab dann kannst du den Agenten fragen: *„Wie ist die Kündigungsfrist bei meiner Wohnung?"* oder *„Analysiere diese Kündigung!"* – und er antwortet wie ein gut vorbereiteter juristischer Assistent: mit Gesetzeszitaten, Urteilen, Fristen-Warnungen und klaren nächsten Schritten.

---

## 🚀 Installation (Ein Befehl)

Öffne ein Terminal und führe aus:

```bash
curl -fsSL https://raw.githubusercontent.com/b3nb0x/F.E.E.---Fully-Examine-Everything/main/install.sh | sh
```

**Das macht der Installer automatisch:**

1. **Erkennt dein Betriebssystem** (Ubuntu, Mint, Debian, Fedora, Nobara, Arch, openSUSE …) und passt die Befehle an
2. **Erkennt deine Agenten** (Hermes, Claude Code, Vibe, Codex, Cursor) und installiert F.E.E. in alle gefundenen
3. **Legt deinen Mandanten-Ordner an** (Standard: `~/FEE-Mandate` – dort landen später deine Fälle)

**Kein Agent installiert?** Kein Problem – der Installer fragt dich, welchen du möchtest, und installiert ihn mit:

```
>> Kein Agent gefunden. Welchen möchtest du installieren?
   1) Hermes Agent (Nous Research)
   2) Claude Code (Anthropic)
   3) Codex CLI (OpenAI)
   4) Mistral Vibe Code
   5) Cursor (Desktop-App)
 Auswahl [1-5]:
```

**Alle Installer-Optionen:**

| Befehl | Wirkung |
|---|---|
| `sh install.sh` | Normal: erkannte Agenten + Mandaten-Ordner |
| `sh install.sh --deps` | Zusätzlich OCR-Werkzeuge (tesseract, poppler, LibreOffice) installieren – **nötig für die Dokumentenverarbeitung** |
| `sh install.sh --agent hermes` | Nur für einen bestimmten Agenten installieren |
| `sh install.sh --install-agent claude` | Diesen Agenten installieren + F.E.E. einrichten |
| `sh install.sh --mandate-dir /pfad` | Anderen Ordner für deine Fälle festlegen |
| `sh install.sh --update` | F.E.E. auf die neueste Version bringen |
| `sh install.sh --uninstall` | F.E.E. entfernen (deine Fälle bleiben unangetastet) |
| `sh install.sh --list-agents` | Nur zeigen, welche Agenten erkannt wurden |

> 💡 **Nach der Installation:** Agenten neu starten (Terminal zu und wieder auf), damit die neuen Skills geladen werden.

---

## 📁 Deine Fälle: der Mandanten-Ordner

Jeder Fall bekommt seinen eigenen Ordner – wie eine physische Akte. Der Name besteht aus **Erstellungsdatum + Mandats-ID + Anzeigename**:

```
~/FEE-Mandate/
└── 2026-11-06_M-001_Herr_Mustermann/
    ├── MANDAT.md          ← das "Gedächtnis" des Falls (Sachverhalt, Beteiligte, Stand)
    ├── fristen.md         ← alle Fristen dieses Falls (⚠️ immer anwaltlich verifizieren)
    ├── eingang/           ← deine Original-Dokumente (Kündigung, Vertrag, …) – bleiben unverändert
    ├── dokumente/         ← durchsuchbare Textversionen (automatisch per OCR erzeugt)
    ├── notizen/           ← Arbeitsnotizen des Agenten
    ├── 1_Mietrecht/       ← Rechtsgebiet 1
    └── 2_Arbeitsrecht/    ← Rechtsgebiet 2
        └── 2.2_Kuendigungsschutzklage/
```

**Warum mit Name im Ordnernamen?** Die Daten liegen nur auf deinem Rechner/Server – sichtbar nur für jemanden mit Zugriff (DSGVO-konform). So findest du jeden Fall sofort, ohne eine separate ID-Datenbank pflegen zu müssen.

**Dokumente einbringen:** Lade sie einfach im Agenten hoch und sag z. B. *„Diese Kündigung zu Mandat M-001"*. Der Agent legt das Original in `eingang/` ab und erzeugt eine durchsuchbare Textfassung in `dokumente/` (PDFs – auch gescannte via OCR –, Word, Excel, LibreOffice, Bilder).

**Mehrere Fälle zusammenlegen?** Drei getrennte Fälle desselben Mandanten können zu einem zusammengeführt werden: `/mandant merge <ziel> <quelle1> <quelle2>` – Gedächtnis, Fristen und Ordner werden sauber vereint, nichts geht verloren.

---

## 💬 So benutzt du F.E.E.

**Der einfachste Weg – `/fee`:** Schreib einfach deine Frage, der Agent wählt selbst den richtigen Ablauf:

```
/fee Mein Vermieter hat gekündigt, ich bin seit 9 Jahren in der Wohnung – gilt die 9-Monats-Frist?
```

**Die Spezial-Befehle** (falls du einen Weg direkt erzwingen willst):

| Befehl | Beispiel | Was passiert |
|---|---|---|
| `/fee <anliegen>` | `/fee Frage zur Kündigungsfrist` | Universeller Einstieg – wählt automatisch den passenden Ablauf |
| `/recht <frage>` | `/recht Kündigungsfrist Wohnung § 573c BGB` | Sucht das Gesetz mit Fundstelle und aktueller Fassung |
| `/urteil <was>` | `/urteil BGH VIII ZR 286/22` | Findet und analysiert das Urteil (Aktenzeichen, Leitsatz, Bedeutung) |
| `/verfahren <lage>` | `/verfahren Nachbar will Schadensersatz wegen Baumschnitts` | Welches Gericht ist zuständig? Ablauf, Fristen, Kostenrisiko |
| `/vorabcheck <fall>` | `/vorabcheck Arbeitgeber zahlt Überstunden nicht, seit 3 Monaten` | Strukturierte Ersteinschätzung im Gutachtenstil |
| `/mandant …` | `/mandant neu` oder `/mandant fristen` | Fälle anlegen, wechseln, alle Fristen überblicken, zusammenführen |

**Was du in jeder Antwort erwarten kannst:**

1. Eine Klartext-Zusammenfassung
2. Konkrete Gesetze (`§ 573c Abs. 1 BGB`) und – wo vorhanden – Urteile mit Aktenzeichen
3. Ehrliche Risiken und offene Fragen (nicht nur „das wird klappen")
4. Konkrete nächste Schritte mit Fristen-Hinweis
5. **Am Ende immer:** der Hinweis, dass es keine anwaltliche Beratung ersetzt

---

## 📚 Was F.E.E. kann (die 17 Skills im Überblick)

**Recht (Kern):**
- **Grundwissen & Master-Workflow** – Wirtschafts-, Straf-, Arbeits- und Sozialrecht systematisch
- **Gesetze recherchieren** – amtliche Quellen (gesetze-im-internet.de), zitierfähig mit Stand
- **Rechtsprechung** – BGH, BVerwG, BFH, BAG, BSG, BVerfG, EuGH; nur verifizierte Aktenzeichen
- **Verfahren** – Rechtsweg, zuständiges Gericht, Fristen, Kosten, Alternativen
- **Vorabberatung** – Ersteinschätzung im Gutachtenstil
- **Vertragsprüfung** – AGB-Kontrolle (§§ 305 ff. BGB), Klausel-Bewertung
- **Urteilsanalyse** – Tenor, Leitsätze, tragende Gründe, Einordnung

**Organisation:**
- **Mandatsverwaltung** – mehrere Fälle getrennt, Fristen über alle Fälle hinweg, Zusammenführen
- **Dokumentenverarbeitung** – OCR für PDFs/Scans/Word/Excel/Bilder, Ablage im Fall-Ordner
- **Projektcharts** – Zeitlinien und Fristen-Diagramme
- **Bibliothek-Index** – durchsuchbares Verzeichnis aller Dokumente

**Recherche (OSINT):**
- **Leak-Prüfung** – sind deine eigenen Daten in Datenlecks? (nur eigene, passiv, Clearnet)
- **Name-Recherche** – Personen/Firmen mit 2-Quellen-Verifikation
- **Mail-Erreichbarkeit** – kann eine Domain E-Mails empfangen/versenden? (passiv via DNS)
- **Website-Recon** – Domain-Analyse (Whois, DNS, SSL) mit Bericht
- **Corporate Nexus** – Unternehmensverflechtungen (Handelsregister DE + 8 weitere Länder)

---

## 🛠️ Installation ohne Installer (manuell)

Falls du lieber von Hand installierst:

**Hermes:**
```bash
git clone https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git ~/.hermes/skills/fee
```

**Claude Code:**
```bash
git clone https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git ~/.claude/plugins/fee
```

**llama.cpp / lokale Modelle:** llama.cpp hat kein Plugin-System, aber einen OpenAI-kompatiblen Server. Kombiniere ihn mit Hermes, um F.E.E. auf deinem eigenen, lokalen Modell zu nutzen:

```bash
./llama-server -m <modell>.gguf --port 8080     # 1. llama.cpp-Server starten
hermes model                                      # 2. Endpoint http://localhost:8080/v1 einrichten
# 3. F.E.E. wie oben installieren
```

**Codex / Cursor / OpenCode / generisch:**
```bash
git clone https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git ~/fee
# AGENTS.md in dein Projekt kopieren oder referenzieren
```

---

## 🔍 Das Quellen-Prinzip (warum F.E.E. zuverlässig antwortet)

F.E.E. zwingt den Agenten, **amtliche Quellen zu prüfen**, statt aus dem Gedächtnis zu raten:

| Rang | Quelle | Zweck |
|---|---|---|
| 1 | `gesetze-im-internet.de` (Bundesjustizministerium) | amtlicher, aktueller Gesetzestext |
| 2 | Buzer, dejure.org | Normenkontext, Änderungshistorie |
| 3 | `bundesgerichtshof.de` | amtliche BGH-Entscheidungen |
| 4 | BVerwG, BFH, BAG, BSG, BVerfG | je nach Gerichtsbarkeit |
| 5 | EUR-Lex / curia.europa.eu | EU-Recht, EuGH |
| 6 | openjur, dejure-Dokumente | Auffindbarkeit von Aktenzeichen |

**Feste Sicherheitsregeln („Instincts"), die immer gelten:**
- Keine Aussage ohne Gesetzes- oder Urkunden-Fundstelle
- Keine erfundenen Aktenzeichen – Unverifizierbares wird als solches gekennzeichnet
- Fristen niemals als „sicher" – immer mit Warnhinweis, verbindliche Berechnung nur anwaltlich
- Mandatstrennung: Informationen aus einem Fall fließen nie in einen anderen
- Jede Antwort endet mit dem Haftungshinweis

---

## 📂 Repo-Struktur (für Entwickler)

```
F.E.E.
├── install.sh            # 1-Befehl-Installer (Distro- & Agent-Erkennung)
├── AGENTS.md             # zentrale Agenten-Verhaltensregeln
├── plugin.json           # Plugin-Manifest (17 Skills)
├── commands/             # Slash-Commands (/fee, /recht, /urteil, /verfahren, /vorabcheck, /mandant)
├── skills/               # 17 Skills (00–16)
├── knowledge/            # Referenz: Rechtsquellen, Verfahrensübersicht, Zitierweise
├── memory/               # Memory-Vorlagen, Instincts, Mandats-Registry
└── security/             # Grenzen der Rechtsdienstleistung, Haftungshinweis-System
```

## Lizenz

MIT
