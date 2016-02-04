;;; myinit --- My custom init file
;;; Commentary:
;;;   See accompanying GitHub repository for more specifics
;;;   Depends upon a assisting python environment being in the %PATH%.
;;;      One with introspection tools such as `pylint` and `jedi`.
;;; Code:

;; Remove tempations to utilize the GUI
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Activate the bundled `ido` mode
;;   Haven't gone to the external `flx-ido` implementation yet
(require 'ido)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Setup where to pull third party packages from
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://stable.melpa.org/packages/") t)
(package-initialize)


;; M-x package-install RET zenburn RET
(load-theme 'zenburn t)


;; M-x package-install RET flycheck RET
;; Flycheck uses the fringe
;; Needs `pylint` on your %PATH%
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)


;; M-x package-install RET jedi RET
;; Jedi drags along the maligned `auto-complete` package
;;   Could install an additional package to integrate with `company`, but didn't seem to be worth it
;; When `jedi:setup` is called, it must execute the bundled `jediepcserver.py`
;;   in a python environment that has `jedi` and `epc` python packages.
;; Jedi offers to setup such an environment, but that then depends upon `virtualenv` as opposed to `conda`.
;; To bypass this mess, manually point `jedi:server-command` to a fresh copy of jediepcserver.py
(require 'jedi)
(setq jedi:server-command '("python" "c:/users/USERNAME/.emacs.d/jediepcserver.py"))
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)


;; M-x package-install RET git-gutter RET
;; Git-gutter uses the margin by default
;; Needs `git` and `diff` on your %PATH%
;;   `diff` is often provided in the `/usr/bin` folder of a git-for-windows MinGW system
(require 'git-gutter)
(global-git-gutter-mode +1)
;; Needs to be told to do live diffs
(custom-set-variables
 '(git-gutter:update-interval 2))


;; M-x package-install RET markdown-mode RET
;; TODO: Configure pandoc for live preview mode via `markdown-command`
(require 'markdown-mode)
