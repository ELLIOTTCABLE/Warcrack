local S = SMARTBUFF_GLOBALS;

SMARTBUFF_PLAYERCLASS = nil;
SMARTBUFF_BUFFLIST = nil;

-- Buff types
SMARTBUFF_CONST_ALL       = "ALL";
SMARTBUFF_CONST_GROUP     = "GROUP";
SMARTBUFF_CONST_GROUPALL  = "GROUPALL";
SMARTBUFF_CONST_SELF      = "SELF";
SMARTBUFF_CONST_FORCESELF = "FORCESELF";
SMARTBUFF_CONST_TRACK     = "TRACK";
SMARTBUFF_CONST_WEAPON    = "WEAPON";
SMARTBUFF_CONST_INV       = "INVENTORY";
SMARTBUFF_CONST_FOOD      = "FOOD";
SMARTBUFF_CONST_SCROLL    = "SCROLL";
SMARTBUFF_CONST_POTION    = "POTION";
SMARTBUFF_CONST_STANCE    = "STANCE";
SMARTBUFF_CONST_ITEM      = "ITEM";
SMARTBUFF_CONST_ITEMGROUP = "ITEMGROUP";


function SMARTBUFF_InitItemList()  
  -- Reagents
  SMARTBUFF_WILDBERRIES         = GetItemInfo(17021); --"Wild Berries"
  SMARTBUFF_WILDTHORNROOT       = GetItemInfo(17026); --"Wild Thornroot"
  SMARTBUFF_WILDQUILLVINE       = GetItemInfo(22148); --"Wild Quillvine"
  SMARTBUFF_WILDSPINELEAF       = GetItemInfo(44605); --"Wild Spineleaf"
  SMARTBUFF_ARCANEPOWDER        = GetItemInfo(17020); --"Arcane Powder"
  SMARTBUFF_HOLYCANDLE          = GetItemInfo(17028); --"Holy Candle"
  SMARTBUFF_SACREDCANDLE        = GetItemInfo(17029); --"Sacred Candle"
  SMARTBUFF_DEVOUTCANDLE        = GetItemInfo(44615); --"Devout Candle"
  SMARTBUFF_SYMBOLOFKINGS       = GetItemInfo(21177); --"Symbol of Kings"
  
  -- Stones and oils
  SMARTBUFF_HEALTHSTONE         = GetItemInfo(5512);  --"Healthstone"
  SMARTBUFF_SOULSTONE           = GetItemInfo(5232);  --"Soulstone"
  SMARTBUFF_MANAGEM             = GetItemInfo(36799); --"Mana Gem"
  SMARTBUFF_SSROUGH             = GetItemInfo(2862);  --"Rough Sharpening Stone"
  SMARTBUFF_SSCOARSE            = GetItemInfo(2863);  --"Coarse Sharpening Stone"
  SMARTBUFF_SSHEAVY             = GetItemInfo(2871);  --"Heavy Sharpening Stone"
  SMARTBUFF_SSSOLID             = GetItemInfo(7964);  --"Solid Sharpening Stone"
  SMARTBUFF_SSDENSE             = GetItemInfo(12404); --"Dense Sharpening Stone"
  SMARTBUFF_SSELEMENTAL         = GetItemInfo(18262); --"Elemental Sharpening Stone"
  SMARTBUFF_SSFEL               = GetItemInfo(23528); --"Fel Sharpening Stone"
  SMARTBUFF_SSADAMANTITE        = GetItemInfo(23529); --"Adamantite Sharpening Stone"
  SMARTBUFF_WSROUGH             = GetItemInfo(3239);  --"Rough Weightstone"
  SMARTBUFF_WSCOARSE            = GetItemInfo(3240);  --"Coarse Weightstone"
  SMARTBUFF_WSHEAVY             = GetItemInfo(3241);  --"Heavy Weightstone"
  SMARTBUFF_WSSOLID             = GetItemInfo(7965);  --"Solid Weightstone"
  SMARTBUFF_WSDENSE             = GetItemInfo(12643); --"Dense Weightstone"
  SMARTBUFF_WSFEL               = GetItemInfo(28420); --"Fel Weightstone"
  SMARTBUFF_WSADAMANTITE        = GetItemInfo(28421); --"Adamantite Weightstone"
  SMARTBUFF_SHADOWOIL           = GetItemInfo(3824);  --"Shadow Oil"
  SMARTBUFF_FROSTOIL            = GetItemInfo(3829);  --"Frost Oil"
  SMARTBUFF_MANAOIL1            = GetItemInfo(20745); --"Minor Mana Oil"
  SMARTBUFF_MANAOIL2            = GetItemInfo(20747); --"Lesser Mana Oil"
  SMARTBUFF_MANAOIL3            = GetItemInfo(20748); --"Brilliant Mana Oil"
  SMARTBUFF_MANAOIL4            = GetItemInfo(22521); --"Superior Mana Oil"
  SMARTBUFF_MANAOIL5            = GetItemInfo(36899); --"Exceptional Mana Oil"
  SMARTBUFF_WIZARDOIL1          = GetItemInfo(20744); --"Minor Wizard Oil"
  SMARTBUFF_WIZARDOIL2          = GetItemInfo(20746); --"Lesser Wizard Oil"
  SMARTBUFF_WIZARDOIL3          = GetItemInfo(20750); --"Wizard Oil"
  SMARTBUFF_WIZARDOIL4          = GetItemInfo(20749); --"Brilliant Wizard Oil"
  SMARTBUFF_WIZARDOIL5          = GetItemInfo(22522); --"Superior Wizard Oil"
  SMARTBUFF_WIZARDOIL6          = GetItemInfo(36900); --"Exceptional Wizard Oil"
  
  -- Poisons
  SMARTBUFF_INSTANTPOISON1      = GetItemInfo(6947);  --"Instant Poison"
  SMARTBUFF_WOUNDPOISON1        = GetItemInfo(10918); --"Wound Poison"
  SMARTBUFF_MINDPOISON1         = GetItemInfo(5237);  --"Mind-numbing Poison"
  SMARTBUFF_DEADLYPOISON1       = GetItemInfo(2892);  --"Deadly Poison"
  SMARTBUFF_CRIPPLINGPOISON1    = GetItemInfo(3775);  --"Crippling Poison"
  SMARTBUFF_ANESTHETICPOISON1   = GetItemInfo(21835); --"Anesthetic Poison"
  
  -- Food
  SMARTBUFF_SAGEFISHDELIGHT     = GetItemInfo(21217); --"Sagefish Delight"
  SMARTBUFF_BUZZARDBITES        = GetItemInfo(27651); --"Buzzard Bites"
  SMARTBUFF_RAVAGERDOG          = GetItemInfo(27655); --"Ravager Dog"
  SMARTBUFF_FELTAILDELIGHT      = GetItemInfo(27662); --"Feltail Delight"
  SMARTBUFF_CLAMBAR             = GetItemInfo(30155); --"Clam Bar"
  SMARTBUFF_BROILEDBLOODFIN     = GetItemInfo(33867); --"Broiled Bloodfin"
  SMARTBUFF_SPORELINGSNACK      = GetItemInfo(27656); --"Sporeling Snack"
  SMARTBUFF_BLACKENEDSPOREFISH  = GetItemInfo(27663); --"Blackened Sporefish"
  SMARTBUFF_BLACKENEDBASILISK   = GetItemInfo(27657); --"Blackened Basilisk"
  SMARTBUFF_GRILLEDMUDFISH      = GetItemInfo(27664); --"Grilled Mudfish"
  SMARTBUFF_POACHEDBLUEFISH     = GetItemInfo(27665); --"Poached Bluefish"
  SMARTBUFF_ROASTEDCLEFTHOOF    = GetItemInfo(27658); --"Roasted Clefthoof"
  SMARTBUFF_SPICYHOTTALBUK      = GetItemInfo(33872); --"Spicy Hot Talbuk"
  SMARTBUFF_SKULLFISHSOUP       = GetItemInfo(33825); --"Skullfish Soup"
  SMARTBUFF_WARPBURGER          = GetItemInfo(27659); --"Warp Burger"
  SMARTBUFF_TALBUKSTEAK         = GetItemInfo(27660); --"Talbuk Steak"
  SMARTBUFF_GOLDENFISHSTICKS    = GetItemInfo(27666); --"Golden Fish Sticks"
  SMARTBUFF_CRUNCHYSERPENT      = GetItemInfo(31673); --"Crunchy Serpent"
  SMARTBUFF_MOKNATHALSHORTRIBS  = GetItemInfo(31672); --"Mok'Nathal Shortribs"
  SMARTBUFF_SPICYCRAWDAD        = GetItemInfo(27667); --"Spicy Crawdad"
  --SMARTBUFF_FISHERMANSFEAST     = GetItemInfo(33052); --"Fisherman's Feast"
  --SMARTBUFF_HOTAPPLECIDER       = GetItemInfo(34411); --"Hot Apple Cider"
  SMARTBUFF_WOTLKFOOD1          = GetItemInfo(34748); --"Mammoth Meal"
  SMARTBUFF_WOTLKFOOD2          = GetItemInfo(43268); --"Dalaran Clam Chowder"
  SMARTBUFF_WOTLKFOOD3          = GetItemInfo(42942); --"Baked Manta Ray"
  SMARTBUFF_WOTLKFOOD4          = GetItemInfo(34762); --"Grilled Sculpin"
  SMARTBUFF_WOTLKFOOD5          = GetItemInfo(34763); --"Smoked Salmon"
  SMARTBUFF_WOTLKFOOD6          = GetItemInfo(34765); --"Pickled Fangtooth"
  SMARTBUFF_WOTLKFOOD7          = GetItemInfo(34764); --"Poached Nettlefish"
  SMARTBUFF_WOTLKFOOD8          = GetItemInfo(34749); --"Shoveltusk Steak"
  SMARTBUFF_WOTLKFOOD9          = GetItemInfo(34750); --"Wyrm Delight"
  SMARTBUFF_WOTLKFOOD10         = GetItemInfo(34751); --"Roasted Worg"
  SMARTBUFF_WOTLKFOOD11         = GetItemInfo(34752); --"Rhino Dogs"
  SMARTBUFF_WOTLKFOOD12         = GetItemInfo(34757); --"Very Burnt Worg"
  SMARTBUFF_WOTLKFOOD13         = GetItemInfo(43001); --"Tracker Snacks"
  SMARTBUFF_WOTLKFOOD14         = GetItemInfo(34755); --"Tender Shoveltusk Steak"
  SMARTBUFF_WOTLKFOOD15         = GetItemInfo(42993); --"Spicy Fried Herring"
  SMARTBUFF_WOTLKFOOD16         = GetItemInfo(34768); --"Spicy Blue Nettlefish"
  SMARTBUFF_WOTLKFOOD17         = GetItemInfo(34756); --"Spiced Wyrm Burger"
  SMARTBUFF_WOTLKFOOD18         = GetItemInfo(42996); --"Snapper Extreme"
  SMARTBUFF_WOTLKFOOD19         = GetItemInfo(42994); --"Rhinolicious Wyrmsteak"
  SMARTBUFF_WOTLKFOOD20         = GetItemInfo(34766); --"Poached Northern Sculpin"
  SMARTBUFF_WOTLKFOOD21         = GetItemInfo(34758); --"Mighty Rhino Dogs"
  SMARTBUFF_WOTLKFOOD22         = GetItemInfo(34754); --"Mega Mammoth Meal"
  SMARTBUFF_WOTLKFOOD23         = GetItemInfo(34769); --"Imperial Manta Steak"
  SMARTBUFF_WOTLKFOOD24         = GetItemInfo(42995); --"Hearty Rhino"
  SMARTBUFF_WOTLKFOOD25         = GetItemInfo(34767); --"Firecracker Salmon"
  SMARTBUFF_WOTLKFOOD26         = GetItemInfo(43000); --"Dragonfin Filet"
  SMARTBUFF_WOTLKFOOD27         = GetItemInfo(42998); --"Cuttlesteak"
  SMARTBUFF_WOTLKFOOD28         = GetItemInfo(42997); --"Blackened Worg Steak"
  SMARTBUFF_WOTLKFOOD29         = GetItemInfo(42999); --"Blackened Dragonfin"
  SMARTBUFF_WOTLKFOOD30         = GetItemInfo(42779); --"Steaming Chicken Soup"
  SMARTBUFF_WOTLKFOOD31         = GetItemInfo(34125); --"Shoveltusk Soup"
  SMARTBUFF_WOTLKFOOD32         = GetItemInfo(39691); --"Succulent Orca Stew"  
  SMARTBUFF_FOODCT1             = GetItemInfo(62661); --"Baked Rockfish"
  SMARTBUFF_FOODCT2             = GetItemInfo(62665); --"Basilisk Liverdog"
  SMARTBUFF_FOODCT3             = GetItemInfo(62670); --"Beer-Basted Crocolisk"
  SMARTBUFF_FOODCT4             = GetItemInfo(62668); --"Blackbelly Sushi"
  SMARTBUFF_FOODCT5             = GetItemInfo(62664); --"Crocolisk Au Gratin"
  SMARTBUFF_FOODCT6             = GetItemInfo(62666); --"Delicious Sagefish Tail"
  SMARTBUFF_FOODCT7             = GetItemInfo(62662); --"Grilled Dragon"
  SMARTBUFF_FOODCT8             = GetItemInfo(62667); --"Mushroom Sauce Mudfish"
  SMARTBUFF_FOODCT9             = GetItemInfo(62671); --"Severed Sagefish Head"
  SMARTBUFF_FOODCT10            = GetItemInfo(62669); --"Skewered Eel"
  SMARTBUFF_FOODCT11            = GetItemInfo(62659); --"Hearty Seafood Soup"
  SMARTBUFF_FOODCT12            = GetItemInfo(62660); --"Pickled Guppy"
  SMARTBUFF_FOODCT13            = GetItemInfo(62658); --"Tender Baked Turtle"
  SMARTBUFF_FOODCT14            = GetItemInfo(62663); --"Lavascale Minestrone"
  SMARTBUFF_FOODCT15            = GetItemInfo(62655); --"Broiled Mountain Trout"
  SMARTBUFF_FOODCT16            = GetItemInfo(62654); --"Lavascale Fillet"
  SMARTBUFF_FOODCT17            = GetItemInfo(62651); --"Lightly Fried Lurker"
  SMARTBUFF_FOODCT18            = GetItemInfo(62657); --"Lurker Lunch"
  SMARTBUFF_FOODCT19            = GetItemInfo(62653); --"Salted Eye"
  SMARTBUFF_FOODCT20            = GetItemInfo(62652); --"Seasoned Crab"
  SMARTBUFF_FOODCT21            = GetItemInfo(62656); --"Whitecrest Gumbo"
  SMARTBUFF_FOODCT22            = GetItemInfo(62649); --"Fortune Cookie"
  --SMARTBUFF_FOODCT22            = GetItemInfo(11111); --"Food"
  
  --SMARTBUFF_BCPETFOOD1          = GetItemInfo(33874); --"Kibler's Bits (Pet food)"
  --SMARTBUFF_WOTLKPETFOOD1       = GetItemInfo(43005); --"Spiced Mammoth Treats (Pet food)"
  
  
  -- Scrolls
  SMARTBUFF_SOAGILITY1          = GetItemInfo(3012);  --"Scroll of Agility I"
  SMARTBUFF_SOAGILITY2          = GetItemInfo(1477);  --"Scroll of Agility II"
  SMARTBUFF_SOAGILITY3          = GetItemInfo(4425);  --"Scroll of Agility III"
  SMARTBUFF_SOAGILITY4          = GetItemInfo(10309); --"Scroll of Agility IV"
  SMARTBUFF_SOAGILITY5          = GetItemInfo(27498); --"Scroll of Agility V"
  SMARTBUFF_SOAGILITY6          = GetItemInfo(33457); --"Scroll of Agility VI"
  SMARTBUFF_SOAGILITY7          = GetItemInfo(43463); --"Scroll of Agility VII"
  SMARTBUFF_SOAGILITY8          = GetItemInfo(43464); --"Scroll of Agility VIII"
  SMARTBUFF_SOAGILITY9          = GetItemInfo(63303); --"Scroll of Agility IX"
  SMARTBUFF_SOINTELLECT1        = GetItemInfo(955);   --"Scroll of Intellect I"
  SMARTBUFF_SOINTELLECT2        = GetItemInfo(2290);  --"Scroll of Intellect II"
  SMARTBUFF_SOINTELLECT3        = GetItemInfo(4419);  --"Scroll of Intellect III"
  SMARTBUFF_SOINTELLECT4        = GetItemInfo(10308); --"Scroll of Intellect IV"
  SMARTBUFF_SOINTELLECT5        = GetItemInfo(27499); --"Scroll of Intellect V"
  SMARTBUFF_SOINTELLECT6        = GetItemInfo(33458); --"Scroll of Intellect VI"
  SMARTBUFF_SOINTELLECT7        = GetItemInfo(37091); --"Scroll of Intellect VII"
  SMARTBUFF_SOINTELLECT8        = GetItemInfo(37092); --"Scroll of Intellect VIII"
  SMARTBUFF_SOINTELLECT9        = GetItemInfo(63305); --"Scroll of Intellect IX"
  SMARTBUFF_SOSTAMINA1          = GetItemInfo(1180);  --"Scroll of Stamina I"
  SMARTBUFF_SOSTAMINA2          = GetItemInfo(1711);  --"Scroll of Stamina II"
  SMARTBUFF_SOSTAMINA3          = GetItemInfo(4422);  --"Scroll of Stamina III"
  SMARTBUFF_SOSTAMINA4          = GetItemInfo(10307); --"Scroll of Stamina IV"
  SMARTBUFF_SOSTAMINA5          = GetItemInfo(27502); --"Scroll of Stamina V"
  SMARTBUFF_SOSTAMINA6          = GetItemInfo(33461); --"Scroll of Stamina VI"
  SMARTBUFF_SOSTAMINA7          = GetItemInfo(37093); --"Scroll of Stamina VII"
  SMARTBUFF_SOSTAMINA8          = GetItemInfo(37094); --"Scroll of Stamina VIII"
  SMARTBUFF_SOSTAMINA9          = GetItemInfo(63306); --"Scroll of Stamina IX"
  SMARTBUFF_SOSPIRIT1           = GetItemInfo(1181);  --"Scroll of Spirit I"
  SMARTBUFF_SOSPIRIT2           = GetItemInfo(1712);  --"Scroll of Spirit II"
  SMARTBUFF_SOSPIRIT3           = GetItemInfo(4424);  --"Scroll of Spirit III"
  SMARTBUFF_SOSPIRIT4           = GetItemInfo(10306); --"Scroll of Spirit IV"
  SMARTBUFF_SOSPIRIT5           = GetItemInfo(27501); --"Scroll of Spirit V"
  SMARTBUFF_SOSPIRIT6           = GetItemInfo(33460); --"Scroll of Spirit VI"
  SMARTBUFF_SOSPIRIT7           = GetItemInfo(37097); --"Scroll of Spirit VII"
  SMARTBUFF_SOSPIRIT8           = GetItemInfo(37098); --"Scroll of Spirit VIII"
  SMARTBUFF_SOSPIRIT9           = GetItemInfo(63307); --"Scroll of Spirit IX"
  SMARTBUFF_SOSTRENGHT1         = GetItemInfo(954);   --"Scroll of Strength I"
  SMARTBUFF_SOSTRENGHT2         = GetItemInfo(2289);  --"Scroll of Strength II"
  SMARTBUFF_SOSTRENGHT3         = GetItemInfo(4426);  --"Scroll of Strength III"
  SMARTBUFF_SOSTRENGHT4         = GetItemInfo(10310); --"Scroll of Strength IV"
  SMARTBUFF_SOSTRENGHT5         = GetItemInfo(27503); --"Scroll of Strength V"
  SMARTBUFF_SOSTRENGHT6         = GetItemInfo(33462); --"Scroll of Strength VI"
  SMARTBUFF_SOSTRENGHT7         = GetItemInfo(43465); --"Scroll of Strength VII"
  SMARTBUFF_SOSTRENGHT8         = GetItemInfo(43466); --"Scroll of Strength VIII"
  SMARTBUFF_SOSTRENGHT9         = GetItemInfo(63304); --"Scroll of Strength IX"
  SMARTBUFF_SOPROTECTION9       = GetItemInfo(63308); --"Scroll of Protection IX"
  
  SMARTBUFF_MiscItem1           = GetItemInfo(71134); --"Celebration Package"
  SMARTBUFF_MiscItem2           = GetItemInfo(44986); --"Warts-B-Gone Lip Balm"
  
  SMARTBUFF_FLASK1              = GetItemInfo(46377);  --"Flask of Endless Rage"
  SMARTBUFF_FLASK2              = GetItemInfo(46376);  --"Flask of the Frost Wyrm"
  SMARTBUFF_FLASK3              = GetItemInfo(46379);  --"Flask of Stoneblood"
  SMARTBUFF_FLASK4              = GetItemInfo(46378);  --"Flask of Pure Mojo"
  SMARTBUFF_FLASK5              = GetItemInfo(47499);  --"Flask of the North"  
  SMARTBUFF_FLASKCT1            = GetItemInfo(58087);  --"Flask of the Winds"
  SMARTBUFF_FLASKCT2            = GetItemInfo(58088);  --"Flask of Titanic Strength"
  SMARTBUFF_FLASKCT3            = GetItemInfo(58086);  --"Flask of the Draconic Mind"
  SMARTBUFF_FLASKCT4            = GetItemInfo(58085);  --"Flask of Steelskin"
  SMARTBUFF_FLASKCT5            = GetItemInfo(67438);  --"Flask of Flowing Water"
  SMARTBUFF_FLASKCT6            = GetItemInfo(58149);  --"Flask of Enhancement"
  SMARTBUFF_FLASKCT7            = GetItemInfo(65455);  --"Flask of Battle"
  
  SMARTBUFF_ELIXIR1             = GetItemInfo(39666);  --"Elixir of Mighty Agility"
  SMARTBUFF_ELIXIR2             = GetItemInfo(44332);  --"Elixir of Mighty Thoughts"
  SMARTBUFF_ELIXIR3             = GetItemInfo(40078);  --"Elixir of Mighty Fortitude"
  SMARTBUFF_ELIXIR4             = GetItemInfo(40073);  --"Elixir of Mighty Strength"
  SMARTBUFF_ELIXIR5             = GetItemInfo(40072);  --"Elixir of Spirit"
  SMARTBUFF_ELIXIR6             = GetItemInfo(40097);  --"Elixir of Protection"
  SMARTBUFF_ELIXIR7             = GetItemInfo(44328);  --"Elixir of Mighty Defense"
  SMARTBUFF_ELIXIR8             = GetItemInfo(44331);  --"Elixir of Lightning Speed"
  SMARTBUFF_ELIXIR9             = GetItemInfo(44329);  --"Elixir of Expertise"
  SMARTBUFF_ELIXIR10            = GetItemInfo(44327);  --"Elixir of Deadly Strikes"
  SMARTBUFF_ELIXIR11            = GetItemInfo(44330);  --"Elixir of Armor Piercing"
  SMARTBUFF_ELIXIR12            = GetItemInfo(44325);  --"Elixir of Accuracy"
  SMARTBUFF_ELIXIR13            = GetItemInfo(40076);  --"Guru's Elixir"
  SMARTBUFF_ELIXIR14            = GetItemInfo(9187);   --"Elixir of Greater Agility"
  SMARTBUFF_ELIXIR15            = GetItemInfo(28103);  --"Adept's Elixir"
  SMARTBUFF_ELIXIR16            = GetItemInfo(40070);  --"Spellpower Elixir"  
  SMARTBUFF_ELIXIRCT1           = GetItemInfo(58148);  --"Elixir of the Master"
  SMARTBUFF_ELIXIRCT2           = GetItemInfo(58144);  --"Elixir of Mighty Speed"
  SMARTBUFF_ELIXIRCT3           = GetItemInfo(58094);  --"Elixir of Impossible Accuracy"
  SMARTBUFF_ELIXIRCT4           = GetItemInfo(58143);  --"Prismatic Elixir"
  SMARTBUFF_ELIXIRCT5           = GetItemInfo(58093);  --"Elixir of Deep Earth"
  SMARTBUFF_ELIXIRCT6           = GetItemInfo(58092);  --"Elixir of the Cobra"
  SMARTBUFF_ELIXIRCT7           = GetItemInfo(58089);  --"Elixir of the Naga"
  SMARTBUFF_ELIXIRCT8           = GetItemInfo(58084);  --"Ghost Elixir"
  
  --SMARTBUFF_ELIXIR1             = GetItemInfo(39666);  --"Elixir"

  
  --SMARTBUFF_ = GetItemInfo(xxx); --""
  
  --if (SMARTBUFF_SACREDCANDLE) then
    --SMARTBUFF_AddMsgD(SMARTBUFF_SACREDCANDLE.." found");
  --end
  
  SMARTBUFF_AddMsgD("Item list initialized");
end


function SMARTBUFF_InitSpellIDs()
  SMARTBUFF_TESTSPELL       = GetSpellInfo(774);
  
  -- Druid  
  SMARTBUFF_DRUID_CAT       = GetSpellInfo(768);   --"Cat Form"
  SMARTBUFF_DRUID_TREE      = GetSpellInfo(33891); --"Tree of Life"
  SMARTBUFF_DRUID_MOONKIN   = GetSpellInfo(24858); --"Moonkin Form"
  SMARTBUFF_DRUID_TRACK     = GetSpellInfo(5225);  --"Track Humanoids"
  SMARTBUFF_MOTW            = GetSpellInfo(1126);  --"Mark of the Wild"
  SMARTBUFF_THORNS          = GetSpellInfo(467);   --"Thorns"
  SMARTBUFF_BARKSKIN        = GetSpellInfo(22812); --"Barkskin"
  SMARTBUFF_NATURESGRASP    = GetSpellInfo(16689); --"Nature's Grasp"
  SMARTBUFF_TIGERSFURY      = GetSpellInfo(5217);  --"Tiger's Fury"
  SMARTBUFF_SAVAGEROAR      = GetSpellInfo(52610); --"Savage Roar"

  -- Priest
  SMARTBUFF_PWF             = GetSpellInfo(21562); --"Power Word: Fortitude"
  SMARTBUFF_SP              = GetSpellInfo(27683); --"Shadow Protection"
  SMARTBUFF_INNERFIRE       = GetSpellInfo(588);   --"Inner Fire"
  SMARTBUFF_PWS             = GetSpellInfo(17);    --"Power Word: Shield"
  SMARTBUFF_INNERWILL       = GetSpellInfo(73413); --"Inner Will"
  SMARTBUFF_FEARWARD        = GetSpellInfo(6346);  --"Fear Ward"
  SMARTBUFF_CHAKRA          = GetSpellInfo(14751); --"Chakra"
  SMARTBUFF_RENEW           = GetSpellInfo(139);   --"Renew"
  SMARTBUFF_LEVITATE        = GetSpellInfo(1706);  --"Levitate"
  SMARTBUFF_SHADOWFORM      = GetSpellInfo(15473); --"Shadowform"
  SMARTBUFF_VAMPIRICEMBRACE = GetSpellInfo(15286); --"Vampiric Embrace"
  SMARTBUFF_LIGHTWELL       = GetSpellInfo(724);   --"Lightwell"
  SMARTBUFF_CHAKRA1         = GetSpellInfo(81206)  --"Chakra Sanctuary"
  SMARTBUFF_CHAKRA2         = GetSpellInfo(81208)  --"Chakra Serenity"
  SMARTBUFF_CHAKRA3         = GetSpellInfo(81209)  --"Chakra Chastise"
  
  S.ChainPriestInner        = { SMARTBUFF_INNERFIRE, SMARTBUFF_INNERWILL };
  S.LinkPriestChakra        = { SMARTBUFF_CHAKRA, SMARTBUFF_CHAKRA1, SMARTBUFF_CHAKRA2, SMARTBUFF_CHAKRA3 }; 
  
  -- Mage
  SMARTBUFF_AB              = GetSpellInfo(1459);  --"Arcane Brilliance"
  SMARTBUFF_DALARANB        = GetSpellInfo(61316); --"Dalaran Brilliance"
  SMARTBUFF_FROSTARMOR      = GetSpellInfo(7302);  --"Frost Armor"
  SMARTBUFF_MAGEARMOR       = GetSpellInfo(6117);  --"Mage Armor"
  SMARTBUFF_MOLTENARMOR     = GetSpellInfo(30482); --"Molten Armor"
  SMARTBUFF_MANASHIELD      = GetSpellInfo(1463);  --"Mana Shield"
  SMARTBUFF_MAGEWARD        = GetSpellInfo(543);   --"Fire Ward"
  SMARTBUFF_ICEBARRIER      = GetSpellInfo(11426); --"Ice Barrier"
  SMARTBUFF_COMBUSTION      = GetSpellInfo(11129); --"Combustion"
  SMARTBUFF_ARCANEPOWER     = GetSpellInfo(12042); --"Arcane Power"
  SMARTBUFF_PRESENCEOFMIND  = GetSpellInfo(12043); --"Presence of Mind"
  SMARTBUFF_ICYVEINS        = GetSpellInfo(12472); --"Icy Veins"
  SMARTBUFF_SUMMONWATERELE  = GetSpellInfo(31687); --"Summon Water Elemental"
  SMARTBUFF_FOCUSMAGIC      = GetSpellInfo(54646); --"Focus Magic"
  SMARTBUFF_SLOWFALL        = GetSpellInfo(130);   --"Slow Fall"
  SMARTBUFF_CREATEMG        = GetSpellInfo(759);   --"Conjure Mana Gem"
  
  -- Mage buff links
  S.LinkMageArmor = { SMARTBUFF_FROSTARMOR, SMARTBUFF_MAGEARMOR, SMARTBUFF_MOLTENARMOR };
  
  -- Warlock
  SMARTBUFF_FELARMOR        = GetSpellInfo(28176); --"Fel Armor"
  SMARTBUFF_DEMONARMOR      = GetSpellInfo(687);   --"Demon Armor"
  SMARTBUFF_DARKINTENT      = GetSpellInfo(80398); --"Dark Intent"  
  SMARTBUFF_UNENDINGBREATH  = GetSpellInfo(5697);  --"Unending Breath"
  SMARTBUFF_SOULLINK        = GetSpellInfo(19028); --"Soul Link"
  SMARTBUFF_SHADOWWARD      = GetSpellInfo(6229);  --"Shadow Ward"
  SMARTBUFF_LIFETAP         = GetSpellInfo(1454);  --"Life Tap"
  SMARTBUFF_NETHERWARD      = GetSpellInfo(91711); --"Nether Ward"
  SMARTBUFF_DARKINTEND      = GetSpellInfo(80398); --"Dark Intent"
  SMARTBUFF_CREATEHS        = GetSpellInfo(6201);  --"Create Healthstone"
  SMARTBUFF_CREATESS        = GetSpellInfo(693);   --"Create Soulstone"
  SMARTBUFF_SOULSTONERES    = GetSpellInfo(20707); --"Soulstone Resurrection"
  SMARTBUFF_SOULHARVEST     = GetSpellInfo(79268); --"Soul Harvest"
  -- Warlock pets
  SMARTBUFF_FELI            = GetSpellInfo(54424); --"Fel Intelligence"
  SMARTBUFF_BLOODPACT       = GetSpellInfo(6307);  --"Blood Pact"
  -- Warlock buff links
  S.LinkWarlockArmor = { SMARTBUFF_FELARMOR, SMARTBUFF_DEMONARMOR };  
  
  -- Hunter
  SMARTBUFF_TRUESHOTAURA    = GetSpellInfo(19506); --"Trueshot Aura"
  SMARTBUFF_RAPIDFIRE       = GetSpellInfo(3045);  --"Rapid Fire"
  SMARTBUFF_FOCUSFIRE       = GetSpellInfo(82692); --"Focus Fire"  
  SMARTBUFF_AOTF            = GetSpellInfo(82661); --"Aspect of the Fox"
  SMARTBUFF_AOTH            = GetSpellInfo(13165); --"Aspect of the Hawk"
  SMARTBUFF_AOTW            = GetSpellInfo(20043); --"Aspect of the Wild"
  SMARTBUFF_AOTC            = GetSpellInfo(5118);  --"Aspect of the Cheetah"
  SMARTBUFF_AOTP            = GetSpellInfo(13159); --"Aspect of the Pack"
  -- Hunter pets
  SMARTBUFF_QIRAJIFORT      = GetSpellInfo(90364); --"Qiraji Fortitude"
  SMARTBUFF_EMBRACEOTSS     = GetSpellInfo(90363); --"Embrace of the Shale Spider"
  SMARTBUFF_ROAROFCOURAGE   = GetSpellInfo(93435); --"Roar of Courage"
  -- Hunter buff links
  S.LinkAspects = { SMARTBUFF_AOTH, SMARTBUFF_AOTF, SMARTBUFF_AOTW, SMARTBUFF_AOTC, SMARTBUFF_AOTP };
  
  -- Shaman
  SMARTBUFF_LIGHTNINGSHIELD = GetSpellInfo(324);   --"Lightning Shield"
  SMARTBUFF_WATERSHIELD     = GetSpellInfo(52127); --"Water Shield"
  SMARTBUFF_EARTHSHIELD     = GetSpellInfo(974);   --"Earth Shield"
  SMARTBUFF_ROCKBITERW      = GetSpellInfo(8017);  --"Rockbiter Weapon"
  SMARTBUFF_FROSTBRANDW     = GetSpellInfo(8033);  --"Frostbrand Weapon"
  SMARTBUFF_FLAMETONGUEW    = GetSpellInfo(8024);  --"Flametongue Weapon"
  SMARTBUFF_WINDFURYW       = GetSpellInfo(8232);  --"Windfury Weapon"
  SMARTBUFF_WATERBREATHING  = GetSpellInfo(131);   --"Water Breathing"
  SMARTBUFF_EARTHLIVINGW    = GetSpellInfo(51730); --"Earthliving Weapon"
  SMARTBUFF_WATERWALKING    = GetSpellInfo(546);   --"Water Walking"
  SMARTBUFF_EMASTERY        = GetSpellInfo(16166); --"Elemental Mastery"
  -- Totem
  SMARTBUFF_STREGTHOFEARTH =  GetSpellInfo(8076);  --"Strength of Earth"
  SMARTBUFF_STONESKIN      =  GetSpellInfo(8071);  --"Stoneskin Totem"
  -- Shaman buff links
  S.LinkShamanShield = { SMARTBUFF_LIGHTNINGSHIELD, SMARTBUFF_WATERSHIELD, SMARTBUFF_EARTHSHIELD };  
  
  -- Warrior
  SMARTBUFF_BATTLESHOUT     = GetSpellInfo(6673);  --"Battle Shout"
  SMARTBUFF_COMMANDINGSHOUT = GetSpellInfo(469);   --"Commanding Shout"
  SMARTBUFF_BERSERKERRAGE   = GetSpellInfo(18499); --"Berserker Rage"
  SMARTBUFF_VIGILANCE       = GetSpellInfo(50720); --"Vigilance"
  SMARTBUFF_RAMPAGE         = GetSpellInfo(29801); --"Rampage"
  SMARTBUFF_BATSTANCE       = GetSpellInfo(2457);  --"Battle Stance"
  SMARTBUFF_DEFSTANCE       = GetSpellInfo(71);    --"Defensive Stance"
  SMARTBUFF_BERSTANCE       = GetSpellInfo(2458);  --"Berserker Stance"
  SMARTBUFF_SHIELDBLOCK     = GetSpellInfo(2565);  --"Shield Block"

  -- Rogue
  SMARTBUFF_STEALTH         = GetSpellInfo(1784);  --"Stealth"
  SMARTBUFF_BLADEFLURRY     = GetSpellInfo(13877); --"Blade Flurry"
  SMARTBUFF_SAD             = GetSpellInfo(5171);  --"Slice and Dice"
  SMARTBUFF_EVASION         = GetSpellInfo(5277);  --"Evasion"
  SMARTBUFF_HUNGERFORBLOOD  = GetSpellInfo(60177); --"Hunger For Blood"
  SMARTBUFF_TRICKS          = GetSpellInfo(57934); --"Tricks of the Trade"
  SMARTBUFF_RECUPERATE      = GetSpellInfo(73651); --"Recuperate"
  
  -- Paladin
  SMARTBUFF_RIGHTEOUSFURY         = GetSpellInfo(25780); --"Righteous Fury"
  SMARTBUFF_HOLYSHIELD            = GetSpellInfo(20925); --"Holy Shield"
  SMARTBUFF_BOK                   = GetSpellInfo(20217); --"Blessing of Kings"  
  SMARTBUFF_BOM                   = GetSpellInfo(19740); --"Blessing of Might"
  SMARTBUFF_HOF                   = GetSpellInfo(1044);  --"Hand of Freedom"  
  SMARTBUFF_HOP                   = GetSpellInfo(1022);  --"Hand of Protection"
  SMARTBUFF_HOSAL                 = GetSpellInfo(1038);  --"Hand of Salvation"
  SMARTBUFF_SOJUSTICE             = GetSpellInfo(20164); --"Seal of Justice"
  SMARTBUFF_SOINSIGHT             = GetSpellInfo(20165); --"Seal of Insight"
  SMARTBUFF_SORIGHTEOUSNESS       = GetSpellInfo(20154); --"Seal of Righteousness"
  SMARTBUFF_SOTRUTH               = GetSpellInfo(31801); --"Seal of Truth"
  SMARTBUFF_DEVOTIONAURA          = GetSpellInfo(465);   --"Devotion Aura"
  SMARTBUFF_RETRIBUTIONAURA       = GetSpellInfo(7294);  --"Retribution Aura"
  SMARTBUFF_CONCENTRATIONAURA     = GetSpellInfo(19746); --"Concentration Aura"
  SMARTBUFF_RESISTANCEAURA        = GetSpellInfo(19891); --"Resistance Aura"
  SMARTBUFF_CRUSADERAURA          = GetSpellInfo(32223); --"Crusader Aura"
  SMARTBUFF_AVENGINGWARTH         = GetSpellInfo(31884); --"Avenging Wrath"
  SMARTBUFF_INQUISITION           = GetSpellInfo(84963); --"Inquisition"
  SMARTBUFF_BEACONOFLIGHT         = GetSpellInfo(53563); --"Beacon of Light"
  -- Paladin buff links
  S.LinkPaladinSeal = { SMARTBUFF_SOTRUTH, SMARTBUFF_SOJUSTICE, SMARTBUFF_SOINSIGHT, SMARTBUFF_SORIGHTEOUSNESS };
  S.ChainPaladinAura = { SMARTBUFF_DEVOTIONAURA, SMARTBUFF_RETRIBUTIONAURA, SMARTBUFF_CONCENTRATIONAURA, SMARTBUFF_RESISTANCEAURA };
  S.ChainPaladinBlessing = { SMARTBUFF_BOK, SMARTBUFF_BOM };
  
  -- Death Knight
  --SMARTBUFF_ = GetSpellInfo(xxx); --"xxx"
  SMARTBUFF_DANCINGRW         = GetSpellInfo(49028); --"Dancing Rune Weapon"
  SMARTBUFF_BLOODPRESENCE     = GetSpellInfo(48263); --"Blood Presence"
  SMARTBUFF_FROSTPRESENCE     = GetSpellInfo(48266); --"Frost Presence"
  SMARTBUFF_UNHOLYPRESENCE    = GetSpellInfo(48265); --"Unholy Presence"  
  SMARTBUFF_PATHOFFROST       = GetSpellInfo(3714);  --"Path of Frost"
  SMARTBUFF_BONESHIELD        = GetSpellInfo(49222); --"Bone Shield"
  SMARTBUFF_HORNOFWINTER      = GetSpellInfo(57330); --"Horn of Winter"
  SMARTBUFF_ABOMINATIONSMIGHT = GetSpellInfo(53138); --"Abomination's Might"
  SMARTBUFF_RAISEDEAD         = GetSpellInfo(46584); --"Raise Dead"
  -- Death Knight buff links
  S.LinkDKPresence = { SMARTBUFF_BLOODPRESENCE, SMARTBUFF_FROSTPRESENCE, SMARTBUFF_UNHOLYPRESENCE };  
  
  -- Tracking
  SMARTBUFF_FINDMINERALS    = GetSpellInfo(2580);  --"Find Minerals"
  SMARTBUFF_FINDHERBS       = GetSpellInfo(2383);  --"Find Herbs"
  SMARTBUFF_FINDTREASURE    = GetSpellInfo(2481);  --"Find Treasure"
  SMARTBUFF_TRACKHUMANOIDS  = GetSpellInfo(19883); --"Track Humanoids"
  SMARTBUFF_TRACKBEASTS     = GetSpellInfo(1494);  --"Track Beasts"
  SMARTBUFF_TRACKUNDEAD     = GetSpellInfo(19884); --"Track Undead"
  SMARTBUFF_TRACKHIDDEN     = GetSpellInfo(19885); --"Track Hidden"
  SMARTBUFF_TRACKELEMENTALS = GetSpellInfo(19880); --"Track Elementals"
  SMARTBUFF_TRACKDEMONS     = GetSpellInfo(19878); --"Track Demons"
  SMARTBUFF_TRACKGIANTS     = GetSpellInfo(19882); --"Track Giants"
  SMARTBUFF_TRACKDRAGONKIN  = GetSpellInfo(19879); --"Track Dragonkin"
  SMARTBUFF_SENSEDEMONS     = GetSpellInfo(5500);  --"Sense Demons"
  SMARTBUFF_SENSEUNDEAD     = GetSpellInfo(5502);  --"Sense Undead"

  -- Racial
  SMARTBUFF_STONEFORM       = GetSpellInfo(20594); --"Stoneform"
  --SMARTBUFF_PRECEPTION      = GetSpellInfo(20600); --"Perception"
  SMARTBUFF_BLOODFURY       = GetSpellInfo(20572); --"Blood Fury" 33697, 33702
  SMARTBUFF_BERSERKING      = GetSpellInfo(20554); --"Berserking" 26296, 26297
  SMARTBUFF_WOTFORSAKEN     = GetSpellInfo(7744);  --"Will of the Forsaken"
  
  -- Food
  SMARTBUFF_FOOD_AURA       = GetSpellInfo(46899); --"Well Fed"
  SMARTBUFF_FOOD_SPELL      = GetSpellInfo(433);   --"Food"
  SMARTBUFF_DRINK_SPELL     = GetSpellInfo(430);   --"Drink"
  
  
  -- Misc
  SMARTBUFF_KIRUSSOV        = GetSpellInfo(46302); --"K'iru's Song of Victory"
  SMARTBUFF_FISHING         = GetSpellInfo(7620);  --"Fishing"
  
  -- Scroll
  SMARTBUFF_SBAGILITY       = GetSpellInfo(8115);  --"Scroll buff: Agility"
  SMARTBUFF_SBINTELLECT     = GetSpellInfo(8096);  --"Scroll buff: Intellect"
  SMARTBUFF_SBSTAMINA       = GetSpellInfo(8099);  --"Scroll buff: Stamina"
  SMARTBUFF_SBSPIRIT        = GetSpellInfo(8112);  --"Scroll buff: Spirit"
  SMARTBUFF_SBSTRENGHT      = GetSpellInfo(8118);  --"Scroll buff: Strength"
  SMARTBUFF_SBPROTECTION    = GetSpellInfo(89344); --"Scroll buff: Armor"
  SMARTBUFF_BMiscItem1      = GetSpellInfo(100951);--"WoW's 7th Anniversary"
  SMARTBUFF_BMiscItem2      = GetSpellInfo(62574); --"Warts-B-Gone Lip Balm"
  
  -- Flasks & Elixirs
  SMARTBUFF_BFLASK1         = GetSpellInfo(53760);  --"Flask of Endless Rage"
  SMARTBUFF_BFLASK2         = GetSpellInfo(53755);  --"Flask of the Frost Wyrm"
  SMARTBUFF_BFLASK3         = GetSpellInfo(53758);  --"Flask of Stoneblood"
  SMARTBUFF_BFLASK4         = GetSpellInfo(54212);  --"Flask of Pure Mojo"
  SMARTBUFF_BFLASK5         = GetSpellInfo(67019);  --"Flask of the North"  
  SMARTBUFF_BFLASKCT1       = GetSpellInfo(79471);  --"Flask of the Winds"
  SMARTBUFF_BFLASKCT2       = GetSpellInfo(79472);  --"Flask of Titanic Strength"
  SMARTBUFF_BFLASKCT3       = GetSpellInfo(79470);  --"Flask of the Draconic Mind"
  SMARTBUFF_BFLASKCT4       = GetSpellInfo(79469);  --"Flask of Steelskin"
  SMARTBUFF_BFLASKCT5       = GetSpellInfo(94160);  --"Flask of Flowing Water"
  SMARTBUFF_BFLASKCT6       = GetSpellInfo(79637);  --"Flask of Enhancement"
  SMARTBUFF_BFLASKCT7       = GetSpellInfo(92679);  --"Flask of Battle"
  
  SMARTBUFF_BFLASKCT61      = GetSpellInfo(79640);  --"Enhanced Intellect"
  SMARTBUFF_BFLASKCT62      = GetSpellInfo(79639);  --"Enhanced Agility"
  SMARTBUFF_BFLASKCT63      = GetSpellInfo(79638);  --"Enhanced Strength"
  S.LinkFlaskCT6            = { SMARTBUFF_BFLASKCT61, SMARTBUFF_BFLASKCT62, SMARTBUFF_BFLASKCT63, SMARTBUFF_BFLASKCT1, SMARTBUFF_BFLASKCT2, SMARTBUFF_BFLASKCT3, SMARTBUFF_BFLASKCT4, SMARTBUFF_BFLASKCT5 };
  S.LinkFlaskCT7            = { SMARTBUFF_BFLASKCT1, SMARTBUFF_BFLASKCT2, SMARTBUFF_BFLASKCT3, SMARTBUFF_BFLASKCT4, SMARTBUFF_BFLASKCT5 };
  
  SMARTBUFF_BELIXIR1        = GetSpellInfo(28497);  --"Mighty Agility"
  SMARTBUFF_BELIXIR2        = GetSpellInfo(60347);  --"Mighty Thoughts"
  SMARTBUFF_BELIXIR3        = GetSpellInfo(53751);  --"Elixir of Mighty Fortitude"
  SMARTBUFF_BELIXIR4        = GetSpellInfo(53748);  --"Mighty Strength"
  SMARTBUFF_BELIXIR5        = GetSpellInfo(53747);  --"Elixir of Spirit"
  SMARTBUFF_BELIXIR6        = GetSpellInfo(53763);  --"Protection"
  SMARTBUFF_BELIXIR7        = GetSpellInfo(60343);  --"Mighty Defense"
  SMARTBUFF_BELIXIR8        = GetSpellInfo(60346);  --"Lightning Speed"
  SMARTBUFF_BELIXIR9        = GetSpellInfo(60344);  --"Expertise"
  SMARTBUFF_BELIXIR10       = GetSpellInfo(60341);  --"Deadly Strikes"
  SMARTBUFF_BELIXIR11       = GetSpellInfo(60345);  --"Armor Piercing"
  SMARTBUFF_BELIXIR12       = GetSpellInfo(60340);  --"Accuracy"
  SMARTBUFF_BELIXIR13       = GetSpellInfo(53749);  --"Guru's Elixir"
  SMARTBUFF_BELIXIR14       = GetSpellInfo(11334);  --"Elixir of Greater Agility"
  SMARTBUFF_BELIXIR15       = GetSpellInfo(54452);  --"Adept's Elixir"
  SMARTBUFF_BELIXIR16       = GetSpellInfo(33721);  --"Spellpower Elixir"  
  SMARTBUFF_BELIXIRCT1      = GetSpellInfo(79635);  --"Elixir of the Master"
  SMARTBUFF_BELIXIRCT2      = GetSpellInfo(79632);  --"Elixir of Mighty Speed"
  SMARTBUFF_BELIXIRCT3      = GetSpellInfo(79481);  --"Elixir of Impossible Accuracy"
  SMARTBUFF_BELIXIRCT4      = GetSpellInfo(79631);  --"Prismatic Elixir"
  SMARTBUFF_BELIXIRCT5      = GetSpellInfo(79480);  --"Elixir of Deep Earth"
  SMARTBUFF_BELIXIRCT6      = GetSpellInfo(79477);  --"Elixir of the Cobra"
  SMARTBUFF_BELIXIRCT7      = GetSpellInfo(79474);  --"Elixir of the Naga"
  SMARTBUFF_BELIXIRCT8      = GetSpellInfo(79468);  --"Ghost Elixir"
  
  --if (SMARTBUFF_GOTW) then
  --  SMARTBUFF_AddMsgD(SMARTBUFF_GOTW.." found");
  --end
  
  -- Buff map
  S.LinkSta = { SMARTBUFF_PWF, SMARTBUFF_COMMANDINGSHOUT, SMARTBUFF_BLOODPACT, SMARTBUFF_QIRAJIFORT };
  S.LinkAgi = { SMARTBUFF_HORNOFWINTER, SMARTBUFF_BATTLESHOUT, SMARTBUFF_STREGTHOFEARTH, SMARTBUFF_ROAROFCOURAGE };
  S.LinkInt = { SMARTBUFF_AB, SMARTBUFF_DALARANB };
  S.LinkPCA = { SMARTBUFF_MOTW, SMARTBUFF_BOK, SMARTBUFF_EMBRACEOTSS };
  
  --SMARTBUFF_AddMsgD("Spell IDs initialized");
end


function SMARTBUFF_InitSpellList()
  if (SMARTBUFF_PLAYERCLASS == nil) then return; end
  
  --if (SMARTBUFF_GOTW) then
  --  SMARTBUFF_AddMsgD(SMARTBUFF_GOTW.." found");
  --end
  
  -- Druid
  if (SMARTBUFF_PLAYERCLASS == "DRUID") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_DRUID_MOONKIN, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_DRUID_TREE, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_MOTW, 60, SMARTBUFF_CONST_GROUP, {30}, "WPET;DKPET", S.LinkPCA},
      {SMARTBUFF_THORNS, 0.333, SMARTBUFF_CONST_GROUP, {5}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT"},
      {SMARTBUFF_BARKSKIN, 0.25, SMARTBUFF_CONST_FORCESELF},
      {SMARTBUFF_NATURESGRASP, 0.75, SMARTBUFF_CONST_FORCESELF},
      {SMARTBUFF_TIGERSFURY, 0.1, SMARTBUFF_CONST_SELF, nil, SMARTBUFF_DRUID_CAT},
      {SMARTBUFF_SAVAGEROAR, 0.15, SMARTBUFF_CONST_SELF, nil, SMARTBUFF_DRUID_CAT}
    };
  end
  
  -- Priest
  if (SMARTBUFF_PLAYERCLASS == "PRIEST") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_SHADOWFORM, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_VAMPIRICEMBRACE, 30, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_PWF, 60, SMARTBUFF_CONST_GROUP, {14}, "HPET;WPET;DKPET", S.LinkSta},
      {SMARTBUFF_SP, 60, SMARTBUFF_CONST_GROUP, {56}, "HPET;WPET;DKPET"},
      {SMARTBUFF_PWS, 0.5, SMARTBUFF_CONST_GROUP, {6}, "MAGE;WARLOCK;ROGUE;PALADIN;WARRIOR;DRUID;HUNTER;SHAMAN;DEATHKNIGHT;HPET;WPET;DKPET"},
      {SMARTBUFF_INNERWILL, 30, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPriestInner},
      {SMARTBUFF_INNERFIRE, 30, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPriestInner},
      {SMARTBUFF_FEARWARD, 3, SMARTBUFF_CONST_GROUP, {54}, "HPET;WPET;DKPET"},
      {SMARTBUFF_LEVITATE, 2, SMARTBUFF_CONST_GROUP, {34}, "HPET;WPET;DKPET"},
      {SMARTBUFF_CHAKRA, 0.5, SMARTBUFF_CONST_SELF, nil, nil, S.LinkPriestChakra},
      {SMARTBUFF_LIGHTWELL, 3, SMARTBUFF_CONST_SELF}
    };
  end
  
  -- Mage
  if (SMARTBUFF_PLAYERCLASS == "MAGE") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_AB, 60, SMARTBUFF_CONST_GROUP, {1,14,28,42,56,70,80}, "HUNTER;ROGUE;WARRIOR;DEATHKNIGHT;HPET;WPET;DKPET", S.LinkInt},
      {SMARTBUFF_DALARANB, 60, SMARTBUFF_CONST_GROUP, {80,80,80,80,80,80,80}, "HUNTER;ROGUE;WARRIOR;DEATHKNIGHT;HPET;WPET;DKPET", S.LinkInt},
      {SMARTBUFF_FOCUSMAGIC, 30, SMARTBUFF_CONST_GROUP, {20}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;HPET;WPET;DKPET"},
      {SMARTBUFF_FROSTARMOR, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkMageArmor},
      {SMARTBUFF_MAGEARMOR, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkMageArmor},
      {SMARTBUFF_MOLTENARMOR, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkMageArmor},
      {SMARTBUFF_SLOWFALL, 0.5, SMARTBUFF_CONST_GROUP, {32}, "HPET;WPET;DKPET"},
      {SMARTBUFF_MANASHIELD, 1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_MAGEWARD, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_ICEBARRIER, 1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_COMBUSTION, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_ICYVEINS, 0.333, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_ARCANEPOWER, 0.25, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_PRESENCEOFMIND, 0.165, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_CREATEMG, 0.03, SMARTBUFF_CONST_ITEM, nil, SMARTBUFF_MANAGEM}
    };
  end
  
  -- Warlock
  if (SMARTBUFF_PLAYERCLASS == "WARLOCK") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_FELARMOR, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkWarlockArmor},
      {SMARTBUFF_DEMONARMOR, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkWarlockArmor},
      {SMARTBUFF_SOULLINK, 0, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_UNENDINGBREATH, 10, SMARTBUFF_CONST_GROUP, {16}, "HPET;WPET;DKPET"},
      {SMARTBUFF_SHADOWWARD, 0.5, SMARTBUFF_CONST_SELF, nil, nil, nil, {SMARTBUFF_NETHERWARD, SMARTBUFF_SHADOWWARD}},
      {SMARTBUFF_NETHERWARD, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_DARKINTEND, 30, SMARTBUFF_CONST_GROUP, {83}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT"},      
      {SMARTBUFF_DARKPACT, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_LIFETAP, 0.025, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_SOULHARVEST, 0.5, SMARTBUFF_CONST_SELF, nil, SPELL_POWER_SOUL_SHARDS},
      {SMARTBUFF_SOULSTONE, 15, SMARTBUFF_CONST_ITEMGROUP, nil, SMARTBUFF_SOULSTONERES},
      {SMARTBUFF_CREATESS, 0.03, SMARTBUFF_CONST_ITEM, nil, SMARTBUFF_SOULSTONE},
      {SMARTBUFF_CREATEHS, 0.03, SMARTBUFF_CONST_ITEM, nil, SMARTBUFF_HEALTHSTONE}
    };
  end

  -- Hunter
  if (SMARTBUFF_PLAYERCLASS == "HUNTER") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_RAPIDFIRE, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_FOCUSFIRE, 0.25, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_AOTH, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects},
      {SMARTBUFF_AOTF, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects},
      {SMARTBUFF_AOTW, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects},
      {SMARTBUFF_AOTC, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects},
      {SMARTBUFF_AOTP, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAspects}
    };
  end

  -- Shaman
  if (SMARTBUFF_PLAYERCLASS == "SHAMAN") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_LIGHTNINGSHIELD, 10, SMARTBUFF_CONST_SELF, nil, nil, S.LinkShamanShield},
      {SMARTBUFF_WATERSHIELD, 10, SMARTBUFF_CONST_SELF, nil, nil, S.LinkShamanShield},
      {SMARTBUFF_EARTHSHIELD, 10, SMARTBUFF_CONST_GROUP, {50,60,70,75,80}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;HPET;WPET;DKPET", S.LinkShamanShield},
      {SMARTBUFF_WINDFURYW, 30, SMARTBUFF_CONST_WEAPON},      
      {SMARTBUFF_FROSTBRANDW, 30, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_FLAMETONGUEW, 30, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_ROCKBITERW, 30, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_EARTHLIVINGW, 30, SMARTBUFF_CONST_WEAPON},
      {SMARTBUFF_EMASTERY, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_WATERBREATHING, 10, SMARTBUFF_CONST_GROUP, {22}},
      {SMARTBUFF_WATERWALKING, 10, SMARTBUFF_CONST_GROUP, {28}}
    };
  end

  -- Warrior
  if (SMARTBUFF_PLAYERCLASS == "WARRIOR") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_BATTLESHOUT, 2, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAgi},
      {SMARTBUFF_COMMANDINGSHOUT, 2, SMARTBUFF_CONST_SELF, nil, nil, S.LinkSta},
      {SMARTBUFF_BERSERKERRAGE, 0.165, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_VIGILANCE, 30, SMARTBUFF_CONST_GROUP, {40}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;HPET;WPET;DKPET"},
      {SMARTBUFF_SHIELDBLOCK, 0.1666, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BATSTANCE, -1, SMARTBUFF_CONST_STANCE, nil, 1},
      {SMARTBUFF_DEFSTANCE, -1, SMARTBUFF_CONST_STANCE, nil, 2},
      {SMARTBUFF_BERSTANCE, -1, SMARTBUFF_CONST_STANCE, nil, 3}
    };
  end
  
  -- Rogue
  if (SMARTBUFF_PLAYERCLASS == "ROGUE") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_STEALTH, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BLADEFLURRY, -1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_SAD, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_TRICKS, 0.5, SMARTBUFF_CONST_GROUP, {75}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;HPET;WPET;DKPET"},
      {SMARTBUFF_HUNGERFORBLOOD, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_RECUPERATE, 0.5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_EVASION, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_INSTANTPOISON1, 60, SMARTBUFF_CONST_INV},
      {SMARTBUFF_DEADLYPOISON1, 60, SMARTBUFF_CONST_INV},
      {SMARTBUFF_WOUNDPOISON1, 60, SMARTBUFF_CONST_INV},
      {SMARTBUFF_MINDPOISON1, 60, SMARTBUFF_CONST_INV},
      {SMARTBUFF_CRIPPLINGPOISON1, 60, SMARTBUFF_CONST_INV},
      {SMARTBUFF_ANESTHETICPOISON1, 60, SMARTBUFF_CONST_INV}     
    };
  end

  -- Paladin
  if (SMARTBUFF_PLAYERCLASS == "PALADIN") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_RIGHTEOUSFURY, 30, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_HOLYSHIELD, 0.166, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_AVENGINGWARTH, 0.333, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_INQUISITION, 0.166, SMARTBUFF_CONST_SELF, nil, SPELL_POWER_HOLY_POWER},
      {SMARTBUFF_BOK, 60, SMARTBUFF_CONST_GROUP, {20}, nil, S.LinkPCA, S.ChainPaladinBlessing},
      {SMARTBUFF_BOM, 60, SMARTBUFF_CONST_GROUP, {56}, nil, nil, S.ChainPaladinBlessing},     
      {SMARTBUFF_BOSAL, 10, SMARTBUFF_CONST_GROUP, {26}, "WARRIOR;HPET;WPET;DKPET"},
      {SMARTBUFF_HOF, 0.1, SMARTBUFF_CONST_GROUP, {52}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;HPET;WPET;DKPET"},
      {SMARTBUFF_HOSAL, 0.1, SMARTBUFF_CONST_GROUP, {66}, "WARRIOR;DEATHKNIGHT;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;HPET;WPET;DKPET"},
      {SMARTBUFF_BEACONOFLIGHT, 5, SMARTBUFF_CONST_GROUP, {39}, "WARRIOR;DRUID;SHAMAN;HUNTER;ROGUE;MAGE;PRIEST;PALADIN;WARLOCK;DEATHKNIGHT;HPET;WPET;DKPET"},
      {SMARTBUFF_SORIGHTEOUSNESS, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkPaladinSeal},
      {SMARTBUFF_SOINSIGHT, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkPaladinSeal},
      {SMARTBUFF_SOTRUTH, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkPaladinSeal},
      {SMARTBUFF_SOJUSTICE, 30, SMARTBUFF_CONST_SELF, nil, nil, S.LinkPaladinSeal},      
      {SMARTBUFF_DEVOTIONAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, {SMARTBUFF_STONESKIN}, S.ChainPaladinAura},
      {SMARTBUFF_RETRIBUTIONAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPaladinAura},
      {SMARTBUFF_CONCENTRATIONAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPaladinAura},
      {SMARTBUFF_RESISTANCEAURA, -1, SMARTBUFF_CONST_SELF, nil, nil, nil, S.ChainPaladinAura},
      {SMARTBUFF_CRUSADERAURA, -1, SMARTBUFF_CONST_SELF}
    };
  end
  
  -- Deathknight
  if (SMARTBUFF_PLAYERCLASS == "DEATHKNIGHT") then
    SMARTBUFF_BUFFLIST = {
      {SMARTBUFF_DANCINGRW, 0.2, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_BLOODPRESENCE, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkDKPresence, S.LinkDKPresence},
      {SMARTBUFF_FROSTPRESENCE, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkDKPresence, S.LinkDKPresence},
      {SMARTBUFF_UNHOLYPRESENCE, -1, SMARTBUFF_CONST_SELF, nil, nil, S.LinkDKPresence, S.LinkDKPresence},
      {SMARTBUFF_HORNOFWINTER, 2, SMARTBUFF_CONST_SELF, nil, nil, S.LinkAgi},
      {SMARTBUFF_BONESHIELD, 5, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_RAISEDEAD, 1, SMARTBUFF_CONST_SELF},
      {SMARTBUFF_PATHOFFROST, -1, SMARTBUFF_CONST_SELF}
    };
  end

  -- Stones and oils
  SMARTBUFF_WEAPON = {
    {SMARTBUFF_SSROUGH, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSCOARSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSHEAVY, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSSOLID, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSDENSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSELEMENTAL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSFEL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SSADAMANTITE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSROUGH, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSCOARSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSHEAVY, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSSOLID, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSDENSE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSFEL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WSADAMANTITE, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_SHADOWOIL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_FROSTOIL, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL5, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL4, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_MANAOIL1, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL6, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL5, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL4, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL3, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL2, 60, SMARTBUFF_CONST_INV},
    {SMARTBUFF_WIZARDOIL1, 60, SMARTBUFF_CONST_INV}
  };

  -- Tracking
  SMARTBUFF_TRACKING = {
    {SMARTBUFF_FINDMINERALS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_FINDHERBS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_FINDTREASURE, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKHUMANOIDS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKBEASTS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKUNDEAD, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKHIDDEN, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKELEMENTALS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKDEMONS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKGIANTS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_TRACKDRAGONKIN, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_SENSEDEMONS, -1, SMARTBUFF_CONST_TRACK},
    {SMARTBUFF_SENSEUNDEAD, -1, SMARTBUFF_CONST_TRACK}
  };

  -- Racial
  SMARTBUFF_RACIAL = {
    {SMARTBUFF_STONEFORM, 0.133, SMARTBUFF_CONST_SELF},  -- Dwarv
    --{SMARTBUFF_PRECEPTION, 0.333, SMARTBUFF_CONST_SELF}, -- Human
    {SMARTBUFF_BLOODFURY, 0.416, SMARTBUFF_CONST_SELF},  -- Orc
    {SMARTBUFF_BERSERKING, 0.166, SMARTBUFF_CONST_SELF}, -- Troll
    {SMARTBUFF_WOTFORSAKEN, 0.083, SMARTBUFF_CONST_SELF} -- Undead
  };

  -- FOOD
  SMARTBUFF_FOOD = {
    {SMARTBUFF_FOODCT1, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT2, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT3, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT4, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT5, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT6, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT7, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT8, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT9, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT10, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT11, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT12, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT13, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT14, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT15, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT16, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT17, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT18, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT19, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT20, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT21, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FOODCT22, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD32, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD31, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD30, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD29, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD28, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD27, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD26, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD25, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD24, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD23, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD22, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD21, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD20, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD19, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD18, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD17, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD16, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD15, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD14, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD13, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD12, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD11, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD10, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD9, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD8, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD7, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD6, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD5, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD4, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD3, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD2, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WOTLKFOOD1, 60, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPICYCRAWDAD, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_MOKNATHALSHORTRIBS, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_CRUNCHYSERPENT, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_GOLDENFISHSTICKS, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPICYHOTTALBUK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SKULLFISHSOUP, 30, SMARTBUFF_CONST_FOOD},    
    {SMARTBUFF_TALBUKSTEAK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_WARPBURGER, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_ROASTEDCLEFTHOOF, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_POACHEDBLUEFISH, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_GRILLEDMUDFISH, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BLACKENEDBASILISK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BLACKENEDSPOREFISH, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SPORELINGSNACK, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BROILEDBLOODFIN, 30, SMARTBUFF_CONST_FOOD},    
    {SMARTBUFF_CLAMBAR, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_FELTAILDELIGHT, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_RAVAGERDOG, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_BUZZARDBITES, 30, SMARTBUFF_CONST_FOOD},
    {SMARTBUFF_SAGEFISHDELIGHT, 15, SMARTBUFF_CONST_FOOD}
  };

  -- Scrolls
  SMARTBUFF_SCROLL = {
    {SMARTBUFF_SOAGILITY9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOAGILITY1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBAGILITY},
    {SMARTBUFF_SOINTELLECT9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOINTELLECT1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBINTELLECT},
    {SMARTBUFF_SOSTAMINA9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSTAMINA1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTAMINA},
    {SMARTBUFF_SOSPIRIT9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSPIRIT1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSPIRIT},
    {SMARTBUFF_SOSTRENGHT9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT8, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT7, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT6, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT5, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT4, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT3, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT2, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOSTRENGHT1, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBSTRENGHT},
    {SMARTBUFF_SOPROTECTION9, 30, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_SBPROTECTION},
    {SMARTBUFF_MiscItem1, 60, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem1},
    {SMARTBUFF_MiscItem2, -1, SMARTBUFF_CONST_SCROLL, nil, SMARTBUFF_BMiscItem2}
  };
  
  -- Potions
  SMARTBUFF_POTION = {
    {SMARTBUFF_FLASKCT1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT1},
    {SMARTBUFF_FLASKCT2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT2},
    {SMARTBUFF_FLASKCT3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT3},
    {SMARTBUFF_FLASKCT4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT4},
    {SMARTBUFF_FLASKCT5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT5},
    {SMARTBUFF_FLASKCT6, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT6, S.LinkFlaskCT6},
    {SMARTBUFF_FLASKCT7, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASKCT7, S.LinkFlaskCT7},
    {SMARTBUFF_ELIXIRCT1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT1},
    {SMARTBUFF_ELIXIRCT2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT2},
    {SMARTBUFF_ELIXIRCT3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT3},
    {SMARTBUFF_ELIXIRCT4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT4},
    {SMARTBUFF_ELIXIRCT5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT5},
    {SMARTBUFF_ELIXIRCT6, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT6},
    {SMARTBUFF_ELIXIRCT7, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT7},
    {SMARTBUFF_ELIXIRCT8, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIRCT8},
    {SMARTBUFF_FLASK1, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK1},
    {SMARTBUFF_FLASK2, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK2},
    {SMARTBUFF_FLASK3, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK3},
    {SMARTBUFF_FLASK4, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK4},
    {SMARTBUFF_FLASK5, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BFLASK5},
    {SMARTBUFF_ELIXIR1,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR1},
    {SMARTBUFF_ELIXIR2,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR2},
    {SMARTBUFF_ELIXIR3,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR3},
    {SMARTBUFF_ELIXIR4,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR4},
    {SMARTBUFF_ELIXIR5,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR5},
    {SMARTBUFF_ELIXIR6,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR6},
    {SMARTBUFF_ELIXIR7,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR7},
    {SMARTBUFF_ELIXIR8,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR8},
    {SMARTBUFF_ELIXIR9,  60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR9},
    {SMARTBUFF_ELIXIR10, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR10},
    {SMARTBUFF_ELIXIR11, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR11},
    {SMARTBUFF_ELIXIR12, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR12},
    {SMARTBUFF_ELIXIR13, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR13},
    {SMARTBUFF_ELIXIR14, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR14},
    {SMARTBUFF_ELIXIR15, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR15},
    {SMARTBUFF_ELIXIR16, 60, SMARTBUFF_CONST_POTION, nil, SMARTBUFF_BELIXIR16}
  }
  
  SMARTBUFF_AddMsgD("Spell list initialized");
end
