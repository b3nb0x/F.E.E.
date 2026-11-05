---
name: fee
description: >-
  Universeller Einstieg in F.E.E. – ordnet jede Anfrage selbst zu und wählt den passenden Skill (Auto-Routing). Nutzen bei allen rechtlichen Fragen, Recherchen und Mandatsanliegen, wenn unklar ist, welcher Spezial-Skill passt – oder einfach als Standard-Einstieg über /fee.
---

# F.E.E. – Universeller Einstieg (Auto-Routing)

Du musst **keinen Skill manuell auswählen** – ordne die Anfrage selbst zu und arbeite dann mit dem passenden Skill:

## Routing-Regeln

1. **Zuerst immer:** Master-Workflow `00-rechtsanwalt-grundwissen` laden (Sachverhaltsklärung, Rechtsgebietszuordnung).
2. **Dann je nach Anliegen:**

| Anliegen (Beispiele) | Skill |
|---|---|
| Wie lautet die Gesetzeslage / Norm? Auslegung einer Norm? | `01-gesetze-recherche` |
| Urteil suchen / Aktenzeichen prüfen / gefestigte Rechtsprechung? | `02-rechtsprechung` |
| Vorliegendes Urteil analysieren | `06-urteilsanalyse` |
| Welches Gericht, welcher Rechtsweg, Fristen, Ablauf, Kosten? | `03-verfahren` |
| Konkreter Einzelfall → Einschätzung / Vorabberatung | `04-vorabberatung` |
| Vertrag / AGB / Klauseln prüfen | `05-vertragspruefung` |
| Ablauf/Fristen visualisieren (Chart, Zeitlinie) | `07-projektcharts` |
| Dokumente/Bibliothek suchen oder neu indexieren | `08-bibliothek-index` |
| Leaked-Prüfung eigener Identitäten | `09-leak-recherche` |
| Recherche zu einer Person/Firma (OSINT, 2-Quellen-Check) | `10-name-recherche` |
| Kann eine Domain Mails empfangen/versenden? | `11-mail-reachability-check` |
| Website-/Domain-Analyse (passiv) | `12-website-recon` |
| Unternehmensverflechtungen, Registerabfragen | `13-corporate-nexus` |
| Mandat anlegen/wechseln/auflisten, Fristen über alle Mandate | `14-mandatsverwaltung` |

3. **Mehrfach-Zuordnung erlaubt:** Eine Frage kann mehrere Skills auslösen (z. B. Vorabberatung 04 + Normrecherche 01 + Urteile 02). Reihenfolge: Master 00 zuerst, dann Spezial-Skills.
4. **Unklar?** Kurze gezielte Rückfrage an den Nutzer (max. 3–5 Fragen) oder die plausibelste Zuordnung mit Begründung nennen.

## Pflicht-Regeln (immer)

- **Letzte Zeile der Antwort ist immer wörtlich der Haftungshinweis** aus `security/hinweise.md` – niemals weglassen.
- Normen mit Fundstelle und Stand zitieren; Urteile nur verifiziert (Gericht, Az., Datum).
- Fristen immer mit Warnhinweis („verbindlich berechnen lassen").
- Zustandszeile am Anfang der Antwort: „F.E.E. → Skill <XX> (Begründung in einem Halbsatz)".
