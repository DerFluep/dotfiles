-- ====================================================================
-- Swayimg Vim Bindings + 100% Real Size Zoom (Shift-z)
-- ====================================================================

-- Force swayimg to scan the directory for adjacent files on startup
swayimg.imagelist.enable_adjacent(true)

-- Set the layout rule for subsequent images you switch to
swayimg.viewer.set_default_scale("fit")

-- Force a layout recalculation when the window manager tiles/stretches the window
swayimg.on_window_resize(function()
	if swayimg.get_mode() == "viewer" then
		swayimg.viewer.set_fix_scale("fit")
	end
end)

-- 1. VIEWER MODE: Image Switching ([ and ])
swayimg.viewer.on_key("]", function()
	swayimg.viewer.switch_image("next")
end)

swayimg.viewer.on_key("[", function()
	swayimg.viewer.switch_image("prev")
end)

-- 2. VIEWER MODE: Switch to Gallery Grid
swayimg.viewer.on_key("g", function()
	swayimg.set_mode("gallery")
end)

-- 3. VIEWER MODE: Panning / Scrolling (Pure h / j / k / l - INVERTED)
-- Moves the actual image under your cursor instead of the viewport
swayimg.viewer.on_key("h", function()
	local pos = swayimg.viewer.get_position()
	if pos then
		swayimg.viewer.set_abs_position(pos.x + 50, pos.y)
	end
end)

swayimg.viewer.on_key("l", function()
	local pos = swayimg.viewer.get_position()
	if pos then
		swayimg.viewer.set_abs_position(pos.x - 50, pos.y)
	end
end)

swayimg.viewer.on_key("k", function()
	local pos = swayimg.viewer.get_position()
	if pos then
		swayimg.viewer.set_abs_position(pos.x, pos.y + 50)
	end
end)

swayimg.viewer.on_key("j", function()
	local pos = swayimg.viewer.get_position()
	if pos then
		swayimg.viewer.set_abs_position(pos.x, pos.y - 50)
	end
end)

-- 4. VIEWER MODE: Clipboard Yanking (Vim Style)
-- 'y' copies the actual image contents into the clipboard
swayimg.viewer.on_key("y", function()
	local img = swayimg.viewer.get_image()
	if img and img.path then
		os.execute("wl-copy < " .. '"' .. img.path .. '"')
	end
end)

-- 'Ctrl-y' copies only the file path text string to the clipboard
swayimg.viewer.on_key("Ctrl-y", function()
	local img = swayimg.viewer.get_image()
	if img and img.path then
		os.execute("echo -n " .. '"' .. img.path .. '"' .. " | wl-copy")
	end
end)

-- 5. GALLERY MODE: Grid Navigation & Selection (Return Only)
swayimg.gallery.on_key("h", function()
	swayimg.gallery.switch_image("left")
end)
swayimg.gallery.on_key("l", function()
	swayimg.gallery.switch_image("right")
end)
swayimg.gallery.on_key("j", function()
	swayimg.gallery.switch_image("down")
end)
swayimg.gallery.on_key("k", function()
	swayimg.gallery.switch_image("up")
end)

swayimg.gallery.on_key("Return", function()
	swayimg.set_mode("viewer")
end)

-- 6. GALLERY MODE: Consistent Zooming (i / o)
swayimg.gallery.on_key("i", function()
	local size = swayimg.gallery.get_thumb_size()
	if size then
		swayimg.gallery.set_thumb_size(size + 30)
	end
end)

swayimg.gallery.on_key("o", function()
	local size = swayimg.gallery.get_thumb_size()
	if size and size > 60 then
		swayimg.gallery.set_thumb_size(size - 30)
	end
end)

-- 7. VIEWER MODE: Zooming & Reset
swayimg.viewer.on_key("i", function()
	local scale = swayimg.viewer.get_scale()
	if scale then
		swayimg.viewer.set_abs_scale(scale * 1.2)
	end
end)

swayimg.viewer.on_key("o", function()
	local scale = swayimg.viewer.get_scale()
	if scale then
		swayimg.viewer.set_abs_scale(scale / 1.2)
	end
end)

-- Lowercase 'z' fits the image cleanly to your window boundaries
swayimg.viewer.on_key("z", function()
	swayimg.viewer.set_fix_scale("fit")
end)

-- 'Shift-z' snaps the image to 100% pixel-perfect original scale
swayimg.viewer.on_key("Shift-z", function()
	swayimg.viewer.set_fix_scale("real")
end)

-- 8. VIEWER MODE: Show Info Layer Again
swayimg.viewer.on_key("Tab", function()
	swayimg.text.show()
end)

-- 9. GLOBAL: Quick Exit with 'q'
swayimg.viewer.on_key("q", function()
	swayimg.exit()
end)

swayimg.gallery.on_key("q", function()
	swayimg.exit()
end)
