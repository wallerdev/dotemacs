; add usr/local/bin to path
(setenv "PATH" (concat "/usr/local/bin" ":" (getenv "PATH")))

; remove splash screen
(setq inhibit-splash-screen t)

; remove menus etc
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; highlight marked region
(transient-mark-mode t)

; don't want tabs
(setq-default indent-tabs-mode nil)

; disable backup
(setq backup-inhibited t)

; disable auto save
(setq auto-save-default nil)

; cursor style
(setq default-cursor-type 'box)
(set-cursor-color "#606060")
(blink-cursor-mode t)

; open new line
(global-set-key (kbd "C-o") (kbd "C-e C-j"))

; Use C-x C-m for meta
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

; Backwards kill word
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

; fix indent settings for css to be 2
(setq-default css-indent-offset 2)

; load libraries
(setq load-path (cons "~/.emacs.d/site-lisp" load-path))
(require 'find-recursive)
(require 'snippet)
(require 'gist)

; textile
(require 'textile-minor-mode)
(add-to-list 'auto-mode-alist '("\\.textile\\'" . textile-minor-mode))

; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

; os x copy paste
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil)) 
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

; git commits
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))

; diff red-green highlighting

(eval-after-load 'diff-mode
  '(progn
     (set-face-foreground 'diff-added "green4")
     (set-face-foreground 'diff-removed "red3")))

; php

(add-to-list 'load-path "~/.emacs.d/site-lisp/php")
(load "php-mode")
(add-to-list 'auto-mode-alist
	     '("\\.php[34]?\\'\\|\\.phtml\\'" . php-mode))

; ruby

(add-to-list 'load-path "~/.emacs.d/site-lisp/ruby")
 
 (autoload 'ruby-mode "ruby-mode"
     "Mode for editing ruby source files")
 (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
 (add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))
 (autoload 'run-ruby "inf-ruby"
     "Run an inferior Ruby process")
 (autoload 'inf-ruby-keys "inf-ruby"
     "Set local key defs for inf-ruby in ruby-mode")
 (add-hook 'ruby-mode-hook
     '(lambda ()
         (inf-ruby-keys)))
 ;; If you have Emacs 19.2x or older, use rubydb2x                                                                              
 (autoload 'rubydb "rubydb3x" "Ruby debugger" t)
 ;; uncomment the next line if you want syntax highlighting                                                                     
 (add-hook 'ruby-mode-hook 'turn-on-font-lock)

(add-hook 'ruby-mode-hook
          (lambda()
            (add-hook 'local-write-file-hooks
                      '(lambda()
                         (save-excursion
                           (untabify (point-min) (point-max))
                           (delete-trailing-whitespace)
                           )))
            (set (make-local-variable 'indent-tabs-mode) 'nil)
            (set (make-local-variable 'tab-width) 2)
            (imenu-add-to-menubar "IMENU")
            (require 'ruby-electric)
            (ruby-electric-mode t)
            ))

;; Import Rails mode

(setq load-path (cons "~/.emacs.d/site-lisp/rails" load-path))
(require 'rails)
 

;; Import C# mode
(require 'cc-mode)
(add-to-list 'load-path "~/.emacs.d/site-lisp/csharp")
(autoload 'csharp-mode "csharp-mode" "Major mode for editing C# code." t)
(setq auto-mode-alist
      (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))

;; Import js mode
(add-to-list 'load-path "~/.emacs.d/site-lisp/js2")
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; colors
(if window-system
    (progn      
      (set-foreground-color "#E6E1DC")
      (set-background-color "#2B2B2B")
      (set-face-foreground 'font-lock-keyword-face "#C97836")
      (set-face-foreground 'font-lock-comment-face "#BA945A")
      (set-face-foreground 'font-lock-variable-name-face "#D1D0FE")
      (set-face-foreground 'font-lock-type-face "#719CBD")
      (set-face-foreground 'font-lock-constant-face "#FDFFA6")
      (set-face-foreground 'font-lock-string-face "#A5C262")
      (set-face-foreground 'font-lock-regexp-grouping-backslash "#539F50")
      (set-face-foreground 'font-lock-regexp-grouping-construct "#539F50")
      (set-face-foreground 'font-lock-preprocessor-face "#539F50")
      (set-face-foreground 'font-lock-negation-char-face "719CBD")
      (set-face-foreground 'font-lock-builtin-face "#719CBD")
      (set-face-foreground 'font-lock-function-name-face "#FCC66F")
      (set-face-foreground 'font-lock-warning-face "#E6BF6C")
      (set-face-foreground 'font-lock-doc-face "#E6BF6C")
      (set-face-foreground 'minibuffer-prompt "#C97836")
      (set-face-background 'region "#333C48")
			(set-face-foreground 'js2-function-param-face "#B0D9CE")
      (set-face-foreground 'textile-ol-bullet-face "#C97836")
      (set-face-foreground 'textile-acronym-face "#719CBD")
      (set-face-foreground 'textile-ul-bullet-face "#719CBD")))
(server-start)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(standard-indent 2)
 '(tab-stop-list (quote (2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34)))
 '(tab-width 2))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
