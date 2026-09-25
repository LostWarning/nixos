-- 1. Disable text overlay / UI elements
swayimg.text.visible = false

-- Helper function to set or adjust scale
local function adjust_scale(factor)
	local current = swayimg.viewer.scale or 1.0
	swayimg.viewer.set_abs_scale(current * factor)
end

-- Helper function to pan/step image position
local function pan(dx, dy)
	local pos = swayimg.viewer.get_position()
	local win = swayimg.get_window_size()
	if pos and win then
		local w = win.width or win.w or win[1]
		local h = win.height or win.h or win[2]
		swayimg.viewer.set_abs_position(pos.x + (dx * w), pos.y + (dy * h))
	end
end

-- 2. Zoom Controls
swayimg.viewer.on_key("Equal", function()
	adjust_scale(1.1)
end)
swayimg.viewer.on_key("Plus", function()
	adjust_scale(1.1)
end)
swayimg.viewer.on_key("Minus", function()
	adjust_scale(0.9)
end)
swayimg.viewer.on_key("0", function()
	swayimg.viewer.set_abs_scale(1.0)
end)
swayimg.viewer.on_key("f", function()
	swayimg.viewer.reset()
end)

-- 3. Vim Panning (Moves image by 10% of window dimensions)
swayimg.viewer.on_key("h", function()
	pan(0.1, 0)
end)
swayimg.viewer.on_key("l", function()
	pan(-0.1, 0)
end)
swayimg.viewer.on_key("k", function()
	pan(0, 0.1)
end)
swayimg.viewer.on_key("j", function()
	pan(0, -0.1)
end)

-- 4. File Navigation (using non-deprecated open())
swayimg.viewer.on_key("Space", function()
	swayimg.viewer.open("next")
end)

swayimg.viewer.on_key("Backspace", function()
	swayimg.viewer.open("prev")
end)

-- 5. Quit
swayimg.viewer.on_key("q", swayimg.exit)
swayimg.viewer.on_key("Escape", swayimg.exit)
