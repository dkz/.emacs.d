(require 'package)
(add-to-list
 'package-archives
 '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq-default truncate-lines t)

(defun reload-init.el ()
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

(global-set-key (kbd "C-c C-r") 'reload-init.el)

;; Themes
(use-package flatland-theme :ensure t)
(load-theme 'flatland t)

(defun set-font-weight (weight)
  (interactive)
  (set-face-attribute 'default nil
		      :weight weight))

(defun set-font-height (height)
  (interactive)
  (set-face-attribute 'default nil
		      :height height))

(set-font-height 100)
(set-font-weight 'semibold)

(use-package undo-tree :ensure t)

(use-package linum-relative
  :ensure t
  :init
  :config
  (linum-mode)
  (linum-relative-global-mode)
  (set-face-attribute 'fringe nil :background nil)
  (set-face-attribute 'linum-relative-current-face nil
		      :foreground nil
		      :background nil))

;; Ivy
(use-package ivy
  :ensure t
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode 1)
  (use-package counsel
    :ensure t
    :config
    (counsel-mode 1)))

;; Evil
(use-package evil
  :ensure t
  :after (undo-tree)
  :init
  (setq evil-search-module 'evil-search)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  :config
  (evil-mode)
  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode 1))
  (use-package evil-collection
    :ensure t
    :custom
    (evil-collection-setup-minibuffer t)
    :config
    (evil-collection-init)))

(setq custom-file
      (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)
