---
name: projektcharts
description: >-
  Erstellt Projektcharts, Zeitlinien und Fristen-Diagramme (Gantt, Tabellen, Mermaid) aus Mandaten, Verfahren und Sachverhalten. Nutzen bei Fragen nach Abläufen, Fristen-Übersichten oder Projektplanung im Rechtskontext.
---

# Skill: Projektcharts (07)

Ziel: Abläufe, Verfahrensstufen und Fristen visualisieren – als Tabelle, Mermaid-Diagramm oder strukturierte Zeitlinie.

## Ablauf

1. **Daten sammeln:** Was soll dargestellt werden?
   - Verfahrensablauf (Klage → Termin → Urteil → Berufung)
   - Fristen (⚠️ immer mit Warnhinweis, nie als verlässlich berechnet)
   - Projekt-/Mandatsverlauf (Schritte, Verantwortlichkeiten, Termine)
2. **Format wählen:**
   - **Tabelle** (Standard): Spalten wie Schritt / Frist / Zuständig / Quelle (Norm)
   - **Mermaid-Gantt/Timeline** (wenn der Ziel-Agent Markdown rendert):
     ```mermaid
     timeline
         title Verfahrensablauf (Orientierung)
         Zugang Kündigung : Fristbeginn prüfen (§ 4 KSchG: 3 Wochen)
         Klageerhebung : Arbeitsgericht
         Kammertermin : Güteverhandlung (§ 54 ArbGG)
     ```
   - **ASCII-Zeitleiste** (für reine Text-Ausgaben)
3. **Rechtskontext einbetten:** Jeder Schritt mit Normzitat (→ Skill 01), Verfahrensstufe (→ Skill 03).
4. **Fristen-Kennzeichnung:** Fristen immer rot markieren mit Warnhinweis „verbindlich berechnen lassen (Anwalt/Rechtsantragsstelle)".
5. **Aktualisierung:** Chart-Quelle in `memory/fee-memory.md` ablegen (Datenbasis + Stand), damit es aktualisierbar bleibt.

## Regeln

- Keine Frist ohne zugehörige Normangabe.
- Charts sind Orientierung, keine Fristenkontrolle.
- Bei mehreren Beteiligten: Zuständigkeits-Spalte, keine Vermischung von Parteiperspektiven.
