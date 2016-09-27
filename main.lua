local _, ns = ...
local S = ns.Settings

local handler = CreateFrame("Frame")
handler:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
handler:RegisterEvent("PLAYER_ENTERING_WORLD")
handler:RegisterEvent("PLAYER_REGEN_ENABLED")
handler:RegisterEvent("PLAYER_REGEN_DISABLED")
handler:RegisterEvent("UNIT_HEALTH")

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

local function FadeOut(frame, OnFinish)
	if frame.inCombatLock then
		return
	end

	local fadeInfo = {
		mode = "OUT",
		timeToFade = S.FadeOutTime,
		startAlpha = frame:GetAlpha(),
		endAlpha = S.MinAlpha,
		finishedFunc = OnFinish
	}
	SecureFade(frame, fadeInfo)
end

local function FadeIn(frame, OnFinish)
	if frame.inCombatLock then
		return
	end

	local fadeInfo = {
		mode = "IN",
		timeToFade = S.FadeInTime,
		startAlpha = frame:GetAlpha(),
		endAlpha = S.MaxAlpha,
		finishedFunc = OnFinish
	}
	SecureFade(frame, fadeInfo)
end

local function SetMouseHover(frame)
	frame.UnitFrameFaderMouseHoverFrame = CreateFrame("Frame", nil, frame)
	frame.UnitFrameFaderMouseHoverFrame:SetFrameStrata("TOOLTIP")

	for _,v in pairs(S.Frames[frame:GetName()].Boundaries) do
		frame.UnitFrameFaderMouseHoverFrame:SetPoint(v.point, v.x, v.y)
	end

	frame.UnitFrameFaderMouseHoverFrame.tex = frame.UnitFrameFaderMouseHoverFrame:CreateTexture(nil, "ARTWORK")
	frame.UnitFrameFaderMouseHoverFrame.tex:SetColorTexture(1, 0, 1, 0.5)
	frame.UnitFrameFaderMouseHoverFrame.tex:SetAllPoints()

	frame.UnitFrameFaderMouseHoverFrame:SetScript("OnEnter", function(self, ...)
		FadeIn(self:GetParent())
	end)

	frame.UnitFrameFaderMouseHoverFrame:SetScript("OnLeave", function(self, ...)
		FadeOut(self:GetParent())
	end)
end

function handler:PLAYER_ENTERING_WORLD()
	for f,_ in pairs(S.Frames) do
		local frame = _G[f]

		if frame ~= nil then 
			frame:SetAlpha(0)
			SetMouseHover(frame)
		end
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
	if S.Frames.PlayerFrame then
		if UnitHealth("player") == UnitHealthMax("player") then
			FadeOut(PlayerFrame)
		else
			FadeIn(PlayerFrame)
		end
	end
end