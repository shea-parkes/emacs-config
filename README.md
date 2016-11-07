## Background

I'm drawn to emacs due to its lightweight nature, and good Python REPL integration.  I originally rolled my own emacs; you can read about that adventure in the [depreciated readme](README_HomeGrown.md).  I have since shifted to building on top of [Spacemacs](http://spacemacs.org).  It provides an excellent base that is always up to date and easy to extend.

## This Repo

This repo will contain my configuration files, notes to remind myself about how to setup a new system, and any customizations I have layered onto Spacemacs.

### Configuration Files

I'm closely following the Spacemacs documentation; my main configuration file is named `init.el` with the intention of cloning this repo into a `~/.spacemacs.d` folder.

### Setting up a new rig

#### [Chocolatey](https://chocolatey.org/)

I'm currently using [Chocolatey](https://chocolatey.org/) to handle installing emacs and some optional dependencies.  It does require admin rights, so if you don't have those available consider `MSYS2` below, or chase down the Chocolatey sources (most of the packages below are "portable").  The following Chocolatey packages will provide a reasonable emacs environment:
  - `emacs64`
  - `hunspell.portable`
  - `pt`
  - `pandoc --ia=ALLUSERS=1` (*option required to land on PATH for all users*)
  - `sourcecodepro` (*will always require admin rights*)
  - `git -params '"/GitAndUnixToolsOnPath"'` (*if not handled elsewhere*)

Other useful packages:
  - `putty.portable`
  -  `rapidee`

#### [MSYS2](http://msys2.github.io/)

As an alternative to Chocolatey, there is the very nice [msys2](http://msys2.github.io/) project.  In fact, most of the Chocolatey packages above are built with `MSYS2` itself.  However, `MSYS2` binary packages aren't updated very often (so you'll have to compile them yourself) and you can't really snag an older version of a package.  A few other things to remember:
  - We want to install the `mingw` versions of components if possible; this way they work better in a standard ~`cmd.exe`.
  - Even though we want the `mingw` versions, it's advised to run `pacman` from the `MSYS2 MSYS` environment.
  - The pre-compiled packages are not always available (or updated), so sometimes you have to build them yourself from the recipes in the main [MINGW-Packages repository](https://github.com/Alexpux/MINGW-packages).
  - The following folders then need added to `%PATH%`:
    - `C:\msys64\mingw\bin`
    - `C:\msys64\usr\bin`

On a new machine, I would generally recommend installing the following packages:
  - `git` (*if needed*)
  - `mingw-w64-x86_64-tk` (*for gitk*)
  - `mingw-w64-x86_64-emacs`
  - `mingw-w64-x86_64-ag`
  - `mingw-w64-x86_64-hunspell`
  - `mingw-w64-x86_64-hunspell-en`

#### Other Misc (e.g. Environmental Variables)

`emacs.exe` is the main emacs executable, but you would generally use `runemacs.exe` to launch it so it will release any ~console used to launch it.

Emacs looks into `%Home%` instead of `%UserProfile%` for `~/.emacs`, so be sure to setup `%Home%` (not generally done by default on Windows).

Follow the standard instructions for installing Spacemacs (just clone it into `~/.emacs.d`).  Then clone this repo into `~/.spacemacs.d`.

#### Windows Explorer Context Menu Integration

I largely followed the breadcrumbs in these links:
  * [Emacsclient launch options](https://www.gnu.org/software/emacs/manual/html_node/emacs/emacsclient-Options.html)
  * [Add Anything to Explorer Context Menu](http://www.howtogeek.com/107965/how-to-add-any-application-shortcut-to-windows-explorers-context-menu/)
  * [Open file in existing Emacs on Windows](http://stackoverflow.com/questions/15606188/open-file-in-existing-emacs-frame-windows)

The two challenges are:
  * Adding an Emacs entry to the registry (not that hard)
  * Ensuring new files are opened in existing Emacs instances (kind of tricky)

Succinctly:
  * Use a code snippet at the top of `.emacs` to ensure the Emacs server is running (already handled by Spacemacs)
  * Make `%ALTERNATE_EDITOR%` and point it to `runemacs.exe` (or always pass `--alternate-editor` to `emacsclientw.exe`)
    * *This is what executes if a server is not already running.*
  * Make `%EMACS_SERVER_FILE%` and point it to `~\emacs.d\server\server` (This file will only exist while an Emacs server is running) (or always pass `--server-file` to `emacsclientw.exe`)
    * *This is the breadcrumb file Emacs uses to determine if a server is running (and how to connect to said server).*
  * Make appropriate registry entries (mostly calling `emacsclientw.exe -n %1`, or a pass-thru batch script that sets up the environment first)

The server should still nicely shut down when the client is closed.  However, sometimes this will go haywire and the server indicator file (`~\emacs.d\server\server`) will be left behind after the server dies.  If that happens, subsequent launches will complain about failing to make a connection.  Just go and delete the server indicator file manually and the problem should go away.

#### Git Integration

`Magit` is a very nice package that mostly will handle all the git integration.  However, it does need/benefit from the following:
  * Be sure that `git` is on `%PATH%`
  * Some run-time munging of ~`.gitconfig` (that is already embedded in this `init.el`)
  * Setting `core.editor = emacsclient` to allow Emacs integration with command line `git` usage
    * Still only works if an emacs server is already running (see above)
	* `magit` takes over the commit message editing (i.e. `C-c C-c` / `C-c C-k` work like below)
    * I've since done the sacrilige of just setting `core.editor = vim` so I don't have to leave the command line (terminal emacs is not impressive on Windows)

#### Assisting Python environment

This configuration depends upon having a helpful python environment at the front of your `%PATH%` when launching emacs.  This environment should contain any code introspection tools used in packages below (e.g. `pylint` and `jedi`).  `jedi` in particular would likely benefit from this python environment being very similar to the environment you would actually execute code in (i.e. contain packages such as `sqlalchemy` if you're going to use them in your code).  `emacs-jedi` also wants the `epc` package installed in this environment.  The Emacs anaconda package (not to be confused with the Anaconda python distribution) also wants a couple other packages installed; read its current documentation at the time of install.

Be sure to also include the `/Scripts` folder of the environment in your `%PATH%` (most tools like `conda` would already do this).

### Profiling startup

Spacemacs does a great job of doing as much lazy loading as possible.  As long as your customizations follow the best practices they outline, you will likely continue to have a snappy Emacs.  However, the Emacs Start Up Profiler package can be useful to profile your startup if needed.

### Fringe vs Margin

Emacs has two "gutter" areas. The `fringe` is the inner one and the `margin` is the outer one.  Various packages/modes try to take advantage of these areas, but in general only one can use a given area at once.  Spacemacs does a good job of managing any conflicts that arise.

### Keyboard Shortcuts

I'm mostly typing these out as a memory exercise.  I'll lead with the handful of custom ones and then only toss on the standard ones I want to remind myself of.  Overall, I have a lot less customizations now that I start from Spacemacs (which was one of the reasons I changed over to it).

| Shortcut | ~Mode | Description |
| :------- | :---- | :---------- |
| `SPC m S` | `python-mode` | Search the official Python 3 documentation. |
| `C-c o` | `helm` | Open current item in other window. |
| `C-c C-f` | `helm` | Enable follow-mode. |
| `C-c C-c` / `C-c C-k` | `magit` | Finish (/cancel) a commit message. |
| `SPC S c` | `flyspell` | Show spell correction candidates. |
| `M-!` / `M-&` | *shells* | Run a single system command (/asynchronously) |
| `M-x shell` / `M-x eshell` | *shells* | Run a system shell (/elisp-faked-bash shell). |
| `ls > #<buffer my_buf>` | *shells* | Redirect StdOut to a new buffer (`eshell` only). |
| `SPC T F` | *frames* | Go totally full screen. |
| `s` / `d` / `x` | *buffers-list* | Mark a buffer for later saving/deleting. Then execute out marks. |
| `C-f` / `C-b` | `vim` | Scroll by ~half pages. |
| `SPC x J` / `SPC x K` | `spacemacs` | Move line(s). |
| `SPC s e` | `iedit` | Enter special iedit mode. (Or `e` from `expand-region`) |
| `TAB` | `iedit` | Toggle current occurence. |
| `F` | `iedit` | Restrict scope to the function. |
| `V` | `iedit` | Toggle visibility to just matches. |
| `n` `N` | `iedit` | Move between matches. |
| `SPC v` | `expand-region` | Enter into `expand-region` mode. |
| `SPC a u` | `undo-tree` | Visualize the undo tree. |

And some brief vim-centric reminders:
  - Word movements: `w` `W` `e` `E` `b` `B` `ge` `gE`
  - ~Single-character commands: `x` `r`
  - While in Insert mode, `C-o` lets you do a single Normal mode command
  - Also in Insert mode, `C-w` will delete a word and `C-r` will paste (need to tell it which register)
  - `.` - Repeat last command; highly useful
  - `""` is the default register.  `"+` is the system clipboard. `"0` is the last yank.
    - Prefix commands (e.g. yank/paste) to manually specify a registry.
  - `SPC n +`/`SPC n -` to increment/decrement a number (Vim uses `C-a` `C-x`)
  - Set a mark with an `m` prefix.  Jump to it with a back-tick prefix.
    - Capital letter marks are "global" across buffers.
    - Back-tick + period jumps to last edit.  Double back-tick jumps "back" (~undoes a jump).
  - Use `%` to jump between enclosure ends

| Key | Vim Operator |
| :-- | :----------- |
| `c` | Change |
| `d` | Delete (cut) |
| `y` | Yank (copy) |
| `gu` | Lowercase |
| `gU` | Uppercase |
| `<` `>` | (Un-) Indent |
| `SPC ;` | Comment (Not Vim) |
| `ys` | Add enclosure (Not Vim) |
| `gx` | Swap on 2nd (Not Vim) |

And text objects (my personal favorites).  To be used with `a` or `i` after an operator.  Spacemacs (and `vim-surround`) also provide `s` (`S`) to just operate on the surrounding tidbits; inserting closing form (e.g. `)`) will not pad whitespace, while opening form (e.g. `(`) will. If you are not ~inside a given text object, the action will operate on the next corresponding object on the line (for most objects).

| Key | Base Vim | Text Object |
| :-- | :------- | :---------- |
| `w` | `True` | A word. |
| `s` | `True` | A sentence. |
| `p` | `True` | A paragraph. |
| `(` `[` etc | `True` | Grab based on enclosing characters. |
| `'` `"` etc | `True` | String literals. |
| `t` | `True` | HTML tags. |
| `i` | `False` | Indentation block. |
| `I` | `False` | Indentation block plus line above. |
| `J` | `False` | Indentation block plus line above and below. |
| `a` | `False` | Function argument. |

Search mess:
  - *Inline*: `f` `F` `t` `T` `;` `,` (Spacemacs alters `,` to be major-mode leader key)
  - *Everywhere*: `/` `?` `n` `N`
  - *Current Word*: `*` `#` (Can then jump to `iedit`)
  - *Replace*: `:%s/old/new/g` to actually hit all occurrences on all lines.  Can add `c` suffix to interactively confirm each hit.

Visual mode mess:
  - The goal is largely to avoid this with text objects (saves time and is semantically cleaner)
  - Can be useful to learn the motions and text objects however (visualize what you think you're going to act on)
  - Once in visual mode can use motions or text objects to make selections, then operator to make effect.

| Key | Effect |
| :-- | :----- |
| `v` | Enter visual mode. |
| `V` | Enter visual line mode. |
| `C-v` | Enter visual block mode. |
| `o` | Jump cursor to other end of selection. |
| `I`/`A` | Insert before/after the selection(s). |
