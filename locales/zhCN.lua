local folder, core = ...
local L = LibStub("AceLocale-3.0"):NewLocale(folder, "zhCN")
if not L then return end
L["Add Spell Description"] = "添加法术描述。"
L["Add buffs above NPCs"] = "在NPC上添加Buff"
L["Add buffs above friendly plates"] = "在友方姓名板上添加Buff"
L["Add buffs above hostile plates"] = "在敌方姓名板上添加Buff"
L["Add buffs above neutral plates"] = "在中立姓名板上添加Buff"
L["Add buffs above players"] = "在玩家上添加Buff"
L["Add spell"] = "添加法术"
L[ [=[Add spell descriptions to the specific spell's list.
Disabling this will lower memory usage and login time.]=] ] = "将法术描述加入特定法术列表。/n禁用此项可降低内存占用及登入时间。"
L["Add spell to list."] = "添加法术到列表。"
L["Added: "] = "已添加："
L["All"] = "全部"
L["Always"] = "总是"
L["Always show spell, only show your spell, never show spell"] = "总是显示法术、仅显示自己的法术、从不显示法术。"
L["Bar"] = "血条"
L["Bar Anchor Point"] = "血条锚点定位"
L["Bar Growth"] = "血条增长"
L["Bar X Offset"] = "血条X偏移"
L["Bar Y Offset"] = "血条Y偏移"
L["Bars"] = "血条"
L["Blink Timeleft"] = "闪烁剩余时间"
L["Blink spell if below x% timeleft, (only if it's below 60 seconds)"] = "如果剩余时间低于x%则闪烁法术，(仅当低于60秒)"
L["Bottom"] = "底部"
L["Bottom Left"] = "底部左边"
L["Bottom Right"] = "底部右边"
L["Center"] = "中"
L["Cooldown Size"] = "冷却大小"
L["Cooldown Text Size"] = "冷却时间文字的大小"
L["Core"] = "核心"
L["Default Spells"] = "默认法术"
L["Display a question mark above plates we don't know spells for. Target or mouseover those plates."] = "如果是未知法术，则在目标或鼠标指向的姓名板上显示一个问号标记。"
L["Down"] = "向下"
L["Enable"] = "启用"
L["Enables / Disables the addon"] = "启用/禁用插件"
L[ [=[For each spell on someone, multiply it by the number of icons per bar.
This option won't be saved at logout.]=] ] = "对于某人身上的每个法术效果，将其乘以每个血条上的图标数量。/n此选项不会在登出时保存。" -- Needs review
L["Friendly"] = "友方"
L["Hostile"] = "敌方"
L["Icon Size"] = "图标大小"
L["Icons per bar"] = "每血条图标数"
L["Input a spell name. (case sensitive)"] = "输入一个法术名称（区分大小写）。"
L[ [=[Input a spell name. (case sensitive)
Or spellID]=] ] = [=[输入一个法术名称（区分大小写）。
或法术ID]=]
L["Larger self spells"] = "放大自身法术"
L["Left"] = "左"
L["Left to right offset."] = "从左到右偏移。"
L["Make your spells 20% bigger then other's."] = "自己施放的法术比他人的大20%。"
L["Max bars"] = "血条最大数量"
L["Max number of bars to show."] = "血条的最大显示数量。"
L["Mine Only"] = "仅自身"
L["Mine only"] = "仅自身"
L["NPC"] = "NPC"
L["NPC combat only"] = "仅用于PVE战斗"
L["Neutral"] = "中立"
L["Never"] = "从不"
L["None"] = "无"
L["Number of icons to display per bar."] = "每个血条显示的图标数量。"
L["Only show spells above nameplates that are in combat."] = "仅在战斗中显示姓名板上的法术。"
L["Other"] = "其他"
L["Plate Anchor Point"] = "姓名板锚点定位"
L["Player combat only"] = "仅用于PVP战斗"
L["Players"] = "玩家"
L[ [=[Point of the buff frame that gets anchored to the nameplate.
default = Bottom]=] ] = [=[Buff框架的锚点位置，用于定位到姓名板。
默认为底部]=]
L[ [=[Point of the nameplate our buff frame gets anchored to.
default = Top]=] ] = [=[姓名板的锚点位置，用于Buff框架定位。
默认为顶部]=]
L["Profiles"] = "配置文件"
L["Reaction"] = "反应类型"
L[ [=[Remember player GUID's so target/mouseover isn't needed every time nameplate appears.
Keep this enabled]=] ] = "记住玩家GUID，这样就无需在每次姓名板出现时都要选为目标/鼠标指向。/n保持启用"
L["Remove Spell"] = "移除法术"
L["Remove spell from list"] = "从列表中移除法术"
L["Right"] = "右"
L["Row Anchor Point"] = "行锚点位点"
L["Row Growth"] = "行增长方向"
L["Row X Offset"] = "行X轴偏移"
L["Row Y Offset"] = "行Y轴偏移"
L["Rows"] = "行" -- Needs review
L["Save player GUID"] = "保存玩家GUID"
L["Show"] = "显示"
L["Show Aura"] = "显示光环"
L["Show Buffs"] = "显示Buff"
L["Show Debuffs"] = "显示Debuff"
L["Show Totems"] = "显示图腾"
L["Show a clock overlay over spell textures showing the time remaining."] = "在法术材质上使用顺时针冷却螺旋显示剩余时间。" -- Needs review
L["Show auras above nameplate. This sometimes causes duplicate buffs."] = "在姓名板上方显示光环。有时会出现重复Buff。"
L["Show bar background"] = "显示血条背景"
L["Show buffs above nameplate."] = "在姓名板上方显示Buff。"
L["Show by default"] = "按默认显示"
L["Show cooldown"] = "显示冷却"
L["Show cooldown overlay"] = "显示冷却覆盖层" -- Needs review
L["Show cooldown text under the spell icon."] = "在法术图标下显示冷却文字"
L["Show debuffs above nameplate."] = "在姓名板上方显示Deuff。"
L["Show spell icons on totems"] = "在图腾上显示法术图标"
L["Show the area where spell icons will be. This is to help you configure the bars."] = "显示法术图标的位置区域。这将帮助你配置血条。"
L["Shrink Bar"] = "收缩血条"
L["Shrink the bar horizontally when spells frames are hidden."] = "当法术框架隐藏时水平收缩血条。"
L["Size of the icons."] = "图标的大小。"
L["Specific"] = "特定"
L["Specific Spells"] = "特定法术"
L["Spell name"] = "法术名称"
L["Spells"] = "法术"
L["Spells not in the Specific Spells list will use these options."] = "不在特定法术列表中的法术将使用这些选项。"
L["Stack Size"] = "层数大小"
L["Stack Text Size"] = "层数文字大小"
L["Test Mode"] = "测试模式"
L["Text size"] = "文字大小"
L["This overlay tends to disappear when the frame's moving."] = "框架移动时，覆盖层会趋于消失状态。" -- Needs review
L["Top"] = "顶部"
L["Top Left"] = "顶部左边"
L["Top Right"] = "顶部右边"
L["Type"] = "类型"
L["Unknown spell info"] = "未知法术信息"
L["Up"] = "向上"
L["Up to down offset."] = "从上到下偏移。"
L["Watch Combatlog"] = "关注战斗记录"
L[ [=[Watch combatlog for people gaining/losing spells.
Disable this if you're having performance issues.]=] ] = [=[关注战斗记录中获得或失去法术的人。
如果遇到性能问题请禁用。]=]
L["Which way do the bars grow, up or down."] = "血条增长的方向，向上或向下。"
L["Who"] = "谁"
L["about"] = "关于" -- Needs review
L["author"] = "作者" -- Needs review
L["clickCopy"] = "点击并按下Ctrl+C复制" -- Needs review
L["donate"] = "捐赠" -- Needs review
L["email"] = "Email" -- Needs review
L["enableDesc"] = "启用/禁用这个插件。" -- Needs review
L["license"] = "许可" -- Needs review
L["notes"] = "注释" -- Needs review
L["openOptionsFrameDesc"] = "点击打开选项框。" -- Needs review
L["openOptionsFrameName"] = "打开选项框" -- Needs review
L["sizes: 9, 10, 12, 13, 14, 16, 20"] = "大小：9、10、12、13、14、16、20"
L["spells to show by default"] = "法术按默认显示"
L["title"] = "标题" -- Needs review
L["version"] = "版本" -- Needs review
L["website"] = "网站" -- Needs review
