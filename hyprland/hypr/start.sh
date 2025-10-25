# Initialize the wallpaper
swww-daemon & 
waypaper --random   
cp $(waypaper --list | jq -r '.[0].wallpaper') $HOME/.config/hypr/wallpapers/wallpaper.jpg
waypaper --wallpaper $HOME/.config/hypr/wallpapers/wallpaper.jpg

# For controlling the lock 
hypridle &

# The status bar
waybar &

# The notification hub
swaync &
swaync-client -df &

# Go to the lock screen
sleep 1
hyprlock

