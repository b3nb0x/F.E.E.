---
name: dokumentenverarbeitung
description: >-
  Nimmt Dokumente (PDF, Word, Excel, LibreOffice, Bilder) in ein Mandat auf: OCR/Textextraktion, einheitliche Ablage im Mandanten-Ordner (eingang/ für Originale, dokumente/ für Volltexte) und Index-Aktualisierung. Nutzen, wenn der Nutzer Dokumente hochlädt, vorlegt oder einscannen lässt.
---

# Skill: Dokumentenverarbeitung (16)

Ziel: Jedes Dokument landet im richtigen Mandats-Ordner, als Original **und** als durchsuchbarer Volltext.

## Ordner-Konvention (pro Mandat)

```
<Mandate-Basis>/JJJJ-MM-TT_<MANDATS-ID>_<ANZEIGENAME>/
├── MANDAT.md            # Memory des Mandats (→ Skill 14)
├── fristen.md
├── eingang/             # Original-Dokumente, unverändert
├── dokumente/           # Volltexte (OCR/Extraktion), durchsuchbar
├── notizen/
└── 1_<Rechtsgebiet>/    # z. B. 1_Mietrecht, 2_Arbeitsrecht/2.2_Kuendigungsschutzklage
```

- Mandate-Basis: konfigurierbar über `.fee-config` (Installer: `--mandate-dir`, Standard `~/FEE-Mandate`)
- Ordnername: Erstellungsdatum + Mandats-ID + Anzeigename, z. B. `2026-11-06_M-001_Herr_Mustermann`
- Ein Dokument gehört zu **genau einem** Mandat (bei Mehrfachbezug: physisch in das Hauptmandat, im anderen Mandat nur ein Verweis in `MANDAT.md`)

## Ablauf

1. **Mandat klären:** In welchen Mandat Ordner gehört das Dokument? (Bei Unklarheit nachfragen – → Skill 14. Ggf. Unterordner des Rechtsgebiets wählen, z. B. `2_Arbeitsrecht/2.2_Kuendigungsschutzklage/eingang/`.)
2. **Original ablegen:** Datei unverändert nach `eingang/` kopieren (nie verändern – Beweiswert!).
3. **Typ erkennen** (Dateiendung + `file`-Ausgabe) und Volltext erzeugen:

   | Typ | Werkzeug | Befehl (Beispiel) |
   |---|---|---|
   | PDF (Text-Layer) | poppler | `pdftotext -layout eingang/x.pdf dokumente/x.txt` |
   | PDF (Scan, kein Text) | poppler + tesseract | `pdftoppm -r 300 -png eingang/x.pdf /tmp/x` → `tesseract /tmp/x-1.png dokumente/x -l deu` (je Seite) |
   | Bild (JPG/PNG/TIFF) | tesseract | `tesseract eingang/x.jpg dokumente/x -l deu` |
   | DOCX/DOC, ODT | LibreOffice headless | `libreoffice --headless --convert-to txt:Text --outdir dokumente/ eingang/x.docx` |
   | XLSX/ODS | LibreOffice headless | `libreoffice --headless --convert-to csv --outdir dokumente/ eingang/x.xlsx` |
   | RTF/TXT | direkt | kopieren |

4. **Ergebnis prüfen:** Ist der Volltext lesbar/vollständig? Leere oder wirre Ausgabe → OCR-Pfad (Schritte für Scans). Mehrseitige PDFs: alle Seiten abarbeiten.
5. **Benennen:** Volltext als `JJJJ-MM-TT_<typ>_<kurzbeschreibung>.txt` (z. B. `2026-11-06_pdf_kuendigung_arbeitgeber.txt`).
6. **Index pflegen:** Neues Dokument in die Index-Bibliothek eintragen (→ Skill 08) und ggf. in `MANDAT.md` unter Dokumente vermerken.
7. **Inhalt auswerten:** Relevante Fakten (Datierungen, Fristauslöser, Absender/Empfänger) in `MANDAT.md` festhalten; Fristen nach `fristen.md` (⚠️ mit Warnhinweis).

## Fehlende Werkzeuge

Benötigt: `tesseract` (+ `deu`-Sprachpaket), `poppler-utils` (pdftotext/pdftoppm), `libreoffice`. Installation per Distro über den F.E.E.-Installer:

```sh
curl -fsSL https://raw.githubusercontent.com/b3nb0x/F.E.E.---Fully-Examine-Everything/main/install.sh | sh -s -- --deps
```

(Installer erkennt Distro und wählt apt/dnf/zypper/pacman.)

## Regeln

- Originale nie verändern oder löschen – nur Kopien verarbeiten.
- Keine Dokumente ohne Mandatszuordnung ablegen.
- Sensible Inhalte (Personendaten) bleiben im Mandats-Ordner; nichts davon in globale Dateien (Mandatstrennung, → `security/hinweise.md`).
- Dokumentenmetadaten (Eingangsdatum, Quelle) im Dateinamen und Index festhalten.
