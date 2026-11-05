---
name: mail-reachability-check
description: >-
  Prüft passiv über DNS, ob eine Domain E-Mails empfangen und versenden kann, ohne die Domain selbst zu kontaktieren (MX, SPF, DMARC, DKIM, Hoster-Muster). Nutzen bei Fragen nach Mail-Erreichbarkeit und Domain-Infrastruktur.
---

# Mail-Reachability-Check (passive Domain-/Mail-Prüfung)

Prüft, ob eine Domain E-Mails **empfangen und versenden** kann, ohne die Domain selbst zu kontaktieren. Rein passive Quellen (DNS-Abfragen, Archiv, ggf. vom Nutzer bereitgestellte internet.nl-Tests).

## Arbeitsablauf

1. **Passive DNS-Abfragen** via DNS-over-HTTPS (liefert JSON):

   * `https://dns.google/resolve?name=<domain>&type=MX` — Mailserver (Empfangsfähigkeit)
   * `https://dns.google/resolve?name=<domain>&type=A` — Webhost-IP (IP-Bereich identifizieren: 217.160.x.x = IONOS/1&1 etc.)
   * `https://dns.google/resolve?name=<domain>&type=TXT` — SPF (`v=spf1 …`) = autorisierte Versandsysteme
   * `https://dns.google/resolve?name=_dmarc.<domain>&type=TXT` — DMARC-Policy
   * `https://dns.google/resolve?name=default._domainkey.<domain>&type=TXT` — DKIM (Zusätzlich testen: `selector1._domainkey.`/`selector2._domainkey.` = Microsoft-365-Standard-Selektoren; `google._domainkey.`/`krs._domainkey.` = Google-Workspace)
   * `https://dns.google/resolve?name=<domain>&type=NS` und `&type=SOA` — Registrar-/Zone-Betreiber + Serial (Datumsmuster lesen: z. B. `2017060112` = Zone-Seriennummer-Schema des Hosters)

2. **internet.nl-Mailtest** (falls Nutzer eine Test-ID/URL nennt): `https://internet.nl/mail/<domain>/<ID>/` öffnen. ⚠ Die Ergebnislisten sind JS-gerendert und blocken oft automatisierten Zugriff — in dem Fall den Nutzer um **Kopie/Screenshot der Teilresultate** bitten (der Nutzer kann den Test im Browser ausführen: `https://internet.nl/mail/<domain>/`). Beweisfixierung: Permalink + Test-Zeitstempel (UTC) notieren.

   **internet.nl-Bericht parsen (aus Nutzer-Kopie)** — Extraktionsschablone:

   * **Score + Zeitstempel** notieren (z. B. „67 %, 2026-10-05 13:22 UTC").
   * **Fünf Kategorien** in Kompakttabelle übernehmen: IPv6 (Passed/Failed) · DNSSEC · Phishing-Marken (DMARC/DKIM/SPF) · Transportverschlüsselung (STARTTLS/DANE) · RPKI.
   * **Erreichbarkeits-Relevanz priorisieren:** Für „kann die Domain Mails empfangen/versenden?" sind ONLY relevant: MX-Eintrag (Mail server(s)-Tabelle), SPF existence + policy, DMARC/DKIM existence, STARTTLS available. Die Kategorien DNSSEC/IPv6/RPKI und Cipher-Suiten sind Sicherheits-, NICHT Erreichbarkeitsaussagen — getrennt ausweisen.
   * **Verantwortlichkeits-Trennung (wichtig gegen Fehlinterpretation):** Bei MX auf `*.mail.protection.outlook.com` (Microsoft 365) sind **Failed-Cipher-Suiten, SHA-1-Key-Exchange, RSA-2048-„phase out"** Artefakte des **Microsoft-Standard-Endpoints** — dieselben Fehler hätte jeder M365-Mandant; NICHT domain-betreiber-verursacht. **Domain-Betreiber-verantwortet** sind nur: DMARC-Record, DKIM-Records, DNSSEC-Signatur der eigenen Zone. Diese Trennung im Befund ausdrücklich kennzeichnen.
   * **Ableitungslogik Fazit:** Empfang = MX vorhanden + STARTTLS „yes" (Transport funktioniert, ggf. mit TLS-Einschränkungen). Versand = SPF „Passed" (existence + policy) + DKIM-Status; fehlendes DKIM/DMARC heißt NICHT „kann nicht versenden", sondern „Versand unauthentifiziert/spoofing-anfällig".
   * **Muster-Hinweis:** „Registrar: None" in der DNSSEC-Tabelle = keine Aussage über Registrar (nicht als „unregistriert" lesen); Registrar-Daten nur via WHOIS.

3. **Erreichbarkeits-Fazit ableiten** (niemals messen durch Senden!):

   * **Empfang möglich, wenn:** ein MX-Record existiert und auf einen seriösen Mail-Hoster zeigt (z. B. `*.mail.protection.outlook.com` = Microsoft 365, `*.bluehost.com`, `mail.*` bei IONOS etc.). Ein vorhandener MX + SPF auf denselben Dienst = funktionsfähige Postfach-Landschaft (Postfächer selbst sind per DNS nicht verifizierbar — nur der Zustellweg).
   * **Versand möglich, wenn:** SPF `include:`-Einträge die Versandsysteme autorisieren (M365: `spf.protection.outlook.com`; IONOS: `_spf-eu.ionos.com`; Google: `_spf.google.com`). DKIM-Selektoren prüfen.
   * **Lücken bewerten:** fehlendes DMARC = Spoofing-/Compliance-Lücke; fehlende DKIM-Standard-Selektoren; Web-/Mail-Host-Divergenz (z. B. IONOS-Webhost zeigt Placeholder einer dritten Firma, Mail läuft woanders).

4. **Muster erkennen**:

   * `*-de.mail.protection.outlook.com` = Microsoft-365-Mandant (DE-Region) — Mandanten-Suffixmuster mit anderen Domains desselben Orbits vergleichen (gleiche Infrastruktur-Familie = Hinweis auf gemeinsamen IT-Betreiber, KEIN Beweis).
   * IONOS-IP-Bereich `217.160.0.0/16` + `ui-dns.*`-Nameserver = IONOS-Hosting (Platzhalter-/WordPress-Standardseiten sind dort typisch).
   * SOA-Seriennummer-Datumsschema lesen (ältere Zone-Serien deuten auf alte Domain-Konfiguration; beweist keine Registrierung — dafür WHOIS).

5. **Dokumentation:** Befund als strukturierte Tabelle (Record | Wert | Bedeutung) ausgeben; im laufenden Fall ins Kompendium übernehmen mit Portalstand/Datum; Beweisfixierungshinweis geben (DNS-Werte haben TTL und ändern sich — Screenshot/Abrufdatum sichern).

## Kautelen (kritisch)

* **NIEMALS Test-Mails senden, kein SMTP-Handshake, kein Telnet-Port-25-Probe** — das wäre ein Kontakt zum Ziel. Passiv = DNS-Lesen + vom Nutzer bereitgestellte Testergebnisse only.
* Domain-/DNS-Daten als **Portaldaten mit Abrufdatum** kennzeichnen; Hypothese vs. Tatsache trennen (Infrastruktur-Gleichheit = Indiz, nicht Beweis für Betrieberschaft).
* WHOIS-Daten (Registrant) je nach DSGVO-Privacy oft geschützt — nur berichten, was real sichtbar ist.
