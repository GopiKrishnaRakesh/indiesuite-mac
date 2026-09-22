# Pathway — a Windows-style file manager for macOS

Native SwiftUI, no sandbox, no dependencies. Explorer's workflow, Mac's look.

## Installing on another Mac

Grab `Pathway-<version>.dmg` from `dist/` (built by `package.sh` — see below), then:

1. Double-click the `.dmg` to mount it. It's Developer ID–signed and notarized, so macOS opens it
   with **no** "unidentified developer" warning.
2. Drag **Pathway** onto the **Applications** shortcut shown in the same window.
3. Eject the mounted disk image (the one still in the sidebar/Finder — not the folder inside `/Applications`).
4. Launch Pathway from `/Applications` or Spotlight. First launch, macOS may still show its
   ordinary "Pathway.app is an app downloaded from the Internet — are you sure you want to open
   it?" dialog once — that's the normal Gatekeeper quarantine check for any downloaded app, not a
   sign of a problem; click **Open**.

That's it — no installer, no separate runtime to install. The app is a universal binary (Apple
Silicon + Intel), so this works the same on any Mac from either family.

## Permissions — what the prompts are and how to skip them

Pathway isn't sandboxed, so it can browse anywhere on disk — but macOS itself still gates access to
a handful of specific locations (Desktop, Documents, Downloads, external/removable drives, network
volumes) behind a one-time consent dialog per location, the first time *any* non-Apple app tries to
read them. This is enforced by macOS (it's the same mechanism behind every third-party file manager,
backup tool, and sync client), not something Pathway asks for or can bypass on its own — no app can
silently grant itself blanket file access. Click **Allow** the first time you navigate into each of
those folders, and macOS won't ask again for that folder.

**To skip all of those prompts at once, grant Full Disk Access instead — one dialog, covers every
folder, permanently:**
1. Open **System Settings → Privacy & Security → Full Disk Access**
2. Click **+**, navigate to `/Applications/Pathway.app`, and add it
3. Turn the toggle **on** next to Pathway (if it was already added but the app was rebuilt/replaced,
   toggle it off and back on once)
4. Restart Pathway if it was already running

With Full Disk Access on, Pathway won't prompt for *any* individual folder again.

## Build & run
```bash
./build.sh                      # fast local dev loop: xcodegen + xcodebuild (ad-hoc signed, this Mac's arch only)
open Build/Build/Products/Release/Pathway.app --args -startPath ~/Downloads   # optional start folder

./package.sh                    # the real distribution build: universal binary, Developer ID signed,
                                 # notarized (if credentials are set up — see below), packaged as
                                 # dist/Pathway-<version>.dmg
```
Press ⌘/ in the app for the full shortcut cheat-sheet (Windows key → Pathway key).

## Features
- **Sidebar**: Quick access (pinned, drag-to-pin, reorderable), This Mac (volumes with free-space bars; right-click for Eject/Rename/Format/Get Info/Remove from Sidebar), Trash, Recent, lazy folder tree — right-click any item for Open/Reveal/Copy Path/Properties
- **Address bar**: clickable breadcrumbs; click / ⌘L / F4 to type a path (`~` works); star pins the folder
- **Windows keys**: Backspace = back · Alt+←/→/↑ · Enter = open · F2 inline rename · Delete = Trash · Shift+Delete = permanent (confirmed) · F5 · F3 search · Alt+Enter Properties · type-to-select
- **Clipboard**: Cut/Copy/Paste (cut = move, shared with Finder), Duplicate, Compress/Extract zip, Copy Path, multi-level Undo
- **Views**: Details (sortable columns), Icons, Tiles with real content thumbnails for images/PDFs/movies, size slider, hidden files toggle, folders-on-top
- **Search**: live filter, or recursive "Subfolders" scope
- **Properties**: size (recursive for folders), size on disk, dates, owner, hidden flag, editable POSIX permissions; volumes get a fast capacity/available/format view instead of a full-drive scan
- **Preview pane** (⌥⌘P) with Quick Look; Space opens the Quick Look panel; arrow keys cycle through the whole folder, Finder-style
- Drag & drop between windows, sidebar and Finder (⌥ to force copy); Open With; Open in Terminal

## Notes
- Not sandboxed so it can browse the whole disk — see **Permissions** above for what that means for first-launch prompts.
- `package.sh` signs with a real Developer ID certificate, builds a universal binary, and notarizes (given stored credentials) — see **Build & run** above. `build.sh` (ad-hoc signed, this Mac's own architecture only) is for local iteration, not for handing to anyone else.
