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

# Detect OS
OS=$(uname -s)

# Auto-detect all vault paths on macOS
VAULT_NAMES=()
VAULT_PATHS=()
VAULT_COUNT=0
if [ "$OS" = "Darwin" ]; then
    OBSIDIAN_CONFIG="$HOME/Library/Application Support/obsidian/obsidian.json"
    if [ -f "$OBSIDIAN_CONFIG" ]; then
        # Extract all vaults with names and paths
        VAULTS_JSON=$(python3 -c "
import json
import sys
try:
    with open('$OBSIDIAN_CONFIG', 'r') as f:
        data = json.load(f)
    vaults = data.get('vaults', {})
    for vault_id, vault_info in vaults.items():
        name = vault_info.get('path', '').split('/')[-1]
        path = vault_info.get('path', '')
        if path:
            print(f'{name}|{path}')
except Exception as e:
    sys.exit(0)
" 2>/dev/null)

        # Parse vaults into arrays
        if [ -n "$VAULTS_JSON" ]; then
            while IFS='|' read -r vault_name vault_path; do
                if [ -n "$vault_name" ] && [ -n "$vault_path" ]; then
                    VAULT_COUNT=$((VAULT_COUNT + 1))
                    VAULT_NAMES[$VAULT_COUNT]="$vault_name"
                    VAULT_PATHS[$VAULT_COUNT]="$vault_path"
                fi
            done <<< "$VAULTS_JSON"
        fi
    fi
fi

# Prompt for Obsidian vault path
if [ $VAULT_COUNT -gt 0 ]; then
    echo -e "${GREEN}Available Obsidian Vaults:${NC}"
    echo ""
    
    i=1
    while [ $i -le $VAULT_COUNT ]; do
        printf "  ${GREEN}%d)${NC} ${YELLOW}%s${NC} (%s)\n" "$i" "${VAULT_NAMES[$i]}" "${VAULT_PATHS[$i]}"
        i=$((i + 1))
    done
    
    echo ""
    echo -e "${YELLOW}Select vault number (1-$VAULT_COUNT) or enter custom path:${NC}"
    read -p "Your selection: " USER_INPUT
    
    # Check if input is a number and within range
    if [[ "$USER_INPUT" =~ ^[0-9]+$ ]] && [ "$USER_INPUT" -ge 1 ] && [ "$USER_INPUT" -le "$VAULT_COUNT" ]; then
        VAULT_PATH="${VAULT_PATHS[$USER_INPUT]}"
        echo -e "${GREEN}Selected vault: ${VAULT_NAMES[$USER_INPUT]}${NC}"
    else
        # Treat as custom path
        VAULT_PATH="$USER_INPUT"
        echo -e "${GREEN}Using custom path${NC}"
    fi
else
    echo -e "${YELLOW}No Obsidian vaults detected on your system.${NC}"
    echo -e "${YELLOW}Please enter the path to your Obsidian vault:${NC}"
    read -p "Vault path: " VAULT_PATH
fi

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

