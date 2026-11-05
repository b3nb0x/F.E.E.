---
name: website-recon
description: >-
  Passive Reconnaissance von Websites (Whois, DNS, SSL, HTTP-Header, Hoster) mit strukturiertem Markdown-Bericht; aktive Scans nur mit bestätigter Autorisierung durch den Eigentümer. Nutzen bei Domain-Analysen und Sicherheitsbewertungen.
---

# Website Recon & Bericht

## Grundsätze

1. **Passive Recon immer erlaubt:** Whois, dig/nslookup, SSL-Zertifikatsdaten, HTTP-Header, DNS-Einträge (TXT, MX, NS), Reverse-DNS, ASN/Hoster-Erkennung. Ziel kann jede beliebige Website sein.
2. **Aktive Scans nur mit Autorisierung:** nmap, nikto, sslscan, whatweb, dirb o. ä. nur ausführen, wenn der Nutzer bestätigt hat, dass er Eigentümer ist oder eine schriftliche Test-Erlaubnis für das Ziel besitzt. Ohne Bestätigung: nur passive Checks und den Bericht entsprechend kennzeichnen.
3. Keine Angriffs- oder Exploit-Techniken; nur Erkennung und Dokumentation.

## Ablauf

1. **Ziel klären:** Domain/URL abfragen (aus der Nutzeranfrage übernehmen). Bei aktiven Scans vorher die Autorisierung bestätigen lassen, falls nicht im Request enthalten.

2. **Daten sammeln (passiv, bevorzugt parallel):**
   * **Whois** (`whois example.com`): Registrant/Organisation, Registrar, Creation Date ("online seit"), Registry Expiry Date ("Auslaufdatum"), Name-Server.
   * **DNS** (`dig` / `host`): A/AAAA-Records → IP-Adresse(n); NS, MX, TXT; Reverse-DNS (`dig -x`).
   * **IP-Geolokation & Hoster:** ASN, ISP/Organisation via `whois <IP>` oder GeoIP-Tools (z. B. `whois`-Ausgabe von RIPE/ARIN). Land/Stadt der IP notieren.
   * **SSL/TLS** (`openssl s_client -connect host:443` + `openssl x509`): Issuer, Gültigkeitszeitraum, SANs; veraltete Protokolle/Zertifikate als Hinweis.
   * **HTTP-Header** (HEAD/GET auf Startseite): Server-, X-Powered-By-, CSP-, HSTS-, Security-Header-Check (fehlende Security-Header als Schwachstellen-Hinweise).
   * Optional per Web-Suche: Hosting-Provider (DNS/NS deutet oft auf Hoster), historische/kontextuelle Infos.

3. **Aktive Checks (nur autorisiert, z. B. mit nmap** `-sV -p 80,443`**, nikto, whatweb, sslscan):** offene Dienste, veraltete Softwareversionen, TLS-Schwächen, bekannte Banner-Schwachstellen.

4. **Bericht erstellen** als Markdown-Datei, Struktur siehe Berichts-Abschnitte.

## Bericht-Abschnitte

Ziel, Prüfzeitpunkt & Methodik (passiv/aktiv), tabellarische Übersicht der Fakten, dann Schwachstellen-/Hinweis-Liste mit Schweregrad (Kritisch/Hoch/Mittel/Niedrig/Info) und Empfehlung je Punkt, am Ende eine Kurz-Zusammenfassung (3–5 Sätze).

## Hinweise

* Whois-Daten können durch Privacy-Proxys (z. B. "REDACTED FOR PRIVACY") unkenntlich sein – das dokumentieren, nicht als Schwachstelle werten.
* IP hinter CDNs (Cloudflare & Co): dokumentierte IP ist Edge-/CDN-IP, nicht der Ursprungsserver – im Bericht kenntlich machen.
* Alle Werkzeug-Ausgaben intern halten; nur der aufbereitete Bericht ist nutzersichtbar.
