# F.E.E. – Fully Examine Everything

Rechts-Addon (Plugin) für KI-Agenten – inspiriert von [ECC](https://github.com/affaan-m/ECC), spezialisiert auf **deutsches Recht**: Gesetze, Rechtsprechung (u. a. BGH), Verfahrensarten und Vorabberatung.

> ⚠️ **Wichtiger Hinweis:** F.E.E. ist ein Recherche- und Analyse-Werkzeug. Es ersetzt keine Rechtsberatung im Sinne des RDG. Alle Ausgaben sind unverbindliche Informationen und Orientierung – keine verbindliche Rechtsauskunft.

## Was F.E.E. mitbringt

- **Skills** (Recherche-Ablaufpläne für den Agenten)
  - `01-gesetze-recherche` – Gesetze und Normen auffinden und zitierfähig aufbereiten (BGB, StGB, SGB, AO u. v. m.)
  - `02-rechtsprechung` – Rechtsprechung recherchieren: BGH, BVerfG, BVerwG, BFH, BAG, BSG, EuGH, OLGs/LGs
  - `03-verfahren` – Verfahrensarten und -abläufe: ZPO, StPO, VwGO, SGG, FGO, FamFG, Instanzenzüge, Fristen
  - `04-vorabberatung` – strukturierte Vorab-Einschätzung mit Pflicht-Haftungshinweis
  - `05-vertragspruefung` – Verträge und Klauseln systematisch prüfen (AGB-Kontrolle, §§ 305 ff. BGB)
  - `06-urteilsanalyse` – Urteile systematisch auswerten (Tenor, Leitsatz, tragende Gründe)
  - `07-projektcharts` – Verfahrens- und Fristen-Charts (Tabellen, Mermaid, Zeitlinien) erstellen
  - `08-index-bibliothek` – durchsuchbare Index-Bibliothek aller Normen, Urteile und Verfahren pflegen
- **Commands** (direkt aufrufbar)
  - `/recht <frage>` – Normrecherche mit Fundstellen
  - `/urteil <aktenzeichen oder thema>` – Urteilsrecherche und -analyse
  - `/verfahren <lage>` – Verfahrensweg, Zuständigkeit, Fristen
  - `/vorabcheck <sachverhalt>` – Vorabberatung mit Prüfstruktur
- **Memory** – Sitzungsübergreifendes Gedächtnis (Mandate, Normen, offene Punkte)
- **Instincts** – Verhaltensregeln: erst Norm, dann Auslegung, dann Rechtsprechung; immer aktuelles Datum prüfen
- **Security** – RBAG/RDG-Grenzen, kein Rechtsrat, keine Fristenberechnung ohne Verifikation

## Installation

> Konkrete URL: `https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git`

### Hermes Agent (Nous Research)

F.E.E. ist vollständig Hermes-kompatibel: Alle Skills tragen YAML-Frontmatter (`name`, `description`) und werden von Hermes automatisch erkannt und geladen.

```bash
# Variante A: als Plugin installieren
hermes plugins install b3nb0x/F.E.E.---Fully-Examine-Everything

# Variante B: Skills direkt ins Hermes-Skills-Verzeichnis klonen
git clone https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git ~/.hermes/skills/fee

# Bestehendes Claude-Code-Setup importieren (übernimmt Plugins/Skills):
hermes import-agent claude-code
```

Danach stehen in Hermes die Slash-Commands `/recht`, `/urteil`, `/verfahren` und `/vorabcheck` zur Verfügung (Autocomplete via `/<Tab>`), und die 6 Rechts-Skills werden bei passenden Fragen automatisch herangezogen. Das F.E.E.-Memory (`memory/fee-memory.md`) integriert sich in das Hermes-Memory-Konzept (MEMORY.md/USER.md) – die Regeln aus `AGENTS.md` gelten agentenübergreifend.

### Claude Code

```bash
mkdir -p ~/.claude/plugins
git clone https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git ~/.claude/plugins/fee
# oder als Marketplace-Plugin:
/plugin install b3nb0x/F.E.E.---Fully-Examine-Everything
```

### llama.cpp / lokale Modelle (Nobara, Ubuntu, …)

llama.cpp hat kein eigenes Plugin-System, aber einen OpenAI-kompatiblen Server. Kombiniere ihn mit Hermes (oder einem anderen Agenten), um F.E.E. auf dem eigenen, lokalen Modell zu nutzen:

```bash
# 1. llama.cpp-Server starten (llama-server, OpenAI-kompatibel)
./llama-server -m <modell>.gguf --port 8080

# 2. Hermes installieren und lokalen Endpoint als Provider einrichten
hermes model   # Custom/OpenAI-compatible: http://localhost:8080/v1

# 3. F.E.E. installieren (siehe Abschnitt Hermes Agent oben)
```

Ohne Agenten-Framework kannst du F.E.E. auch direkt als Kontext laden – ohne Memory und automatische Skill-Auswahl:

```bash
cat AGENTS.md skills/*/SKILL.md > /tmp/fee-context.md
./llama-cli -m <modell>.gguf --system-prompt-file /tmp/fee-context.md
```

### Codex / Cursor / OpenCode / generisch

```bash
git clone https://github.com/b3nb0x/F.E.E.---Fully-Examine-Everything.git ~/fee
# AGENTS.md in dein Projekt kopieren oder referenzieren
```

## Schnellstart

```
/recht Kündigungsfrist bei Wohnung nach § 573c BGB
/urteil BGH XII ZR 12/24 Mietrecht
/verfahren Nachbar will Schadensersatz wegen Baumschnitts – welcher Rechtsweg?
/vorabcheck Arbeitgeber zahlt Überstunden nicht, seit 3 Monaten
```

## Quellen-Prinzip

F.E.E. priorisiert **amtliche und primäre Quellen**:

| Rang | Quelle | Zweck |
|---|---|---|
| 1 | `gesetze-im-internet.de` (Bundesjustizministerium) | amtlicher, aktueller Gesetzestext |
| 2 | Buzer, dejure.org | Normenkontext, Synopsen, Verweisungen |
| 3 | `bundesgerichtshof.de` | amtliche BGH-Entscheidungen |
| 4 | Rechtsprechung der obersten Bundesgerichte (BVerwG, BFH, BAG, BSG, BVerfG) | je nach Gerichtsbarkeit |
| 5 | EUR-Lex / curia.europa.eu | EU-Recht, EuGH |
| 6 | openjur, dejure-Dokumente | Auffindbarkeit von Aktenzeichen |

## Struktur

```
F.E.E.
├── AGENTS.md              # Agenten-Verhaltensregeln (zentral)
├── plugin.json            # Manifest (Claude-Code-Plugin / generisch)
├── commands/              # Slash-Commands
├── skills/                # Recherche- und Analyse-Skills
├── knowledge/             # Referenz: Quellen, Verfahrensübersicht, Zitierweise
├── memory/                # Memory-Template + Instincts
└── security/              # Grenzen der Rechtsdienstleistung
```

## Lizenz

MIT
