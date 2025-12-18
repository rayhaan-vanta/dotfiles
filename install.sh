#!/bin/bash

# 1. Install Oh My Zsh if not already present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 2. Define path for plugins and themes
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# 3. Install THEME (Powerlevel10k)
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Downloading Powerlevel10k theme..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# 4. Install PLUGINS
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  echo "Downloading zsh-syntax-highlighting..."
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Downloading zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# 5. Link configuration files
# $(pwd) works in Codespaces because GitHub runs the script from the repo folder
DOTFILES_PATH=$(pwd)
echo "Linking configuration files from $DOTFILES_PATH..."
ln -sf "$DOTFILES_PATH/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_PATH/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$DOTFILES_PATH/.gitconfig" "$HOME/.gitconfig"

# 6. Set Zsh as the default shell (Codespaces only)
if [ "$CODESPACES" = "true" ]; then
  echo "Setting Zsh as the default shell..."
  sudo chsh -s $(which zsh) vscode
fi

echo "Installation complete!"
