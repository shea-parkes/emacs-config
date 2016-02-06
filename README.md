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

#### Assisting Python environment

This configuration depends upon having a helpful python environment at the front of your `%PATH%` when launching emacs.  This environment should contain any code introspection tools used in packages below (e.g. `pylint` and `jedi`).  `jedi` in particular would likely benefit from this python environment being very similar to the environment you would actually execute code in (i.e. contain packages such as `sqlalchemy` if you're going to use them in your code).  `emacs-jedi` also wants the `epc` package installed in this environment.

Be sure to also include the `/Scripts` folder of the environment in your `%PATH%` (most tools like `conda` would already do this).

### Package-specific setup steps

Most package specific notes are directly in the `.emacs` file to keep the configuration and documentation cognitively close together.

### Fringe vs Margin

Emacs has two "gutter" areas. The `fringe` is the inner one and the `margin` is the outer one.  Various packages/modes try to take advantage of these areas, but in general only one can use a given area at once.  I try to note which package/mode is using which area in notes in the config file.

### Keyboard Shortcuts

I'm mostly typing these out as a memory exercise.  I'll lead with the handful of custom ones and then only toss on the standard ones I want to remind myself of.

| Shortcut | ~Mode | Description |
| :------- | :---- | :---------- |
| `C->`/`C-<` | `multiple-cursors` | Add another cursor at the next/previous: {matching region if a selection is active; row if a selection is not active} |
| `<C-tab>` | `jedi-mode` | Force auto-completion to trigger. (Does a pretty good job on its own, this is just the hammer.) |
| `M-n`/`M-p` | `contextual` | Very dynamic shortcuts.  Cycles `M-x` history, `jedi` completion options and many more. |
| `C-j` | `ido-mode` | Force evaluation of current text literal (i.e. do not use the first completion suggestion).  Useful to enter `dired` mode. |
| `C-y` | *kill/yank* | "Paste" from the kill ring (i.e. "clipboard"). |
| `M-y` | *kill/yank* | Only effective immediately after `C-y`.  Cycles through the kill ring (i.e. "clipboard") |
| `C-w`/`M-w` | *kill/yank* | "Cut" or "Copy" the selected region. |
| `C-k` | *kill/yank* | Kill to the end of the line. |
| `C-x 1` | *windows* | Destroy all windows but the current one. |
| `C-x 0` | *windows* | Destroy the current window. |
| `C-x 3` | *windows* | Split the current window down the middle. |
| `C-x o` | *windows* | Switch the active cursor to the next window. |
| `C-x k` | *buffers* | Kill a buffer. |
| `C-x b` | *buffers* | Switch buffers. |
| `C-x C-b` | *buffers* | Open up buffer of buffers. |
