---
name: index-bibliothek
description: >-
  Pflegt eine durchsuchbare Index-Bibliothek aller recherchierten Normen, Urteile, Verfahren und Dokumente mit Querverweisen und Aktualitäts-Stand. Nutzen bei Wiederholungsfragen, Mandatsübersichten und um Doppelrecherche zu vermeiden.
---

# Skill: Index-Bibliothek (08)

Ziel: Ein zentrale, durchsuchbare Wissensbasis aufbauen, damit bereits Recherchiertes nicht verloren geht und wiederverwendbar ist.

## Ablauf

1. **Vor jeder neuen Recherche:** Index prüfen – wurde die Norm/das Urteil schon recherchiert und ist der Stand noch aktuell?
2. **Index-Einträge erfassen** (in `memory/index-bibliothek.md`, nach Vorlage unten):
   - Normen: Fundstelle, Stand (i. d. F. v. …), Kernaussage, Mandate/Themen
   - Urteile: Gericht, Az., Datum, Kernaussage, Fundstelle, Skill-06-Analysen verlinken
   - Verfahren: Mandat, Gericht, Stand, nächste Schritte (→ Skill 07)
   - Dokumente: Was, wo zu finden, Status
3. **Querverweise setzen:** Jeder Eintrag verweist auf verwandte Einträge (z. B. Norm ↔ Urteil ↔ Verfahren) – so entsteht eine Bibliothek statt isolierter Notizen.
4. **Aktualität verwalten:** Jeder Eintrag hat ein „Stand"-Datum; bei Recherche-Treffer prüfen, ob sich Norm/Urt. geändert hat (→ Skill 01/02). Veraltete Einträge nicht löschen, sondern als „überholt (Stand …)" markieren.
5. **Abfrage unterstützen:** Bei Nutzerfragen den Index durchsuchen (Stichworte, Normen, Az.) und vor neuer Web-Recherche die eigene Bibliothek zuerst konsultieren.

## Vorlage: `memory/index-bibliothek.md`

```markdown
# F.E.E. Index-Bibliothek

## Normen
| Norm | Stand | Kernaussage | Verwandte Einträge |
|---|---|---|---|
| § 4 KSchG | i. d. F. v. … | 3-Wochen-Frist Kündigungsschutz | BGH/BAG …, Mandat … |

## Rechtsprechung
| Gericht | Az. | Datum | Kernaussage | Verwandte |
|---|---|---|---|---|
| BAG | … | … | … | § 4 KSchG |

## Verfahren & Mandate
| Mandat | Gericht | Stand | Nächster Schritt (⚠️ Frist) |
|---|---|---|---|
| … | … | … | … |

## Änderungshistorie
- [Datum] Eintrag X als überholt markiert (Grund)
```

## Regeln

- Keine Einträge ohne Quelle bzw. Verifikationsstand („verifiziert am / nur aus Gedächtnis").
- Keine sensiblen Personendaten im Index, wenn nicht ausdrücklich gewünscht (`security/hinweise.md`, DSGVO).
- Index ist Gedächtnis, nicht Beweis: Für Ausgaben gilt weiterhin Quellenpflicht (Instinct 1).
