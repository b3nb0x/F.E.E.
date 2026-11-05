---
name: leak-recherche
description: >-
  Prüft, ob vom Nutzer bestätigte eigene Identitäten (E-Mail-Adressen, Usernames, Telefonnummern, eigene/firmeneigene Domains) in bekannten Leaks oder Breaches auftauchen. Rein passiv, nur Clearnet-Aggregatoren, nur eigene Daten. Nutzen bei Fragen nach Datenleaks und Account-Sicherheit.
---

# Leak-Recherche (eigene Daten)

Prüfung, ob **vom Nutzer bestätigte eigene Identitäten** (eigene E-Mail-Adressen, Usernames, Telefonnummern, eigene/firmeneigene Domains) in bekannten Leaks, Breaches oder Darknet-Quellen auftauchen.

## Grundsätze (immer einhalten)

* **Nur eigene Daten:** Recherchiere ausschließlich Identitäten, deren Eigentum der Nutzer ausdrücklich bestätigt hat (eigene Konten oder Konten der eigenen Organisation). Lehnrecherchen zu Daten Dritter ab.
* **Nur Clearnet-Aggregatoren:** Kein Tor, keine direkten Onion-Zugriffe, keine Downloads von Leak-Datenbanken oder Credential-Dumps. Die Quelle muss über das normale Web erreichbar sein.
* **Kein Klartext-Passwörter:** Bestätige nur, *ob* Daten geleakt wurden und *welche* Datentypen. Gib niemals geleakte Passwörter im Klartext wieder oder beschreibe, wie man an die eigentliche Dump-Datei kommt.
* **Passive Recon:** Keine Anmeldung auf Darknet-Foren, keine Interaktion mit Leak-Sites — nur Lesezugriff über Indexe, Tracker und Berichte.

## Ablauf

1. **Identifier sammeln:** Frage den Nutzer (falls nicht genannt), welche E-Mail-Adressen, Usernames, Rufnummern oder Domains geprüft werden sollen — und ob sie ihm selbst oder seiner Organisation gehören.

2. **Breach-Datenbanken prüfen:**
   * [Have I Been Pwned](https://haveibeenpwned.com) — autoritativ für E-Mail-Breaches; wenn die Suchfunktion nicht direkt abfragbar ist, weise den Nutzer auf die Selbstanprüfung hin und nenne die bekannten Breaches aus Suchergebnissen und News.
   * [Firefox Monitor](https://monitor.firefox.com) als Zweitquelle.
   * Bezahldienste (DeHashed, Snusbase, Intelligence X) nur erwähnen, nicht anstelle des Nutzers bedienen; Inhalte daraus nur aus bereits öffentlich indexierten Quellen zitieren.

3. **Web-Recherche je Identifier:** Websuche mit `"<identifier>" breach OR leak OR hacked` sowie Nachrichtensuche für aktuelle Vorfälle (News melden große Leaks oft vor jedem Tracker).

4. **Darknet-Indexe (Clearnet) für Domains/Firmen:**
   * [Ahmia](https://ahmia.fi) — Clearnet-Suchindex für Onion-Dienste; Suche nach firmeneigenen Begriffen/Marken.
   * [ransomware.live](https://www.ransomware.live) — Leak-Sites von Ransomware-Gruppen; prüfe, ob die eigene Organisation dort gelistet ist.
   * dark.fail nur zur Verifikation legitimer Mirrors, wenn ein konkreter Anlass besteht.

5. **Bewertung:** Je Fund: Quelle, Datum des Leaks, betroffene Datentypen (E-Mail, Passwort-Hash, Klartext-Passwort, Adresse, IBAN …), Status (bestätigt/ungenau), empfohlene Maßnahme.

## Berichtsformat

Kompakter Markdown-Bericht pro Identifier:

* **Fund / kein Fund** mit Quelle und Datum
* **Betroffene Datentypen**
* **Handlungsempfehlungen** (Passwort-Reset + 2FA, ggf. Kredit-/Identitätsschutz, Meldung an die Organisation, Anzeige bei polizeilichen Stellen bei schwerwiegenden Fällen)
* **Konfidenz** der Quelle (offizielle Bestätigung > Tracker > Forum-Gerücht)

Schließe mit dem Hinweis, dass Clearnet-Aggregatoren nicht das gesamte Darknet abdecken und ein "kein Fund" keine Garantie ist.
