---
name: corporate-nexus
description: >-
  Automatisierte Analyse von Unternehmensverflechtungen in DE, AT, CH, UK, BE, NL, FR, ES und PL (Handelsregister, Firmenbuch, Zefix u. a.) mit rekursiver Suche und Graph-Darstellung. Nutzen bei Fragen nach Beteiligungen, Geschäftsführern und Firmennetzwerken.
---

# Corporate Nexus – Unternehmensverflechtungs-Analysator

Du nutzt **Corporate Nexus**: zur automatisierten Analyse von Unternehmensverflechtungen in Deutschland, Österreich, Schweiz, England, Belgien, Niederlande, Frankreich, Spanien und Polen – ähnlich Northdata, aber mit erweiterter Funktionalität.

Die vollständige Spezifikation (UI, Backend, Datenanalyse, Graphendarstellung, Dokumentenverwaltung, Tech-Stack, Workflow, Compliance) liegt in einer `requirements.md` (bei Projektfragen konsultieren und Implementierungsvorschläge konsistent zu ihr halten).

## Kernpunkte (Kurzreferenz)

* **Ziel:** Handelsregisterdaten abfragen, Geschäftsführer/Gesellschafter/Beteiligungen extrahieren, rekursiv weitersuchen, interaktiv als Graph darstellen.
* **Länder & Quellen:** DE (Handelsregister.de via bundesAPI/handelsregister; POST-Parameter der erweiterten Suche, Rate-Limit 60 Abrufe/h, Parsing der Ergebnistabelle), AT (Firmenbuch), CH (Zefix), UK (Companies House), BE (Crossroads Bank for Enterprises), NL (Dutch Chamber of Commerce), FR (Infogreffe), ES (Registro Mercantil), PL (KRS). Fallback: Web-Scraping mit Respekt vor robots.txt und Rate-Limiting.
* **Stack:** Python-Backend (FastAPI/Flask), PySide6 (Qt) oder Electron Frontend, SQLite/PostgreSQL, NetworkX + Matplotlib oder D3.js/Vis.js für Graphen, PyPDF2/pdfplumber/Tesseract für PDFs/OCR, requests/aiohttp + asyncio für parallele Abfragen.
* **Rekursive Suche:** BFS-artige Expansion mit vom Nutzer wählbarer Tiefenbegrenzung, Caching und Deduplizierung (Fuzzy Matching) gegen doppelte Abfragen.
* **Compliance:** Keine Speicherung personenbezogener Daten ohne Zustimmung, SQLCipher-Verschlüsselung, offizielle APIs bevorzugen, Rate-Limits respektieren, Lizenzbedingungen der Register klären.

## Arbeitsweise

* Standard-Domäne: Softwareentwicklung (Python, Qt, Datenbanken, APIs, Graphenalgorithmen). Antworten in der Sprache des Nutzers.
* Vorschläge priorisieren: erst CLI-Prototyp (nur DE, ohne UI), dann UI, dann weitere Länder.
* Code-Beispiele in Python, asynchron (asyncio/aiohttp) für Abfragen.
* Datenschema: Unternehmen, Personen, Beteiligungen, Dokumente.
* Graph-Darstellung: Knoten = Unternehmen/Personen, Kanten = Beteiligungen/gemeinsame Adressen/gemeinsame Personen; Farbcodierung nach Beteiligungsgrad (rot = 100 %, orange = 50–99 %, gelb < 50 %).
