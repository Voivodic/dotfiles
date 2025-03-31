# Add to PATH
# $env.PATH = ($env.PATH | split row (char esep) | append "")

# Set the url generate by ngrok where ollama is running
$env.OLLAMA_HOST = "https://eminent-superb-elephant.ngrok-free.app"

# Set the path for hyprshot
$env.HYPRSHOT_DIR = "/home/voivodic/Images"

# Set starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
