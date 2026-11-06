---
name: mandant
description: >-
  Mandatsverwaltung in F.E.E.: Mandate auflisten, anlegen, wechseln, Fristen über alle Mandate, abschließen oder zusammenführen. Aufruf über /mandant.
---

# /mandant – Aufruf-Skill

Führt den gleichnamigen F.E.E.-Command aus. Arbeitet mit Skill `14-mandatsverwaltung` zusammen.

# /mandant – Mandatsverwaltung

Verwalte Mandate: **$ARGUMENTS**

Mögliche Aufrufe:
- `/mandant liste` – alle Mandate aus `memory/mmandate/_registry.md` mit Status und nächster Frist
- `/mandant neu <slug>` – neues Mandat anlegen (Skill 14: Verzeichnis + MANDAT.md + Registry-Eintrag)
- `/mandant wechsle <slug>` – aktives Mandat wechseln (MANDAT.md + fristen.md laden, offene Punkte des alten Mandats sichern)
- `/mandant fristen` – mandatsübergreifende Fristen-Tabelle, nach Ablauf sortiert (⚠️ mit Warnhinweis)
- `/mandant abschliessen <slug>` – Mandat abschließen (Registry-Status, Abschlussvermerk, Verzeichnis bleibt)
- `/mandant merge <ziel> <quelle1> <quelle2> …` – Mandate zusammenführen (Memory- und Fristen-Merge, Ordner verschieben, Registry + Redirect, nur nach Bestätigung)

Regeln (Skill 14): strikte Mandatstrennung – keine Informationen über Mandatsgrenzen; bei Mehrdeutigkeit nachfragen; Verzeichnis- und Registry-Einträge anonymisiert.
