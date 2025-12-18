#!/bin/bash

# 1. Install Oh My Zsh if not already present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 2. Define the directory where this script is running (the dotfiles repo)
# Using $(pwd) ensures it works in Codespaces where the path is specific.
DOTFILES_PATH=$(pwd)

# 3. Install Plugins (Syntax Highlighting & Autosuggestions)
ZSH_CUSTOM_PLUGINS="$HOME/.oh-my-zsh/custom/plugins"

if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting" ]; then
  echo "Downloading zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM_PLUGINS/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions" ]; then
  echo "Downloading zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM_PLUGINS/zsh-autosuggestions"
fi

# 4. Create symbolic links to your home directory
# This connects the files in your repo to where Zsh expects them to be.
echo "Linking configuration files..."
ln -sf "$DOTFILES_PATH/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_PATH/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_PATH/.gitconfig" "$HOME/.gitconfig"

# 5. Set Zsh as the default shell (Specific for Codespaces environments)
if [ "$CODESPACES" = "true" ]; then
  echo "Setting Zsh as the default shell..."
  sudo chsh -s $(which zsh) vscode
fi

echo "Installation complete! Please restart your terminal or type 'zsh'."
