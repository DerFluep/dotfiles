-- ====================================================================
-- Swayimg Vim Bindings + 100% Real Size Zoom (Shift-z)
-- ====================================================================

-- Force swayimg to scan the directory for adjacent files on startup
swayimg.imagelist.adjacent = true

-- Set the layout rule for subsequent images you switch to
swayimg.viewer.default_scale = "fit"

-- Force a layout recalculation when the window manager tiles/stretches the window
swayimg.on_window_resize(function()
	swayimg.viewer.set_fix_scale("fit")
end)

local thumb_size = 128
swayimg.gallery.thumb_size = thumb_size
swayimg.text.timeout = 2

-- 1. VIEWER MODE: Image Switching ([ and ])
swayimg.viewer.on_key("]", function()
	swayimg.viewer.open("next")
end)

swayimg.viewer.on_key("[", function()
	swayimg.viewer.open("prev")
end)

-- 2. VIEWER MODE: Switch to Gallery Grid
swayimg.viewer.on_key("g", function()
	swayimg.mode = "gallery"
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
	swayimg.gallery.select("left")
end)
swayimg.gallery.on_key("l", function()
	swayimg.gallery.select("right")
end)
swayimg.gallery.on_key("j", function()
	swayimg.gallery.select("down")
end)
swayimg.gallery.on_key("k", function()
	swayimg.gallery.select("up")
end)

swayimg.gallery.on_key("Return", function()
	swayimg.mode = "viewer"
end)

-- 6. GALLERY MODE: Consistent Zooming (i / o)
swayimg.gallery.on_key("i", function()
	thumb_size = thumb_size + 30
	swayimg.gallery.thumb_size = thumb_size
end)

swayimg.gallery.on_key("o", function()
	thumb_size = thumb_size - 30
	swayimg.gallery.thumb_size = thumb_size
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
	swayimg.text.visible = not swayimg.text.visible
end)

-- 9. GLOBAL: Quick Exit with 'q'
swayimg.viewer.on_key("q", function()
	swayimg.exit()
end)

swayimg.gallery.on_key("q", function()
	swayimg.exit()
end)
