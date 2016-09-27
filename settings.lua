local _, ns = ...
ns.Settings = {}
ns.Settings.HoverFrames = {}

--The minimum alpha reached. Must have a value between 1 and 0. Lower number is more transparent
ns.Settings.MinAlpha = 0

--The maximum alpha reached. Must have a value between 1 and 0. Lower number is more transparent
ns.Settings.MaxAlpha = 1

--Time it takes for a frame to fade in (in seconds, fractions are available)
ns.Settings.FadeInTime = 0.25
ns.Settings.FadeInTimeLong = 0.5

--Time it takes for a frame to fade out (in seconds, fractions are available)
ns.Settings.FadeOutTime = 0.5
ns.Settings.FadeOutTimeLong = 3

--The order of appearence of stacked frames, see http://wow.gamepedia.com/FrameStrata for details
ns.Settings.FrameStrata = "TOOLTIP"

------------
-- Frames --
------------

--Deleting these tables disables all behavior for the corresponding frame


ns.Settings.Frames = {}

ns.Settings.Frames.PlayerFrame = {}
ns.Settings.Frames.PlayerFrame.Boundaries = {
	{
		point = "TOPLEFT",
		x = 40,
		y = -10
	},
	{
		point = "BOTTOMRIGHT",
		x = -4,
		y = 20
	}
}

ns.Settings.Frames.PartyMemberFrame1 = {}
ns.Settings.Frames.PartyMemberFrame1.Boundaries = {
	{
		point = "TOPLEFT",
		x = 0,
		y = 0
	},
	{
		point = "BOTTOMRIGHT",
		x = -5,
		y = 0
	}
}

ns.Settings.Frames.PartyMemberFrame2 = {}
ns.Settings.Frames.PartyMemberFrame2.Boundaries = {
	{
		point = "TOPLEFT",
		x = 0,
		y = 0
	},
	{
		point = "BOTTOMRIGHT",
		x = -5,
		y = 0
	}
}


ns.Settings.Frames.PartyMemberFrame3 = {}
ns.Settings.Frames.PartyMemberFrame3.Boundaries = {
	{
		point = "TOPLEFT",
		x = 0,
		y = 0
	},
	{
		point = "BOTTOMRIGHT",
		x = -5,
		y = 0
	}
}


ns.Settings.Frames.PartyMemberFrame4 = {}
ns.Settings.Frames.PartyMemberFrame4.Boundaries = {
	{
		point = "TOPLEFT",
		x = 0,
		y = 0
	},
	{
		point = "BOTTOMRIGHT",
		x = -5,
		y = 0
	}
}


ns.Settings.Frames.PartyMemberFrame5 = {}
ns.Settings.Frames.PartyMemberFrame5.Boundaries = {
	{
		point = "TOPLEFT",
		x = 0,
		y = 0
	},
	{
		point = "BOTTOMRIGHT",
		x = -5,
		y = 0
	}
}



-- ns.Settings.Frames.TargetFrame = {}
-- ns.Settings.Frames.TargetFrame.Boundaries = {
-- 	{
-- 		point = "TOPLEFT",
-- 		x = 4,
-- 		y = -10
-- 	},
-- 	{
-- 		point = "BOTTOMRIGHT",
-- 		x = -40,
-- 		y = 20
-- 	}
-- }


