#!/bin/bash

# Make sure to run this script as part of your dotfiles repo.
# It will be executed by Codespaces on new environment creation.

echo "--- Setting up dotfiles ---"

# --- 1. Install Oh My Zsh (Example) ---
# Check if OMZ is already installed before trying to install
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  # --unattended flag skips interactive prompts
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "Oh My Zsh installed."
else
  echo "Oh My Zsh already installed."
fi

# --- 2. Link/Copy your dotfiles ---
# Good practice to back up existing ones first if you're not in Codespaces
# In Codespaces, these will usually be fresh home directories anyway.
# Symlink is preferred for easier updates from the repo.

# Example: Symlink your custom .zshrc
# This assumes you have a .zshrc file in your dotfiles repo
if [ -f "$HOME/.zshrc" ]; then
  rm "$HOME/.zshrc" # Remove the default one OMZ created
fi
ln -s "$HOME/.dotfiles/my_zshrc" "$HOME/.zshrc" # Link your custom zshrc from your repo

# Example: Symlink .gitconfig
if [ -f "$HOME/.gitconfig" ]; then
  rm "$HOME/.gitconfig"
fi
ln -s "$HOME/.dotfiles/gitconfig" "$HOME/.gitconfig" # Assuming your gitconfig is named 'gitconfig' in your repo

# --- 3. Install Zsh Plugins (Example for zsh-autosuggestions) ---
# This should go after OMZ installation
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom" # OMZ custom directory

echo "--- Installing Zsh Plugins ---"
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

echo "--- Dotfiles setup complete ---"