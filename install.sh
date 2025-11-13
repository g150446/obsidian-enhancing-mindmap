#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Plugin name from manifest.json
PLUGIN_NAME="obsidian-enhancing-mindmap"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}Obsidian Enhancing Mindmap Plugin Installer${NC}"
echo "=========================================="
echo ""

# Check if main.js exists, if not, build it
if [ ! -f "$SCRIPT_DIR/main.js" ]; then
    echo -e "${YELLOW}main.js not found. Building plugin...${NC}"
    cd "$SCRIPT_DIR"
    npm run build
    if [ $? -ne 0 ]; then
        echo -e "${RED}Build failed! Please fix the errors and try again.${NC}"
        exit 1
    fi
    echo -e "${GREEN}Build completed!${NC}"
    echo ""
fi

# Prompt for Obsidian vault path
echo -e "${YELLOW}Please enter the path to your Obsidian vault:${NC}"
read -p "Vault path: " VAULT_PATH

# Expand tilde and resolve path
VAULT_PATH="${VAULT_PATH/#\~/$HOME}"
VAULT_PATH=$(cd "$VAULT_PATH" 2>/dev/null && pwd)

# Validate vault path
if [ ! -d "$VAULT_PATH" ]; then
    echo -e "${RED}Error: Vault path does not exist: $VAULT_PATH${NC}"
    exit 1
fi

# Check if .obsidian directory exists
OBSIDIAN_DIR="$VAULT_PATH/.obsidian"
if [ ! -d "$OBSIDIAN_DIR" ]; then
    echo -e "${YELLOW}Warning: .obsidian directory not found. Creating it...${NC}"
    mkdir -p "$OBSIDIAN_DIR"
fi

# Create plugins directory if it doesn't exist
PLUGINS_DIR="$OBSIDIAN_DIR/plugins"
if [ ! -d "$PLUGINS_DIR" ]; then
    echo -e "${YELLOW}Creating plugins directory...${NC}"
    mkdir -p "$PLUGINS_DIR"
fi

# Create plugin directory
PLUGIN_DIR="$PLUGINS_DIR/$PLUGIN_NAME"
echo -e "${GREEN}Installing plugin to: $PLUGIN_DIR${NC}"
mkdir -p "$PLUGIN_DIR"

# Copy required files
echo "Copying files..."
cp "$SCRIPT_DIR/main.js" "$PLUGIN_DIR/" && echo "  ✓ main.js"
cp "$SCRIPT_DIR/manifest.json" "$PLUGIN_DIR/" && echo "  ✓ manifest.json"
cp "$SCRIPT_DIR/styles.css" "$PLUGIN_DIR/" && echo "  ✓ styles.css"

# Check if copy was successful
if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ Plugin installed successfully!${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Open Obsidian"
    echo "2. Go to Settings > Community plugins"
    echo "3. Enable 'Enhancing Mindmap' plugin"
    echo ""
else
    echo -e "${RED}Error: Failed to copy files${NC}"
    exit 1
fi

