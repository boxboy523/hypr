hl.monitor({ output = "eDP-1", mode = "2880x1800@120", position = "0x0", scale = 1.6 })

hl.on("hyprland.start", function()
    hl.exec_cmd("kitten panel --edge=background -o background=black -o font_size=10 btop")
    hl.exec_cmd("bash ~/conf/quickshell/bar/start.sh --portable")
end)
