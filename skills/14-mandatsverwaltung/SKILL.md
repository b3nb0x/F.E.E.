---
name: mandatsverwaltung
description: >-
  Verwaltung mehrerer paralleler Mandate: Anlegen, Aktivieren/Wechseln, Fristen-Aggregation über alle Mandate und Abschluss. Erzwinget strikte Mandatstrennung – Informationen fließen nie über Mandatsgrenzen. Nutzen bei mehr als einem Fall/Mandat, Mandatswechsel oder der Frage nach offenen Fristen.
---

# Skill: Mandatsverwaltung (14)

Ziel: Sauber getrennte, parallel bearbeitbare Mandate mit zentralem Register und mandatsübergreifender Fristen-Sicht.

## Struktur

### Variante A – Plugin-Memory (innerhalb des Agenten)

```
memory/mmandate/
├── _registry.md          # zentrale Mandatsübersicht (alle Mandate, Status, nächste Frist)
└── <mandats-slug>/        # ein Verzeichnis pro Mandat (z. B. "mandat-alpha")
    ├── MANDAT.md          # Sachverhalt, Beteiligte, Stand (Vorlage: vorlage-mandat.md)
    ├── fristen.md         # alle Fristen dieses Mandats (⚠️ verifizieren)
    └── notizen/           # Arbeitsnotizen, Recherche-Ergebnisse zu DIESEM Mandat
```

### Variante B – Mandanten-Ordner auf Dateisystem (Installer-Standard)

Basisordner konfigurierbar (Installer-Option `--mandate-dir`, Standard `~/FEE-Mandate`, in `.fee-config` gespeichert). Ordnername: **Erstellungsdatum + Mandats-ID + Anzeigename**:

```
~/FEE-Mandate/
└── 2026-11-06_M-001_Herr_Mustermann/      ← Datum & Mandats-ID & Anzeigename
    ├── MANDAT.md          # Memory des Mandats (Vorlage: vorlage-mandat.md)
    ├── fristen.md
    ├── eingang/           # Original-Dokumente (unverändert)
    ├── dokumente/        # OCR-Volltexte (→ Skill 16)
    ├── notizen/
    ├── 1_Mietrecht/                     ← Rechtsgebiet 1
    └── 2_Arbeitsrecht/                   ← Rechtsgebiet 2
        └── 2.2_Kuendigungsschutzklage/    ← Unterverfahren
```

- Nummerierte Unterordner pro Rechtsgebiet/Verfahren; weitere Ebenen als `2.2`, `2.3` … möglich.
- Jeder Ordner gehört zu **genau einem** Mandanten – niemals vermischen.
- Dokumente werden über Skill `16-dokumentenverarbeitung` aufgenommen (eingang/ → dokumente/).
- Beide Varianten synchron halten: Registry-Eintrag verweist auf den Dateisystem-Ordner.

## Kernregeln (Mandatstrennung)

1. **Ein aktives Mandat pro Sitzung/Aufgabe** – alle Recherchen, Ausarbeitungen und Memory-Schreibvorgänge beziehen sich auf das aktive Mandat.
2. **Never cross the wall:** Informationen aus Mandat A fließen **niemals** in Ausarbeitungen zu Mandat B – auch nicht als „ähnlicher Fall". Begründung: Vertraulichkeit der Beteiligten, DSGVO (→ `security/hinweise.md`).
3. **Eindeutige Zuordnung:** Wenn unklar ist, welches Mandat gemeint ist, **nachfragen**, bevor gearbeitet wird.
4. **Generische Beispiele:** In allgemeinen Ausarbeitungen (Vorschläge, README, Skills) keine echten Mandatsnamen, Beteiligten oder Fakten verwenden – nur Platzhalter.
5. **Ablage-Disziplin:** Neue Dateien immer im Mandats-Ordner ablegen; das Registry nur mit Status/Fristen pflegen.

## Ablauf

### Mandat anlegen
1. Slug festlegen (kurz, anonymisiert, z. B. `mandat-alpha` – keine echten Namen in Verzeichnisnamen).
2. `memory/mmandate/<slug>/` anlegen, `MANDAT.md` aus `vorlage-mandat.md` füllen.
3. Eintrag im `_registry.md` (Status: aktiv, nächste Frist, Kurztitel).

### Mandat wechseln / aktivieren
1. Gewünschtes Mandat aus `_registry.md` identifizieren (bei Mehrdeutigkeit nachfragen).
2. `MANDAT.md` + `fristen.md` des Mandats laden – **erst dann** arbeiten.
3. Altes Mandat: offene Punkte in dessen `MANDAT.md` festhalten, damit nichts verloren geht.

### Fristen-Aggregation (mandatsübergreifend)
1. Alle `fristen.md`-Dateien einlesen.
2. Tabelle nach Fristablauf sortieren: Mandat | Frist | Grund | Norm | Aktion.
3. ⚠️ Jede Frist mit Warnhinweis – verbindliche Berechnung nur anwaltlich/rechtsantragagsstelle.
4. Ausgabe optional als Chart (→ Skill `07-projektcharts`).

### Mandat abschließen
1. Status im `_registry.md` auf „abgeschlossen (Datum)" setzen; Verzeichnis **nicht** löschen.
2. Abschlussvermerk in `MANDAT.md` (Ergebnis, Restpunkte, Aufbewahrung).

### Mandate zusammenführen (mehrere Fälle → ein Mandat)

Wenn mehrere Mandate zu einem zusammengelegt werden (z. B. drei getrennte Fälle desselben Mandanten):

1. **Ziel klären:** Welches Mandat bleibt bestehen (oder neues Ziel-Mandat anlegen)? Nutzer bestätigen lassen.
2. **Memory zusammenführen:** `MANDAT.md`-Inhalte der Quell-Mandate in die Ziel-`MANDAT.md` übernehmen – je Abschnitt (Sachverhalt, Beteiligte, Normen, Rechtsprechung, offene Punkte) mit Herkunfts-Kennzeichnung `[aus <slug>]`.
3. **Fristen mergen:** Alle `fristen.md`-Zeilen in die Ziel-`fristen.md` übernehmen, Duplikate prüfen, je Zeile Herkunft notieren.
4. **Ordner verschieben:** `eingang/`, `dokumente/`, `notizen/` und Rechtsgebiet-Ordner der Quell-Mandate in den Ziel-Ordner verschieben – bei Namenskollisionen Datum/Slug-Präfix vor den Dateinamen setzen (z. B. `2026-11-06_M-002_kuendigung.pdf`).
5. **Registry aktualisieren:** Ziel-Mandat-Status `aktiv`; Quell-Mandate auf `zusammengeführt (Datum) → <ziel-slug>`.
6. **Redirect hinterlassen:** In der Quell-`MANDAT.md` oben eintragen: „Zusammengeführt am <Datum> in <ziel-slug>" – Verzeichnis der Quellen **nicht** löschen (Nachvollziehbarkeit), bzw. nach Nutzerwunsch.
7. **Index aktualisieren:** Dokument-Index (→ Skill 08) auf neue Pfade korrigieren.

Regeln: Zusammenführung nur nach Bestätigung des Nutzers; nichts geht verloren (ersatzweise kopieren statt verschieben); Trennung zu **anderen** Mandaten bleibt bestehen.


## Datenschutz

- Mandats-Verzeichnisnamen und Registry-Einträge anonymisiert (Slug, Kurztitel ohne Beteiligtennamen).
- Keine Abflüsse von Mandatsdaten in globale Dateien (Instincts, Knowledge, Skills) – dort nur Generisches.
- Lösch-/Aufbewahrungswünsche des Nutzers haben Vorrang (DSGVO-Art. 17).
