# obsidian-enhancing-mindmap-plugin
[English](https://github.com/MarkMindCkm/obsidian-enhancing-mindmap) [中文](https://github.com/MarkMindCkm/obsidian-enhancing-mindmap/blob/main/Readme-zh.md)

![test](https://user-images.githubusercontent.com/18719494/124454742-63ec8580-ddbb-11eb-8da0-7cd44f38a225.gif)

## Will output this markdown:

```
---

mindmap-plugin: basic

---

# Enhancing Mind map

## Links
- <https://github.com/MarkMindLtd/obsidian-enhancing-mindmap>
- [GitHub](https://github.com/MarkMindLtd/obsidian-enhancing-mindmap)

## Related
- [coc-markmap](https://github.com/gera2ld/coc-markmap)
- [gatsby-remark-markmap](https://github.com/gera2ld/gatsby-remark-markmap)

## Features
- links
- **inline** ~~text~~ *styles*
- multiline
   text
- `inline code`
- Katex - $x = {-b \pm \sqrt{b^2-4ac} \over 2a}$
```

### notice

The plug-in only support a limited markdown format 

## Short cuts

| Action                    | Shortcut         |
| ------------------------- | ---------------- |
| New Mind Map              | Ctrl/Cmd+P       |
| New child node            | Tab              |
| New brother node          | Enter (when not editing) |
| Delete node               | Delete           |
| Edit node                 | Space/dblclick node |
| Undo                      | Ctrl/Cmd+Z       |
| Redo                      | Ctrl/Cmd+Y       |
| **Edit Mode Shortcuts**   |                  |
| End edit mode             | Enter            |
| Create new line in node   | Shift+Enter      |
| Quit edit mode (cancel)   | Escape           |
| Expand node               | Ctrl/Cmd + /     |
| Collapse node             | Ctrl/Cmd + /     |
| Move node to another node | Drag and drop node |
| Navigate nodes            | Up/down/left/right |
| Zoom in/out               | Ctrl/Cmd + mouse wheel |
| Center mind map           | Ctrl/Cmd + E     |

### Keyboard Shortcut Notes

- **Tab**: Creates a new child node and automatically enters edit mode. The new node starts with empty text, allowing you to type immediately.
- **Enter**: 
  - When **not in edit mode**: Creates a new sibling node
  - When **in edit mode**: Ends edit mode and saves the node (node remains selected and focused)
  - During **Japanese kanji input**: Commits the character (normal behavior)
- **Shift+Enter**: Creates a new line within the node text while editing (useful for multi-line labels)
- **Escape**: Cancels edit mode and reverts to the previous text

## Features

1. edit node
2. drag node to another node
3. undo/redo
4. toggle between mindmap and markdown views  
5. synchronize data between boards
...

![test (2)](https://user-images.githubusercontent.com/18719494/124458786-fd1d9b00-ddbf-11eb-8dbc-eeefb5b7abf5.gif)

## Installation

### Quick Install (Recommended)

For developers or users building from source, use the provided installation script:

1. Clone this repository or download the source code
2. Build the plugin: `npm install && npm run build`
3. Run the installation script: `./install.sh`
4. Enter your Obsidian vault path when prompted
5. The script will remember your vault path for future installations
6. Reload Obsidian and enable the plugin in Settings > Community plugins

**Note:** The install script automatically:
- Builds the plugin if `main.js` is missing
- Creates necessary directories if they don't exist
- Remembers your last vault path for convenience

### Manual installation
1. Download the latest release
2. Extract the obsidian-enhancing-mindmap folder from the zip to your vault's plugins folder: <vault>/.obsidian/plugins/
3. Note: On some machines the .obsidian folder may be hidden. On MacOS you should be able to press Command+Shift+Dot to show the folder in Finder.
4. Reload Obsidian
5. If prompted about Safe Mode, you can disable safe mode and enable the plugin.


## Plans 
1. more theme
2. more mind map layouts
3. save to image/opml
4. imports opml/xmind

## For developers
Pull requests are both welcome and appreciated. 😀

## Donating
https://www.buymeacoffee.com/markmind  
<a href="https://www.buymeacoffee.com/markmind"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=markmind&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff"></a>



