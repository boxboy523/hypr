hl.monitor({ output = "DP-4", mode = "3840x2160@144", position = "0x0", scale = 1.5 })
hl.monitor({ output = "HDMI-A-2", mode = "1920x1080@60", position = "2560x0", scale = 1 })

hl.on("hyprland.start", function()
    hl.exec_cmd('while true; do kitty +kitten panel --edge=background --output-name "DP-4" -o background=black -o font_size=40 $HOME/.config/hypr/scripts/watch_dcss.sh; sleep 1; done')
    hl.exec_cmd('kitten panel --edge=background --output-name "HDMI-A-2" -o background=black -o font_size=10 btop')
    hl.exec_cmd("waybar")
end)

hl.bind("SUPER + F9", hl.dsp.exec_cmd("systemctl --user start sunshine.service"))
hl.bind("SUPER + F10", hl.dsp.exec_cmd("systemctl --user start sunshine.service"))

for workspace = 1, 10 do
    hl.workspace_rule({
        workspace = tostring(workspace),
        monitor = workspace % 2 == 1 and "DP-4" or "HDMI-A-2",
    })
end
