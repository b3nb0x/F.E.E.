---
name: recht
description: >-
  Normrecherche in F.E.E.: Gesetz/Norm mit Fundstelle, aktuellem Stand und relevanter Rechtsprechung recherchieren. Aufruf über /recht.
---

# /recht – Aufruf-Skill

Führt den gleichnamigen F.E.E.-Command aus. Arbeitet mit Skill `01-gesetze-recherche` zusammen.

# /recht – Normrecherche

Recherchiere die einschlägige(n) Norm(n) zur Frage: **$ARGUMENTS**

Ablauf (Skill 01-gesetze-recherche):
1. Rechtsgebiet einordnen, einschlägige Norm identifizieren
2. Amtliche Quelle prüfen (gesetze-im-internet.de), Stand der Norm angeben
3. Zitierfähige Ausgabe: `§ … Abs. … S. … <Gesetz>` + Kernaussage
4. Verweisungen auf angrenzende Normen
5. Relevante Rechtsprechung (BGH zuerst) mit Aktenzeichen
6. **Letzte Zeile der Antwort ist immer wörtlich dieser Haftungshinweis** – niemals weglassen, kein Dateizugriff nötig:

> ⚠️ Diese Ausarbeitung ist eine unverbindliche, automatisierte Vorab-Information und **keine Rechtsberatung** im Sinne des Rechtsdienstleistungsgesetzes (RDG). Für eine verbindliche Einschätzung – insbesondere bei laufenden Fristen, hohem Streitwert oder Straf-/Verwaltungsverfahren – konsultiere eine Anwältin oder einen Anwalt. Bei geringem Einkommen: Beratungshilfe (§ 1 BerHG) über die örtliche Rechtsantragsstelle.
