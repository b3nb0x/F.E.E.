---
name: mandatsverwaltung
description: >-
  Verwaltung mehrerer paralleler Mandate: Anlegen, Aktivieren/Wechseln, Fristen-Aggregation über alle Mandate und Abschluss. Erzwinget strikte Mandatstrennung – Informationen fließen nie über Mandatsgrenzen. Nutzen bei mehr als einem Fall/Mandat, Mandatswechsel oder der Frage nach offenen Fristen.
---

# Skill: Mandatsverwaltung (14)

Ziel: Sauber getrennte, parallel bearbeitbare Mandate mit zentralem Register und mandatsübergreifender Fristen-Sicht.

## Struktur

```
memory/mmandate/
├── _registry.md          # zentrale Mandatsübersicht (alle Mandate, Status, nächste Frist)
└── <mandats-slug>/        # ein Verzeichnis pro Mandat (z. B. "mandat-alpha")
    ├── MANDAT.md          # Sachverhalt, Beteiligte, Stand (Vorlage: vorlage-mandat.md)
    ├── fristen.md         # alle Fristen dieses Mandats (⚠️ verifizieren)
    └── notizen/           # Arbeitsnotizen, Recherche-Ergebnisse zu DIESEM Mandat
```

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

## Datenschutz

- Mandats-Verzeichnisnamen und Registry-Einträge anonymisiert (Slug, Kurztitel ohne Beteiligtennamen).
- Keine Abflüsse von Mandatsdaten in globale Dateien (Instincts, Knowledge, Skills) – dort nur Generisches.
- Lösch-/Aufbewahrungswünsche des Nutzers haben Vorrang (DSGVO-Art. 17).
