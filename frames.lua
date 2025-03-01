local folder, core = ...

if not core.LibNameplate then
    print("Nameplate Lib not found")
    return
end

local LBF = LibStub("LibButtonFacade", true)

Testreversepos = false

local L = core.L or LibStub("AceLocale-3.0"):GetLocale(folder, true)
local _G = _G
local pairs = pairs
local GetTime = GetTime
local CreateFrame = CreateFrame
local table_remove = table.remove
local table_sort = table.sort
local type = type
local table_getn = table.getn
local Debug = core.Debug
local table_getn = table.getn
local DebuffTypeColor = DebuffTypeColor
local select = select
local string_gsub = string.gsub

local P = {}
local LibNameplate = core.LibNameplate
local nametoGUIDs = core.nametoGUIDs
local buffBars = core.buffBars
local buffFrames = core.buffFrames
local guidBuffs = core.guidBuffs

core.unknownIcon = "Inv_misc_questionmark"

local defaultSettings = core.defaultSettings
defaultSettings.profile.skin_SkinID = "Blizzard"
defaultSettings.profile.skin_Gloss = false
defaultSettings.profile.skin_Backdrop = false
defaultSettings.profile.skin_Colors = {}

-- NEW API ---------

local GetPlateName = core.GetPlateName
local GetPlateType = core.GetPlateType
local IsPlateInCombat = core.IsPlateInCombat
local GetPlateThreat = core.GetPlateThreat
local GetPlateReaction = core.GetPlateReaction
local GetPlateGUID = core.GetPlateGUID
local PlateIsBoss = core.PlateIsBoss
local PlateIsElite = core.PlateIsElite
local GetPlateByGUID = core.GetPlateByGUID
local GetPlateByName = core.GetPlateByName

-------------------

do
    local OnEnable = core.OnEnable
    function core:OnEnable()
        if OnEnable then
            OnEnable(self)
        end

        --~ 	Debug("OnEnable", "frames", self.db.profile)
        P = self.db.profile --this can change on profile change.

        if LBF then
            LBF:RegisterSkinCallback(folder, self.SkinCallback, self)

            LBF:Group(self.name):Skin(
                self.db.profile.skin_SkinID,
                self.db.profile.skin_Gloss,
                self.db.profile.skin_Backdrop,
                self.db.profile.skin_Colors
            )
        end
    end
end

--[[MyIcon = CreateFrame("Button", "MyButton", UIParent)
MyIcon:SetSize(60, 60)
MyIcon:SetPoint("CENTER")
MyIcon.Texture = MyIcon:CreateTexture()
MyIcon.Texture:SetAllPoints(MyIcon)
MyIcon.Texture:SetTexture("Interface\\Icons\\Ability_Druid_TreeofLife")
MyIcon.Cooldown = CreateFrame("Cooldown", "myCooldown", MyIcon)
MyIcon.Cooldown:SetAllPoints(MyIcon)
MyIcon.Border = MyIcon:CreateTexture(nil,"BORDER")
MyIcon.Border:SetSize(80, 80)
MyIcon.Border:SetAllPoints(MyIcon)
MyIcon.Border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays") --Interface\\Buttons\\UI-Debuff-Overlays
MyIcon.Border:SetTexCoord(0.296875,0.5703125,0,0.515625)


local LMB = LibStub("Masque", true) or (LibMasque and LibMasque("Button"))
if LMB then

local function OnEvent(self, event, addon)
	print("RUN MASQUE")
	LMB:Group('PlateBuff', 'Icons')
	LMB:Group("PlateBuff", "Buffs"):AddButton(_G["MyButton"])
	self:SetScript("OnEvent", nil)
end

local testf = CreateFrame("Frame")
testf:SetScript("OnEvent", OnEvent)
testf:RegisterEvent("PLAYER_ENTERING_WORLD")

end]]
--[[function core:UpdateTexterSkins()
 	local Group = LBF:Group(folder, "Buffs")
 	Group:Skin(P.skin_SkinID, P.skin_Gloss, P.skin_Backdrop, P.skin_Colors)

		for i=1, NUM_ACTIONBAR_BUTTONS do
			local button = format("ActionButton%d", i)
			if _G[button] then
 				Group:AddButton(_G[button])
				_G[button]:SetFrameStrata("HIGH")
			end
 		end

end]]
local function GetTexCoordFromSize(frame, size, size2)
    local gap = P.textureSize
    --	frame:SetTexCoord(0,1,0,1)

    local arg = size / size2
    local abj
    if arg > 1 then
        abj = 1 / size * ((size - size2) / 2)

        frame:SetTexCoord(0 + gap, 1 - gap, (0 + abj + gap), (1 - abj - gap))
    elseif arg < 1 then
        abj = 1 / size2 * ((size2 - size) / 2)

        frame:SetTexCoord((0 + abj + gap), (1 - abj - gap), 0 + gap, 1 - gap)
    else
        frame:SetTexCoord(0 + gap, 1 - gap, 0 + gap, 1 - gap)
    end
    return false
end
----------------------------------------------------------
local function UpdateBuffSize(frame, size, size2) --
    -- Update a spell frame's texture size. 				--
    ----------------------------------------------------------
    local k
    local d, d2
    local ic
    local msqbs = frame.msqborder.bordersize or size
    local msqns = frame.msqborder.normalsize or size
    --[[if customSize then
		size = customSize
		size2 = (customSize*size2)/size
	end]]
    --	if LBF and not LBF:Group(folder).db.Disabled then

    --	print(frame.msqborder.normalsize, size, size2)

    k = frame.msqborder.bordersize / frame.msqborder.normalsize
    d = (size * frame.msqborder.bordersize) / frame.msqborder.normalsize
    d2 = (size2 * frame.msqborder.bordersize) / frame.msqborder.normalsize
    --	ic = abs(d-frame.msqborder.normalsize)/2

    if frame.msqborder.bgtexture then
        frame.msqborder:SetWidth(d)
        frame.msqborder:SetHeight(d2)
        frame.cd:SetPoint("TOP", frame.icon, "BOTTOM", 0, -5)
    else
        frame.msqborder:SetWidth(d)
        frame.msqborder:SetHeight(d2)
        frame.cd:SetPoint("TOP", frame.icon, "BOTTOM", 0, 0)
    end

    frame.icon:SetWidth(size)
    frame.icon:SetHeight(size2)
    GetTexCoordFromSize(frame.texture, size, size2)
    frame:SetWidth(size + P.intervalX) --ic+2
    --	self.msqborder.bordersize
    --	self.msqborder.normalsize

    --	self.msqborder.borderoffsetx
    --	self.msqborder.borderoffsety

    --	self.msqborder.normaloffsetx
    --	self.msqborder.normaloffsety

    --	print("size:",size,":bordersize:",frame.msqborder.bordersize,":iconz:",frame.msqborder.normalsize,":k:",k,":d:",d,":size-d",(size-d))
    --print("bofX:", frame.msqborder.borderoffsetx, ":bofY:", frame.msqborder.borderoffsety,":nofX:",frame.msqborder.normaloffsetx,":nofY:",frame.msqborder.normaloffsety)
    --	frame:SetWidth(frame.msqborder.bordz)

    --	else

    --	frame.icon:SetWidth(size)
    --	frame.icon:SetHeight(size2)

    --	frame:SetWidth(size+P.intervalX)
    --	end

    if P.showCooldown == true then
        --	end
        --	if LBF and not LBF:Group(folder).db.Disabled then
        --		frame:SetHeight((size) + frame.cd:GetStringHeight())
        --	else
        frame:SetHeight(size2 + P.cooldownSize + P.intervalY) --frame.cd:GetStringHeight())
    else
        frame:SetHeight(size2 + P.intervalY)
    end
    --	print(P.showCooldown)
end

------------------------------------------------------
local function UpdateBuffCDSize(buffFrame, size) --
    -- Set cooldown text size.							--
    ------------------------------------------------------
    buffFrame.cd:SetFont("Fonts\\FRIZQT__.TTF", size, "NORMAL")
    buffFrame.cdbg:SetHeight(buffFrame.cd:GetStringHeight())
    --~ 	iconOnShow(buffFrame) --lazy way to hide/show cooldown.
end

--------------------------------------------------
local function SetStackSize(buffFrame, size) --
    -- Set the stack text size.						--
    --------------------------------------------------
    buffFrame.stack:SetFont("Fonts\\FRIZQT__.TTF", size, "OUTLINE")
end

------------------------------------------
local function iconOnShow(self) --
    -- Called when spell frames are shown.	--
    ------------------------------------------
    self:SetAlpha(1)

    self.cdbg:Hide()
    self.cd:Hide()
    self.cdtexture:Hide()
    self.stack:Hide()
    self.border:Hide()

    --	if LBF then
    self.skin:Hide()
    self.msqborder:Hide()
    --	end

    if P.borderTexture == "Masque" and LBF and LBF:Group(folder).db and not LBF:Group(folder).db.Disabled then
        --		self.skin:SetBlendMode(blendmode)
        local Group = LBF:Group(folder).db
        local skinID = Group.SkinID
        local ntexture, bordersize, normalsize, borderoffsetX, borderoffsetY
        local btcoord, itcoord = nil, nil
        local SkinData = LBF:GetSkin(skinID)
        if SkinData.Template then
            bordersize = LBF:GetSkin(SkinData.Template).Border.Height
            normalsize = LBF:GetSkin(SkinData.Template).Icon.Height
            texturecoord = LBF:GetSkin(SkinData.Template).Icon.TexCoords
        else
            bordersize = SkinData.Border.Height
            normalsize = SkinData.Icon.Height
            texturecoord = SkinData.Icon.TexCoords
        end

        --	if btcoord then
        --	self.texture:SetTexCoord(unpack(btcoord))
        --	else
        --		self.texture:SetTexCoord(0,1,0,1)
        --	end

        --[[	if texturecoord then
			self.texture:SetTexCoord(unpack(texturecoord))
		else
			self.texture:SetTexCoord(0,1,0,1)
		end]]
        ntexture = SkinData.Normal.Texture

        self.msqborder.bgtexture = ntexture
        self.msqborder.bordersize = bordersize
        self.msqborder.normalsize = normalsize

        --	self.msqborder.borderoffsetx = borderoffsetX
        --	self.msqborder.borderoffsety = borderoffsetY

        --	self.msqborder.normaloffsetx = normaloffsetX
        --	self.msqborder.normaloffsety = normaloffsetY

        --	print(csize)
        self.skin:SetTexture(ntexture)
    else
        --	self.border:SetTexture("Interface\\Buttons\\UI-Debuff-Overlays")
        --	self.border:SetTexCoord(0,1,0,1)
        --	self.border:SetTexture("Interface\\Addons\\PlateBuffs\\media\\border.tga")

        --	ntexture = P.borderTexture --"Interface\\Addons\\PlateBuffs\\media\\border.tga"

        self.msqborder.bgtexture = P.borderTexture
        self.msqborder.bordersize = 42
        self.msqborder.normalsize = 36

        self.skin:SetTexture(P.borderTexture)
    end

    if P.showCooldown == true and self.expirationTime > 0 then
        self.cdbg:Show()
        self.cd:Show()
    end
    if P.showCooldownTexture == true then
        self.cdtexture:Show()
        local cdtexturetimer = self.startTime or GetTime()
        self.cdtexture:SetCooldown(cdtexturetimer, self.duration)
    else
        self.cdtexture:Hide()
    end

    local iconSize = P.iconSize
    local iconSize2 = P.iconSize2
    local cooldownSize = P.cooldownSize
    local stackSize = P.stackSize
    local customSize = 1
    --~ 	if not self.spellName then
    --~ 		Debug("iconOnShow", "no spell name?")
    --~ 	end

    local spellName = self.spellName or "X"
    local spellID = self.sID or 0
    local spellOpts = core:HaveSpellOpts(spellName, spellID)

    if spellOpts then
        iconSize = spellOpts.iconSize or iconSize
        iconSize2 = spellOpts.iconSize2 or iconSize2

        customSize = spellOpts.increase or 1

        cooldownSize = spellOpts.cooldownSize or cooldownSize
        stackSize = spellOpts.stackSize or stackSize
    end

    UpdateBuffCDSize(self, cooldownSize)

    if self.stackCount and self.stackCount > 1 then
        self.stack:SetText(self.stackCount)

        self.stack:Show()
        SetStackSize(self, stackSize)
    end

    --[[
		DebuffTypeColor["none"] = { r = 0.80, g = 0, b = 0 };
		DebuffTypeColor["Magic"]    = { r = 0.20, g = 0.60, b = 1.00 };
		DebuffTypeColor["Curse"]    = { r = 0.60, g = 0.00, b = 1.00 };
		DebuffTypeColor["Disease"]  = { r = 0.60, g = 0.40, b = 0 };
		DebuffTypeColor["Poison"]   = { r = 0.00, g = 0.60, b = 0 };

	]]
    if self.isDebuff then
        local colour = self.debuffType or ""
        if colour then
            if P.colorByType then
                if colour == "Magic" then
                    color = P.color2
                end
                if colour == "Curse" then
                    color = P.color3
                end
                if colour == "Disease" then
                    color = P.color4
                end
                if colour == "Poison" then
                    color = P.color5
                end
                if colour == "none" or colour == "" then
                    color = P.color1
                end

                self.skin:SetVertexColor(color[1], color[2], color[3])
                self.skin:Show()
                self.msqborder:Show()
            else
                self.skin:SetVertexColor(P.color1[1], P.color1[2], P.color1[3])
                self.skin:Show()
                self.msqborder:Show()
            end
        end
    else
        self.skin:SetVertexColor(P.color6[1], P.color6[2], P.color6[3])
        self.skin:Show()
        self.msqborder:Show()
    end

    if self.playerCast and P.biggerSelfSpells == true then
        UpdateBuffSize(self, (iconSize * 1.2 * customSize), (iconSize2 * 1.2 * customSize))
    else
        UpdateBuffSize(self, iconSize * customSize, iconSize2 * customSize)
    end
end

------------------------------------------
local function iconOnHide(self) --
    -- Called when spell frames are shown.	--
    ------------------------------------------
    self.stack:Hide()
    self.cdbg:Hide()
    self.cd:Hide()
    --	self.border:Hide()

    --	if LBF then
    self.msqborder:Hide()
    self.skin:Hide()
    --	end
    self.cdtexture:Hide()
    self:SetAlpha(1)

    UpdateBuffSize(self, P.iconSize, P.iconSize2)
end

----------------------------------------------
local function iconOnUpdate(self, elapsed) --
    -- Fires for spell frames.					--
    ----------------------------------------------
    self.lastUpdate = self.lastUpdate + elapsed
    if self.lastUpdate > 0.1 then --abit fast for cooldown flash.
        self.lastUpdate = 0

        --~ 		if self.stackCount > 0 then
        --~ 			self.stack:SetText(self.stackCount)
        --~ 		end

        if self.expirationTime > 0 then
            local rawTimeLeft = self.expirationTime - GetTime()
            local timeLeft
            if rawTimeLeft < 10 then
                timeLeft = core:Round(rawTimeLeft, P.digitsnumber) --, 1
            else
                timeLeft = core:Round(rawTimeLeft)
            end

            if P.showCooldown == true then
                self.cd:SetText(core:SecondsToString(timeLeft, 1))
                self.cd:SetTextColor(core:RedToGreen(timeLeft, self.duration))
                self.cdbg:SetWidth(self.cd:GetStringWidth())
            end

            if (timeLeft / (self.duration + 0.01)) < P.blinkTimeleft and timeLeft < 60 then --buff only has 20% timeleft and is less then 60 seconds.
                local f = GetTime() % 1
                if f > 0.5 then
                    f = 1 - f
                end

                self:SetAlpha(f * 3)
            end

            if GetTime() > self.expirationTime then
                self:Hide()

                local GUID = GetPlateGUID(self.realPlate)
                if GUID then
                    core:RemoveOldSpells(GUID)
                    core:AddBuffsToPlate(self.realPlate, GUID)
                else
                    local plateName = GetPlateName(self.realPlate)
                    if plateName and nametoGUIDs[plateName] then
                        core:RemoveOldSpells(nametoGUIDs[plateName])
                        core:AddBuffsToPlate(self.realPlate, nametoGUIDs[plateName])
                    end
                end
            end
        end
    end
end

function core:RemoveOldSpells(GUID)
    for i = (P.numBars * P.iconsPerBar), 1, -1 do
        if guidBuffs[GUID] and guidBuffs[GUID][i] then
            if
                guidBuffs[GUID][i].expirationTime and guidBuffs[GUID][i].expirationTime > 0 and
                    GetTime() > guidBuffs[GUID][i].expirationTime
             then
                --~ 				Debug("RemoveOldSpells", GUID, i, guidBuffs[GUID][i].name)
                table_remove(guidBuffs[GUID], i)
            end
        end
    end
end

local function SetBarSize(barFrame, width, height)
    barFrame:SetWidth(width)
    barFrame:SetHeight(height)
end

local function CreateBuffFrame(parentFrame, realPlate)
    local f = CreateFrame("Frame", "MainFrame", parentFrame) --
    f.realPlate = realPlate
    f:SetFrameStrata("BACKGROUND")

    f.icon = CreateFrame("Frame", "MainFrameIcon", f)
    f.icon:SetPoint("TOP", f)

    --	f.cdtexture = CreateFrame("Cooldown", nil , f.icon)
    --	f.cdtexture:SetAllPoints(f.icon)

    f.texture = f.icon:CreateTexture(nil, "BACKGROUND")
    f.texture:SetAllPoints(f.icon)

    local cd = f:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
    cd:SetText("")
    cd:SetPoint("TOP", f.icon, "BOTTOM")
    f.cd = cd

    --Make the text easier to see.
    f.cdbg = f:CreateTexture(nil, "BACKGROUND")
    f.cdbg:SetTexture(0, 0, 0, .75)
    f.cdbg:SetPoint("CENTER", cd)

    --clock cooldown texture
    --~ 	f.cdtextureP = CreateFrame("Frame", nil, f)
    --~ 	f.cdtextureP:SetPoint("TOP", f)

    f.cdtexture = CreateFrame("Cooldown", "MainFrameTexture", f.icon, "CooldownFrameTemplate")
    f.cdtexture:SetAllPoints(true)
    f.cdtexture:SetReverse(true)

    --	f.cdtexture:SetDrawEdge(true)
    --~ 	f.cdtexture:SetPoint("CENTER", f.icon, 0, -1)
    --	f.cdtexture:SetAllPoints(f.icon)
    --~ 	f.cdtexture:SetFrameLevel(core.db.profile.frameLevel + 1)
    f.border = f.icon:CreateTexture(nil, "BORDER")
    f.border:SetAllPoints(f.icon)

    core:SetFrameLevel(f)

    f.stack = f.icon:CreateFontString(nil, "OVERLAY", "ChatFontNormal")
    f.stack:SetText("")
    f.stack:SetPoint("BOTTOMRIGHT", f.icon, "BOTTOMRIGHT", -1, 3)

    f.lastUpdate = 0
    f.expirationTime = 0
    f:SetScript("OnShow", iconOnShow)
    f:SetScript("OnHide", iconOnHide)

    f:SetScript("OnUpdate", iconOnUpdate)
    f.stackCount = 0

    f.cdbg:Hide()
    f.cd:Hide()
    f.border:Hide()
    f.cdtexture:Hide()
    f.stack:Hide()

    --[===[@debug@
--~ 	f:EnableMouse(true)
--~ 	f:SetScript("OnEnter", function(frame)
--~ 		Debug("OnEnter!",
--~ 			frame.spellName,
--~ 			frame.expirationTime,
--~ 			(frame.expirationTime or 0) - GetTime(),
--~ 			frame.cd:IsShown()
--~ 		)
--~ 	end)
	--@end-debug@]===]

    --	if LBF then

    f.msqborder = CreateFrame("Frame", "MainFrameMSQBorders", f.icon)
    f.msqborder:SetPoint("CENTER", f.icon, "CENTER")
    f.msqborder:SetFrameLevel(f.icon:GetFrameLevel())
    f.skin = f.msqborder:CreateTexture(nil, "BORDER")
    f.skin:SetAllPoints(f.msqborder)
    --	f.skin:SetBlendMode("ADD")
    f.skin:Hide()

    f.msqborder.bordersize = 1
    f.msqborder.normalsize = 1

    --	f.msqborder.borderoffsetx = 0
    --	f.msqborder.borderoffsety = 0

    --	f.msqborder.normaloffsetx = 0
    --	f.msqborder.normaloffsety = 0

    f.msqborder.bgtexture = nil
    f.msqborder:Hide()
    --	els

    --	end

    return f
end

--[[	local Group = LBF:Group(folder)
	local skinID = Group.SkinID

	local SkinData = LBF:GetSkins()
	Debug("test", SkinData[skinID].Border.Texture)

	for skinID, skinData in pairs(SkinData) do


		for a, b in pairs(skinData.Border) do
			Debug("skinTest 1", skinID, skinData, a, b)
		end

	end

end]]
------------------------------------------
function core:UpdateBarsBackground() --
    -- Show/Hide bar background texture.	--
    ------------------------------------------
    for plate in pairs(buffBars) do
        for b in pairs(buffBars[plate]) do
            if P.showBarBackground == true then
                buffBars[plate][b].barBG:Show()
            else
                buffBars[plate][b].barBG:Hide()
            end
        end
    end
end
--~ local barSizes = {}

----------------------------------------------------------
local function CreateBarFrame(parentFrame, realPlate) --
    -- Create and return a bar frame.						--
    ----------------------------------------------------------
    local f = CreateFrame("frame", nil, parentFrame)
    f.realPlate = realPlate

    f:SetFrameStrata("BACKGROUND")
    --~ 	f:SetFrameLevel(parentFrame:GetFrameLevel())

    f:SetWidth(1)
    f:SetHeight(1)

    --Make the text easier to see.
    f.barBG = f:CreateTexture(nil, "BACKGROUND")
    f.barBG:SetAllPoints(true)

    f.barBG:SetTexture(1, 1, 1, 0.3) --uses for testing
    if P.showBarBackground == true then
        f.barBG:Show()
    else
        f.barBG:Hide()
    end

    f:Show()
    return f
end

----------------------------------------------------------------------
local function BuildPlateBars(plate, visibleFrame) --
    -- Build all our bar frames for a plate. 							--
    -- We anchor these to the plate and our spell frames to the bar.	--
    ----------------------------------------------------------------------
    buffBars[plate] = buffBars[plate] or {}

    if not buffBars[plate][1] then
        buffBars[plate][1] = CreateBarFrame(visibleFrame, plate)
    end
    buffBars[plate][1]:ClearAllPoints()
    buffBars[plate][1]:SetPoint(P.barAnchorPoint, visibleFrame, P.plateAnchorPoint, P.barOffsetX, P.barOffsetY) -- + GetCooldownHeight(buffFrames[plate][1])
    buffBars[plate][1]:SetParent(visibleFrame) --uhuh

    local barPoint = P.barAnchorPoint
    local parentPoint = P.plateAnchorPoint
    if P.barGrowth == 1 then --up
        barPoint = string_gsub(barPoint, "TOP", "BOTTOM")
        parentPoint = string_gsub(parentPoint, "BOTTOM", "TOP")
    else
        barPoint = string_gsub(barPoint, "BOTTOM,", "TOP")
        parentPoint = string_gsub(parentPoint, "TOP", "BOTTOM")
    end

    if P.numBars > 1 then
        for r = 2, P.numBars do
            if not buffBars[plate][r] then
                buffBars[plate][r] = CreateBarFrame(visibleFrame, plate)
            end
            buffBars[plate][r]:ClearAllPoints()

            buffBars[plate][r]:SetPoint(barPoint, buffBars[plate][r - 1], parentPoint, 0, 0)
            buffBars[plate][r]:SetParent(visibleFrame) --uhuh
        end
    end
end

local function GetBarChildrenSize(n, ...)
    local frame
    local totalWidth = 1
    local totalHeight = 1
    if n > P.iconsPerBar then
        n = P.iconsPerBar
    end
    for i = 1, n do
        frame = select(i, ...)
        if P.shrinkBar == true then
            if frame:IsShown() then
                totalWidth = totalWidth + frame:GetWidth()

                if frame:GetHeight() > totalHeight then
                    totalHeight = frame:GetHeight()
                end
            end
        else
            totalWidth = totalWidth + frame:GetWidth()

            if frame:GetHeight() > totalHeight then
                totalHeight = frame:GetHeight()
            end
        end
    end
    return totalWidth, totalHeight
end

--------------------------------------------------------------------------------------
local function UpdateBarSize(barFrame) --
    -- Update a bar's size taking into account all the spell frame's height and width.	--
    --------------------------------------------------------------------------------------
    if barFrame:GetNumChildren() == 0 then
        --~ 		Debug("Our buff bar lost it's children?")
        return
    end

    local totalWidth, totalHeight = GetBarChildrenSize(barFrame:GetNumChildren(), barFrame:GetChildren())

    barFrame:SetWidth(totalWidth)
    barFrame:SetHeight(totalHeight)
end

local function UpdateAllBarSizes(plate)
    --~ 	for r=P.numBars, 1, -1  do
    for r = 1, P.numBars do
        UpdateBarSize(buffBars[plate][r])
    end
end

function core:UpdateAllPlateBarSizes()
    for plate in pairs(buffBars) do
        UpdateAllBarSizes(plate)
    end
end

----------------------------------------------
function core:AddBuffsToPlate(plate, GUID) --
    -- Show spells on a plate linked to a GUID.	--
    ----------------------------------------------

    --~ 	if true then
    --~ 		return
    --~ 	end
    --print("core:AddBuffsToPlate(plate, GUID)")
    if not buffFrames[plate] or not buffFrames[plate][P.iconsPerBar] then
        self:BuildBuffFrame(plate)
    end

    local t, f
    --~ 	Debug("AddBuffsToPlate 0", GUID)
    if guidBuffs[GUID] then
        table_sort(
            guidBuffs[GUID],
            function(a, b)
                if (a and b) then
                    if a.playerCast ~= b.playerCast then
                        return (a.playerCast or 0) > (b.playerCast or 0)
                    elseif a.expirationTime == b.expirationTime then
                        return a.name < b.name
                    else
                        return (a.expirationTime or 0) < (b.expirationTime or 0)
                    end
                end
            end
        )

        for i = 1, P.numBars * P.iconsPerBar do
            if buffFrames[plate][i] then
                if guidBuffs[GUID][i] then --and (not guidBuffs[GUID][i].expirationTime or guidBuffs[GUID][i].expirationTime == 0 or guidBuffs[GUID][i].expirationTime > GetTime()) then
                    buffFrames[plate][i].spellName = guidBuffs[GUID][i].name or ""
                    buffFrames[plate][i].sID = guidBuffs[GUID][i].sID or ""
                    buffFrames[plate][i].expirationTime = guidBuffs[GUID][i].expirationTime or 0
                    buffFrames[plate][i].duration = guidBuffs[GUID][i].duration or 1
                    buffFrames[plate][i].startTime = guidBuffs[GUID][i].startTime or GetTime()
                    buffFrames[plate][i].stackCount = guidBuffs[GUID][i].stackCount or 0
                    buffFrames[plate][i].isDebuff = guidBuffs[GUID][i].isDebuff
                    buffFrames[plate][i].debuffType = guidBuffs[GUID][i].debuffType
                    buffFrames[plate][i].playerCast = guidBuffs[GUID][i].playerCast

                    buffFrames[plate][i].texture:SetTexture("Interface\\Icons\\" .. guidBuffs[GUID][i].icon)
                    buffFrames[plate][i]:Show()
                     --make sure OnShow fires.
                    iconOnShow(buffFrames[plate][i])

                    iconOnUpdate(buffFrames[plate][i], 1) --do a onupdate.
                else
                    buffFrames[plate][i]:Hide()
                end
            end
        end

        UpdateAllBarSizes(plate)
    end
end

----------------------------------------------------------------------------------
function core:AddUnknownIcon(plate) --
    -- Display a question mark icon since we don't know the GUID of the plate/mob.	--
    ----------------------------------------------------------------------------------
    if not buffFrames[plate] then
        self:BuildBuffFrame(plate, nil, true)
    end

    local i = 1 --eaiser for me to copy/paste code elsewhere.
    buffFrames[plate][i].spellName = false
    buffFrames[plate][i].expirationTime = 0
    buffFrames[plate][i].duration = 1
    buffFrames[plate][i].stackCount = 0
    buffFrames[plate][i].isDebuff = false
    buffFrames[plate][i].debuffType = false
    buffFrames[plate][i].playerCast = false

    buffFrames[plate][i].texture:SetTexture("Interface\\Icons\\" .. core.unknownIcon)

    if buffFrames[plate][i]:IsShown() then
        buffFrames[plate][i]:Hide()
    end
    buffFrames[plate][i]:Show()

    UpdateAllBarSizes(plate)
end

function core:UpdateAllFrameLevel()
    for plate in pairs(self.buffFrames) do
        for i = 1, table_getn(self.buffFrames[plate]) do
            self:SetFrameLevel(self.buffFrames[plate][i])
        end
    end
end

function core:SetFrameLevel(frame)
    Debug("SetFrameLevel", frame, self.db.profile.frameLevel)
    frame:SetFrameLevel(self.db.profile.frameLevel)
    frame.cdtexture:SetFrameLevel(self.db.profile.frameLevel + 1)
end

----------------------------------------------------------
function core:ResetAllPlateIcons() --
    -- This will reset all the anchors on the spell frames.	--
    ----------------------------------------------------------
    for plate in pairs(buffFrames) do
        core:BuildBuffFrame(plate, true)
    end
end

------------------------------------------------------
function core:BuildBuffFrame(plate, reset, onlyOne) --
    -- Create our buff frames on a plate.				--
    ------------------------------------------------------

    --~ 	local visibleFrame = LibNameplate:GetVisibleFrame(plate)
    local visibleFrame = plate
    if not buffBars[plate] then
        BuildPlateBars(plate, visibleFrame)
    end

    if not buffBars[plate][P.numBars] then --user increased the size.
        BuildPlateBars(plate, visibleFrame)
    end

    buffFrames[plate] = buffFrames[plate] or {}

    if reset then
        for i = 1, table_getn(buffFrames[plate]) do
            buffFrames[plate][i]:Hide() --makesure all frames stop OnUpdating.
        end

    --~ 		for b in pairs(buffBars[plate]) do
    --~ 			buffBars[plate][b]:Hide()
    --~ 		end
    end

    local total = 1 --total number of spell frames
    if not buffFrames[plate][total] then
        buffFrames[plate][total] = CreateBuffFrame(buffBars[plate][1], plate)
    end
    buffFrames[plate][total]:SetParent(buffBars[plate][1])
     --Doing this seems to make UpdateBarSize() function properly. =/

    buffFrames[plate][total]:ClearAllPoints()

    if Testreversepos then
        buffFrames[plate][total]:SetPoint("TOP", buffBars[plate][1])
    else
        --size2+P.cooldownSize+P.intervalY
        buffFrames[plate][total]:SetPoint("BOTTOMLEFT", buffBars[plate][1]) -- + GetCooldownHeight(buffFrames[plate][1])
    end

    if onlyOne then
        --[===[@debug@
		-- Used to see why my frames were doubling up. think I fixed this in LibNameplate r56
		buffFrames[plate][total]:SetScript("OnShow", function(self)

			if self.realPlate.extended then
				Debug("buffFrames OnShow", "buff frame on show!", self.realPlate.extended)
			end
		end)
		--@end-debug@]===]

        --Save CPU cycles not creating every single frame. Lets wait till they're needed.
        --~ 		UpdateBarSize(buffBars[plate][1])
        return
    end

    local prevFrame = buffFrames[plate][total]
    for i = 2, P.iconsPerBar do
        total = total + 1
        if not buffFrames[plate][total] then
            buffFrames[plate][total] = CreateBuffFrame(buffBars[plate][1], plate)
        end
        buffFrames[plate][total]:SetParent(buffBars[plate][1])

        buffFrames[plate][total]:ClearAllPoints()

        buffFrames[plate][total]:SetPoint("BOTTOMLEFT", prevFrame, "BOTTOMRIGHT", -P.intervalY)

        prevFrame = buffFrames[plate][total]
    end
    --~ 	UpdateBarSize(buffBars[plate][1])

    if P.numBars > 1 then
        for r = 2, P.numBars do
            for i = 1, P.iconsPerBar do
                total = total + 1

                if not buffFrames[plate][total] then
                    buffFrames[plate][total] = CreateBuffFrame(buffBars[plate][r], plate)
                end
                buffFrames[plate][total]:SetParent(buffBars[plate][r])

                buffFrames[plate][total]:ClearAllPoints()
                if i == 1 then
                    buffFrames[plate][total]:SetPoint("BOTTOMLEFT", buffBars[plate][r])
                else
                    buffFrames[plate][total]:SetPoint("BOTTOMLEFT", prevFrame, "BOTTOMRIGHT", -P.intervalY)
                end

                prevFrame = buffFrames[plate][total]
            end

            --~ 			UpdateBarSize(buffBars[plate][r])
            --~ 			buffBars[plate][r]:Show() --***
        end
    end

    if not plate.PlateBuffsIsHooked then
        -- ChatFrame7:AddMessage("PlateBuffs.BuildBuffFrame(): hooking")
        plate.PlateBuffsIsHooked = true
        plate:HookScript(
            "OnSizeChanged",
            function(self, w, h)
                -- ChatFrame7:AddMessage("PlateBuffs.BuildBuffFrame(): " .. tostring(self))
                core:ResetPlateBarPoints(self)
            end
        )
    end
end

--------------------------------------------------------------
function core:ResetBarPoint(barFrame, plate, visibleFrame) --
    -- Reset a bar's anchor point.								--
    --------------------------------------------------------------

    barFrame:ClearAllPoints()

    --~ 			buffFrames[plate][i]:SetPoint(P.barAnchorPoint, plate, P.plateAnchorPoint, P.barOffsetX, P.barOffsetY)
    --~ 	local visibleFrame = visibleFrame or LibNameplate:GetVisibleFrame(plate)
    local visibleFrame = plate
    barFrame:SetParent(visibleFrame)
    --	barFrame:SetPoint(P.barAnchorPoint, visibleFrame, P.plateAnchorPoint, P.barOffsetX, P.barOffsetY+P.cooldownSize) -- + GetCooldownHeight(barFrame)

    barFrame:SetPoint(P.barAnchorPoint, visibleFrame, P.plateAnchorPoint, P.barOffsetX, P.barOffsetY)
end

--------------------------------------------------------------
function core:ResetIconSizes() --
    -- Reset all icon sizes. Called when user changes settings.	--
    --------------------------------------------------------------

    local iconSize
    local iconSize2
    local customincreaze = 1

    local frame
    for plate in pairs(self.buffFrames) do
        for i = 1, table_getn(self.buffFrames[plate]) do
            frame = self.buffFrames[plate][i]

            local spellOpts = self:HaveSpellOpts(frame.name, frame.sID)
            if frame:IsShown() and spellOpts then
                iconSize = spellOpts.iconSize
                iconSize2 = spellOpts.iconSize2
                customincreaze = spellOpts.customincreaze or 1
            else
                iconSize = P.iconSize
                iconSize2 = P.iconSize2
            end

            --~ 			if frame:IsShown() and P.spellOpts[frame.name] then
            --~ 				iconSize = P.spellOpts[frame.name].iconSize
            --~ 			else
            --~ 				iconSize = P.iconSize
            --~ 			end

            --Update the spell texture size.
            --~ 			frame.texture:SetWidth(iconSize)
            --~ 			frame.texture:SetHeight(iconSize)

            frame.icon:SetWidth(iconSize * customincreaze)
            frame.icon:SetHeight(iconSize2 * customincreaze)

            GetTexCoordFromSize(frame.texture, iconSize * customincreaze, iconSize2 * customincreaze)
            --~ 			frame.cdtextureP:SetWidth(iconSize)
            --~ 			frame.cdtextureP:SetHeight(iconSize)

            --~ 			frame.cdtexture:SetPoint("CENTER", frame.texture, 0, -1)

            --Update the frame as a whole, this takes into account the size of the cooldown size.
            frame:SetWidth((iconSize * customincreaze) + P.intervalX)

            if P.showCooldown == true then
                frame:SetHeight((iconSize2 * customincreaze) + P.cooldownSize + P.intervalY)
            else
                frame:SetHeight((iconSize2 * customincreaze) + P.intervalY)
            end
            --~ 			frame:SetScale(1)
        end
    end
end

----------------------------------------------------------------------
function core:ResetCooldownSize() --
    -- Reset cooldown text sizes. Called when user changes settings.	--
    ----------------------------------------------------------------------
    for plate in pairs(buffFrames) do
        for i = 1, table_getn(buffFrames[plate]) do
            --~ 			buffFrames[plate][i].cd:SetFontObject(core:GetCooldownFont())
            local spellOpts = self:HaveSpellOpts(buffFrames[plate][i].spellName)

            --~ 			UpdateBuffCDSize(buffFrames[plate][i], buffFrames[plate][i].spellName and P.spellOpts[buffFrames[plate][i].spellName] and P.spellOpts[buffFrames[plate][i].spellName].cooldownSize or P.cooldownSize)
            UpdateBuffCDSize(
                buffFrames[plate][i],
                buffFrames[plate][i].spellName and spellOpts and spellOpts.cooldownSize or P.cooldownSize
            )
        end
    end
end

----------------------------------
function core:ResetStackSizes() --
    -- Update stack text size.		--
    ----------------------------------
    for plate in pairs(buffFrames) do
        for i = 1, table_getn(buffFrames[plate]) do
            local spellOpts = self:HaveSpellOpts(buffFrames[plate][i].spellName)
            --~ 			SetStackSize(buffFrames[plate][i], buffFrames[plate][i].spellName and P.spellOpts[buffFrames[plate][i].spellName] and P.spellOpts[buffFrames[plate][i].spellName].stackSize or P.stackSize)
            SetStackSize(
                buffFrames[plate][i],
                buffFrames[plate][i].spellName and spellOpts and spellOpts.stackSize or P.stackSize
            )

            --~ 			buffFrames[plate][i].stack:SetFont("Fonts\\FRIZQT__.TTF", P.stackSize, "OUTLINE")
        end
    end
end

--------------------------------------
function core:ResetAllBarPoints() --
    -- Reset all bar anchors.			--
    --------------------------------------
    local barPoint = P.barAnchorPoint
    local parentPoint = P.plateAnchorPoint

    if P.barGrowth == 1 then --up
        barPoint = string_gsub(barPoint, "TOP", "BOTTOM")
        parentPoint = string_gsub(parentPoint, "BOTTOM", "TOP")
    else
        barPoint = string_gsub(barPoint, "BOTTOM,", "TOP")
        parentPoint = string_gsub(parentPoint, "TOP", "BOTTOM")
    end

    for plate in pairs(buffBars) do
        self:ResetPlateBarPoints(plate)
    end
end

--------------------------------------
function core:ResetPlateBarPoints(plate) --
    -- Reset bar anchors for a particular plate.	--
    --------------------------------------
    if buffBars[plate][1] then
        self:ResetBarPoint(buffBars[plate][1], plate)
    end

    for r = 2, table_getn(buffBars[plate]) do
        buffBars[plate][r]:ClearAllPoints()
        buffBars[plate][r]:SetPoint(P.barAnchorPoint, buffBars[plate][r - 1], P.plateAnchorPoint, 0, 0)
    end
end

------------------------------------------------------------------
function core:ShowAllKnownSpells() --
    -- When we change number of icons to show we hide all icons.	--
    -- This will reshow the buffs again in their new locations.		--
    ------------------------------------------------------------------
    local GUID
    for plate in pairs(buffFrames) do
        local GUID = GetPlateGUID(plate)
        if GUID then
            self:AddBuffsToPlate(plate, GUID)
        else
            local plateName = GetPlateName(plate)
            if plateName and nametoGUIDs[plateName] then
                self:AddBuffsToPlate(plate, nametoGUIDs[plateName])
            end
        end
    end
end

--[===[@debug@
function PB_TestSizes()--	/run PB_TestSizes()
	local plate = LibNameplate:GetTargetNameplate()
	local frame
	Debug("TestSizes", "----")
	if plate and buffBars[plate] then
		for i=1, table_getn(buffBars[plate]) do
			frame = buffBars[plate][i]
			Debug("TestSizes", i, frame:GetScale(), frame:GetWidth(), frame:GetHeight())
		end
--~
	end
end

--@end-debug@]===]