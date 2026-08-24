hl.monitor({ output = "eDP-1", mode = "2560x1600@120", position = "0x0", scale = 1.6 })

hl.on("hyprland.start", function()
    hl.exec_cmd("while true; do kitty +kitten panel --edge=background -o background=black -o font_size=40 $HOME/.config/hypr/scripts/watch_dcss.sh; sleep 1; done")
    hl.exec_cmd("waybar -c ~/.config/waybar/laptop_config")
end)
