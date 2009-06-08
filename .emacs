;; UI--------------------------------------------------------------------------

(menu-bar-mode -1)                                  ; disable extra UI elemnts
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq ring-bell-function 'ignore)                   ; disable beep

(setq inhibit-splash-screen t)                      ; no splash

(setq x-alt-keysym 'meta)                           ; swap meta

(setq-default indent-tabs-mode nil)                 ; use spaces for indent'n

;; Backup file placement-------------------------------------------------------

; put autosaves in a special directory
(setq backup-by-copying t                           ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.saves"))  ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)                            ; use versioned backups

;; Hooks-----------------------------------------------------------------------
(add-hook 'python-mode-hook '(lambda () (font-lock-mode)))
(add-hook 'c-mode-hook '(lambda () (font-lock-mode)
                          (auto-fill-mode)))
(add-hook 'latex-mode-hook 
          '(lambda () 
             (auto-fill-mode)))

;; Load path-------------------------------------------------------------------

(setq load-path (cons "/home/chris/.emacs.d" load-path))

;; Modes-----------------------------------------------------------------------

; markdown
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files." t)
(setq auto-mode-alist
      (cons '("\\.md$" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook '(lambda () (auto-fill-mode)))

; erlang 
(setq erlang-root-dir "/usr/lib/erlang")
(setq exec-path (cons "/usr/bin/erl" exec-path))
(require 'erlang-start)
(defvar inferior-erlang-prompt-timeout t)
(add-hook 'erlang-mode-hook '(lambda () (font-lock-mode)))

; haskell
(setq load-path (cons "~/.emacs.d/haskell-mode/" load-path))
(setq auto-mode-alist
      (append auto-mode-alist
              '(("\\.[hg]s$"  . haskell-mode)
                ("\\.hi$"     . haskell-mode)
                ("\\.l[hg]s$" . literate-haskell-mode))))
(autoload 'haskell-mode "haskell-mode"
  "Major mode for editing Haskell scripts." t)
(autoload 'literate-haskell-mode "haskell-mode"
  "Major mode for editing literate Haskell scripts." t)

; clojure
(add-to-list 'load-path "/home/chris/.emacs.d/clojure-mode")
(require 'clojure-mode) 

; swank-clojure
(add-to-list 'load-path "/home/chris/.emacs.d/swank-clojure")
(setq swank-clojure-binary "/home/chris/bin/clojure")
(setq clojure-src-root "/home/chris/progs")
(eval-after-load 'clojure-mode '(clojure-slime-config))
(require 'swank-clojure)

; SLIME
(add-to-list 'load-path "/home/chris/progs/lisp/slime") 
(require 'slime)
(slime-setup '(slime-fancy slime-asdf)) ; fancy prompt et al.

; Hooks and other tweaks (mostly for SBCL)
(add-hook 'lisp-mode-hook (lambda () (slime-mode t)))
(add-hook 'inferior-lisp-mode-hook (lambda () (inferior-slime-mode t)))
;(setq slime-lisp-implementations                ; There are problems
;      '((sbcl ("/usr/local/bin/sbcl"))          ; with these lines
;       (clojure ("/home/chris/bin/clojure"))))  ; figure out why

; misc config
(setq lisp-indent-function 'common-lisp-indent-function
      slime-complete-symbol-function 'slime-fuzzy-complete-symbol
      slime-startup-animation t
      slime-redirect-inferior-output t)

;; Misc functions--------------------------------------------------------------

(defun cjw-toggle-selective-display (column)
  (interactive "P")
  (set-selective-display 
   (if selective-display nil (or column 1))))

(global-set-key [f1] 'cjw-toggle-selective-display)

;; textmate-style snippets
(require 'yasnippet-bundle)
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets/")

;; Customized settings---------------------------------------------------------

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((column-number-mode . t)))))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
