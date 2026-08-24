local hostname_file = assert(io.open("/etc/hostname", "r"))
local hostname = assert(hostname_file:read("*l"))
hostname_file:close()

require("monitors." .. hostname)

hl.on("hyprland.start", function()
    hl.exec_cmd("fcitx5 -d --replace")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("xrandr --output DP-4 --primary")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DBUS_SESSION_BUS_ADDRESS")
    hl.exec_cmd("~/conf/quickshell/lock.sh")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("GTK_IM_MODULE", "")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("INPUT_METHOD", "fcitx")

hl.config({
    debug = { full_cm_proto = true },
    xwayland = {
        force_zero_scaling = true,
        use_nearest_neighbor = true,
        enabled = true,
    },
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        col = {
            active_border = "rgba(13a10eff)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = { enabled = true },
    dwindle = { preserve_split = true },
    master = { new_status = "master" },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo = false,
    },
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "korean:ralt_hangul,korean:rctrl_hanja",
        kb_rules = "",
        follow_mouse = 0,
        sensitivity = 0,
        touchpad = { natural_scroll = false },
    },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("sidebar", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

local animations = {
    { "global", 10, "default" },
    { "border", 5.39, "easeOutQuint" },
    { "windows", 4.79, "easeOutQuint" },
    { "windowsIn", 4.1, "easeOutQuint", "popin 87%" },
    { "windowsOut", 1.49, "linear", "popin 87%" },
    { "fadeIn", 1.73, "almostLinear" },
    { "fadeOut", 1.46, "almostLinear" },
    { "fade", 3.03, "quick" },
    { "layers", 3.81, "easeOutQuint" },
    { "layersIn", 4, "easeOutQuint", "fade" },
    { "layersOut", 1.5, "linear", "fade" },
    { "fadeLayersIn", 1.79, "almostLinear" },
    { "fadeLayersOut", 1.39, "almostLinear" },
    { "workspaces", 1.94, "almostLinear", "fade" },
    { "workspacesIn", 1.21, "almostLinear", "fade" },
    { "workspacesOut", 1.94, "almostLinear", "fade" },
    { "zoomFactor", 7, "quick" },
}

for _, animation in ipairs(animations) do
    hl.animation({
        leaf = animation[1],
        enabled = true,
        speed = animation[2],
        bezier = animation[3],
        style = animation[4],
    })
end

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

require("keybindings")

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "fix-xwayland-dragging",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false,
    },
    no_focus = true,
})

hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)" }, float = true })
hl.window_rule({ match = { class = "(org.kde.ark)" }, float = true })
hl.window_rule({ match = { class = ".*pavucontrol.*" }, border_size = 1, float = true, size = { 600, 1000 }, center = true })
hl.window_rule({ match = { class = ".*blueman.*" }, border_size = 1, float = true, size = { 600, 1000 }, center = true })

for _, title in ipairs({ "(Open File)", "(Save As)", "(Confirm to replace files)", "(File Operation Progress)" }) do
    hl.window_rule({ match = { title = title }, float = true })
end

hl.window_rule({ match = { class = "^(FFPWA-.*)$" }, float = true, border_size = 1 })
hl.window_rule({ match = { class = "^(Waydroid)$" }, float = true })
hl.window_rule({ match = { title = "^(Waydroid)$" }, float = true })
