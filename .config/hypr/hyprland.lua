-- ~/.config/hypr/hyprland.lua
-- Port of the former hyprland.conf (hyprlang) to the Lua config.
-- Wiki: https://wiki.hypr.land/Configuring/Start/


------------------
---- PROGRAMS ----
------------------

local terminal    = "ghostty"
local launcher    = "gmrun"
local fileManager = "dolphin"
local menu        = "hyprlauncher"
local mainMod     = "SUPER" -- Windows key


------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1200",
    position = "auto",
    scale    = 1,
})

hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080",
    position = "auto",
    scale    = 1,
    mirror   = "eDP-1",
})

hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1920x1080",
    position = "auto",
    scale    = 1,
    mirror   = "eDP-1",
})


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd(terminal)
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("firefox")
    hl.exec_cmd("wl-clip-persist --clipboard both")

    -- For screen sharing
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")


-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 5,
        border_size = 2,
        col = {
            active_border = {
                colors = { "rgba(33ccffee)", "rgba(00ff99ee)" },
                angle  = 45,
            },
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "master",
    },

    decoration = {
        rounding       = 4,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})


----------------------
---- ANIMATIONS ----
----------------------

hl.config({
    animations = { enabled = true },
})

hl.curve("easeOutQuint",   { type = "bezier", points = { { 0.23, 1 },    { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear",         { type = "bezier", points = { { 0, 0 },       { 1, 1 } } })
hl.curve("almostLinear",   { type = "bezier", points = { { 0.5, 0.5 },   { 0.75, 1 } } })
hl.curve("quick",          { type = "bezier", points = { { 0.15, 0 },    { 0.1, 1 } } })

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })


-------------
---- INPUT ----
-------------

hl.config({
    input = {
        kb_layout    = "us",
        kb_variant   = "altgr-intl",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Per-device config (one hl.device() call per device, NOT inside hl.config)
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name       = "thinkpad-extra-buttons",
    kb_options = "",
})


---------------------
---- KEYBINDINGS ----
---------------------

-- Programs
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",  hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",  hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R",  hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(launcher, { float = true }))
hl.bind(mainMod .. " + TAB", hl.dsp.exec_cmd("~/.config/hypr/scripts/fullscreen_cycle.sh"))

-- Session / window state
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(
    "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"
))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F",     hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + SPACE", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Master layout navigation
hl.bind(mainMod .. " + J", hl.dsp.layout("cyclenext"))
hl.bind(mainMod .. " + K", hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("swapnext"))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.layout("swapprev"))
hl.bind(mainMod .. " + RETURN", hl.dsp.layout("swapwithmaster"))

-- Focus (only "up" was active in the old config)
hl.bind(mainMod .. " + UP", hl.dsp.focus({ direction = "up" }))

-- Resize (binde -> repeating)
hl.bind(mainMod .. " + L", hl.dsp.window.resize({ x = 50,  y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })

-- Workspaces: SUPER + [1-9,0] focuses on the current monitor,
-- SUPER + SHIFT + [1-9,0] moves the active window there
for i = 1, 10 do
    local key = i % 10 -- workspace 10 is on key 0

    hl.bind(mainMod .. " + " .. key,
        hl.dsp.focus({ workspace = i, on_current_monitor = true }))

    hl.bind(mainMod .. " + SHIFT + " .. key,
        hl.dsp.window.move({ workspace = i, follow = true }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with SUPER + LMB/RMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume and brightness (bindel -> locked + repeating)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),   { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media keys (requires playerctl; bindl -> locked)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


------------------------------
---- WINDOWS AND WORKSPACES ----
------------------------------

-- Ignore maximize requests from all apps
hl.window_rule({
    name = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- Hyprland-run
hl.window_rule({
    name = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
