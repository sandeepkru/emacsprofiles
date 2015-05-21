(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(package-initialize)
;; initialize auto-complete
;;(require 'auto-complete)
;;(require 'auto-complete-config)
;;(ac-config-default)
;;(auto-complete-mode 1)
;; One more try on CEDET - Hope I will be successful atleast this time
(load-file "~/cedet-1.1/common/cedet.el")
;;(load-file "~/sandTemp/cedet-bzr/trunk/cedet-devel-load.el")
;;(semantic-mode 1)
(semantic-load-enable-excessive-code-helpers)
(custom-set-variables
 '(semantic-idle-scheduler-idle-time 3)
 '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
 '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))

(setq senator-minor-mode-name "SN")
(setq semantic-imenu-auto-rebuild-directory-indexes nil)
(global-srecode-minor-mode 1)
;(global-semantic-mru-bookmark-mode 1)
;;(global-semantic-folding-mode 1)

(require 'semantic-decorate-include)

;; gcc setup
(require 'semantic-gcc)

;; smart complitions
(require 'semantic-ia)
(require 'semanticdb)
(setq-mode-local c-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local c++-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))
(setq-mode-local erlang-mode semanticdb-find-default-throttle
                 '(project unloaded system recursive))

(require 'eassist)
;; customisation of modes
(defun sandeep/cedet-hook ()
  (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
  (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
  ;;
  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  (local-set-key "\C-c=" 'semantic-decoration-include-visit)

  (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  (local-set-key "\C-cb" 'semantic-mrub-switch-tag)
  (local-set-key "\C-cq" 'semantic-ia-show-doc)
  (local-set-key "\C-cs" 'semantic-ia-show-summary)
  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  (local-set-key (kbd "C-c <left>") 'semantic-tag-folding-fold-block)
  (local-set-key (kbd "C-c <right>") 'semantic-tag-folding-show-block)
  )

(add-hook 'c-mode-common-hook 'sandeep/cedet-hook)
(add-hook 'lisp-mode-hook 'sandeep/cedet-hook)
(add-hook 'scheme-mode-hook 'sandeep/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'sandeep/cedet-hook)
(add-hook 'erlang-mode-hook 'sandeep/cedet-hook)

(defun sandeep/c-mode-cedet-hook ()
;; (local-set-key "." 'semantic-complete-self-insert)
;; (local-set-key ">" 'semantic-complete-self-insert)
 (local-set-key "\C-ct" 'eassist-switch-h-cpp)
 (local-set-key "\C-xt" 'eassist-switch-h-cpp)
 (local-set-key "\C-ce" 'eassist-list-methods)
 (local-set-key "\C-c\C-r" 'semantic-symref)
)
(add-hook 'c-mode-common-hook 'sandeep/c-mode-cedet-hook)


;;(global-semantic-mode 1)
;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project

(ede-cpp-root-project "leveldb" :file "~/gopher/sandeepu/Documents/leveldb/Makefile")
(if (file-exists-p "~/gopher/sandeepu/Documents/leveldb/Makefile")
    (ede-cpp-root-project "leveldb" 
			  :file "~/gopher/sandeepu/Documents/leveldb//Makefile"
			  :system-include-path '("/usr/include")
			  :include-path  '("~/gopher/sandeepu/Documents/leveldb/")))
;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
;;;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;;(semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;;;;(semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
 ;;;;(global-srecode-minor-mode 1)
;;(semantic-mode 1)
;; Directory tree plugin - Similar to NERDTree
(add-to-list 'load-path "~/.emacs.d")
(require 'tree-mode)
(require 'windata)
(require 'dirtree)
(autoload 'dirtree "dirtree" "Add directory to tree view" t)
(global-set-key "\C-o" 'dirtree-show)
(require 'auto-complete)
(require 'auto-complete-extension)
;; Load color theme path
(add-to-list 'load-path "~/.emacs.d/color-theme-6.6.0")
(require 'color-theme)
;;(color-theme-arjen)
;; Initialize theme
;;(color-theme-initialize)
;; Set whichever theme youwant
;; (color-theme-arjen) ;; somehow few vriables are getting darked out in this,otherwise I liked
;; it
;;(color-theme-calm-forest)
;; TODO: Configuration for Auto Complete feature - Somehow my emacs 23 errors out for this feature
;; So comment out this region until I fix it and use defaulat till then
(add-to-list 'load-path "~/.emacs.d/")
;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
;;(ac-config-default)
;;(auto-complete-mode 1) ;; Probably I would need the require field earlier to this
;; Anyways set now globaly
(require 'auto-complete)
(global-auto-complete-mode t)
;; See if C++ mode works better here.
;;(setq 'ac-modes '(c++-mode))
;; Try setting up default semantic mode until I setup CEDET package
;;;;(require 'semantic/ia)
;;(semantic-mode 1)
;; Somehow I like this key mappings for fast jump
;;;;(global-set-key (kbd "C-x j") 'semantic-ia-fast-jump)

;; I like the ido mode it makes to browse stuff faster - So enable it
(require 'ido)
(setq ido-enable-tramp-completion nil)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enadle-flex-matching 1)
(setq ido-show-dot-for-dired t)
;; remap metakey for MBP
(setq x-alt-keysym 'meta)
;;(set-keyboad-conding-system nil)
;; C-x o/C-- C-x o are good window navigation commands but mapping as per
;; GUI might be easier to use
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
;;(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 ;;;;'(ede-project-directories (quote ("/u/sandeepu/ccm_wa/symbios/RAIDCore-illi_skr/RAIDCore"))))
;;;;(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
;;;; )
;; semantic db and code browing stuff
;;;;(require 'semanticdb)
;;;;(global-semanticdb-minor-mode 1)
;; Setup GNU GLOBAL
(load-file "~/.emacs.d/gtags.el")
(autoload 'gtags-mode "gtags" "" t)
(setq c++-mode-hook
         '(lambda ()
             (gtags-mode 1)
     ))
;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (require 'semanticdb-global)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; CSCOPE Setup
(require 'xcscope)
(cscope-setup)
(require 'cc-mode)
(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
(add-to-list 'load-path "~/.emacs.d/autopair")
(require 'autopair)
(autopair-global-mode 1)
(setq autopair-autowrap t)
(require 'yasnippet)
(yas-global-mode 1)
;; auto-complete-c-headers mode
(defun my:ac-c-header-init ()
   (require 'auto-complete-c-headers)
   (add-to-list 'ac-sources 'ac-source-c-headers)
   (add-to-list 'achead:include-directories '"/usr/include/c++/4.8"))
; c/C++ hooks
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)
(require 'compile)
(setq compilation-disable-input nil)
(setq compilation-scroll-output t)
(setq mode-compile-always-save-buffer-p t)

(defun alexott/compile ()
  "Saves all unsaved buffers, and runs 'compile'."
  (interactive)
  (save-some-buffers t)
  (let* ((fname (or (buffer-file-name (current-buffer)) default-directory))
		 (current-dir (file-name-directory fname))
         (prj (ede-current-project current-dir)))
    (if prj
		(project-compile-project prj)
	  (compile compile-command))))
(global-set-key [f9] 'alexott/compile)
;;(require 'ecb)
;;(require 'ecb-autoloads)
