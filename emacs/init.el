;;; package.el

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

;;; Theme

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi t))

;;; Emacs

(use-package emacs
  :init
  (setq inhibit-startup-message t
	enable-recursive-minibuffers t
	visible-bell t)
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (tooltip-mode 0)
  (menu-bar-mode 0)

  ;; Font
  (set-face-attribute 'default nil :font "FiraCode Nerd Font Mono" :height 120)

  ;; Line Numbers
  (global-display-line-numbers-mode t)
  (dolist (mode `(org-mode-hook
		  term-mode-hook
		  shell-mode-hook
		  eshell-mode-hook))
    (add-hook mode (lambda () (display-line-numbers-mode 0)))))

;;; Which-Key
  
(use-package which-key
  :init
  (setq which-key-idle-delay 0.3)
  (which-key-mode t))

;;; No-Littering

(use-package no-littering
  :ensure t)

;;; Evil

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode))


(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))


;;; Vertico

(use-package vertico
  :ensure t
  :config
  (vertico-mode)
  (keymap-set vertico-map "C-j" #'vertico-next)
  (keymap-set vertico-map "C-k" #'vertico-previous)
  (keymap-set vertico-map "C-d" #'vertico-scroll-up)
  (keymap-set vertico-map "C-u" #'vertico-scroll-down))

;;; Orderless

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))  

;;; Marginalia

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

;;; Embark

(use-package embark
  :ensure t
  :bind
  (("C-;" . embark-act)         ;; pick some comfortable binding
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)
  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))


;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t
  :config
  (setq consult-async-min-input 1)
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;; Consult

(use-package consult
  :ensure t)

;;; Magit

(use-package magit
  :ensure t)

;;; Doom Modeline

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config (setq doom-modeline-major-mode-icon nil))

(use-package org
  :bind
  (("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture))
  :config
  (setq org-agenda-files '("~/org")
	org-log-done 'time
	org-return-follows-link t)

  (custom-theme-set-faces
   'user
   `(org-level-1 ((t (:height 1.4 :weight bold))))
   `(org-level-2 ((t (:height 1.3 :weight bold))))
   `(org-level-3 ((t (:height 1.2 :weight semi-bold))))
   `(org-level-4 ((t (:height 1.1 :weight semi-bold)))))

  (setq org-todo-keywords
	'((sequence "TODO(t)" "IN-PROGRESS(i@/!)" "BLOCKED(b@)"  "|" "DONE(d!)" "WONT-DO(w@/!)" )
          ))

  (setq org-todo-keyword-faces
	'(
          ("TODO" . (:foreground "GoldenRod" :weight bold))
          ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
          ("BLOCKED" . (:foreground "Red" :weight bold))
          ("DONE" . (:foreground "LimeGreen" :weight bold))
          ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
          ))

  (setq org-capture-templates
	'(
          ("n" "Notes"
           entry (file+headline "~/org/notes.org" "Misc Notes")
           "** %?"
           :empty-lines 0)

	  ("g" "General To-Do"
           entry (file+headline "~/org/todos.org" "General Tasks")
           "* TODO [#B] %?\n:Created: %T\n "
           :empty-lines 0)
	  
	  ("m" "Meeting"
           entry (file+datetree "~/org/meetings.org")
           
"* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
           :tree-type week
           :clock-in t
           :clock-resume t
           :empty-lines 0)

          ))
  :hook
  (org-mode-hook . org-indent-mode)
  (org-mode-hook . visual-line-mode))


;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
