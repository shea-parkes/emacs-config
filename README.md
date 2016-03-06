## Background

I'm drawn to emacs due to its lightweight nature, and good Python REPL integration.  It also appears that there is still a robust package development community, with 1-2 active implementations of each of the important add-ons (e.g. linters, code completers).  I work dominantly on Windows, but the majority of the emacs ecosystem seems to support that just fine.  I anticipate using emacs mostly for python development in the immediate future, so much of this repository will be focused on that.

## This Repo

This repo will contain my configuration files, notes to remind myself about how to setup a new system, and main keyboard shortcuts I intend to learn.

### Configuration Files

I'm currently just going to aim for a monolithic `~/.emacs` file at this time.  I don't generally like to deviate from the defaults on most packages too much, so hopefully it stays manageable.

### Setting up a new rig

I'm currently planning on using the 64-bit windows builds available on sourceforge, but I am quite leary of that host.  They're basically "portable" apps, so they can be tossed anywhere and optionally added to the `%PATH%`.

`emacs.exe` is the main emacs executable, but you would generally use `runemacs.exe` to launch it so it will release any ~console used to launch it.

Emacs looks into `%Home%` instead of `%UserProfile%` for `~/.emacs`, so be sure to setup `%Home%` (not generally done by default on Windows).

It's probably too awkward to directly check this repository out into my `%UserProfile%`, so I'll likely just hack-ily copy the `.emacs` over as needed.

For now, I'll leave commented-out `package-install` calls littered in `.emacs`.  The idea would be to skim `.emacs` during each system setup to refresh myself on my customizations and install each package manually.  A nice enhancement might be to implement the light-weight state function offered by Yusuke Tsutsumi [here](http://y.tsutsumi.io/emacs-from-scratch-part-1-extending-emacs-basics.html).  [el-get](https://github.com/dimitri/el-get) is another possible option, but it claims to play only so-so with Windows.

#### Windows Explorer Context Menu Integration

I largely followed the breadcrumbs in these links:
  * [Emacsclient launch options](https://www.gnu.org/software/emacs/manual/html_node/emacs/emacsclient-Options.html)
  * [Add Anything to Explorer Context Menu](http://www.howtogeek.com/107965/how-to-add-any-application-shortcut-to-windows-explorers-context-menu/)
  * [Open file in existing Emacs on Windows](http://stackoverflow.com/questions/15606188/open-file-in-existing-emacs-frame-windows)

The two challenges are:
  * Adding an Emacs entry to the registry (not that hard)
  * Ensuring new files are opened in existing Emacs instances (kind of tricky)

Succinctly:
  * Use a code snippet at the top of `.emacs` to ensure the Emacs server is running (already present in this `.emacs`)
  * Make `%ALTERNATE_EDITOR%` and point it to `runemacs.exe` (or always pass `--alternate-editor` to `emacsclientw.exe`)
    * *This is what executes if a server is not already running.*
  * Make `%EMACS_SERVER_FILE%` and point it to `~\emacs.d\server\server` (This file will only exist while an Emacs server is running) (or always pass `--server-file` to `emacsclientw.exe`)
    * *This is the breadcrumb file Emacs uses to determine if a server is running (and how to connect to said server).*
  * Make appropriate registry entries (mostly calling `emacsclientw.exe -n %1`, or a pass-thru batch script that sets up the environment first)

The server should still nicely shut down when the client is closed.  However, sometimes this will go haywire and the server indicator file (`~\emacs.d\server\server`) will be left behind after the server dies.  If that happens, subsequent launches will complain about failing to make a connection.  Just go and delete the server indicator file manually and the problem should go away.

#### Git Integration

`Magit` is a very nice package that mostly will handle all the git integration.  However, it does need/benefit from the following:
  * Be sure that `git` is on `%PATH%`
  * Some run-time munging of ~`.gitconfig` (that is already embedded in this `.emacs`)
  * Setting `core.editor = emacsclient` to allow Emacs integration with command line `git` usage
    * Still only works if an emacs server is already running (see above)
	* `magit` takes over the commit message editing (i.e. `C-c C-c` / `C-c C-k` work like below)

#### Assisting Python environment

This configuration depends upon having a helpful python environment at the front of your `%PATH%` when launching emacs.  This environment should contain any code introspection tools used in packages below (e.g. `pylint` and `jedi`).  `jedi` in particular would likely benefit from this python environment being very similar to the environment you would actually execute code in (i.e. contain packages such as `sqlalchemy` if you're going to use them in your code).  `emacs-jedi` also wants the `epc` package installed in this environment.

Be sure to also include the `/Scripts` folder of the environment in your `%PATH%` (most tools like `conda` would already do this).

### Package-specific setup steps

Most package specific notes are directly in the `.emacs` file to keep the configuration and documentation cognitively close together.

### Profiling startup

Periodic profiling can be helpful.  The Emacs Start Up Profiler package is very useful for this.  The majority of time spent on startup on the current config is to load `magit`.  I consider this worth the pain.  A lesser burden is `ESS`.  Other packages are largely negligible.

### Fringe vs Margin

Emacs has two "gutter" areas. The `fringe` is the inner one and the `margin` is the outer one.  Various packages/modes try to take advantage of these areas, but in general only one can use a given area at once.  I try to note which package/mode is using which area in notes in the config file.

### Usage of Helm

[Helm](https://github.com/emacs-helm/helm) can be quite a pervasive package.  I'm currently trying it out and have most of its functionality enabled.  This basically means a chunk of the info below is at least a bit off due to helm taking over things.  In particular, I currently have helm over-riding `iSearch` and taking the place of `IDO` everywhere.  In most cases, helm is taking over and providing a similar functionality.  If that is ever not the case I will try to document below.

### Keyboard Shortcuts

I'm mostly typing these out as a memory exercise.  I'll lead with the handful of custom ones and then only toss on the standard ones I want to remind myself of.

| Shortcut | ~Mode | Description |
| :------- | :---- | :---------- |
| `M-o` | *windows* | Custom binding to `other-window` to allow faster window-cycling.  (Default is `C-x o` as documented below.) |
| `mouse-3` | `imenu` | Give a nice in-place code-navigation menu. |
| `C-x o` | `open-with` | Open current file with associated external file. |
| `<ESC>` / `C-z` / `i` | `god-mode` | Enter/exit god-mode (to save my pinkies). |
| `C->`/`C-<` | `multiple-cursors` | Add another cursor at the next/previous: {matching region if a selection is active; row if a selection is not active} |
| `C-;` | `iedit-mode` | Enter/exit iedit mode. |
| `M-0 C-;` | `iedit-mode` | Enter iedit mode, but only within the current defun. |
| `C-'` | `iedit-mode` | While in iedit-mode, limit display to matched lines. (Toggle) |
| `Tab` / `Shift-Tab` | `iedit-mode` | Cycle through the matching selections. |
| `C-=` / `M-- C-=` | `expand-region` | Iteratively expand/contract active region to word/section/function/etc. |
| `C-'` / `C-"` | `avy` | Start avy jump process on word/2-chars.  (Works in iSearch as well.) |
| `C-x C-h` | `helm` | Custom mapping for general helm prefix.  Not really needed since I've given most entry points their own binding. |
| `C-x p` | `helm-ls-git` | Open up a project view (only works when visiting a buffer tied to a git repository). |
| `C-s` | `helm-ls-git` | Grep a project (only from the project helm menu, and only if not on a buffer listing). |
| `C-x C-d` | `helm-ls-git` | Open a `helm-ls-git` buffer from another helm buffer (e.g. `helm-find-file` buffer). |
| `C-o` | `helm` | Cycle through option sections (e.g. `{buffers, recentf}` in `helm-mini`). |
| `C-c o` | `helm` | Open current item in other window. |
| `M-y` | `helm` | Open up a helm view of the kill-ring. |
| `C-x <SPC>` | `helm` | Open up a helm view of the mark-ring. |
| `C-c h` | `helm` | Return to the last helm buffer. |
| `M-/` | `dabbrev` | Do dumb-style completion by just looking through open buffer. |
| `<C-tab>` | `jedi-mode` | Force auto-completion to trigger. (Does a pretty good job on its own, this is just the hammer.) |
| `C-c .`/`C-c ,` | `jedi` | Go-to (come back from) definition of current name. |
| `C-c g` | `git-gutter` | Force refresh of git-gutter markings (will currently get confused in non-saved state.) |
| `C-x g` | `magit` | Spawn the root magit buffer that deals with the repository. |
| `C-x M-g` | `magit` | Spawn the main magit dispatch menu. (Would normally come here from menu above via `?` if desired). |
| `C-c M-g` | `magit` | Spawn magit menu for **this file**. (Nice for `blame` or contextual `log`.) |
| `C-c C-c` / `C-c C-k` | `magit` | Finish (/cancel) a commit message. |
| `M-n`/`M-p` | `contextual` | Very dynamic shortcuts.  Cycles `M-x` history, `jedi` completion options and many more. |
| `C-SPC C-SPC` / `C-u C-SPC` | *marks* | Push a mark onto the `mark-ring` (without starting a region) / traverse backwards through the `mark-ring`. |
| `C-s` / `C-r` | `ido-mode` | Cycle to the next / previous entry in an IDO list. |
| `C-j` | `ido-mode` | Force evaluation of current text literal (i.e. do not use the first completion suggestion).  Useful to enter `dired` mode. |
| `C-M-x` | `prog-mode` | Execute the current `defun` |
| `M-;` | `prog-mode` | Add/remove comments (DWIM style). |
| `C-c C-z` | `python-mode` | Switch to Python interpreter (prompt to launch if needed). |
| `C-c C-r` | `python-mode` | Send region to Python interpreter. |
| `C-c C-c` | `python-mode` | Send buffer to Python interpreter (automatically excludes `if __name__ == '__main__':` sections.) |
| `C-M-h` | `python-mode` | Select the `defun` |
| `C-M-a`/`C-M-e` | `python-mode` | Move to the beginning/end of the `defun` |
| `C-c d` | `python-mode` | Search the official Python 3 documentation. |
| `C-M-h`/`C-M-k` | `prog-mode` | Select / kill the current `defun`. |
| `C-M-i` | `prog-mode` | Generic "completion" shortcut.  Doesn't do that much really.  Jedi has custom shortcut above. |
| `M-!` / `M-&` | *shells* | Run a single system command (/asynchronously) |
| `M-x shell` / `M-x eshell` | *shells* | Run a system shell (/elisp-faked-bash shell). |
| `ls > #<buffer my_buf>` | *shells* | Redirect StdOut to a new buffer (`eshell` only). |
| `C-y` / `M-y` | *kill/yank* | "Paste" from the kill ring (i.e. "clipboard"); then cycle through the kill ring with subsequent calls to `M-y`. |
| `C-w`/`M-w` | *kill/yank* | "Cut" or "Copy" the selected region. |
| `C-k` | *kill/yank* | Kill to the end of the line. |
| `M-f`/`M-b`/`M-d`/`M-DEL` | *kill/yank* | Move/kill by word. |
| `M-up` / `M-down` | `drag-stuff` | Move a line/region up/down. |
| `M-left` / `M-right` | `drag-stuff` | Move a word left/right. |
| `M-=` | *region* | Count characters in the current region. |
| `M-g g` | *cursor* | Goto a specific line. |
| `M-r` | *cursor* | Cycle cursor between top/middle/bottom of active buffer. |
| `mouse-2` | *flyspell* | Show suggested words (note: this is a middle click) |
| `M-%` | *replace* | Go into a find/replace dialogue.  Can then do `y`/`n`/`!` to replace one/skip one/replace all.  Other keys available. |
| `M-l` / `M-u` / `M-c` | *case conversion* | Convert the next word to lower-/upper-/proper- case. |
| `C-x C-l` / `C-x C-u` | *case conversion* | Convert the region to lower-/upper- case. |
| `<F11>` | *frames* | Go totally full screen. |
| `C-x 1` | *windows* | Destroy all windows but the current one. |
| `C-x 4 0` | *windows* | Destroys the current window and kills the associated buffer. |
| `C-x 0` | *windows* | Destroy the current window. |
| `C-x o` | *windows* | Switch the active cursor to the next window. |
| `C-x 4 f` | *windows* | Opens a file in other window. |
| `C-x 4 b` | *windows* | Opens a buffer in other window. |
| `C-x 4 d` | *windows* | Run `Dired` in other window. |
| `C-x 3` | *windows* | Split the current window down the middle. |
| `C-M-v` | *windows* | Scroll the other window. |
| `C-x k` | *buffers* | Kill a buffer. |
| `C-x C-v` | *buffers* | Kills the current buffer **and** visits a new file. |
| `C-x b` | *buffers* | Switch buffers (by name or just last). |
| `C-x LEFT` / `C-x RIGHT` | *buffers* | Cycle the buffer shown in the current window. |
| `M-x revert-buffer` | *buffers* | Reloads the associated file from disk. |
| `C-x C-b` | *buffers* | Open up buffer of buffers. |
| `s` / `d` / `x` | *buffers-list* | Mark a buffer for later saving/deleting. Then execute out marks. |
| `M-x insert-char` | *inserting* | Insert a unicode character by name or code. |
