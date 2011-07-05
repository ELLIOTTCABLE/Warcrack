﻿local L = LibStub("AceLocale-3.0"):NewLocale("AuctionLite", "deDE");
if not L then return end

L["%dh"] = "%dh"
L["(none set)"] = "(nichts festgelegt)"
L["Accept"] = "Akzeptieren"
L["Add a new item to a favorites list by entering the name here."] = "Den Namen eines neuen Gegenstands hier eingeben um ihn der Favoriten-Liste hinzuzufügen."
L["Add an Item"] = "Gegenstand hinzufügen"
L["Advanced"] = "Erweitert"
L["Always"] = "Immer"
L["Amount to multiply by vendor price to get default sell price."] = "Faktor mit dem der Händlerpreis multipliziert werden soll um den Verkaufspreis festzulegen."
L["Approve"] = "Annehmen"
L["Auction"] = "Auktion"
L["Auction creation is already in progress."] = "Es werden bereits Auktionen erstellt."
L["Auction house data cleared."] = "Auktionshaus-Daten gelöscht."
L["Auction scan skipped (control key is down)"] = "Auktionsscan übersprungen"
L["AuctionLite"] = "AuctionLite"
L["AuctionLite - Buy"] = "AuctionLite - Kaufen"
L["AuctionLite - Sell"] = "AuctionLite - Verkaufen"
L["AuctionLite Buy"] = "AuctionLite Kauf"
L["AuctionLite Sell"] = "AuctionLite Verkauf"
L["AuctionLite v%s loaded!"] = "AuctionLite v%s geladen!"
L["Batch %d: %d at %s"] = "Stapel %d: %d bei %s"
-- L["Below AH"] = ""
L["Bid Per Item"] = "Gebot/Stück"
L["Bid Price"] = "Preis bieten"
L["Bid Total"] = "Gebot gesamt"
L["Bid Undercut"] = "Gebot unterbieten um"
-- L["Bid Undercut (Fixed)"] = ""
L["Bid cost for %d:"] = "Gebot für %d:"
L["Bid on %dx %s (%d |4listing:listings; at %s)."] = "Gebot auf %dx %s (%d |4Auktion:Auktionen; mit %s)."
L["Bought %dx %s (%d |4listing:listings; at %s)."] = "Gekauft %dx %s (%d |4Auktion:Auktionen; mit %s)."
L["Buy Tab"] = "Kaufen"
L["Buyout Per Item"] = "Sofortkauf/Stück"
L["Buyout Price"] = "Sofortkaufpreis"
L["Buyout Total"] = "Sofortkauf gesamt"
L["Buyout Undercut"] = "Sofortkauf unterbieten um"
-- L["Buyout Undercut (Fixed)"] = ""
L["Buyout cannot be less than starting bid."] = "Sofortkaufpreis kann nicht niedriger als das Anfangsgebot sein."
L["Buyout cost for %d:"] = "Sofortkauf für %d:"
L["CANCEL_CONFIRM_TEXT"] = "Auf einigen Deiner Auktionen wurde bereits geboten. Möchtest Du alle Auktionen abbrechen, nur Auktionen abbrechen auf die noch nicht geboten wurde oder garnichts tun?"
-- L["CANCEL_NOTE"] = ""
L["CANCEL_TOOLTIP"] = [=[|cffffffffKlick:|r Alle Auktionen abbrechen
|cffffffffSTRG-Klick:|r Unterbotene Auktionen abbrechen]=]
L["CLEAR_DATA_WARNING"] = "Möchtest du wirklich alle durch AuctionLite gesammelten Auktionshaus-Preisdaten löschen?"
L["Cancel"] = "Abbrechen"
L["Cancel All"] = "Alle abbrechen"
L["Cancel All Auctions"] = "Alle Auktionen abbrechen"
L["Cancel Unbid"] = "Nichtgebotene abbrechen"
L["Cancel Undercut Auctions"] = "Unterbotene Auktionen abbrechen"
L["Cancelled %d listings of %s"] = "%d Auktionen von %s abgebrochen"
L["Cancelled %d |4listing:listings; of %s."] = "%d |4listing:listings; von %s abgebrochen."
L["Choose a favorites list to edit."] = "Eine Favoriten-Liste zum Editieren auswählen"
L["Choose which tab is selected when opening the auction house."] = "Reiter der beim Öffnen der Auktionshauses ausgewählt wird."
L["Clear All"] = "Alles löschen"
L["Clear All Data"] = "Alle Daten löschen"
L["Clear all auction house price data."] = "Lösche alle Auktionshaus Preisdaten."
L["Competing Auctions"] = "Konkurrierende Auktionen"
L["Configure"] = "Konfiguration"
L["Configure AuctionLite"] = "Konfiguration"
L["Consider Resale Value When Buying"] = "Beim Kaufen den Wiederverkaufswert berücksichtigen"
L["Consider resale value of excess items when filling an order on the \"Buy\" tab."] = "Berücksichtige den Wiederverkaufswert von überschüssigen Gegenständen, wenn unter \"Verkaufen\" ein Gebot ausgefüllt wird."
L["Create a new favorites list."] = "Eine neue Favoriten-Liste erstellen."
L["Created %d |4auction:auctions; of %s x%d (%s total)."] = "\"%d |4Auktion:Auktionen; mit %3$dx %2$s erstellt (%s total).\""
L["Created %d |4auction:auctions; of %s x%d."] = "%d |4Auktion:Auktionen; mit %3$dx %2$s erstellt."
L["Current: %s (%.2fx historical)"] = "Aktuell: %s (%.2fx historischer Preis)"
L["Current: %s (%.2fx historical, %.2fx vendor)"] = "Aktuell: %s (%.2fx historischer Preis, %.2fx Händlerpreis)"
L["Current: %s (%.2fx vendor)"] = "Aktuell: %s (%.2fx Händlerpreis)"
L["Deals must be below the historical price by this much gold."] = "Angebote müssen den historischen Preis um so viel Gold unterschreiten."
L["Deals must be below the historical price by this percentage."] = "Angebote müssen den historischen Preis um so viel Prozent unterschreiten."
L["Default"] = "Vorgabe"
L["Default Number of Stacks"] = "Standard Stapelanzahl"
L["Default Stack Size"] = "Standard Stapelgröße"
L["Delete"] = "Löschen"
L["Delete the selected favorites list."] = "Die ausgewählte Favoriten-Liste löschen."
L["Disable"] = "Deaktivieren"
L["Disenchant"] = "Entzaubern"
L["Do Nothing"] = "Nichts tun"
L["Do it!"] = "Tu es!"
L["Enable"] = "Aktivieren"
L["Enter item name and click \"Search\""] = "Gegenstandsnamen eingeben und auf \"Suchen\" klicken"
L["Enter the name of the new favorites list:"] = "Den Namen für die neue Favoriten-Liste eingeben:"
L["Error locating item in bags.  Please try again!"] = "Fehler beim Erkennen des Gegenstands in den Taschen.  Bitte nochmals versuchen!"
L["Error when creating auctions."] = "Fehler beim Erstellen von Auktionen"
L["FAST_SCAN_AD"] = [=[AuctionLite's schneller Auktionsscan durchsucht das gesamte Auktionshaus in wenigen Sekunden. 

Dies kann allerdings, abhängig von Server und Internetverbindung, zu Verbindungsabbrüchen führen. Sollte dies geschehen können Sie den schnellen Auktionsscan in der Konfiguration deaktivieren. 

Schnellen Auktionsscan aktivieren?]=]
L["Fast Auction Scan"] = "Schneller Auktionsscan"
L["Fast auction scan disabled."] = "Schneller Auktionsscan deaktiviert."
L["Fast auction scan enabled."] = "Schneller Auktionsscan aktiviert."
L["Favorites"] = "Favoriten"
-- L["Fixed amount to undercut market value for bid prices (e.g., 1g 2s 3c)."] = ""
-- L["Fixed amount to undercut market value for buyout prices (e.g., 1g 2s 3c)."] = ""
L["Full Scan"] = "Scannen"
L["Full Stack"] = "Kompletter Stapel"
L["Hide Tooltips"] = "Tooltips ausblenden"
L["Historical Price"] = "Historischer Preis"
L["Historical price for %d:"] = "Historischer Preis für %d:"
L["Historical: %s (%d |4listing:listings;/scan, %d |4item:items;/scan)"] = "Historisch: %s (%d |4Auktion:Auktionen;/Scan, %d |4Gegenstand:Gegenstände;/Scan)"
L["If Applicable"] = "Wenn zutreffend"
L["Invalid starting bid."] = "Ungültiges Startgebot."
L["Item"] = "Gegenstand"
L["Item Summary"] = "Gegenstandszusammenfassung"
L["Items"] = "Gegenstände"
L["Last Used Tab"] = "Zuletzt benutzt"
-- L["Listing %d of %d"] = ""
L["Listings"] = "Auktionen"
L["Market Price"] = "Marktpreis"
L["Max Stacks"] = "Max. Stapel"
L["Max Stacks + Excess"] = "Max. Stapel + Überschuss"
L["Member Of"] = "Mitglieder von"
L["Minimum Profit (Gold)"] = "Minimaler Profit (Gold)"
L["Minimum Profit (Pct)"] = "Minimaler Profit (%)"
L["Mouse Cursor"] = "Mauscursor"
L["Name"] = "Name"
L["Net cost for %d:"] = "Netto-Kosten für %d:"
L["Never"] = "Niemals"
L["New..."] = "Neu..."
L["No current auctions"] = "Keine aktuellen Auktionen"
L["No deals found"] = "Keine Angebote gefunden"
L["No items found"] = "Keine Gegenstände gefunden"
L["Not enough cash for deposit."] = "Nicht genug Geld für Anzahlung"
L["Not enough items available."] = "Nicht genüg Gegenstände verfügbar."
L["Note: %d |4listing:listings; of %d |4item was:items were; not purchased."] = "Hinweis: %d |4Angebot:Angebot; von %d |4iGegenstand wurde:Gegenstände wurden; nicht gekauft."
L["Number of Items"] = "Anzahl der Gegenstände"
L["Number of Items |cff808080(max %d)|r"] = "Anzahl der Gegenstände |cff808080(max %d)|r"
L["Number of stacks suggested when an item is first placed in the \"Sell\" tab."] = "Anzahl der Stapel wird vorgeschlangen wenn ein Gegenstand im \"Verkaufen\" Reiter an Erster Stelle steht."
L["On the summary view, show how many listings/items are yours."] = "Zeige in der Zusammenfassung, wieviele Auktionen/Gegenständen Dir sind."
L["One Item"] = "Ein Gegenstand"
L["One Stack"] = "Ein Stapel"
L["Open All Bags at AH"] = "Alle Taschen im AH öffnen"
L["Open all your bags when you visit the auction house."] = "Alle deine Taschen öffnen wenn du das Auktionshaus besuchst."
L["Open configuration dialog"] = "Konfigurationsfenster öffnen"
L["Percent to undercut market value for bid prices (0-100)."] = "Prozentsatz um den der Marktwert für Gebote unterboten werden soll (0-100)."
L["Percent to undercut market value for buyout prices (0-100)."] = "Prozentsatz um den der Marktwert für den Sofortkauf unterboten werden soll (0-100)."
-- L["Placement of tooltips in \"Buy\" and \"Sell\" tabs."] = ""
L["Potential Profit"] = "Potenzieller Profit"
L["Pricing Method"] = "Art der Preisgestaltung"
L["Print Detailed Price Data"] = "Detailierte Preisdaten ausgeben"
L["Print detailed price data when selling an item."] = "Detailierte Preisdaten beim Verkauf eines Gegenstandes ausgeben."
L["Profiles"] = "Profile"
L["Qty"] = "Menge"
L["Remove Items"] = "Gegenstände entfernen"
L["Remove the selected items from the current favorites list."] = "Die ausgewählten Gegenstände von der aktuellen Favoriten-Liste entfernen."
L["Resell %d:"] = "Wiederverkaufe %d:"
-- L["Right Side of AH"] = ""
L["Round Prices"] = "Preise runden"
L["Round all prices to this granularity, or zero to disable (0-1)."] = "Alle Preise auf diese Granularität runden, oder auf Null zum Deaktivieren (0-1)."
L["Save All"] = "Alle speichern"
L["Saved Item Settings"] = "Gegenstandseinstellungen gespeichert"
L["Scan complete.  Try again later to find deals!"] = "Scan abgeschlossen.  Versuch es später noch einmal!"
L["Scanning..."] = "Scanne..."
L["Scanning:"] = "Scanne:"
L["Search"] = "Suche"
L["Searching:"] = "Suche:"
L["Select a Favorites List"] = "Eine Favoriten-Liste auswählen"
L["Selected Stack Size"] = "Ausgewählte Stapelgröße"
L["Sell Tab"] = "Verkaufen"
L["Show Auction Value"] = "Zeige Auktionswert"
L["Show Deals"] = "Zeige Angebote"
L["Show Disenchant Value"] = "Zeige Entzauberungswert"
L["Show Favorites"] = "Favoriten anzeigen"
L["Show Full Stack Price"] = "Zeige Preis für den gesamten Stapel"
L["Show How Many Listings are Mine"] = "Zeige wieviele Auktionen mir gehören"
L["Show My Auctions"] = "Meine Auktionen anzeigen"
L["Show Vendor Price"] = "Zeige Händlerpreis"
L["Show auction house value in tooltips."] = "Zeige Auktionswert im Tooltip"
L["Show expected disenchant value in tooltips."] = "Zeige erwarteten Entzauberungswert im Tooltip"
L["Show full stack prices in tooltips (shift toggles on the fly)."] = "Zeige den Preis ganzer Stapel im Tooltip (umschalten mit Shift)."
L["Show vendor sell price in tooltips."] = "Händlerpreise in den Tooltips anzeigen."
L["Stack Count"] = "Anzahl der Stapel"
L["Stack Size"] = "Stapelgröße"
L["Stack size suggested when an item is first placed in the \"Sell\" tab."] = "Stapelgröße wird vorgeschlagen, wenn ein Gegenstand als Erstes unter \"Verkaufen\" platziert ist."
L["Stack size too large."] = "Stapelgröße zu groß."
L["Start Tab"] = "Start-Tab"
L["Store Price Data"] = "Preisdaten speichern"
L["Store price data for all items seen (disable to save memory)."] = "Preisdaten für alle gesehenen Gegenstände speichern (deaktivieren um Speicher zu sparen)."
L["Time Elapsed:"] = "Zeit bisher:"
L["Time Remaining:"] = "Verbleibende Zeit:"
-- L["Tooltip Location"] = ""
L["Tooltips"] = "Tooltips"
L["Use Coin Icons in Tooltips"] = "Münzsymbole in Tooltips verwenden"
L["Use fast method for full scans (may cause disconnects)."] = "Die schnelle Methode für vollständige Scans nutzen (führt eventuell zu Disconnects)."
L["Uses the standard gold/silver/copper icons in tooltips."] = "Verwendet die Standard-Gold/Silber/Kupfer-Symbole in Tooltips."
L["VENDOR_WARNING"] = "Der Buyout-Preis liegt unter dem Händler-Verkaufswert. Möchtest du diese Auktion trotzdem erstellen?"
L["Vendor"] = "Händler"
L["Vendor Multiplier"] = "Händlerpreis Multiplikator"
L["Vendor: %s"] = "Händler: %s"
-- L["Window Corner"] = ""
L["per item"] = "pro Stück"
L["per stack"] = "pro Stapel"
L["stacks of"] = "Stapel je"
L["|cff00ff00Scanned %d listings.|r"] = "|cff00ff00%d gescannte Auktionen.|r"
L["|cff00ff00Using previous price.|r"] = "|cff00ff00Benutze vorherigen Preis.|r"
L["|cff808080(per item)|r"] = "|cff808080(je Stück)|r"
L["|cff808080(per stack)|r"] = "|cff808080(je Stapel)|r"
L["|cff8080ffData for %s x%d|r"] = "|cff8080ffDaten für %s x%d|r"
L["|cffff0000Buyout less than bid.|r"] = "|cffff0000Sofortkauf niedriger als Gebot.|r"
L["|cffff0000Buyout less than vendor price.|r"] = "|cffff0000Sofortkauf niedriger als Händlerpreis.|r"
L["|cffff0000Invalid stack size/count.|r"] = "|cffff0000Ungültige Stapelgröße/Anzahl.|r"
L["|cffff0000No bid price set.|r"] = "|cffff0000Kein Gebot-Preis festgelegt.|r"
L["|cffff0000Not enough cash for deposit.|r"] = "|cffff0000Nicht genug Geld für die Anzahlung.|r"
L["|cffff0000Not enough items available.|r"] = "|cffff0000Nicht genug Gegenstände verfügbar.|r"
L["|cffff0000Stack size too large.|r"] = "|cffff0000Stapelgröße zu groß.|r"
L["|cffff0000Using %.3gx vendor price.|r"] = "|cffff0000Benutze %.3gx Händlerpreis.|r"
L["|cffff0000[Error]|r Insufficient funds."] = "|cffff0000[Fehler]|r Nicht genügend Geld vorhanden."
L["|cffff0000[Warning]|r Skipping your own auctions.  You might want to cancel them instead."] = "|cffff0000[Warnung]|r Eigene Auktion vorhanden.  Vielleicht solltest du diese abbrechen."
L["|cffff7030Buyout less than vendor price.|r"] = "|cffff7030Buyout unter Händler-Verkaufswert.|r"
L["|cffff7030Stack %d will have %d |4item:items;.|r"] = "|cffff7030Stapel %d wird %d |4item:items; haben.|r"
L["|cffffd000Using historical data.|r"] = "|cffffd000Verwende historische Daten.|r"
L["|cffffff00Scanning: %d%%|r"] = "|cffffff00Scanne: %d%%|r"

