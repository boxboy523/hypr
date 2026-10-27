local main_mod = "SUPER"

local function exec(key, command)
    hl.bind(main_mod .. " + " .. key, hl.dsp.exec_cmd(command))
end

exec("G", "~/.config/hypr/scripts/pwa_toggle.sh $PWA_GEMINI")
exec("Y", "~/.config/hypr/scripts/pwa_toggle.sh $PWA_YOUTUBE")
exec("W", "~/.config/hypr/scripts/pwa_toggle.sh $PWA_NAMUWIKI")
exec("R", "qs -p ~/conf/quickshell/agent ipc call agent toggle || qs -n -d -p ~/conf/quickshell/agent")
exec("T", "~/.config/hypr/scripts/pwa_toggle.sh $PWA_CHATGPT")
exec("S", "firefox")
exec("Q", "kitty")
exec("F", "kitty yazi")
exec("E", "rofi -show drun -theme ~/.config/rofi/monochrome_tui.rasi")
exec("L", 'grim -g "$(slurp)" - | wl-copy')

hl.bind(main_mod .. " + C", hl.dsp.window.close())
hl.bind(main_mod .. " + M", hl.dsp.exit())
hl.bind(main_mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(main_mod .. " + " .. direction, hl.dsp.focus({ direction = direction }))
end

for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

local repeating_commands = {
    XF86AudioRaiseVolume = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
    XF86AudioLowerVolume = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
    XF86AudioMute = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
    XF86AudioMicMute = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
    XF86MonBrightnessUp = "brightnessctl -e4 -n2 set 5%+",
    XF86MonBrightnessDown = "brightnessctl -e4 -n2 set 5%-",
}

for key, command in pairs(repeating_commands) do
    hl.bind(key, hl.dsp.exec_cmd(command), { locked = true, repeating = true })
end

local media_commands = {
    XF86AudioNext = "playerctl next",
    XF86AudioPause = "playerctl play-pause",
    XF86AudioPlay = "playerctl play-pause",
    XF86AudioPrev = "playerctl previous",
}

for key, command in pairs(media_commands) do
    hl.bind(key, hl.dsp.exec_cmd(command), { locked = true })
end
