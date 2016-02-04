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

This configuration depends upon having a helpful python environment at the front of your `%PATH%` when launching emacs.  This environment should contain any code introspection tools used in packages below (e.g. `pylint` and `jedi`).  `jedi` in particular would likely benefit from this python environment being very similar to the environment you would actually execute code in (i.e. contain packages such as `sqlalchemy` if you're going to use them in your code).  `emacs-jedi` would also likely want the `epc` package installed in this environment.

Be sure to also include the `/Scripts` folder of the environment in your `%PATH%` (most tools like `conda` would already do this).

### Package-specific setup steps

Most package specific notes are directly in the `.emacs` file to keep the configuration and documentation cognitively close together.
