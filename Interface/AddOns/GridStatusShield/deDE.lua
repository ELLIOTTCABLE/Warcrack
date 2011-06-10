local L = LibStub("AceLocale-3.0"):NewLocale("GridStatusShield", "deDE")

if not L then return end

L["Shield left"] = "Verbleibender Schild"
L["Aegis detection tolerance"] = "Aegis Erkennungs-Toleranz"
L["Increase this parameter if your Divine Aegis isn't not correctly detected. But can also lead to miss detection the higher the value is."] =
            "Erh\195\182he diesen Wert falls deine G\195\182ttliche Aegis nicht korrekt erkannt wird. Je gr\195\182\195\159er der Wert desto gr\195\182\195\159er allerdings auch die Chance auf Fehlerkennungen."
L["Low shield color"] = "Niedriges schild Farbe"
L["Medium shield color"] = "Mittleres Schild Farbe"
L["Low shield threshold"] = "Niedriges Schild Schranke"
L["Medium shield threshold"] = "Mittleres Schild Schranke"
L["Color for shield amount below the low shield threshold."] = "Farbe fuer Schilde deren verbleibende Staerke unter der niedriges Schild Schranke liegen."
L["Color for shield amount below the medium shield threshold."] = "Farbe fuer Schilde deren verbleibende Staerke unter der mittleres Schild Schranke liegen."
L["The threshold below which a shield is considered low."] = "Die Schranke unter welcher Schilde als neidrig eingestuft werden."
L["The threshold below which a shield is considered medium."] = "Die Schranke unter welcher Schilde als mittel eingestuft werden."
L["Use combat log"] = "Nutze Kampflog"
L["Uses the combat log to detect shields. This can be faster but is also be more inaccurate."] = "Benutze das Kampflog um Schilde zu erkennen. Dies kann schneller sein ist aber auch ungenauer."
L["[aA]bsorbs.- (%d+) .-damage"] = "[Aa]bsorbiert.- (%d+) .-[sS]chaden"