-- ░▒▓ HYPRLAND — Lavender Noir ▓▒░

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-----------------------
---- PROGRAMS ---------
-----------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"

-------------------------------
---- ENV ----------------------
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("nm-applet --indicator")
end)

-----------------------
---- MAIN CONFIG ------
-----------------------
hl.config({

    general = {
        gaps_in     = 6,
        gaps_out    = 16,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(c9a7ffee)", "rgba(f5b8d0ee)" }, angle = 45 },
            inactive_border = "rgba(8a7ca655)",
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 20,

        active_opacity   = 0.97,
        inactive_opacity = 0.88,

        blur = {
            enabled       = true,
            size          = 8,
            passes        = 3,
            vibrancy      = 0.25,
            noise         = 0.02,
            brightness    = 1.05,
            contrast      = 1.0,
        },

        shadow = {
            enabled = true,
            range   = 32,
            color   = 0x80b794f6,
        },
    },

    animations = {
        enabled = true,
    },

    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },

    dwindle = {
        pseudotile    = true,
        preserve_split = true,
    },

    misc = {
        disable_hyprland_logo = true,
    },
})

-------------------
---- CURVES -------
-------------------
hl.curve("soft", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("gentle", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1 } } })

-------------------
---- ANIMATIONS ---
-------------------
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "soft", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "gentle", style = "popin 85%" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "gentle" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "soft", style = "slidefade 15%" })

-------------------
---- RULES --------
-------------------
-- SAFE version (no regex madness)
hl.window_rule({
    name  = "pip",
    match = { title = "Picture-in-Picture" },
    float = true,
    pin   = true,
    size  = "25% 25%",
})

-------------------
---- BINDS --------
-------------------
local mod = "SUPER"

hl.bind(mod .. " + Return", function() hl.exec_cmd(terminal) end)
hl.bind(mod .. " + Q", function() hl.dsp.window.close() end)
hl.bind(mod .. " + M", function() hl.dsp.exit() end)
hl.bind(mod .. " + E", function() hl.exec_cmd(fileManager) end)
hl.bind(mod .. " + R", function() hl.exec_cmd(menu) end)
hl.bind(mod .. " + F", function() hl.dsp.window.fullscreen() end)

-- workspace switching
for i = 1, 5 do
    hl.bind(mod .. " + " .. i, function() hl.dsp.focus({ workspace = i }) end)
    hl.bind(mod .. " + SHIFT + " .. i, function() hl.dsp.window.move({ workspace = i }) end)
end
