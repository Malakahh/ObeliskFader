local _, ns = ...
ns.Settings = {}
ns.Settings.HoverFrames = {}

--The minimum alpha reached. Must have a value between 1 and 0. Lower number is more transparent
ns.Settings.MinAlpha = 0

--The maximum alpha reached. Must have a value between 1 and 0. Lower number is more transparent
ns.Settings.MaxAlpha = 1

--Time it takes for a frame to fade in (in seconds, fractions are available)
ns.Settings.FadeInTime = 0.25

--Time it takes for a frame to fade out (in seconds, fractions are available)
ns.Settings.FadeOutTime = 0.5

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


