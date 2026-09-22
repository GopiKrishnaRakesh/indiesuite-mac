# Pathway — a Windows-style file manager for macOS

Native SwiftUI, no sandbox, no dependencies. Explorer's workflow, Mac's look.

## Build & run
```bash
./build.sh                      # xcodegen + xcodebuild → Build/Build/Products/Release/Pathway.app
open Build/Build/Products/Release/Pathway.app --args -startPath ~/Downloads   # optional start folder
```
Press ⌘/ in the app for the full shortcut cheat-sheet (Windows key → Pathway key).

## Features
- **Sidebar**: Quick access (pinned, drag-to-pin, reorderable), This Mac (volumes with free-space bars, eject), Trash, Recent, lazy folder tree
- **Address bar**: clickable breadcrumbs; click / ⌘L / F4 to type a path (`~` works); star pins the folder
- **Windows keys**: Backspace = back · Alt+←/→/↑ · Enter = open · F2 inline rename · Delete = Trash · Shift+Delete = permanent (confirmed) · F5 · F3 search · Alt+Enter Properties · type-to-select
- **Clipboard**: Cut/Copy/Paste (cut = move, shared with Finder), Duplicate, Compress/Extract zip, Copy Path, multi-level Undo
- **Views**: Details (sortable columns), Icons, Tiles, size slider, hidden files toggle, folders-on-top
- **Search**: live filter, or recursive "Subfolders" scope
- **Properties**: size (recursive for folders), size on disk, dates, owner, hidden flag, editable POSIX permissions
- **Preview pane** (⌥⌘P) with Quick Look; Space opens the Quick Look panel
- Drag & drop between windows, sidebar and Finder (⌥ to force copy); Open With; Open in Terminal

## Notes
- Not sandboxed so it can browse the whole disk. macOS asks once per protected folder (Desktop, Documents, Downloads…); grant Full Disk Access in System Settings to browse everything without prompts.
- Signed ad-hoc for local builds; for distribution sign with Developer ID and notarize (same `package.sh` flow as the other Mac apps).
