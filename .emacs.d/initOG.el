;;+
;; Bando Samurai - Custom Emacs Config
;; Last update: 09-18-2019
;;-

;; El-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

;; now either el-get is `require'd already, or have been `load'ed by the
;; el-get installer.

;; set local recipes, el-get-sources should only accept PLIST element
(setq
 el-get-sources
 '((:name buffer-move			; have to add your own keys
	  :after (progn
		   (global-set-key (kbd "<C-S-up>")     'buf-move-up)
		   (global-set-key (kbd "<C-S-down>")   'buf-move-down)
		   (global-set-key (kbd "<C-S-left>")   'buf-move-left)
		   (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

   (:name smex				; a better (ido like) M-x
	  :after (progn
		   (setq smex-save-file "~/.emacs.d/.smex-items")
		   (global-set-key (kbd "M-x") 'smex)
		   (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

   (:name magit				; git meet emacs, and a binding
	  :after (progn
		   (global-set-key (kbd "C-x C-z") 'magit-status)))

   (:name goto-last-change		; move pointer back to last change
	  :after (progn
		   ;; when using AZERTY keyboard, consider C-x C-_
		   (global-set-key (kbd "C-x C-/") 'goto-last-change)))))

;; now set our own packages
(setq
 my:el-get-packages
 '(el-get				; el-get is self-hosting
   escreen            			; screen for emacs, C-\ C-h
   php-mode-improved		; if you're into php...
   switch-window			; takes over C-x o
   auto-complete			; complete as you type with overlays
   zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding
   color-theme		                        ; nice looking emacs
   color-theme-tango	                                               ; check out color-theme-solarized
   ))
;
;; Some recipes require extra tools to be installed
;;
;; Note: el-get-install requires git, so we know we have at least that.
;;
;;(when (el-get-executable-find "cvs")
;;  (add-to-list 'my:el-get-packages 'emacs-goodies-el)) ; the debian addons for emacs

;;(when (el-get-executable-find "svn")
;;  (loop for p in '(psvn    		; M-x svn-status
;;		   yasnippet		; powerful snippet mode
;;		   )
;;	do (add-to-list 'my:el-get-packages p)))

(setq my:el-get-packages
      (append my:el-get-packages
              (mapcar #'el-get-source-name el-get-sources)))


;; install new packages and init already installed packages
(el-get 'sync my:el-get-packages)

;; End of El-get

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#fafafa" "#183691" "#888a88" "#539100" "#888a88" "#888a88" "#183691" "#888a88"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wheatgrass)))
 '(custom-safe-themes
   (quote
    ("cd7ffd461946d2a644af8013d529870ea0761dccec33ac5c51a7aaeadec861c2" "fad9c3dbfd4a889499f6921f54f68de8857e6846a0398e89887dbe5f26b591c0" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "b3775ba758e7d31f3bb849e7c9e48ff60929a792961a2d536edec8f68c671ca5" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "96998f6f11ef9f551b427b8853d947a7857ea5a578c75aa9c4e7c73fe04d10b4" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "075351c6aeaddd2343155cbcd4168da14f54284453b2f1c11d051b2687d6dc48" "d5aec3a39364bc4c6c13f472b2d0cdaebd5cff7a6e4839749be2156fcc075006" "f11e219c9d043cbd5f4b2e01713c2c24a948a98bed48828dc670bd64ae771aa1" "d1cc05d755d5a21a31bced25bed40f85d8677e69c73ca365628ce8024827c9e3" default)))
 '(display-battery-mode t)
 '(fci-rule-color "#888a88")
 '(fringe-mode 10 nil (fringe))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(linum-format " %5i ")
 '(main-line-color1 "#222232")
 '(main-line-color2 "#333343")
 '(nrepl-message-colors
   (quote
    ("#183691" "#888a88" "#539100" "#888a88" "#0086b3" "#183691" "#539100" "#888a88")))
 '(package-selected-packages
   (quote
    (magithub sql-indent js2-mode pyenv-mode-auto theme-changer web web-beautify web-search zen-and-art-theme py-autopep8 py-yapf pygen sexy-monochrome-theme slack virtualenvwrapper virtualenv xah-lookup windresize vlf csv-mode tango-2-theme restart-emacs magit jdee jedi flymake-lua flymake-json flycheck-pyflakes flycheck cyberpunk-theme clues-theme chyla-theme cheatsheet bongo bash-completion aws-snippets aws-ec2 all-the-icons yasnippet ztree w3 sed-mode python json-mode elpy)))
 '(pdf-view-midnight-colors (quote ("#888a88" . "#edf5dc")))
 '(powerline-color1 "#222232")
 '(powerline-color2 "#333343")
 '(python-shell-virtualenv-root "C:\\Projects\\anaconda3\\envs\\Python3")
 '(pyvenv-activate nil)
 '(user-emacs-directory-warning nil)
 '(vc-annotate-background "#d5dec4")
 '(vc-annotate-color-map
   (quote
    ((20 . "#888a88")
     (40 . "#183691")
     (60 . "#888a88")
     (80 . "#888a88")
     (100 . "#888a88")
     (120 . "#539100")
     (140 . "#888a88")
     (160 . "#888a88")
     (180 . "#888a88")
     (200 . "#888a88")
     (220 . "#63a35c")
     (240 . "#0086b3")
     (260 . "#183691")
     (280 . "#888a88")
     (300 . "#0086b3")
     (320 . "#888a88")
     (340 . "#539100")
     (360 . "#888a88"))))
 '(vc-annotate-very-old-color "#888a88" t)
 '(virtualenv-root "C:/Projects/anaconda3/envs/Python3/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Adobe Devanagari" :foundry "outline" :slant normal :weight normal :height 100 :width normal)))))

;; load neo tree
(add-to-list 'load-path "~/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;;(defvar myPackages
;;  '(better-defaults
;;    elpy ;; add the elpy package
;;    material-theme))
(defvar myPackages
  '(better-defaults
    ein ;; add the ein package (Emacs ipython notebook)
    elpy
    flycheck
    material-theme
    py-autopep8))

(elpy-enable)

(require 'all-the-icons)

(global-linum-mode t) ;; enable line numbers globally

;; init.el ends here
(put 'magit-clean 'disabled nil)
;split-window-right)
