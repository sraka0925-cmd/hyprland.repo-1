-- ░▒▓ HYPRLAND (.lua, Hyprland 0.55+) — Lavender Noir ▓▒░
-- vibe: pastel purple + soft neon glow (femboy x Blade Runner 2049)
-- Note: the .lua format replaced hyprlang (.conf) in Hyprland 0.55 (May 2026)
-- and is still fresh — if `hyprctl reload` throws an error on some field,
-- check the current field name at https://wiki.hypr.land/Configuring/

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-----------------------
---- MY PROGRAMS ----
-----------------------
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in     = 6,
        gaps_out    = 16,
        border_size = 2,
        col = {
            -- gradient: pastel purple -> soft pink (Blade Runner glow)
            active_border   = { colors = { "rgba(c9a7ffee)", "rgba(f5b8d0ee)" }, angle = 45 },
            inactive_border = "rgba(8a7ca655)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        active_opacity   = 0.97,
        inactive_opacity = 0.88,

        shadow = {
            enabled      = true,
            range        = 32,
            render_power = 3,
            -- ARGB hex format: 0xAARRGGBB — soft purple b794f6 at ~50% alpha
            color          = 0x80b794f6,
            color_inactive = 0x40b794f6,
        },

        blur = {
            enabled            = true,
            size               = 8,
            passes             = 3,
            new_optimizations  = true,
            ignore_opacity     = true,
            noise              = 0.02,
            contrast           = 1.0,
            brightness         = 1.05,
            vibrancy           = 0.25,
            popups             = true,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Bezier curves — soft, gentle ease in/out
hl.curve("softPurple", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("gentle",     { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1 } } })

hl.animation({ leaf = "global",     enabled = true, speed = 10,  bezier = "default" })
hl.animation({ leaf = "windows",    enabled = true, speed = 4.8, bezier = "softPurple", style = "popin 85%" })
hl.animation({ leaf = "windowsIn",  enabled = true, speed = 4.8, bezier = "softPurple", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3,   bezier = "gentle",     style = "popin 85%" })
hl.animation({ leaf = "border",     enabled = true, speed = 6,   bezier = "gentle" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3,   bezier = "gentle" })
hl.animation({ leaf = "fadeIn",     enabled = true, speed = 3,   bezier = "gentle" })
hl.animation({ leaf = "fadeOut",    enabled = true, speed = 2,   bezier = "gentle" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4,   bezier = "softPurple", style = "slidefade 15%" })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
hl.config({
    dwindle = {
        pseudotile     = true,
        preserve_split = true,
    },
})

----------------
---- MISC ----
----------------
hl.config({
    misc = {
        disable_hyprland_logo   = true,
        force_default_wallpaper = -1,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

-----------------------------------------
---- WINDOWS — float everything by default ----
-----------------------------------------
hl.window_rule({
    name  = "float-everything",
    match = { class = ".*" },
    float = true,
    size   = "62% 68%",
    center = true,
})

hl.window_rule({
    name  = "pip-float",
    match = { title = "^(Picture-in-Picture)$" },
    float = true,
    pin   = true,
    size  = "25% 25%",
})

---------------------
---- KEYBINDINGS ----
---------------------
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",      hl.dsp.window.close())
hl.bind(mainMod .. " + M",      hl.dsp.exit())
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V",      hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen())

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Workspaces 1-5 + move active window
for i = 1, 5 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Move / resize windows with the mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
