local L = LibStub("AceLocale-3.0"):NewLocale("IceHUD", "ruRU")
if not L then return end

L["(De)Buff watcher"] = "Слежение за (де)баффами"
L["1 combo point: yellow, 5 combo points: red"] = "1 комбо-очко: жёлтое, 5 комбо-очков: красные"
L["1 lacerate: yellow, 5 lacerates: red"] = "Растерзать-1 : желтый, Растерзать-5: красный"
L["1 maelstrom: yellow, 5 maelstroms: red"] = "Водоворот-1: желтый, Водоворот-5: красный"
L["1 sunder: yellow, 5 sunders: red"] = "Раскол-1: желтый, Раскол-5: красный"
L["A custom bar has been created and can be configured through Module Settings => MyCustomBar. It is highly recommended that you change the bar name of this module so that it's easier to identify."] = "Пользовательская полоса была создана и может быть настроена с помощью Настройки модуля => MyCustomBar. Настоятельно рекомендуется изменить имя этой полосы, чтобы легче её идентифицировать."
L["A custom cooldown bar has been created and can be configured through Module Settings => MyCustomCD. It is highly recommended that you change the bar name of this module so that it's easier to identify."] = "Пользовательская полоса перезарядки была создана и может быть настроена с помощью Настройки модуля => MyCustomCD. Настоятельно рекомендуется изменить имя этой полосы, чтобы легче её идентифицировать."
L["A custom counter has been created and can be configured through Module Settings => MyCustomCounter. It is highly recommended that you change the bar name of this module so that it's easier to identify."] = "Пользовательский счетчик был создан и может быть настроен с помощью Настройки модуля => MyCustomCounter. Настоятельно рекомендуется изменить имя этой полосы, чтобы легче её идентифицировать."
L["A custom health bar has been created and can be configured through Module Settings => MyCustomHealth. It is highly recommended that you change the bar name of this module so that it's easier to identify."] = "Пользовательская полоса здоровья была создана и может быть настроена с помощью Настройки модуля => MyCustomHealth. Настоятельно рекомендуется изменить имя этой полосы, чтобы легче её идентифицировать."
L["A custom mana bar has been created and can be configured through Module Settings => MyCustomMana. It is highly recommended that you change the bar name of this module so that it's easier to identify."] = "Пользовательская полоса маны была создана и может быть настроена с помощью Настройки модуля => MyCustomMana. Настоятельно рекомендуется изменить имя этой полосы, чтобы легче её идентифицировать."
L["Abbreviate estimated health"] = "Сокращать оценочное здоровье"
L["Abbreviate health"] = "Сокращать здоровье"
L["Adjust the horizontal position of the aura icon"] = "Настройка горизонтального положения иконки ауры"
L["Adjust the vertical placement of this bar"] = "Настройка вертикального размещение этой панели"
L["Adjust the vertical position of the aura icon"] = "Настройка вертикального положения иконки ауры"
L["Adjusts the size of the aura icon for this bar"] = "Настройка размера иконки аур для этой панели"
L["Advanced Bar Settings"] = "Дополнительные настройки полосы"
L["Aggro Indicator alpha"] = "Прозрачность индикатора агро"
L["Aggro indicator alpha (0 is disabled)"] = "Прозрачность индикатора агро (0 откл)"
L["Alert Party"] = "Оповещение группы"
L["Allow click casting"] = "Разрешить нажатием кастовать"
L["Allow click-targeting"] = "Разрешить выделять нажатием"
L["Allow click-targeting in combat"] = "Разрешить выбирать цель в бою"
L["Allow mouse interaction"] = "Разрешить управления мышкой"
L["Alpha OOC and Target"] = "Прозрачность OOC и цели"
L["Alpha OOC and not full"] = "Прозрачность незаполненных полос и вне боя " -- Needs review
L["Alpha in combat"] = "Прозрачность в бою"
L["Alpha out of combat"] = "Прозрачность вне боя"
L["Always display bar"] = "Всегда отображать полосу"
L["Always show at 100% alpha"] = "Всегда показывать 100% прозрачность"
L["Animate changes"] = "Анимация изменения"
L["Animation Duration"] = "Продолжительность анимации"
L["Animation Settings"] = "Настройки анимации"
L["Answers to questions that are frequently asked."] = "Ответы на наиболее часто задаваемые вопросы."
L["Are you sure you want to delete this module? This will remove all settings associated with it and cannot be un-done."] = "Вы уверены, что хотите удалить этот модуль? Это приведёт к удалению всех настроек, связанных с ним, которые нельзя будет восстановить."
L["Aura icon horizontal offset"] = "Горизонт. смещение иконки ауры"
L["Aura icon scale"] = "Масштаб иконки ауры"
L["Aura icon vertical offset"] = "Верт. смещение иконки ауры"
L["Aura settings"] = "Настройки ауры"
L["Aura to track"] = "Отслеживание ауры"
L["Automatically size this module to the addon's 'gap' setting"] = "Автоматически подгонять размер модуля под общий промежуток аддона"
L["BG Alpha OOC and Target"] = "БГ прозрачность OOC и цели"
L["BG Alpha OOC and not Full"] = "Прозрачность фона незаполненных полос и вне боя " -- Needs review
L["BG Alpha in combat"] = "БГ прозрачность в бою"
L["BG Alpha out of combat"] = "БГ прозрачность в не боя"
L["Background Alpha"] = "Прозрачный фон"
L["Background Color"] = "Цвет фона"
L["Background alpha for bars IC"] = "Прозрачность фона для IC"
L["Background alpha for bars OOC and bar not full (Target takes precedence over this)"] = "Прозрачность фона для незаполненных полос и отображения вне боя (Цель имеет больший приоритет, чем это)" -- Needs review
L["Background alpha for bars OOC and target accuired (takes precedence over Not Full)"] = "Прозрачность фона для полос вне боя при взятой цели (Имеет больший приоритет, чем Незаполненная Полоса)"
L["Background alpha for bars OOC without target"] = "Прозрачность фона для полосы OOC без цели"
L["Bar Alpha"] = "Прозрачность полосы"
L["Bar Background Blend Mode"] = "Режим смешивания фона полосы"
L["Bar Blend Mode"] = "Режим смешивания полос"
L["Bar Font Bold"] = "Жирный шрифт на полосе"
L["Bar Font Size"] = "Размер шрифта полосы"
L["Bar Height"] = "Высота полосы"
L["Bar Proportion"] = "Соотношение полосы"
L["Bar Settings"] = "Настройки полос"
L["Bar Space"] = "Отступ от полосы"
L["Bar Texture"] = "Текстура полосы"
L["Bar Texture Override"] = "Переопределить вид полосы"
L["Bar Width"] = "Ширина полосы"
L["Bar alpha In Combat"] = "Прозрачность полосы в бою"
L["Bar alpha Out Of Combat with target accuired (takes precedence over Not Full)"] = "Прозрачность полосы вне боя при взятой цели (Имеет больший приоритет, чем Незаполненная Полоса)"
L["Bar alpha Out Of Combat with target accuired or bar not full (Target takes precedence over this)"] = [=[Прозрачность полосы вне боя при взятой цели
Прозрачность фона для незаполненных полос и отображения вне боя (Цель имеет больший приоритет, чем это)]=]
L["Bar alpha Out Of Combat without target"] = "Прозрачность полосы вне боя без цели"
L["Bar background visible"] = "Фон полосы виден"
L["Bar color"] = "Цвет полосы"
L["Bar horizontal adjust"] = "Горизонтальные регулировки полосы"
L["Bar name"] = "Имя полосы"
L["Bar texture height (not the actual bar!)"] = "Высота текстуры полосы (не самой полосы!)"
L["Bar texture width (not the actual bar!)"] = "Ширина текстуры полосы (не всей полосы!)"
L["Bar vertical offset"] = "Вертикальное смещение полосы"
L["Bar visible"] = "Видимая полоса"
L["Bar width modifier"] = "Модификатор ширины полосы"
L["Blizzard currently does not provide a proper way to right-click focus with custom unit frames."] = "Blizzard currently does not provide a proper way to right-click focus with custom unit frames." -- Requires localization
L["Broadcasts crowd control effects you apply to your target via the party chat channel"] = "Broadcasts crowd control effects you apply to your target via the party chat channel" -- Requires localization
L["Buff Settings"] = "Настройки баффов"
L["Buff anchor to"] = "Закрепить баф" -- Needs review
L["Buff grow direction"] = "Направление роста полосы"
L["Buff horizontal offset"] = "Горизонтальное смещение бафов"
L["Buff or debuff?"] = "Баф или дебаф?"
L["Buff placement settings"] = "Настройки размещения бафов"
L["Buff size"] = "Размер бафа"
L["Buff timer display"] = "Отображать таймера бафа"
L["Buff vertical offset"] = "Вертикальное смещение бафов"
L["Buff zoom"] = "Увеличение бафа"
L["Buff/Debuff Settings"] = "Настройки баф/дебаф"
L["Buff/debuff icon size"] = "Размер иконки бафа/дебафа"
L["Buff/debuff icon zoom"] = "Увеличение иконки бафа/дебафа"
L["Buff/debuff size for buffs/debuffs that were applied by you, the player"] = "Размер (де)баффов, наложенных Вами"
L["Buffs / row"] = "бафы / ряд"
L["Change color"] = "Изменить цвет"
L["Change color when not in range"] = "Изменить цвет, когда вне диапазона"
L["Changes the bar color to the CastNotInRange color when the target goes out of range for the current spell."] = "Включить изменение цвета на цвет CastNotInRange, когда цель вне зоны действия этого заклинания"
L[ [=[Changes the color of this bar to be the minimum health or mana color when it's below the low threshold. See the 'MinHealthColor' and 'MinManaColor' colors in the 'Colors' option page.

This option only applies to health and mana bars.]=] ] = [=[Changes the color of this bar to be the minimum health or mana color when it's below the low threshold. See the 'MinHealthColor' and 'MinManaColor' colors in the 'Colors' option page.

This option only applies to health and mana bars.]=] -- Requires localization
L["Checking this means that only buffs or debuffs that the player applied will trigger this bar"] = "Установка этой опции означает, что только баффы или дебаффы, наложенные самим игроком, будут влиять на эту полосу"
L["Choose a marker to edit. This will place the marker's settings in the fields above here."] = "Выберите метку для редактирования. Опции метки появятся в вышестоящих полях"
L["Choose whether the runes use a cooldown-style wipe, simply an alpha fade to show availability or both."] = "Choose whether the runes use a cooldown-style wipe, simply an alpha fade to show availability or both." -- Requires localization
L["Choose whether the totems use a cooldown-style wipe or simply an alpha fade to show availability."] = "Choose whether the totems use a cooldown-style wipe or simply an alpha fade to show availability." -- Requires localization
L[ [=[Choose whether you'd like a graphical or numeric representation of the runes.

NOTE: The color of 'Numeric' mode can be controlled by the HolyPowerNumeric color.]=] ] = [=[Установить графическое или цифровое отображение рун

ПРИМЕЧАНИЕ: Цвет 'Цифрового' режима может быть установлен с помощью цвета HolyPowerNumeric]=]
L[ [=[Choose whether you'd like a graphical or numeric representation of the runes.

NOTE: The color of 'Numeric' mode can be controlled by the ShardCounterNumeric color.]=] ] = "Установить графическое или цифровое отображение рун"
L["Class color bar"] = "Цвет классовой полосы"
L["Classification icon"] = "Иконка классификации"
L[ [=[Click the + next to |cffffdc42Module Settings|r to see the available modules that you can tweak.

Also notice that some modules have a + next to them. This will open up additional settings such as text tweaks and icon tweaks on that module.]=] ] = [=[Click the + next to |cffffdc42Module Settings|r to see the available modules that you can tweak.

Also notice that some modules have a + next to them. This will open up additional settings such as text tweaks and icon tweaks on that module.]=] -- Requires localization
L["Click to open IceHUD options."] = "Нажатие открывает настройки IceHUD."
L["Color"] = "Цвет"
L["Color NPC by hostility"] = "Различать враждебность NPC цветом"
L["Color bar by health %"] = "Цвет полосы здоровья %"
L["Color bar by mana %"] = "Цвет полосы маны %"
L["Colors"] = "Цвета"
L["Colors the health bar from MaxHealthColor to MinHealthColor based on current health %"] = "Colors the health bar from MaxHealthColor to MinHealthColor based on current health %" -- Requires localization
L[ [=[Colors the health bar from MaxHealthColor to MinHealthColor based on current health %

(Note: This overrides the 'class color bar' setting. Disable this to use class coloring)]=] ] = [=[Colors the health bar from MaxHealthColor to MinHealthColor based on current health %

(Note: This overrides the 'class color bar' setting. Disable this to use class coloring)]=] -- Requires localization
L["Colors the mana bar from MaxManaColor to MinManaColor based on current mana %"] = "Цвета полосы маны с MaxManaColor к MinManaColor основаны на текущих % маны"
L["Combo Points Font Size"] = "Размер шрифта комбо-очков"
L["Combo gap"] = "Промежуток комбо-очков"
L["Configuration Mode"] = "Режим конфигурации"
L["Contextual Background"] = "Контекстный фон"
L["Controls what it means for the bar to be filled. A normal bar will grow larger as the value grows from 0% to 100%. A reversed bar will shrink as the value grows from 0% to 100%."] = "Задает направление заполнения полосы. Нормальная полоса заполняется по мере увеличения значения от 0% до 100%, перевернутая полоса уменьшается по мере увеличения значения от 0% до 100%"
L["Controls which direction the bar fills up. With this checked, the bar will fill opposite from normal (e.g. for health: 0% at the top, 100% at the bottom)."] = "Устанавливает в какую сторону заполняется полоса. Если установлено, то полоса заполняется в обратном направлении (допустим для здоровья 0% будут вверху, а 100% внизу)"
L["Cooldown"] = "Перезарядка"
L["Cooldown timer display"] = "Отображать таймер перезарядки"
L["Count color"] = "Количество цветов"
L["Count minimum color"] = "Минимальное количество цветов"
L["Counter"] = "Счётчик"
L["Counter look and feel"] = "Вид и поведение счетчика"
L["Counter name"] = "Имя счетчика"
L["Create"] = "Создать"
L["Create custom module"] = "Создать пользовательский модуль"
L["Create marker"] = "Создать маркер"
L["Create or remove markers at various points along the bar here"] = "Создание и удаление маркеров для различных значений на полосе"
L["Creates a new marker with the chosen settings."] = "Создает новый маркер с выбранными параметрами."
L["Creates a new module of this same type and with all the same settings."] = "Создать модуль этого же типа и с такими же настройками"
L["Creates the selected custom module"] = "Создает выбранный пользовательский модуль"
L["Custom CD settings"] = "Пользовательские настройки перезарядки"
L["Custom bar settings"] = "Пользовательские настройки полосы"
L["Custom color"] = "Свой цвет"
L["Custom minimum color"] = "Custom minimum color" -- Requires localization
L["Debuff Settings"] = "Настройки дебаффоф"
L["Debuff anchor to"] = "Закрепить дебаф"
L["Debuff grow direction"] = "Сторона добавления дебаффов"
L["Debuff horizontal offset"] = "Горизонтальное смещение дебафов"
L["Debuff placement settings"] = "Настройки размещения дебафов"
L["Debuff size"] = "Размер дебаффов"
L["Debuff vertical offset"] = "Вертикальное смещение дебафов"
L["Debugging"] = "Отладка"
L["Defines when cast bar should flash on failed spells"] = "Устанавливает, когда должна мигать Полоса Заклинания при неудавшемся заклинании"
L["Defines when cast bar should flash on instant spells"] = "Устанавливает, когда должна мигать Полоса Заклинания при мгновенном заклинании"
L["Delete me"] = "Удалить меня"
L["Deletes this custom module and all associated settings. Cannot be undone!"] = "Удаляет данный пользовательский модуль и все связанные с ним настройки. Отменить не возможно!"
L["Determines the bar width compared to the whole texture width"] = "Соотношение ширины полосы и ширины текстуры"
L["Display Mode"] = "Режим отображения"
L["Display aura icon"] = "Показать иконку ауры"
L["Display mode"] = "Режим дисплея"
L["Display non-interruptible color"] = "Показать непрерывные цвета"
L["Display target details"] = "Показать подробности цели"
L["Display target guild"] = "Показать гильдию цели"
L["Display target name"] = "Показать имя цели"
L["Display when empty"] = "Показывать когда пусто"
L["Display when targeting"] = "Display when targeting" -- Requires localization
L["Distance between the left and right bars"] = "Расстояние между левой и правой полосами"
L[ [=[DogTag-formatted string to use for the bottom text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] ] = [=[DogTag-formatted string to use for the bottom text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] -- Requires localization
L[ [=[DogTag-formatted string to use for the left side of the bar.

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] ] = [=[DogTag-formatted string to use for the left side of the bar.

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] -- Requires localization
L[ [=[DogTag-formatted string to use for the range display (only available if LibDogTag is being used)

Type /dogtag for a list of available tags]=] ] = [=[DogTag-formatted string to use for the range display (only available if LibDogTag is being used)

Type /dogtag for a list of available tags]=] -- Requires localization
L[ [=[DogTag-formatted string to use for the right side of the bar.

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] ] = [=[DogTag-formatted string to use for the right side of the bar.

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] -- Requires localization
L[ [=[DogTag-formatted string to use for the second text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] ] = [=[DogTag-formatted string to use for the second text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] -- Requires localization
L[ [=[DogTag-formatted string to use for the third text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] ] = [=[DogTag-formatted string to use for the third text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] -- Requires localization
L[ [=[DogTag-formatted string to use for the top text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] ] = [=[DogTag-formatted string to use for the top text line (leave blank to revert to old behavior)

Type /dogtag for a list of available tags.

Remember to press Accept after filling out this box or it will not save.]=] -- Requires localization
L["Draw Elite Icon On Top"] = "Рисовать иконку элиты на верху"
L["Draw PVP Icon on top"] = "Рисовать PvP иконку на верху"
L["Draw Raid Icon On Top"] = "Рисовать рейд иконку на верху"
L["Duplicate me"] = "Дублировать меня"
L["Edit Marker"] = "Изменить маркер"
L["Elite Icon Scale"] = "Масштаб иконки элиты"
L["Elite Icon X Offset"] = "Смещение иконки элиты по X"
L["Elite Icon Y Offset"] = "Смещение иконки элиты по Y"
L["Enable/disable IceHUD"] = "Включить/выключить IceHUD"
L["Enable/disable debug messages"] = "Включить/выключить отладочные сообщения"
L["Enable/disable module"] = "Включить/выключить модуль"
L["Enabled"] = "Включён"
L["Energy Ticker Alpha"] = "Прозрачность таймера энергии"
L[ [=[Enter which unit that this bar should be monitoring the health of (e.g.: focustarget, pettarget, etc.)

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Введите того, чьё здоровье должна отображать эта полоса (например: focustarget (выделенная цель), pettarget (цель питомца) и т.д.)

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L[ [=[Enter which unit that this bar should be monitoring the mana of (e.g.: focustarget, pettarget, etc.)

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Введите того, чью ману должна отображать эта полоса (например: focustarget (выделенная цель), pettarget (цель питомца) и т.д.)

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L["Error: IceHUD database not loaded correctly.  Please exit out of WoW and delete the database file (IceHUD.lua) found in: \\World of Warcraft\\WTF\\Account\\<Account Name>>\\SavedVariables\\"] = "Ошибка: База IceHUD загружена не корректно. Пожалуйста выйдите из WoW и удалите файл базы данных (IceHUD.lua) находящийся в: \\World of Warcraft\\WTF\\Account\\<Account Name>\\SavedVariables\\"
L["Exact match only"] = "Точная фраза"
L["Export profile"] = "Экспорт профиля"
L["Exports your active profile to something you can copy and paste to another user or use on another account."] = "Экспорт настроек активного профиля. Можете вставить их в настройки другого профиля или даже пользователя"
L["FAQs"] = "ЧаВо"
L["Flash Instant Spells"] = "Блеск мгновенных заклинаний"
L["Flash bar below Low Threshold"] = "Мигание полосы при достижении нижнего предела"
L["Flash on Spell Failures"] = "Мигать, если заклинание не выполнилось"
L["Flash when ready"] = "Мигать когда готово"
L["Flashes the bar when it is below the Low Threshold specified above"] = "Мигать, если Нижний Порог достигнут"
L["Font"] = "Шрифт"
L["Font Size"] = "Размер шрифта"
L["Force Text Justification"] = "Принудительное выравнивание текста"
L["Friendly OOC alpha"] = "Friendly OOC alpha" -- Requires localization
L["Gap"] = "Промежуток"
L["General Settings"] = "Основные настройки"
L["HUD scale"] = "масштаб HUD"
L["Height"] = "Высота"
L["Hide Blizzard Buffs"] = "Скрыть стандартные баффы"
L["Hide Blizzard Frame"] = "Скрыть стандартный фрейм"
L["Hide Blizzard Party"] = "Скрыть стандартный фрейм группы"
L["Hides Blizzard Focus frame and disables all events related to it"] = "Скрыть стандартное окно цели и отключить все события с ним связанные"
L["Hides Blizzard Player frame and disables all events related to it"] = "Скрыть стандартный фрейм игрока и отключить все события с ним связанные"
L["Hides Blizzard Rune frame and disables all events related to it"] = "Спрятать стандартный фрейм рун и отключить все события с ним связанные"
L["Hides Blizzard Target frame and disables all events related to it"] = "Спрятать стандартный фрейм цели и отключить все события с ним связанные"
L[ [=[Hides Blizzard frame and disables all events related to it.

NOTE: Blizzard attaches this UI to the player's unitframe, so if you have that hidden in PlayerHealth, then this won't do anything.]=] ] = [=[Спрятать стандартный фрейм и отключить все события с ним связанные

ПРИМЕЧАНИЕ: По-умолчанию этот UI привязан к фрейму игрока, т.е. если Вы отключили его в модуле PlayerHealth, но эта настройки не будет давать никакого эффекта]=]
L[ [=[Hides Blizzard shard frame and disables all events related to it.

NOTE: Blizzard attaches the shard UI to the player's unitframe, so if you have that hidden in PlayerHealth, then this won't do anything.]=] ] = [=[Hides Blizzard shard frame and disables all events related to it.

NOTE: Blizzard attaches the shard UI to the player's unitframe, so if you have that hidden in PlayerHealth, then this won't do anything.]=] -- Requires localization
L["Hides Blizzard's default buffs frame and disables all events related to it"] = "Скрывает окно бафов Blizzard и отключает все события, связанные с ним"
L["Hides Blizzard's default party frame and disables all events related to them"] = "Скрывает окно группы Blizzard и отключает все связанные с ним события"
L["Horizontal Position"] = "Горизонтальная позиция"
L["Horizontal position"] = "Горизонтальная позиция"
L["Horizontal position (for you dual screen freaks)"] = "Горизонтальная позиция (для чудаков с 2 экранами)"
L["How far horizontally the buff frame should be offset from the anchor"] = "Отступ фрейма баффов по горизонтали"
L["How far horizontally the debuff frame should be offset from the anchor"] = "Отступ фрейма дебаффов по горизонтали"
L["How far to push the elite icon right or left"] = "Горизонтальный отступ для иконки элиты"
L["How far to push the elite icon up or down"] = "Вертикальный отступ для иконки элиты"
L["How far to push the raid icon right or left"] = "Горизонтальный отступ для иконки рейда"
L["How far to push the raid icon up or down"] = "Вертикальный отступ для иконки рейда"
L["How far vertically the buff frame should be offset from the anchor"] = "Вертикальный отступ панели баффов от панели информации"
L["How far vertically the debuff frame should be offset from the anchor"] = "Вертикальный отступ панели дебаффов от панели информации"
L["How long the animation should take to play"] = "Продолжительность анимации"
L["How many buffs/debuffs is shown on each row"] = "Количество (де)бафов в ряду"
L[ [=[How many total applications of this buff/debuff can be applied. For example, only 5 sunders can ever be on a target, so this would be set to 5 for tracking Sunder.

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[How many total applications of this buff/debuff can be applied. For example, only 5 sunders can ever be on a target, so this would be set to 5 for tracking Sunder.

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] -- Requires localization
L["How much space should be between each buff or debuff icon."] = "Промежуток между иконками (де)баффов"
L["How much to offset the Party Role icon from the bar horizontally"] = "Горизонтальное смещение иконки роли в группе от полосы"
L["How much to offset the Party Role icon from the bar vertically"] = "Вертикальное смещение иконки роли в группе от полосы"
L["How much to offset the PvP icon from the bar horizontally"] = "Горизонтальное смещение иконки PvP от полосы"
L["How much to offset the PvP icon from the bar vertically"] = "Вертикальное смещение иконки PvP от полосы"
L["How much to offset the leader icon from the bar horizontally"] = "Горизонтальное смещение иконки лидера от полосы"
L["How much to offset the leader icon from the bar vertically"] = "Вертикальное смещение иконки лидера от полосы"
L["How much to offset the loot master icon from the bar horizontally"] = "Горизонтальное смещение иконки лут-мастера от полосы"
L["How much to offset the loot master icon from the bar vertically"] = "Вертикальное смещение иконки лут-мастера от полосы"
L["How much to offset the status icon (resting/combat) from the bar horizontally"] = "Горизонтальное смещение иконки статуса (отдыха/боя) от полосы"
L["How much to offset the status icon (resting/combat) from the bar vertically"] = "Вертикальное смещение иконки статуса (отдыха/боя) от полосы"
L["How much to scale the Party Role icon"] = "Масштаб иконки роли в группе"
L["How much to scale the PvP icon"] = "Масштаб иконки PvP"
L["How much to scale the elite icon"] = "Масштаб иконки элиты"
L["How much to scale the leader icon"] = "Масштаб иконки лидера группы"
L["How much to scale the loot master icon"] = "Масштаб иконки лут-мастера"
L["How much to scale the raid icon"] = "Масштаб иконки рейда"
L["How much to scale the status icon"] = "Масштаб иконки статуса"
L["How the graphical combo points should be displayed"] = "Стиль отображения комбо-очков"
L["How the graphical counter should be displayed"] = "Стиль отображения графического счетчика"
L["How to display the buff timer next to the name of the buff on the bar"] = "Стиль отображения таймера баффа после имени баффа"
L["IceHUD"] = "IceHUD"
L["IceHUD Bar Background Blend mode"] = "IceHUD Стиль Наложения фона"
L["IceHUD Bar Blend mode"] = "IceHUD Стиль Наложения полос"
L["IceHUD Bar Texture"] = "IceHUD текстура полосы"
L["IceHUD Font"] = "IceHUD Шрифт"
L["Icon Settings"] = "Настройки иконки"
L["Icon config mode"] = "Режим конфигурации иконки"
L["Icon gap"] = "Промежуток между иконками"
L["Icon set"] = "Набор иконок"
L["Icon size"] = "Размер иконки"
L["Icon size for auras that were applied by you, the player"] = "Icon size for auras that were applied by you, the player" -- Requires localization
L["If the selected ability has a max range or only works on friendly units, this will ignore that check. Meaning you can use a CD bar for buff spells and it will display when you have an enemy targeted."] = "If the selected ability has a max range or only works on friendly units, this will ignore that check. Meaning you can use a CD bar for buff spells and it will display when you have an enemy targeted." -- Requires localization
L["If this is checked, then a health value of 1100 will display as 1.1k, otherwise it shows the number"] = "Отображать цифры сокращенными (1.1к вместо 1100)"
L[ [=[If this is checked, then a health value of 1100 will display as 1.1k, otherwise it shows the number

Note: this only applies if you are NOT using DogTag]=] ] = [=[Отображать цифры сокращенными (1.1к вместо 1100)
]=]
L["If this is checked, then the SnD buff time shows as a percent of the maximum attainable (taking set bonuses and talents into account). Otherwise, the bar always goes from full to empty when applying SnD no matter the duration."] = "If this is checked, then the SnD buff time shows as a percent of the maximum attainable (taking set bonuses and talents into account). Otherwise, the bar always goes from full to empty when applying SnD no matter the duration." -- Requires localization
L["If this is checked, then the buff name must be entered exactly as the full buff name. Otherwise, you can use only a portion of the name such as 'Sting' to track all stings."] = "If this is checked, then the buff name must be entered exactly as the full buff name. Otherwise, you can use only a portion of the name such as 'Sting' to track all stings." -- Requires localization
L["If this is checked, then the counter will use your 'out of target' alpha when targeting someone who is friendly."] = "If this is checked, then the counter will use your 'out of target' alpha when targeting someone who is friendly." -- Requires localization
L["If this is checked, then whenever the counter is maxed out it will gently pulsate to let you know it's ready to be used."] = "If this is checked, then whenever the counter is maxed out it will gently pulsate to let you know it's ready to be used." -- Requires localization
L["If this is disabled, then targeting a friendly will use the 'Alpha out of combat' setting instead of 'Alpha OOC and Target'."] = "If this is disabled, then targeting a friendly will use the 'Alpha out of combat' setting instead of 'Alpha OOC and Target'." -- Requires localization
L["If you are using the 'class color bar' setting above, then enabling this will color NPC's by their hostility toward you since NPC class isn't very helpful or applicable information."] = "If you are using the 'class color bar' setting above, then enabling this will color NPC's by their hostility toward you since NPC class isn't very helpful or applicable information." -- Requires localization
L["If you have game default font selected, this option has no effect"] = "Если шрифт по-умолчанию установлен, тогда эта опция ни на что не влияет"
L["If your class power is not full (or not empty in the case of Holy Power) then the module will always be displayed on your screen using the In Combat alpha setting. Otherwise it will fade to the OOC alpha when you leave combat."] = "If your class power is not full (or not empty in the case of Holy Power) then the module will always be displayed on your screen using the In Combat alpha setting. Otherwise it will fade to the OOC alpha when you leave combat." -- Requires localization
L["Ignore range"] = "Ignore range" -- Requires localization
L["Import profile"] = "Импорт профиля"
L["Imports a profile as exported from another user's IceHUD."] = "Импорт профиля экспортированный другим пользователем IceHUD."
L["Inactive mode"] = "Неактивный режим"
L["Incoming heal bar alpha"] = "Прозрачность полосы Внешнее Лечение"
L["Invert bar"] = "Обратить полосу"
L["Lacerate Count Font Size"] = "Размер текста Количества 'Растерзать'"
L["Lacerate gap"] = "Отступ для 'Растерзать'"
L["Lag Indicator alpha"] = "Прозрачность индикатора задержки"
L["Lag indicator alpha (0 is disabled)"] = "Прозрачность индикатора задержки (0 отключено)"
L["Layout"] = "Макет"
L["Leader Icon Horizontal Offset"] = "Горизонтальное смещение иконки лидера"
L["Leader Icon Scale"] = "Масштаб иконки лидера"
L["Leader Icon Vertical Offset"] = "Вертикальное смещение иконки лидера"
L["Leader icon"] = "Иконка лидера"
L["Left Tag"] = "Левая метка"
L["Line 1 tag"] = "1я строка метки"
L["Line 2 tag"] = "2я строка метки"
L["Line 3 tag"] = "3я строка метки"
L["Line 4 tag"] = "4я строка метки"
L["Lock Bar Text Alpha"] = "Запретить изменение прозрачности текста"
L["Lock Lower Text Alpha"] = "Запретить изменение прозрачности нижнего текста"
L["Lock Upper Text Alpha"] = "Запретить изменение прозрачности верхнего текста"
L["Lock all icons to 100% alpha"] = "Запереть прозрачность иконок на 100%"
L["Lock raid icon to 100% alpha"] = "Запереть прозрачность иконок рейда на 100%"
L["Locks lower text alpha to 100%"] = "Принудительно установить прозрачность нижнего текста в 100%"
L["Locks text alpha to 100%"] = "Принудительно установить прозрачность текста в 100%"
L["Locks upper text alpha to 100%"] = "Принудительно установить прозрачность верхнего текста в 100%"
L["Look and Feel"] = "Вид и поведение"
L["Loot Master Icon Horizontal Offset"] = "Горизонтальное смещение иконки лут-мастера"
L["Loot Master Icon Scale"] = "Масштаб иконки лут-мастера"
L["Loot Master Icon Vertical Offset"] = "Вертикальное смещение иконки лут-мастера"
L["Loot Master icon"] = "Иконка лут-мастера"
L["Low Threshold"] = "Нижний Порог"
L["Low Threshold color"] = "Цвет Нижнего Порога"
L["Lower Text"] = "Нижний текст"
L["Lower Text Color"] = "Цвет нижнего текста"
L["Lower text visible"] = "Нижний текст включен" -- Needs review
L["Maelstrom Count Font Size"] = "Размер текста Количества Водоворотов"
L["Maelstrom gap"] = "Отступ Водоворотов"
L["Make this bar wider or thinner than others"] = "Сделать полосу шире или уже, чем остальные"
L["Makes all modules visible so you can see where they're placed and find any that are overlapping."] = "Сделать все модули видимыми, для того,чтобы найти их или увидеть, где они перекрываются"
L["Marker Settings"] = "Настройки маркера"
L[ [=[Maximum Duration for the bar (the bar will remained full if it has longer than maximum remaining).  Leave 0 for spell duration.

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Maximum Duration for the bar (the bar will remained full if it has longer than maximum remaining).  Leave 0 for spell duration.

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] -- Requires localization
L["Maximum applications"] = "Максимум приложений"
L["Maximum duration"] = "Максимальная длительность"
L["Module Settings"] = "Настройки модулей"
L["Module color configuration options"] = "Опции настроек цветов модуля"
L["Module configuration options"] = "Опции настройки модуля"
L["Module options"] = "Опции модуля"
L["Module type:"] = "Тип модуля:"
L["Mouse settings"] = "Настройки мыши"
L["Mouseover"] = "Наведение мышкой" -- Needs review
L["Mouseover for buffs"] = "Наведение мышкой для баффов" -- Needs review
L["Mouseover for target"] = "Наведение мышкой для цели" -- Needs review
L["Number of updates per second. The higher this number is, the smoother bars will animate. However, higher settings will also use more CPU, so balance it to your liking. 30 is the recommended setting."] = "Количество обновлений в секунду. Чем больше значение, тем более плавной будет анимация полос, но тем больше используется процессор. Подберите оптимальное значение вручную. Рекомендованное значение - 30"
L["Offset"] = "Смещение"
L["Offset of the bar"] = "Смещение полосы"
L["Offset of the text from the bar horizontally"] = "Смещение текста полосы по горизонтали"
L["Offset of the text from the bar vertically (negative is farther below)"] = "Смещение текста полосы по вертикали (чем меньше, тем ниже)"
L["Only show buffs by me"] = "Показывать только баффы от меня"
L["Only show debuffs by me"] = "Показывать только дебаффы от меня"
L["Only show for my debuffs"] = "Показывать только для дебаффов от меня"
L["Only show if target uses mana"] = "Показывать только если цель использует ману"
L["Only show in groups"] = "Показывать только в группах"
L["Only show the threat bar if you are in a group or you have an active pet"] = "Показывать Полосу Аггро только если в группе или с питомцем"
L["Only track auras by me"] = "Only track auras by me" -- Requires localization
L["Other"] = "Другое"
L["Override alpha when not full"] = "Override alpha when not full" -- Requires localization
L["Override global texture"] = "Замещать глобальную текстуру"
L["Own buff size"] = "Размер собственных бафов"
L["Own debuff size"] = "Own debuff size" -- Requires localization
L["Party Role Icon Horizontal Offset"] = "Горизонтальное смещение иконки роли в группе"
L["Party Role Icon Scale"] = "Масштаб иконки роли в группе"
L["Party Role Icon Vertical Offset"] = "Вертикальное смещение иконки роли в группе"
L["Party Role icon"] = "Иконка роли в группе"
L["Position (percent)"] = "Позиция (процент)"
L["Positioning Settings"] = "Настройки расположения"
L["Potential SnD time bar alpha"] = "Прозрачность полосы 'Прогнозируемое время Мясорубки'"
L["Predefined settings for different bars"] = "Предустановленные настройки для разных полос"
L["Presets"] = "Заготовки"
L["Pulse when full"] = "Пульсировать, если полный"
L["PvP Icon Horizontal Offset"] = "Горизонтальное смещение иконки PvP"
L["PvP Icon Scale"] = "Масштаб иконки PvP"
L["PvP Icon Vertical Offset"] = "Вертикальное смещение иконки PvP"
L["PvP icon"] = "PvP иконка"
L["Raid Icon Scale"] = "Масштаб иконки рейда"
L["Raid Icon X Offset"] = "Смещение рейд-иконки по X"
L["Raid Icon Y Offset"] = "Смещение рейд-иконки по Y"
L["Raid icon"] = "Иконка рейда"
L["Range string"] = "Строка расстояния"
L["Remove"] = "Удалить"
L["Reverse channeling"] = "Обратное заполнение"
L["Reverse direction"] = "Противоположное направление"
L["Right Tag"] = "Правая метка"
L["Rotate 90 degrees"] = "Поворот на 90 градусов"
L["Rune cooldown mode"] = "Режим перезарядки рун"
L["Rune gap"] = "Отступ рун"
L["Rune orientation"] = "Ориентация рун"
L["Scale"] = "Масштаб"
L["Scale of the bar"] = "Масштаб полосы"
L["Scale of the element"] = "Масштаб элемента"
L["Second place threat alpha"] = "Прозрачность 2го по агро"
L["Select a custom module that you want to create here, then press the 'Create' button."] = "Выберите дополнительный модуль, который Вы хотите добавить и нажмите кнопку 'Создать'"
L["Select which unit that this bar should be looking for buffs/debuffs on"] = "Select which unit that this bar should be looking for buffs/debuffs on" -- Requires localization
L["Self Color"] = "Свой цвет"
L["Self Display Mode"] = "Свой режим дисплея"
L["Set the color of the TargetTarget bar if you are your target's target."] = "Цвет для полосы TargetTarget, если целью цели являетесь Вы"
L["Sets the height of this module."] = "Устанавливает высоту этого модуля."
L["Sets the width of this module if 'size to gap' is not set"] = "Sets the width of this module if 'size to gap' is not set" -- Requires localization
L["Settings for bar transparencies"] = "Настройки прозрачности для полосы"
L["Settings related to bars"] = "Настройки, связанные с полосами"
L["Settings related to icons"] = "Настройки связанные с иконками"
L["Settings related to positioning and alpha"] = "Настройки расположения и прозрачности"
L["Settings related to texts"] = "Настройки, связанные с текстами"
L["Show Elite Icon"] = "Показать иконку элиты"
L["Show Minimap Icon"] = "Показать иконку мини-карты"
L["Show Party Role icon"] = "Показать иконку роли в группе"
L["Show PvP icon"] = "Показать PvP иконку"
L["Show Raid Icon"] = "Показать рейд иконку"
L["Show bar as % of maximum"] = "Показать полосу как % от максимума"
L["Show buffs"] = "Показать бафы"
L["Show combat status"] = "Показывать статус боя"
L["Show debuffs"] = "Показать дебафы"
L["Show default cast bar"] = "Показывать стандартную полосу заклинания"
L["Show graphical or numeric combo points"] = "Отображать комбо-очки цифрами или графикой"
L["Show graphical or numeric counts"] = "Установить графическое или цифровое отображение счетчиков"
L["Show graphical or numeric lacerates"] = "Отображать 'Растерзания' графически или цифрами"
L["Show graphical or numeric maelstroms"] = "Отображать 'Водовороты' графически или цифрами"
L["Show graphical or numeric sunders"] = "Отображать 'Расколы брони' графически или цифрами"
L["Show incoming heals"] = "Отображать внешние лечения"
L["Show leader icon"] = "Показать иконку лидера"
L["Show loot master icon"] = "Показать иконку лут-мастера"
L["Show resting status"] = "Показать статус отдыха"
L["Show rogue/cat energy ticker"] = "Отображать тикер энергии для Разбойника/Формы кошки"
L["Show scaled threat"] = "Показывать агро масштабированным"
L["Show second highest threat"] = "Показывать второго по агро"
L["Show spell cast time"] = "Отображать время произнесения заклинания"
L["Show spell rank"] = "Отображать уровень заклинания"
L["Show stacking debuffs"] = "Показывать дебаффы объединенными"
L["Show stacking debuffs in ToT info"] = "Show stacking debuffs in ToT info" -- Requires localization
L["Show status icon"] = "Показать статус иконку"
L["Shows a flash behind each holy rune when it becomes available."] = "Shows a flash behind each holy rune when it becomes available." -- Requires localization
L["Shows a flash behind each shard when it becomes available."] = "Shows a flash behind each shard when it becomes available." -- Requires localization
L["Side"] = "Сторона"
L["Side of the HUD where the bar appears"] = "Side of the HUD where the bar appears" -- Requires localization
L["Since the last time you updated IceHUD, many significant CPU and memory optimizations have been made. If bar animation looks jumpy to you, open the /icehud configuration page and raise the 'Update Period' slider. This will cause higher CPU usage but will look nicer. Enjoy IceHUD!"] = "С тех пор, как Вы обновили IceHUD в нем было сделано множество улучшений производительности. Если анимация выглядит рваной, откройте конфигурацию командой /icehud и увеличьте значение 'Период обновления'. Это немного увеличит использование CPU, но выглядеть все будет намного лучше. Наслаждайтесь IceHUD!"
L["Size and Placement"] = "Размер и размещение"
L["Size to gap"] = "Size to gap" -- Requires localization
L["Sort by expiration"] = "Sort by expiration" -- Requires localization
L["Space between bars on the same side"] = "Промежуток между полосами одной стороны"
L["Space between buffs"] = "Промежуток между бафами"
L["Spacing between each combo point (only works for graphical mode)"] = "Промежуток между комбо-очками в графическом режиме"
L["Spacing between each icon (only works for graphical mode)"] = "Расстояние между иконками (работает только для графического режима)"
L["Spacing between each lacerate count (only works for graphical mode)"] = "Промежуток между 'Растерзаниями' в графическом режиме"
L["Spacing between each maelstrom point (only works for graphical mode)"] = "Расстояние между точками водоворота (работает только для графического режима)"
L["Spacing between each rune (only works for graphical mode)"] = "Расстояние между рунами (работает только для графического режима)"
L["Spacing between each sunder count (only works for graphical mode)"] = "Промежуток между 'Расколами брони' в графическом режиме"
L["Spacing between each totem (only works for graphical mode)"] = "Расстояние между каждым тотемом (работает только для графического режима)"
L["Spell cast text visible"] = "Включить текст времени произнесения заклинания"
L["Spell to track"] = "Заклинание для отслеживания"
L["Stack Font Size"] = "Размер шрифта стопки"
L["Status Icon Horizontal Offset"] = "Гориз. смещение иконки статуса"
L["Status Icon Scale"] = "Масштаб иконки статуса"
L["Status Icon Vertical Offset"] = "Верт. смещение иконки статуса"
L["Status icon"] = "Иконка статуса"
L["Sunder Count Font Size"] = "Размер шрифта 'Раскола брони'"
L["Sunder gap"] = "Отступ 'Раскола брони'"
L["Text Horizontal Offset"] = "Горизонтальное смещение текста"
L["Text Settings"] = "Настройки текста"
L["Text Vertical Offset"] = "Вертикальное смещение текста"
L["Texture"] = "Текстура"
L["The alpha value for the second-place threat bar to be (this is multiplied by the bar's alpha so it's always proportionate)"] = "The alpha value for the second-place threat bar to be (this is multiplied by the bar's alpha so it's always proportionate)" -- Requires localization
L["The color for this bar"] = "Цвет для этой полосы"
L["The color for this counter"] = "Цвет счетчика"
L["The color this marker should be."] = "Цвет маркера"
L["The height of the marker on the bar."] = "Высота маркера"
L[ [=[The lower text to display under this bar (accepts LibDogTag formatting)

See http://www.wowace.com/wiki/LibDogTag-2.0/ or type /dogtag for tag info.

Remember to press ENTER after filling out this box or it will not save.]=] ] = [=[The lower text to display under this bar (accepts LibDogTag formatting)

See http://www.wowace.com/wiki/LibDogTag-2.0/ or type /dogtag for tag info.

Remember to press ENTER after filling out this box or it will not save.]=] -- Requires localization
L[ [=[The lower text to display under this bar.

NOTE: this text block does NOT support DogTags.

Remember to press ENTER/Accept after filling out this box or it will not save.]=] ] = [=[Ниже текст, отображаемый в этой полосе.

Примечание: Этот блок текста НЕ поддерживает DogTags.

Не забудьте нажать ENTER/Принять после заполнения этого поля, иначе оно не сохранится.]=]
L["The minimum color for this counter (only used if Change Color is enabled)"] = "The minimum color for this counter (only used if Change Color is enabled)" -- Requires localization
L[ [=[The name of this bar (must be unique!).

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Название этой полосы (должно быть уникальным!).

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L[ [=[The name of this counter (must be unique!). 

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Название этого счетчика (должно быть уникальным!).

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L["The point on the TargetInfo frame that the buff frame gets connected to"] = "The point on the TargetInfo frame that the buff frame gets connected to" -- Requires localization
L["The point on the TargetInfo frame that the debuff frame gets connected to"] = "The point on the TargetInfo frame that the debuff frame gets connected to" -- Requires localization
L[ [=[The upper text to display under this bar (accepts LibDogTag formatting)

See http://www.wowace.com/wiki/LibDogTag-2.0/ or type /dogtag for tag info.

Remember to press ENTER after filling out this box or it will not save.]=] ] = [=[The upper text to display under this bar (accepts LibDogTag formatting)

See http://www.wowace.com/wiki/LibDogTag-2.0/ or type /dogtag for tag info.

Remember to press ENTER after filling out this box or it will not save.]=] -- Requires localization
L[ [=[The upper text to display under this bar.

NOTE: this text block does NOT support DogTags.

Remember to press ENTER/Accept after filling out this box or it will not save.]=] ] = [=[Верхний текст, отображаемый в этой полосе.

Примечание: Этот блок текста НЕ поддерживает DogTags.

Не забудьте нажать ENTER/Принять после заполнения этого поля, иначе оно не сохранится.]=]
L["This controls what happens to runes that are inactive. Darkened means they are visible but colored black, Hidden means they are not displayed."] = "This controls what happens to runes that are inactive. Darkened means they are visible but colored black, Hidden means they are not displayed." -- Requires localization
L["This is a per-pixel horizontal adjustment. You should probably use the 'offset' setting above as it is designed to snap bars together. This may be used in the case of a horizontal bar needing to be positioned outside the normal bar locations."] = "Точное горизонтальное выравнивание. Обычно нужно использовать вышестоящую настройку 'Смещение', которая и предназначена для взаимного выравнивания полос. Эта опция предназначена для вынесения полосы из обычного расположения полос"
L["This option requires the UI to be reloaded. Do you wish to reload it now?"] = "Эта настройка требует перезагрузки пользовательского интерфейса. Вы хотите перезагрузить его сейчас?"
L["This sets the alignment for the text on this bar"] = "Устанавливает выравнивание текста этой полосы"
L[ [=[This specifies at what point along the bar this marker should be displayed. Remember to press ENTER when you are done typing.

Example: if you wanted a marker at 40 energy and you have 100 total energy, then this would be 40. If you want it at 40 energy and you have 120 total energy, then this would be 33.]=] ] = [=[This specifies at what point along the bar this marker should be displayed. Remember to press ENTER when you are done typing.

Example: if you wanted a marker at 40 energy and you have 100 total energy, then this would be 40. If you want it at 40 energy and you have 120 total energy, then this would be 33.]=] -- Requires localization
L[ [=[This will fade the bars or numeric representation from the min color specified to the regular color

(e.g. if the min color is yellow, the color is red, and there are 3 total applications, then the first would be yellow, second orange, and third red)]=] ] = [=[This will fade the bars or numeric representation from the min color specified to the regular color

(e.g. if the min color is yellow, the color is red, and there are 3 total applications, then the first would be yellow, second orange, and third red)]=] -- Requires localization
L[ [=[This will fade the graphical representation from the min color specified to the regular color

(e.g. if the min color is yellow, the color is red, and there are 3 total applications, then the first would be yellow, second orange, and third red)]=] ] = [=[This will fade the graphical representation from the min color specified to the regular color

(e.g. if the min color is yellow, the color is red, and there are 3 total applications, then the first would be yellow, second orange, and third red)]=] -- Requires localization
L["This will override the global bar texture setting for this bar with the one specified below."] = "Переопределяет глобальное значение стиля полосы на значение указанное ниже"
L["This will override the global bar texture setting for this bar."] = "Переназначает глобальную настройку текстуры для полосы"
L["This will remove the marker selected in the 'edit marker' box. This action is irreversible."] = "Удаляет маркер, выбранный в поле 'Редактирование маркера'. Это действие необратимо"
L[ [=[This will rotate this module by 90 degrees to give a horizontal orientation.

WARNING: This feature is brand new and a bit rough around the edges. You will need to greatly adjust the vertical and horizontal offset of this bar plus move the text around in order for it to look correct.

And I mean greatly.]=] ] = "Переворачивает отображение модуля на 90градусов чтобы придать ему горизонтальное расположение"
L["This will update the marker selected in the 'edit marker' box with the values specified."] = "Обновляет параметры маркера, выбранного в поле 'Редактирование маркера'."
L["ToT frame texture"] = "Текстура фрейма ToT"
L["Toggle bar background visibility"] = "Вкл/выкл видимость фона полосы"
L["Toggle bar visibility"] = "Вкл/выкл видимость полосы"
L["Toggle lower text visibility"] = "Вкл/выкл видимость нижнего текста"
L["Toggle mouseover on/off"] = "Вкл/выкл наведение мышкой"
L["Toggle mouseover on/off for buffs/debuffs"] = "Вкл/выкл наведение мышкой для (де)баффов"
L["Toggle mouseover on/off for target"] = "Вкл/выкл наведение мышкой для цели"
L["Toggle spell cast text visibility"] = "Вкл/выкл текст заклинания"
L["Toggle upper text visibility"] = "Вкл/выкл верхний текст"
L["Toggles contextual background coloring"] = "Вкл/выкл контекстную расцветку фона"
L["Toggles whether or not buffs are displayed at all"] = "Вкл/выкл отображение баффов"
L["Toggles whether or not debuffs are displayed at all"] = "Вкл/выкл отображение дебаффов"
L["Toggles whether or not to show the CastNonInterruptible color for this bar when a cast is non-interruptible"] = "Toggles whether or not to show the CastNonInterruptible color for this bar when a cast is non-interruptible" -- Requires localization
L["Toggles whether or not to sort by expiration time (otherwise they're sorted how the game sorts them - by application time)"] = "Toggles whether or not to sort by expiration time (otherwise they're sorted how the game sorts them - by application time)" -- Requires localization
L["Totem cooldown mode"] = "Режим перезарядки тотема"
L["Totem gap"] = "Отступ тотемов"
L["Totem orientation"] = "Ориентация тотемов"
L["Transparency Settings"] = "Настройки прозрачности"
L["Type %s to clear focus"] = "Наберите %s для очистки фокуса"
L["Type %s to set focus"] = "Наберите %s для установки фокуса"
L["Unit to track"] = "Unit to track" -- Requires localization
L["Update"] = "Обновить"
L["Update Period"] = "Период обновления"
L["Upper Text"] = "Верхний текст"
L["Upper Text Color"] = "Цвет верхнего текста"
L["Upper text visible"] = "Верхний текст включен" -- Needs review
L["Use 'Target' alpha for friendlies"] = "Use 'Target' alpha for friendlies" -- Requires localization
L["Use Dog Tags"] = "Use Dog Tags" -- Requires localization
L["Use class color as the bar color instead of default color"] = "Use class color as the bar color instead of default color" -- Requires localization
L["Use class color as the bar color instead of reaction color"] = "Use class color as the bar color instead of reaction color" -- Requires localization
L[ [=[Use class color as the bar color instead of reaction color

(Note: The 'color bar by health %' setting overrides this)]=] ] = [=[Use class color as the bar color instead of reaction color

(Note: The 'color bar by health %' setting overrides this)]=] -- Requires localization
L["Use normal alpha"] = "Use normal alpha" -- Requires localization
L["Usually CD bars will always display if they're set to 'When Ready' or 'Always' mode regardless of your other transparency settings. If you'd rather this bar show/hide as per normal transparency rules, then check this box."] = "Usually CD bars will always display if they're set to 'When Ready' or 'Always' mode regardless of your other transparency settings. If you'd rather this bar show/hide as per normal transparency rules, then check this box." -- Requires localization
L["Vertical Position"] = "Вертикальная позиция"
L["Vertical position"] = "Вертикальная позиция"
L["Visibility Settings"] = "Настройки видимости"
L["What alpha value to use for the bar that displays how long your SnD will last if you activate it. (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)"] = "What alpha value to use for the bar that displays how long your SnD will last if you activate it. (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)" -- Requires localization
L["What alpha value to use for the bar that displays how much health you'll have after an incoming heal (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)"] = "What alpha value to use for the bar that displays how much health you'll have after an incoming heal (This gets multiplied by the bar's current alpha to stay in line with the bar on top of it)" -- Requires localization
L["What this bar should do whenever the player is the TargetOfTarget"] = "Поведение полосы если игрок является целью цели"
L[ [=[What this bar should do whenever the player is the TargetOfTarget

NOTE: When this is set to 'hide', then click-targeting is not available due to Blizzard's restrictions]=] ] = [=[Поведение полосы если игрок является целью цели

ПРИМЕЧАНИЕ: Если установлено в 'спрятать', то выбор цели ЛКМ невозможен из-за ограничений Blizzard]=]
L["When tanking, this toggles whether or not the second-highest threat value found in your party or raid is displayed on top of your actual threat value"] = "When tanking, this toggles whether or not the second-highest threat value found in your party or raid is displayed on top of your actual threat value" -- Requires localization
L["When the bar drops below this amount, it will start flashing (0 means never). For the 'mana' bar this only applies to mana and not rage/energy/focus/runic power."] = "Когда полоса падает ниже этого значения, она начнёт мигать (0 означает никогда). Для полосы \"мана\" это относится только к мане, а не ярости/энергии/концентрации/рунической силы."
L["When to display this bar."] = "Когда отображать эту полосу."
L[ [=[Whether or not the addon should use the DogTag library (this will increase the CPU usage of the mod). DogTag controls all text displayed around bars such as health or mana amounts. Type |cffffff78/dog|r to see all DogTag options.

NOTE: after changing this option, you must reload the UI or else bad things happen]=] ] = [=[Whether or not the addon should use the DogTag library (this will increase the CPU usage of the mod). DogTag controls all text displayed around bars such as health or mana amounts. Type |cffffff78/dog|r to see all DogTag options.

NOTE: after changing this option, you must reload the UI or else bad things happen]=] -- Requires localization
L["Whether or not to allow click casting of Hunger For Blood"] = "Whether or not to allow click casting of Hunger For Blood" -- Requires localization
L["Whether or not to allow click targeting/casting and the player drop-down menu for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)"] = "Whether or not to allow click targeting/casting and the player drop-down menu for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)" -- Requires localization
L["Whether or not to allow click targeting/casting and the player drop-down menu for this bar while the player is in combat (Note: does not work properly with HiBar, have to click near the base of the bar)"] = "Whether or not to allow click targeting/casting and the player drop-down menu for this bar while the player is in combat (Note: does not work properly with HiBar, have to click near the base of the bar)" -- Requires localization
L["Whether or not to allow click targeting/casting and the target drop-down menu for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)"] = "Whether or not to allow click targeting/casting and the target drop-down menu for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)" -- Requires localization
L["Whether or not to allow click targeting/casting for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)"] = "Whether or not to allow click targeting/casting for this bar (Note: does not work properly with HiBar, have to click near the base of the bar)" -- Requires localization
L["Whether or not to allow the mouse to interact with the totems. If this is enabled, then right-clicking a totem will cancel it. Otherwise mouse clicks will not get caught by the totems and no tooltips will be shown."] = "Whether or not to allow the mouse to interact with the totems. If this is enabled, then right-clicking a totem will cancel it. Otherwise mouse clicks will not get caught by the totems and no tooltips will be shown." -- Requires localization
L["Whether or not to animate the bar falloffs/gains"] = "Whether or not to animate the bar falloffs/gains" -- Requires localization
L["Whether or not to display an icon for the aura that this bar is tracking"] = "Отображать или не отображать иконку, что эта полоса отслеживается"
L["Whether or not to display the first line of text on this module which is the target's name."] = "Отображать первую строку текста (где имя цели)"
L["Whether or not to display the second line of text on this module which is the target's details (level, class, PvP status, etc.)."] = "Отображать вторую строку текста (где подробная информация о цели: уровень, класс, PvP статус и.т.д.)"
L["Whether or not to display the third line of text on this module which is the target's guild and realm (if they are from another realm)."] = "Отображать третью строку текста (где общая информация о цели: гильдия, мир и.т.д.)"
L["Whether or not to display this bar even if the buff/debuff specified is not present."] = "Отображать ли полосу даже если указанный (де)бафф не существует"
L["Whether or not to reverse the direction of the cast bar when a spell is being channeled. For example, if a normal cast causes this bar to fill up, then checking this option will cause a channeled spell to empty the bar instead."] = "Whether or not to reverse the direction of the cast bar when a spell is being channeled. For example, if a normal cast causes this bar to fill up, then checking this option will cause a channeled spell to empty the bar instead." -- Requires localization
L["Whether or not to show an IceHUD icon on the minimap."] = "Отображать или не отображать иконку IceHUD на мини-карте."
L["Whether or not to show incoming heals as a lighter-colored bar on top of your current health (requires LibHealComm-4.0 or official patch 4.0)"] = "Whether or not to show incoming heals as a lighter-colored bar on top of your current health (requires LibHealComm-4.0 or official patch 4.0)" -- Requires localization
L["Whether or not to show the Party Role icon"] = "Отображать или не отображать иконку роли в группе"
L["Whether or not to show the PvP icon"] = "Отображать или не отображать PvP иконку"
L["Whether or not to show the combat status portion of the status icon (for example, if you only care when you're resting, not when you're in combat)"] = "Whether or not to show the combat status portion of the status icon (for example, if you only care when you're resting, not when you're in combat)" -- Requires localization
L["Whether or not to show the default cast bar."] = "Отображать стандартную полосу заклинания."
L["Whether or not to show the loot master icon"] = "Отображать иконку лут-мастера"
L["Whether or not to show the party leader icon above this bar"] = "Отображать иконку лидера группы над полосой"
L["Whether or not to show the raid icon above this bar"] = "Отображать иконку рейда над полосой"
L["Whether or not to show the rank of a spell being cast."] = "Отображать ли уровень зачитываемого заклинания"
L["Whether or not to show the rare/elite icon above this bar"] = "Отображать иконку элиты над полосой"
L["Whether or not to show the remaining cast time of a spell being cast."] = "Whether or not to show the remaining cast time of a spell being cast." -- Requires localization
L["Whether or not to show the resting status portion of the status icon (for example, if you only care when you're in combat, but not when you're resting)"] = "Whether or not to show the resting status portion of the status icon (for example, if you only care when you're in combat, but not when you're resting)" -- Requires localization
L[ [=[Whether or not to show the status icon (resting/combat) above this bar

Note: You can configure resting/combat separately below, but disabling both resting and combat is the same as disabling the icon altogether]=] ] = [=[Whether or not to show the status icon (resting/combat) above this bar

Note: You can configure resting/combat separately below, but disabling both resting and combat is the same as disabling the icon altogether]=] -- Requires localization
L["Whether the runes should draw side-by-side or on top of one another"] = "Отображать руны рядом или одна над другой"
L["Whether the totems should draw side-by-side or on top of one another"] = "Отображать тотемы рядом или один над другим"
L["Whether this bar should hide when the player has 0 combo points or stay visible"] = "Whether this bar should hide when the player has 0 combo points or stay visible" -- Requires localization
L["Whether to always show this module at 100% alpha or not"] = "Whether to always show this module at 100% alpha or not" -- Requires localization
L["Whether to display this bar when you target a unit, even if the buff/debuff specified is not present."] = "Whether to display this bar when you target a unit, even if the buff/debuff specified is not present." -- Requires localization
L["Whether to draw the PvP icon in front of or behind this bar"] = "Отрисовывать иконку PvP впереди или позади полосы"
L["Whether to draw the elite icon in front of or behind this bar"] = "Отрисовывать иконку элиты впереди или позади полосы"
L["Whether to draw the raid icon in front of or behind this bar"] = "Отрисовывать иконку рейда впереди или позади полосы"
L["Whether to show threat in scaled values or raw values. Scaled threat means that you will pull aggro when it hits 100%. Raw threat means you will pull aggro at either 110% (melee) or 130% (ranged). Omen uses raw threat which can cause this mod to disagree with Omen if it is in scaled mode."] = "Whether to show threat in scaled values or raw values. Scaled threat means that you will pull aggro when it hits 100%. Raw threat means you will pull aggro at either 110% (melee) or 130% (ranged). Omen uses raw threat which can cause this mod to disagree with Omen if it is in scaled mode." -- Requires localization
L["Whether we are tracking a buff or debuff"] = "Whether we are tracking a buff or debuff" -- Requires localization
L[ [=[Which buff/debuff this bar will be tracking.

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Какой баф/дебаф будет отслеживать эта полоса.

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L[ [=[Which buff/debuff this counter will be tracking. 

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Какой баф/дебаф будет отслеживать этот счетчик.

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L["Which direction the buffs should grow from the anchor point"] = "Сторона, в которую будут накапливаться баффы"
L["Which direction the debuffs should grow from the anchor point"] = "Сторона, в которую будут накапливаться дебаффы"
L["Which icon set to use for elite/rare elite/rare textures. This simply changes the look of the classification icon."] = "Which icon set to use for elite/rare elite/rare textures. This simply changes the look of the classification icon." -- Requires localization
L[ [=[Which spell cooldown this bar will be tracking.

Remember to press ENTER after filling out this box with the name you want or it will not save.]=] ] = [=[Перезарядку какого заклинания будет отслеживать эта полоса.

Не забудьте нажать ENTER после заполнения поля, иначе оно не сохранится.]=]
L["Width"] = "Ширина"
L["Will only show buffs that you cast instead of all buffs active"] = "Отображать только Ваши баффы или все"
L["Will only show debuffs that you cast instead of all debuffs active"] = "Отображать только Ваши дебаффы или все"
L["Will only show this bar if the target uses mana (as opposed to rage, energy, runic power, etc.)"] = "Будет показывать только эту полосу, если цель использует ману (в отличие от ярости, энергии, рунической силы, и т.д.)"
L["With this checked, the bar will only activate for your own CC spells and not those of others."] = "Если включено, отображаются только Ваши CC заклинания"
L[ [=[With this enabled, all icons draw so you can configure their placement

Note: the combat and status icons are actually the same texture so you'll only see combat in config mode (unless you're already resting)]=] ] = [=[Если включено, то отрисовываются все иконки, т.е. можно наглядно задать им расположение

ПРИМЕЧАНИЕ: иконки боя и статуса это одно и то же, поэтому Вы увидите только иконку боя даже если Вы отдыхаете]=]
L["With this enabled, all icons will be 100% visible regardless of the alpha settings for this bar."] = "Принудительно установить видимость всех иконок в 100% невзирая на их локальные установки"
L["With this enabled, the raid icon is always 100% alpha, regardless of the bar's alpha. Otherwise, it assumes the bar's alpha level."] = "Если включено, то иконка рейда всегда будет иметь 100% прозрачность. Иначе значение берется из прозрачности полосы"
L["You have changed IceHUD profiles while in combat. This can cause problems due to Blizzard's secure frame policy. You may need to reload your UI to repair IceHUD."] = "Вы изменили профиль IceHUD во время боя. Это может вызвать проблемы из-за политики безопасности рамки Blizzard. Возможно, вам придется перезагрузить ваш пользовательский интерфейс для восстановленния IceHUD."
L["|cff8888ffIceHUD|r: Combat lockdown restriction. Leave combat and try again."] = "|cff8888ffIceHUD|r: Бой вносит ограничения. Выйдите из боя и попробуйте еще раз."

