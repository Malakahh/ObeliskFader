local _, ns = ...
local S = ns.Settings

local handler = CreateFrame("Frame")
handler:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
handler:RegisterEvent("PLAYER_ENTERING_WORLD")
handler:RegisterEvent("PLAYER_REGEN_ENABLED")
handler:RegisterEvent("PLAYER_REGEN_DISABLED")
handler:RegisterEvent("UNIT_HEALTH")
handler:RegisterEvent("GROUP_ROSTER_UPDATE")
handler:RegisterEvent("UNIT_CONNECTION")

local function SecureFade(frame, fadeInfo)
	if fadeInfo.endAlpha == frame:GetAlpha() then
		return
	end

	frame:SetAlpha(fadeInfo.startAlpha);
	frame.fadeInfo = fadeInfo;

	local index = 1;
	while FADEFRAMES[index] do
		-- If frame is already set to fade then return
		if ( FADEFRAMES[index] == frame ) then
			return;
		end
		index = index + 1;
	end
	tinsert(FADEFRAMES, frame);
	handler:SetScript("OnUpdate", UIFrameFade_OnUpdate);
end

local function FadeOut(frame, newTime)
	if frame.inCombatLock then
		return
	end

	local fadeInfo = {
		mode = "OUT",
		timeToFade = newTime or S.FadeOutTime,
		startAlpha = frame:GetAlpha(),
		endAlpha = S.MinAlpha
	}
	SecureFade(frame, fadeInfo)
end

local function FadeIn(frame, newTime)
	if frame.inCombatLock then
		return
	end

	local fadeInfo = {
		mode = "IN",
		timeToFade = newTime or S.FadeInTime,
		startAlpha = frame:GetAlpha(),
		endAlpha = S.MaxAlpha
	}
	SecureFade(frame, fadeInfo)
end

local function SetMouseHover(frame)
	frame.UnitFrameFaderMouseHoverFrame = CreateFrame("Frame", nil, frame)
	frame.UnitFrameFaderMouseHoverFrame:SetFrameStrata(S.FrameStrata)

	for _,v in pairs(S.Frames[frame:GetName()].Boundaries) do
		frame.UnitFrameFaderMouseHoverFrame:SetPoint(v.point, v.x, v.y)
	end

	-- frame.UnitFrameFaderMouseHoverFrame.tex = frame.UnitFrameFaderMouseHoverFrame:CreateTexture(nil, "ARTWORK")
	-- frame.UnitFrameFaderMouseHoverFrame.tex:SetColorTexture(1, 0, 1, 0.5)
	-- frame.UnitFrameFaderMouseHoverFrame.tex:SetAllPoints()

	frame.UnitFrameFaderMouseHoverFrame:SetScript("OnEnter", function(self, ...)
		FadeIn(self:GetParent())
	end)

	frame.UnitFrameFaderMouseHoverFrame:SetScript("OnLeave", function(self, ...)
		FadeOut(self:GetParent())
	end)
end

function handler:Init(frame)
	if frame ~= nil then 
		frame:SetAlpha(0)
		SetMouseHover(frame)
	end
end

function handler:PLAYER_ENTERING_WORLD()
	for f,_ in pairs(S.Frames) do
		local frame = _G[f]

		self:Init(frame)
	end
end

function handler:GROUP_ROSTER_UPDATE()
	for i = 1, 5, 1 do
		self:Init(_G["PartyMemberFrame" .. i])
	end
end

function handler:PLAYER_REGEN_ENABLED()
	if S.Frames.PlayerFrame and UnitHealth("player") == UnitHealthMax("player") then
		PlayerFrame.inCombatLock = false
		FadeOut(PlayerFrame)
	end
end

function handler:PLAYER_REGEN_DISABLED()
	if S.Frames.PlayerFrame then
		FadeIn(PlayerFrame)
		PlayerFrame.inCombatLock = true
	end
end

function handler:UNIT_HEALTH(unit)
	if unit == "player" and S.Frames.PlayerFrame then
		if UnitHealth("player") == UnitHealthMax("player") then
			FadeOut(PlayerFrame)
		else
			FadeIn(PlayerFrame)
		end
	elseif unit == "party1" and S.Frames.PartyMemberFrame1 then
		if UnitHealth("party1") == UnitHealthMax("party1") then
			PartyMemberFrame1.inCombatLock = false
			FadeOut(PartyMemberFrame1)
		else
			FadeIn(PartyMemberFrame1)
			PartyMemberFrame1.inCombatLock = true
		end
	elseif unit == "party2" and S.Frames.PartyMemberFrame2 then
		if UnitHealth("party2") == UnitHealthMax("party2") then
			PartyMemberFrame2.inCombatLock = false
			FadeOut(PartyMemberFrame2)
		else
			FadeIn(PartyMemberFrame2)
			PartyMemberFrame2.inCombatLock = true
		end
	elseif unit == "party3" and S.Frames.PartyMemberFrame3 then
		if UnitHealth("party3") == UnitHealthMax("party3") then
			PartyMemberFrame3.inCombatLock = false
			FadeOut(PartyMemberFrame3)
		else
			FadeIn(PartyMemberFrame3)
			PartyMemberFrame3.inCombatLock = true
		end
	elseif unit == "party4" and S.Frames.PartyMemberFrame4 then
		if UnitHealth("party4") == UnitHealthMax("party4") then
			PartyMemberFrame4.inCombatLock = false
			FadeOut(PartyMemberFrame4)
		else
			FadeIn(PartyMemberFrame4)
			PartyMemberFrame4.inCombatLock = true
		end
	elseif unit == "party5" and S.Frames.PartyMemberFrame5 then
		if UnitHealth("party5") == UnitHealthMax("party5") then
			PartyMemberFrame5.inCombatLock = false
			FadeOut(PartyMemberFrame5)
		else
			FadeIn(PartyMemberFrame5)
			PartyMemberFrame5.inCombatLock = true
		end
	end
end

function handler:UNIT_CONNECTION(id, hasConnected)
	if id == "party1" and S.Frames.PartyMemberFrame1 then
		FadeOut(PartyMemberFrame1, S.FadeOutTimeLong)
	elseif id == "party2" and S.Frames.PartyMemberFrame2 then
		FadeOut(PartyMemberFrame2, S.FadeOutTimeLong)
	elseif id == "party3" and S.Frames.PartyMemberFrame3 then
		FadeOut(PartyMemberFrame3, S.FadeOutTimeLong)
	elseif id == "party4" and S.Frames.PartyMemberFrame4 then
		FadeOut(PartyMemberFrame4, S.FadeOutTimeLong)
	elseif id == "party5" and S.Frames.PartyMemberFrame5 then
		FadeOut(PartyMemberFrame5, S.FadeOutTimeLong)
	end
end

