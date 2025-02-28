; Look into vertico, consult, orderless, emark, and marginalia

;; Theme
(load-theme `deeper-blue)

;; Basic Emacs Options

(setq inhibit-startup-message t)
(setq enable-recurisve-minibuffers t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode t)
(global-set-key (kbd "<escape>") `keyboard-escape-quit)

;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)

;; Initialize use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Moves tmp files into /var and /etc/
(use-package no-littering)

;; Vim Keybindings
(use-package evil
  :init
  (setq evil-want-C-u-scroll t)
  :config
  (evil-mode))

;; Better completion
(use-package vertico
  :config
  (vertico-mode)
  (keymap-set vertico-map "C-j" #'vertico-next)
  (keymap-set vertico-map "C-k" #'vertico-previous)
  (keymap-set vertico-map "C-d" #'vertico-scroll-up)
  (keymap-set vertico-map "C-u" #'vertico-scroll-down))

;; Completion descriptions
(use-package marginalia
  :init
  (marginalia-mode))

;; Consult
(use-package consult)

;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
