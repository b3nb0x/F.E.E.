# Handelsregister-API (Deutschland) – bundesAPI/handelsregister

Referenz: <https://github.com/bundesAPI/handelsregister> (CLI/Referenzimplementierung des gemeinsamen Registerportals der Länder, <https://www.handelsregister.de>).

## Wesentliche Punkte

* **Kein API-Key, keine Kosten** für Firmensuche, Unternehmensträgerdaten und Handelsregisterbekanntmachungen (§ 9 Abs. 1 HGB).
* **Rate-Limit: max. 60 Abrufe/Stunde** laut Nutzungsordnung. Verstöße können strafrechtlich relevant sein (§§ 303a, 303b StGB). In Corporate Nexus daher als Token-Bucket implementieren und den Referenz-CLI-Cache (Platten-Cache pro Suchbegriff) übernehmen.
* Es ist keine echte REST-API, sondern das JSF-Formular des Registerportals (`https://www.handelsregister.de/rp_web/erweitertesuche.xhtml`), das per POST mit Formularparametern befragt wird. Die Referenzimplementierung nutzt `mechanize` + BeautifulSoup; in Corporate Nexus bevorzugt `aiohttp`-Session mit Cookie-Handling (JSF-View-State) oder das Python-Paket `python-handelsregister`/Fork als Bibliothek.
* Die README dokumentiert alle POST-Parameter (siehe unten); das Skript `handelsregister.py` zeigt das konkrete Formular-Handling (Startseite öffnen → `naviForm` → erweiterte Suche → `form` absenden).

## Suchparameter (POST an erweitertesuche.xhtml)

| Parameter | Werte / Bedeutung |
|---|---|
| `schlagwoerter` | Suchbegriff(e); Platzhalter `*` (beliebig viele Zeichen) und `?` (genau ein) |
| `schlagwortOptionen` | 1 = alle Schlagwörter, 2 = mind. eines, 3 = exakter Firmenname |
| `suchOptionenAehnlich` | `true` = phonetische Suche (Kölner Phonetik) – nützlich fürs Fuzzy Matching |
| `suchOptionenGeloescht` | `true` = auch gelöschte Firmen |
| `suchTyp` | `n` = normal, `e` = erweitert (Länder-/Rechtsform-/Adressfilter) |
| `ergebnisseProSeite` | 10/25/50/100 |
| `niederlassung` | Sitz/Niederlassung (Platzhalter erlaubt) |
| `bundeslandXX` | `on` pro Bundesland (BW, BY, BE, BR, HB, HH, HE, MV, NI, NW, RP, SL, SN, ST, SH, TH) |
| `registerArt` | alle, HRA, HRB, GnR, PR, VR |
| `registerNummer` | Registernummer (Hauptniederlassung) |
| `registerGericht` | Registergericht-Code, z. B. D3201 = Ansbach |
| `rechtsform` | Code je Rechtsform (1=AG, 8=GmbH, 12=OHG, 10=KG, …) |
| `btnSuche` | `Suchen` |

## Rückgabe / Parsing

Ergebnis ist eine HTML-Tabelle (`table[role=grid]`), pro Zeile (Attribut `data-ri`): Gericht + Registernummer (Regex `(HRA|HRB|GnR|VR|PR)\s*\d+(\s+[A-Z])?`), Firmenname, Bundesland, Status (z. B. `ACTIVE`/`LIQUIDATED` als `statusCurrent`), Dokumenten-Links sowie ggf. historische Namen/Niederlassungen. Suffix-Korrekturen: Berlin `HRB … B`, Bremen `… HB`.

## Integration in Corporate Nexus (DE-Adapter)

1. **Suche:** `schlagwoerter` + `schlagwortOptionen=2`, `suchOptionenAehnlich=true` für Namensvarianten (unterstützt Deduplizierung/Fuzzy Matching direkt serverseitig).
2. **Dokumente:** SD/AD-Dateien (Handelsregisterauszüge, Jahresabschlüsse) pro Treffer abrufen → Dokumentenarchiv-Modul.
3. **Extraktion:** GF/Gesellschafter und Beteiligungen aus den AD/SI-Texten via pdfplumber (+ Tesseract-OCR-Fallback) – die Suche selbst liefert nur Stammdaten.
4. **Rekursion:** BFS nutzt `registerNummer` + `registerGericht` als eindeutigen Firmenschlüssel (primäre IDs in SQLite), nicht den Namen.
5. **Compliance:** Token-Bucket ≤ 60 Abrufe/h, Caching pro Abfrage, robots.txt respektieren.

## Beispiel (vereinfacht, Python)

```python
import asyncio, aiohttp
from bs4 import BeautifulSoup

BASE = "https://www.handelsregister.de/rp_web/erweitertesuche.xhtml"

async def search(session: aiohttp.ClientSession, name: str) -> list[dict]:
    async with session.get(BASE) as r:
        page = await r.text()
    # JSF: viewState aus dem HTML extrahieren, dann POST mit obigen Parametern
    # (Formularhandling analog bundesAPI/handelsregister, siehe handelsregister.py)
    data = {
        "form": "form",
        "form:schlagwoerter": name,
        "form:schlagwortOptionen": "2",
        "form:suchOptionenAehnlich": "true",
        "form:btnSuche": "Suchen",
        "javax.faces.ViewState": view_state(page),
    }
    async with session.post(BASE, data=data) as r:
        return parse_results(await r.text())
```
