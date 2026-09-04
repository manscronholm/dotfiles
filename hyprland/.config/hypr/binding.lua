---------------------------------------------------------------------------
-- Applications
---------------------------------------------------------------------------

-- Your old file manager shortcut.
o.bind("SUPER + E", "File manager", "kitty spf")

---------------------------------------------------------------------------
-- Vim-style window navigation
---------------------------------------------------------------------------
hl.unbind("SUPER + H")
hl.unbind("SUPER + J")
hl.unbind("SUPER + K")
hl.unbind("SUPER + L")

o.bind("SUPER + H", "Focus left", "movefocus l")
o.bind("SUPER + J", "Focus down", "movefocus d")
o.bind("SUPER + K", "Focus up", "movefocus u")
o.bind("SUPER + L", "Focus right", "movefocus r")

---------------------------------------------------------------------------
-- Workspace switching
---------------------------------------------------------------------------
for i = 1, 9 do
	o.bind("SUPER + " .. tostring(i), "Workspace " .. tostring(i), "workspace " .. tostring(i))

	o.bind(
		"SUPER + SHIFT + " .. tostring(i),
		"Move window to workspace " .. tostring(i),
		"movetoworkspace " .. tostring(i)
	)
end

o.bind("SUPER + 0", "Workspace 10", "workspace 10")
o.bind("SUPER + SHIFT + 0", "Move window to workspace 10", "movetoworkspace 10")

---------------------------------------------------------------------------
-- Monitor workspace movement
---------------------------------------------------------------------------

o.bind("SUPER + LEFT", "Move workspace to left monitor", "movecurrentworkspacetomonitor l")

o.bind("SUPER + RIGHT", "Move workspace to right monitor", "movecurrentworkspacetomonitor r")

---------------------------------------------------------------------------
-- Special workspaces
---------------------------------------------------------------------------

-- Spotify
o.bind("SUPER + S", "Toggle Spotify", "togglespecialworkspace spotify")

o.bind("SUPER + SHIFT + S", "Move window to Spotify", "movetoworkspace special:spotify")

-- Discord
o.bind("SUPER + D", "Toggle Discord", "togglespecialworkspace discord")

o.bind("SUPER + SHIFT + D", "Move window to Discord", "movetoworkspace special:discord")

---------------------------------------------------------------------------
-- Screenshot
---------------------------------------------------------------------------

o.bind("SUPER + F10", "Screenshot region to clipboard", "hyprshot -m region --clipboard-only")

---------------------------------------------------------------------------
-- 1Password
---------------------------------------------------------------------------

o.bind("CTRL + SHIFT + SPACE", "1Password quick access", "1password --quick-access")

---------------------------------------------------------------------------
-- Workspace scrolling
---------------------------------------------------------------------------

o.bind("SUPER + mouse_down", "Next workspace", "workspace e+1")

o.bind("SUPER + mouse_up", "Previous workspace", "workspace e-1")

---------------------------------------------------------------------------
-- Mouse window movement
---------------------------------------------------------------------------

o.bind("SUPER + mouse:272", "Move window", "movewindow", { mouse = true })

o.bind("SUPER + mouse:273", "Resize window", "resizewindow", { mouse = true })
