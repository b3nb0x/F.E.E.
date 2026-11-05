# Corporate Nexus – Vollständige Spezifikation

## 1. Benutzeroberfläche (UI)

### Suchfenster

- Eingabefeld Firmenname (Autovervollständigung, falls API es unterstützt).
- Dropdown Länderauswahl: DE, AT, CH, UK, BE, NL, FR, ES, PL.
- Button „Suche starten".
- Fortschrittsbalken für Lade- und Analyseprozess.

### Ergebnisansicht

- **Interaktiver Graph:**
  - Knoten = Unternehmen, Personen (Geschäftsführer/Gesellschafter).
  - Kanten = Beteiligungen, gemeinsame Adressen, gemeinsame Personen.
  - Farbcodierung nach Beteiligungsgrad: rot = 100 %, orange = 50–99 %, gelb < 50 %.
  - Zoom- und Filterfunktionen (z. B. nur Personen/Unternehmen).
  - Klick auf Knoten öffnet Details (siehe Abschnitt 5/6).
- **Tabellenansicht (optional):** sortierbare Liste aller Unternehmen/Personen mit Metadaten (Firmenname, Land, Rolle, Beteiligungsprozent).

### Dokumentenarchiv

- Separater Bereich mit allen abrufbaren Unterlagen (PDFs, Handelsregisterauszüge, Jahresabschlüsse).
- Download-Button pro Dokument.
- PDF-Vorschaufunktion (integrierter Viewer).

## 2. Backend – Datenabfrage und -verarbeitung

### Handelsregister-APIs

- **Deutschland:** Handelsregister.de – Anbindung über die dokumentierte Schnittstelle des gemeinsamen Registerportals (bundesAPI/handelsregister, Details siehe [handelsregister-api.md](handelsregister-api.md)). Firmensuche, Trägerdaten und Bekanntmachungen sind kostenlos; Rate-Limit 60 Abrufe/Stunde. Kein kostenpflichtiger Zugang nötig.
- **Österreich:** Firmenbuch
- **Schweiz:** Zefix
- **England:** Companies House
- **Belgien:** Crossroads Bank for Enterprises
- **Niederlande:** Dutch Chamber of Commerce
- **Frankreich:** Infogreffe
- **Spanien:** Registro Mercantil
- **Polen:** KRS
- **Fallback:** Web-Scraping (mit Respekt vor robots.txt und Rate-Limiting).

### Datenbank

- Lokale SQLite- oder PostgreSQL-Datenbank (Offline-Nutzung, Performance).

### Datenextraktion

- Parsing von Geschäftsführern/Gesellschaftern (Namen, Adressen, Nationalitäten).
- Beteiligungsstrukturen (Anteile in %, Mutter-/Tochtergesellschaften).
- Weiterführende Links („Ist Gesellschafter von XY GmbH").
- OCR-Integration (Tesseract) für gescannte Dokumente.

### Rekursive Suche

- Start mit dem ursprünglichen Unternehmen.
- Lade alle Geschäftsführer/Gesellschafter und deren Beteiligungen.
- Für jede gefundene Person/Unternehmen: neue Registerabfrage (falls nicht bereits in DB).
- Wiederholen, bis keine neuen Einträge mehr gefunden werden.
- Tiefenbegrenzung konfigurierbar (z. B. „3 Ebenen").

### Performance

- Parallelisierung der Abfragen (asyncio).
- Caching von Ergebnissen gegen doppelte Abfragen.

## 3. Datenanalyse und -aufbereitung

- **Deduplizierung:** Erkennung von Doppeleinträgen, Fuzzy Matching für Namensvarianten („Müller GmbH" vs. „Müller GmbH & Co. KG").
- **Netzwerkanalyse:** Zentralitätsmaße („Welches Unternehmen hat die meisten Verflechtungen?"), Clustering nach Gemeinsamkeiten (Adresse, gleicher GF).
- **Export:** CSV/JSON der gesamten Struktur, GraphML für externe Tools (z. B. Gephi).

## 4. Schematische Darstellung (Frontend)

- Graph-Bibliotheken: D3.js (Web), NetworkX + Matplotlib (Python-Desktop), Vis.js (einfachere Alternative).
- Dynamische Layouts (Force-Directed, Hierarchisch).
- Tooltips bei Mouseover (Metadaten).
- Suche im Graphen („Zeige alle Verbindungen zu Person X").
- Farben/Legende für Entitätstypen (Unternehmen, Person, Adresse).
- Animationen (z. B. „Expandieren" von Knoten).

## 5. Dokumentenabruf und -verwaltung

- Typen: Handelsregisterauszüge, Jahresabschlüsse, Gesellschaftsverträge, Pressemitteilungen.
- Automatischer Download aller verfügbaren Dokumente.
- Lokale Speicherung projektbasiert (z. B. `/home/user/CorporateNexus/Projekte/[Firmenname]/Dokumente/`).
- Metadaten-Extraktion aus PDFs (PyPDF2/pdfplumber): Eintragungsdatum, Schlüsselwörter („Beteiligung", „Geschäftsführerwechsel").
- Volltextsuche in allen heruntergeladenen Dokumenten.

## 6. Tech-Stack

| Komponente | Technologie | Begründung |
|---|---|---|
| Backend | Python (FastAPI/Flask) | Einfache API-Integration, Skripting |
| Frontend | Qt (PySide6) oder Electron | Linux-kompatibel, interaktiv |
| Datenbank | SQLite oder PostgreSQL | Lokale Speicherung, Skalierbarkeit |
| Graph-Darstellung | NetworkX + Matplotlib oder D3.js | Flexibilität Desktop/Web |
| PDF-Processing | PyPDF2, pdfplumber, Tesseract (OCR) | Textextraktion aus PDFs/Images |
| API-Anbindung | requests, aiohttp (async) | Robuste HTTP-Abfragen |
| Parallelisierung | asyncio, concurrent.futures | Schnelle Abfragen |

## 7. Beispiel-Workflow

1. Nutzer gibt „Siemens AG" ein, wählt Deutschland.
2. Abfrage Handelsregister.de → GF: Joe Example (50 %), Anna Muster (50 %); Beteiligungen: Siemens Energy AG (100 %), Siemens Healthineers (80 %).
3. Rekursive Suche: Joe Example → Example Holding GmbH → Beispiel AG (25 %).
4. Graph: Siemens AG → Siemens Energy AG → Example Holding GmbH → Beispiel AG.
5. Dokumente: alle Registerauszüge der gefundenen Unternehmen werden heruntergeladen.
6. Klick auf Example Holding GmbH → Details + Dokumente.

## 8. Optionale Features

- E-Mail-Benachrichtigungen bei neuen Verflechtungen gespeicherter Unternehmen.
- Historische Analyse (Vergleich von Registereinträgen über Zeit).
- KI/NLP zur Extraktion impliziter Verflechtungen aus Texten.
- Zusatzquellen: LinkedIn, Crunchbase, OpenCorporates.

## 9. Sicherheit & Compliance

- Keine Speicherung personenbezogener Daten ohne Nutzerzustimmung.
- Verschlüsselung der lokalen DB (SQLCipher).
- Rate-Limits der APIs respektieren, offizielle APIs bevorzugen.
- Nutzungsbedingungen/Lizenzierung der Register klären.

## 10. Nächste Schritte

1. API-Zugänge prüfen (Kosten, Limits je Land).
2. CLI-Prototyp (nur Deutschland, ohne UI).
3. UI-Design (Figma oder Qt Designer).
4. ER-Diagramm für Tabellen (Unternehmen, Personen, Beteiligungen, Dokumente).
5. Rekursion zunächst mit statischen Daten (JSON) testen.

## Beispiel-Code (Backend-Logik, Python)

```python
import requests, sqlite3, asyncio, aiohttp

async def fetch_company_data(company_name, country):
    if country == "UK":
        url = f"https://api.company-information.service.gov.uk/companies?q={company_name}"
        headers = {"Authorization": "YOUR_API_KEY"}
        async with aiohttp.ClientSession() as session:
            async with session.get(url, headers=headers) as response:
                data = await response.json()
                return data["items"][0]["company_number"]

async def recursive_search(company_id, depth=0, max_depth=3):
    if depth > max_depth:
        return []
    company_data = await fetch_company_data(company_id, "UK")
    directors = company_data.get("directors", [])
    for director in directors:
        other_companies = await find_companies_by_director(director["name"])
        for company in other_companies:
            recursive_search(company["id"], depth + 1, max_depth)

conn = sqlite3.connect("corporate_nexus.db")
cursor = conn.cursor()
cursor.execute("""
    CREATE TABLE IF NOT EXISTS companies (
        id TEXT PRIMARY KEY,
        name TEXT,
        country TEXT,
        directors TEXT  -- JSON-Array
    )
""")
```
