;;; myinit --- My custom init file
;;; Commentary:
;;;   See accompanying GitHub repository for more specifics
;;;   Depends upon a assisting python environment being in the %PATH%.
;;;      One with introspection tools such as `pylint` and `jedi`.
;;; Code:

;; Remove tempations to utilize the GUI
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Use a more sane cursor type
(setq-default cursor-type 'bar)

;; React normally when typing with a region active
(delete-selection-mode 1)

;; Place a nice code-navigation menu under a right-click menu
(global-set-key [mouse-3] 'imenu)

;; Consider dashes and underscores part of a word in prog-mode
(add-hook 'prog-mode-hook #'superword-mode)

;; Insert matching parens like a real editor
(add-hook 'prog-mode-hook #'electric-pair-mode)
;; And highlight the matching parens
(add-hook 'prog-mode-hook #'show-paren-mode)

;; Activate the bundled `ido` mode
;;   Haven't gone to the external `flx-ido` implementation yet
(require 'ido)
(setq ido-enable-flex-matching t)
(ido-mode t)

;; Activate visible whitespace for code files
(add-hook 'prog-mode-hook #'whitespace-mode)
;; Be refined in what we flag.  Just the bad stuff and then tabs/spaces via marks
(setq whitespace-style (quote
   (face trailing lines space-mark tab-mark)))
;; Kill trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; Adjust when to flag a line as too-long via font
(setq whitespace-line-column 100)

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


;; M-x package-install RET git-gutter RET
;; Git-gutter uses the margin by default
;; Needs `git` and `diff` on your %PATH%
;; `diff` is often provided in the `/usr/bin` folder of a git-for-windows MinGW system
(require 'git-gutter)
(global-git-gutter-mode +1)
;; Needs to be told to do live diffs
(custom-set-variables
 '(git-gutter:update-interval 2))
;; Give a keybinding to force refresh (it gets confused)
(global-set-key (kbd "C-c g") 'git-gutter)


;; Possible alternative to git-gutter, it's a mixed bag
;; M-x package-install RET diff-hl RET
;; (require 'diff-hl)
;; TODO: Confirm if diff-hl needs `diff` in the %PATH%
;; (global-diff-hl-mode)
;; diff-hl uses the fring by default, but conflicts with flycheck
;; (diff-hl-margin-mode)
;; Enable on-the-fly indicators
;; (diff-hl-flydiff-mode)


;; M-x package-install RET magit RET
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)


;; M-x package-install RET multiple-cursors RET
(require 'multiple-cursors)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)


;; M-x package-install RET rainbow-delimiters RET
(require 'rainbow-delimiters)
;; Enable for most programming modes
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


;; M-x package-install RET jedi RET
;; Jedi drags along the maligned `auto-complete` package
;;   Could install an additional package to integrate with `company`, but didn't seem to be worth it
;; When `jedi:setup` is called, it must execute the bundled `jediepcserver.py`
;;   in a python environment that has `jedi` and `epc` python packages.
;; Jedi offers to setup such an environment, but that then depends upon `virtualenv` as opposed to `conda`.
;; To bypass this mess, ensure the first `python` on %PATH% can import `jedi` and `epc`.
;;  Alternatively, adjust jedi:server-command to target a python that does.
(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(define-key jedi-mode-map (kbd "<C-tab>") 'jedi:complete)


;; M-x package-install RET markdown-mode RET
(require 'markdown-mode)
(setq markdown-command "pandoc")


;; M-x package-install RET ess RET
(require 'ess-site)
