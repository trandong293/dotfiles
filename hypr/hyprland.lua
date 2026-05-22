local terminal = "alacritty"
local file_manager = "nautilus"
local app_launcher = "~/.config/rofi/launcher.sh"
local browser = "firefox"
local lock = "hyprlock"

local script_path = "~/.config/hypr/scripts"

------------
--- ENVS ---
------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

----------------
--- MONITORS ---
----------------

hl.monitor({
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = 1.5,
})

--------------------
--- KEY BINDINGS ---
--------------------

-- execute program
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER + R", hl.dsp.exec_cmd(app_launcher))
hl.bind("SUPER + F", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + L", hl.dsp.exec_cmd(lock))

-- move focus window using arrow keys
hl.bind("SUPER + up", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "d" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "r" }))

-- move focus workspace
hl.bind("SUPER + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind("SUPER + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind("SUPER + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind("SUPER + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind("SUPER + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind("SUPER + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind("SUPER + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind("SUPER + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind("SUPER + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = 10 }))

-- move window to workspace
hl.bind("SUPER + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind("SUPER + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind("SUPER + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind("SUPER + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind("SUPER + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind("SUPER + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind("SUPER + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind("SUPER + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind("SUPER + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- special workspace
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- move/resize window using mouse
hl.bind("SUPER + mouse:272", hl.dsp.window.drag())
hl.bind("SUPER + mouse:273", hl.dsp.window.resize())

-- media
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 2%+"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 2%-"))

hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd(script_path .. "/touchpad.sh toggle"))

hl.bind("Print", hl.dsp.exec_cmd(script_path .. "/screenshot.sh area"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd(script_path .. "/screenshot.sh area"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd(script_path .. "/screenshot.sh window"))

hl.bind("SUPER + T", hl.dsp.exec_cmd(script_path .. "/color_pickers.sh"))

-- others
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + C", hl.dsp.window.kill())
hl.bind("SUPER + M", hl.dsp.exit())

--------------------
--- WINDOW RULES ---
--------------------

hl.window_rule({
  match = {
    class = "Alacritty"
  },
  float = true,
  size = { 800, 600 },
  center = true
})

hl.window_rule({
  match = {
    class = "org.gnome.Nautilus"
  },
  float = true,
  size = { 800, 600 },
  center = true
})

-----------------
--- AUTOSTART ---
-----------------

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("fcitx5 --disable xcb")
  hl.exec_cmd(script_path .. "/touchpad.sh init")
  -- gtk
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'")
end)

-----------------
--- VARIABLES ---
-----------------
local general = {
  border_size = 2,
  gaps_in = 0,
  gaps_out = 0,
  col = {
    inactive_border = "#232323",
    active_border = "#ababab"
  },
  snap = {
    enabled = false
  }
}

local decoration = {
  rounding = 5,
  rounding_power = 2,
  active_opacity = 1.0,
  inactive_opacity = 1.0,
  shadow = {
    enabled = false
  },
  blur = {
    enabled = false
  }
}

local input = {
  kb_layout = "us",
  sensitivity = 0.0,
  follow_mouse = 1, -- todo
  touchpad = {
    natural_scroll = true,
    scroll_factor = 0.5
  }
}

hl.config({
  general = general,
  decoration = decoration,
  animations = {
    enabled = false
  },
  input = input,
  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0
  },
  ecosystem = {
    no_update_news = true,
    no_donation_nag = true
  },
  debug = {
    vfr = true
  }
})

hl.device({
  name = "elan1300:00-04f3:3057-touchpad",
  enabled = true
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})
