---
name: bibliothek-index
description: >-
  Hält den persistenten Dokument-Index der Bibliotheken aktuell und nutzt ihn als erste Suchinstanz — statt jede Suche blind über die Dokumentbibliothek zu fahren. Nutzen bei Dokumentensuche, Bibliotheksabfragen und nach neuen Uploads.
---

# Bibliothek-Index

Halte den persistenten Dokument-Index der User-Library-Bibliotheken aktuell und nutze ihn als erste Suchinstanz — statt jede Suche blind über `library_search` zu fahren.

> Plattform-Hinweis: Beschreibt die Mistral-Vibe/Le-Chat-`userLibrary`-Werkzeuge. In anderen Agenten (Hermes, Claude Code) gilt dieselbe Logik mit den dortigen Datei-/Suchwerkzeugen; die Index-Dateien leben dann unter `memory/index-bibliothek.md`.

## Wo liegt der Index

Knowledge-Topic **bibliothek-index** (`/home/user/knowledge/bibliothek-index/`):

* `KNOWLEDGE.md` — Bibliotheks-Tabelle, Suchreihenfolge, Aktualisierungs-Workflow, Bild-Dokument-Workflow.
* `sertop-ra.md` — 212 Doks, Bibliothek "Sertop RA" (Verfahrensakten).
* `ra-sertop-bewerbung.md` — 87 Doks, Bibliothek "RA Sertop Bewerbung" (§ 11 KSchG / § 615 BGB).
  Je Zeile: `**Dateiname** (Typ, Größe) — Auto-Summary · doclib-URI`, alphabetisch sortiert.

## Suche (immer diese Reihenfolge)

1. **Zuerst Index grep-en** (bash: `grep -i "<begriffe>" /home/user/knowledge/bibliothek-index/*.md`) — deckt ALLE Doks inkl. bildbasierte ohne Auto-Summary und ist schneller als mehrere library_search-Runden. Ggf. erst `KNOWLEDGE.md` lesen, um die richtige Bibliothek zu wählen.

2. Treffer → doclib-URI zeichen-genau aus dem Index kopieren → `library_read` / `library_grep` / `library_fetch`.

3. Kein Treffer → `library_search` (semantisch) + `library_list_documents` mit `name_contains` — danach Index ergänzen (s. u.), damit der Treffer beim nächsten Mal im Index steht.

## Bild-/Foto-Dokumente (keine oder irreführende Auto-Summary)

Der Index nennt nur Kandidaten, nicht den Inhalt. Visuelle Prüfung:

1. `library_fetch` (Dokument-URI) → signed URL.
2. URL per curl herunterladen.
3. Größer 12 MB: downscalen — vorher Ausführungsumgebung upgraden, dann die Python-Umgebung aktivieren (Pillow ist als matplotlib-Abhängigkeit enthalten, kein pip!): `ImageOps.exif_transpose(im).convert('RGB')`, `im.thumbnail((3200,3200))`, `save(quality=80)`.
4. Bildanalyse-Tool auf die verkleinerte Datei (12-MB-Limit; gezielt fragen: ein Anliegen pro Aufruf).

## Index aktualisieren

Auslöser: Nutzer meldet neue Uploads in eine Bibliothek, oder `library_list_documents` zählt mehr Doks als der Index, oder der Index-Stand ist deutlich älter als der aktuelle Auftrag.

1. Paginiert je Bibliothek ziehen: `library_list_documents` mit `uri`, `page_size: 100`, `page: 0..n` bis Ergebnis < 100 — `metadata` enthält `name`, `extension`, `size`, `summary`.
2. Diff gegen die Index-Datei nach Dateinamen: neue Doks als neue Zeile im bestehenden Format einfügen (alphabetisch einsortieren); entfernte Doks NICHT löschen, sondern Zeile mit `~~ENTFERNT Stand <Datum>~~` markieren.
3. Kopf der Index-Datei: Dok-Zahl + Stand-Datum aktualisieren; gleiche Zahlen in der Tabelle der `KNOWLEDGE.md`.
4. Fehlende Summary → Platzhalter "OHNE AUTO-SUMMARY (bildbasiert/nicht indiziert)".

## Regeln

* Vor jedem `userLibrary`-Aufruf: Skill laden, Funktionen via Funktionssuche entdecken; Aufrufe immer auf die Ziel-Bibliothek scopen (`uri` = volle `doclib://…`-URI).
* doclib-URIs nie selbst zusammenbauen, immer kopieren.
* Dokumente in Antworten als Markdown-Link mit ihrer doclib-URI zitieren.
* Inhaltliche Fallauswertung gehört nicht in den Index, sondern in die Fall-Topics (Sertop-Verfahren etc.) — der Index bleibt reines Findemittel.
* Sprache: Sprache des Nutzers (Default Deutsch).
