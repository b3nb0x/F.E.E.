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
- **Commands** (direkt aufrufbar)
  - `/recht <frage>` – Normrecherche mit Fundstellen
  - `/urteil <aktenzeichen oder thema>` – Urteilsrecherche und -analyse
  - `/verfahren <lage>` – Verfahrensweg, Zuständigkeit, Fristen
  - `/vorabcheck <sachverhalt>` – Vorabberatung mit Prüfstruktur
- **Memory** – Sitzungsübergreifendes Gedächtnis (Mandate, Normen, offene Punkte)
- **Instincts** – Verhaltensregeln: erst Norm, dann Auslegung, dann Rechtsprechung; immer aktuelles Datum prüfen
- **Security** – RBAG/RDG-Grenzen, kein Rechtsrat, keine Fristenberechnung ohne Verifikation

## Installation

```bash
# Claude Code
mkdir -p ~/.claude/plugins
git clone https://github.com/<owner>/<repo>.git ~/.claude/plugins/fee
# oder als Marketplace-Plugin:
/plugin install <owner>/<repo>

# Codex / Cursor / OpenCode / generisch
git clone https://github.com/<owner>/<repo>.git ~/fee
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
