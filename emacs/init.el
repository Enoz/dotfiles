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
(setq use-package-enable-imenu-support 1)
(require 'use-package)

;;; Theme

(use-package modus-themes
  :ensure t
  :config
  (load-theme 'modus-vivendi t))

;;; Emacs

(defun enoz/split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun enoz/split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (other-window 1))

(use-package emacs
  :init
  (setq inhibit-startup-message t
	enable-recursive-minibuffers t
	visible-bell t
	make-backup-files nil)
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
    (add-hook mode (lambda () (display-line-numbers-mode 0))))
  :bind
  ("C-}" . next-window-any-frame)
  ("C-{" . previous-window-any-frame)
  ("C-+" . enoz/split-and-follow-vertically)
  ("C-=" . enoz/split-and-follow-horizontally)
  ("C-_" . delete-window))


;;; Which-Key

(use-package which-key
  :init
  (setq which-key-idle-delay 0.3)
  (which-key-mode t))


;;; Evil

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t
	evil-want-integration t ;; This is optional since it's already set to t by default.
	evil-want-keybinding nil
	evil-undo-system 'undo-redo
	evil-search-module 'evil-search)
  :config
  (evil-mode)
  (evil-define-key 'normal 'global (kbd "C-<right>") 'enlarge-window-horizontally)
  (evil-define-key 'normal 'global (kbd "C-<left>") 'shrink-window-horizontally)
  (evil-define-key 'normal 'global (kbd "C-<up>") 'enlarge-window)
  (evil-define-key 'normal 'global (kbd "C-<down>") 'shrink-window))


(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-org
  :ensure t
  :after (evil org)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

;;; Better Jumper

(use-package better-jumper
  :ensure t
  :after (evil evil-collection)
  :bind(:map evil-motion-state-map
             ("C-o" . better-jumper-jump-backward)
             ("<C-i>" . better-jumper-jump-forward))
  :config
  (better-jumper-mode))
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
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;;; Consult

(defun enoz/consult-ripgrep-dir ()
  (interactive)
  (consult-ripgrep 1))


(defun enoz/consult-fd-dir ()
  (interactive)
  (consult-fd 1))

(use-package consult
  :ensure t
  :bind (("C-c f g" . consult-ripgrep)
	 ("C-c f G" . enoz/consult-ripgrep-dir)
	 ("C-c f i" . consult-imenu)
	 ("C-c f f" . consult-fd)
	 ("C-c f F" . enoz/consult-fd-dir)
	 ("C-c f l" . consult-line))
  :config
  (setq consult-async-min-input 1))

;;; Magit

(use-package magit
  :ensure t)

;;; Helpful

(use-package helpful
  :ensure t
  :bind
  ("C-h k" . helpful-key)
  ("C-h f" . helpful-callable)
  ("C-h v" . helpful-variable)
  ("C-h o" . helpful-symbol))

;;; Doom Modeline

(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config (setq doom-modeline-major-mode-icon nil))

;;; Org Mode

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

  (require 'ox-md)
  (add-to-list 'org-export-backends 'markdown)

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
           "** %?")

	  ("g" "General To-Do"
           entry (file+headline "~/org/todos.org" "General Tasks")
           "* TODO [#B] %?\n:Created: %T\n ")
	  
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

;;; Eglot

(use-package eglot
  :init
  (setq eglot-events-buffer-config '(:size 0 :format full))
  :hook
  (prog-mode-hook . eglot-ensure))

(use-package eldoc-box
  :ensure t
  :after eglot ; Otherwise, eglot mode map may not exist to override the keymap
  :config
  (evil-define-key 'normal eglot-mode-map "K" #'eldoc-box-help-at-point))


;;; Company

(use-package company
  :ensure t
  :bind(:map company-active-map
             ("<return>" . nil)
             ("RET" . nil)
             ("C-<return>" . company-complete-selection))
  :hook
  (after-init-hook . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
	company-idle-delay 0))

;;; Code Modes

(use-package go-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(use-package lua-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode)))


;; Store automatic customisation options elsewhere
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
