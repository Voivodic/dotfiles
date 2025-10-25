# Add to PATH
# $env.PATH = ($env.PATH | split row (char esep) | append "")

# Source the secrets file
source ~/.config/nushell/secrets.nu

# Set the path for hyprshot
$env.HYPRSHOT_DIR = "/home/voivodic/Images"

# Set the default browser
$env.BROWSER = "microsoft-edge"

# Set the default editor
$env.EDITOR = "nvim"

# Set starship
mkdir ~/.cache/starship
starship init nu | save -f ~/.cache/starship/init.nu
