# hyprland.repo-1
Repo for both `.conf` and `.lua`.

> NOTE: Use only the `test.5` branch. Other branches might not work.
> OTHER NOTE: you will need some things. To install them open a terminal and run: sudo pacman -S kitty wofi waybar mako swww grim slurp wl-clipboard brightnessctl playerctl pavucontrol dolphin

## Install on Arch Linux

Open a terminal and run:

```bash
git clone -b test.5 https://github.com/sraka0925-cmd/hyprland.repo-1.git
cd hyprland.repo-1

mkdir -p ~/.config/hypr ~/.config/waybar ~/.config/mako

cp hyprland.conf ~/.config/hypr/hyprland.conf
cp mega_pastel_waybar_config.jsonc ~/.config/waybar/config.jsonc
cp mega_pastel_waybar_style.css ~/.config/waybar/style.css
cp mega_pastel_mako.conf ~/.config/mako/config

If you have any questions, feel free to ask. I have tested it on Arch Linux Idk if it works in other distros
