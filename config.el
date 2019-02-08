;; Get current system's name
(defun insert-system-name()
  (interactive)
  "Get current system's name"
  (insert (format "%s" system-name))
  )

;; Get current system type
(defun insert-system-type()
  (interactive)
  "Get current system type"
  (insert (format "%s" system-type))
  )

;; Check if system is Darwin/Mac OS X
(defun system-type-is-darwin ()
  (interactive)
  "Return true if system is darwin-based (Mac OS X)"
  (string-equal system-type "darwin")
  )

;; Check if system is GNU/Linux
(defun system-type-is-gnu ()
  (interactive)
  "Return true if system is GNU/Linux-based"
  (string-equal system-type "gnu/linux")
  )
(message "Completed OS Level variables load")

(use-package better-defaults
  :ensure t
)

(message "Loaded better-defaults package")

(setq epa-file-encrypt-to '("shreyas@fastmail.com"))
(require 'org-crypt)
(add-to-list 'org-modules 'org-crypt)
                                        ; Encrypt all entries before saving
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))
                                        ; GPG key to use for encryption. nil for symmetric encryption
(setq org-crypt-key nil)
(setq org-crypt-disable-auto-save t)
(setq org-crypt-tag-matcher "locked")

(message "Loaded crypto setup")

(setq auth-sources '((:source "~/.gh.authinfo.gpg")))
(setq magit-process-find-password-functions '(magit-process-password-auth-source))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq ivy-initial-inputs-alist nil)

(setq package-list '(diminish
                     org-journal
                     ztree
                     org-gcal
                     w3m
                     org-trello
                     org-web-tools
                     ox-hugo
                     auto-indent-mode
                     ob-sql-mode
                     dash
                     org-super-agenda
                     workgroups2
                     switch-window
                     ess
                     ess-R-data-view
                     interleave
                     deft
                     org-bookmark-heading
                     writeroom-mode
                     evil
                     evil-leader
                     polymode
                     poly-R
                     helm-ag
                     writegood-mode
                     artbollocks-mode
                     multiple-cursors
                     ox-reveal
                     better-defaults
                     jedi jedi-core
                     ag ein
                     ein-mumamo
                     ido-vertical-mode
                     company-jedi
                     conda
                     spacemacs-theme
                     elfeed-goodies
                     helpful
                     browse-kill-ring
                     ivy-yasnippet
                     speed-type
                     clojure-mode
                     cider
                     helm-dash
                     org-projectile
                     bash-completion
                     elmacro
                     org-noter
                     helm-org-rifle
                     sx define-word))

;;fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

;; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(use-package switch-window
  :config
  ;;

  (require 'switch-window)

  (global-set-key (kbd "C-x o") 'switch-window)
  (global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
  (global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
  (global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
  (global-set-key (kbd "C-x 0") 'switch-window-then-delete)

  (global-set-key (kbd "C-x 4 d") 'switch-window-then-dired)
  (global-set-key (kbd "C-x 4 f") 'switch-window-then-find-file)
  (global-set-key (kbd "C-x 4 m") 'switch-window-then-compose-mail)
  (global-set-key (kbd "C-x 4 r") 'switch-window-then-find-file-read-only)

  (global-set-key (kbd "C-x 4 C-f") 'switch-window-then-find-file)
  (global-set-key (kbd "C-x 4 C-o") 'switch-window-then-display-buffer)

  (global-set-key (kbd "C-x 4 0") 'switch-window-then-kill-buffer)

  ;; selecting minibuffer
  (setq switch-window-minibuffer-shortcut ?z)
  )

(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

(setq markdown-command "pandoc")

(set-register ?n (cons 'file "~/my_org/notes.org"))
(set-register ?l (cons 'file "~/application_letters/letter.md"))
(set-register ?k (cons 'file "~/application_letters/Cover_letter_Shreyas_R.pdf"))
(set-register ?p (cons 'file "~/org_cv/CV_Shreyas_Ragavan.pdf"))
(set-register ?r (cons 'file "~/org_cv/CV_Shreyas_Ragavan.org"))
(set-register ?t (cons 'file "~/my_org/todo-global.org"))
(set-register ?i (cons 'file "~/dotemacs/.emacs.d/new-init.org"))
(set-register ?j (cons 'file "~/my_org/mrps_canjs.org"))
(set-register ?f (cons 'file "~/scimax/user/sr-cust/"))
(set-register ?d (cons 'file "~/my_org/datascience.org"))
(set-register ?m (cons 'file "~/my_org/"))
(set-register ?g (cons 'file "~/my_gits/"))

(global-set-key (kbd "M-s g") 'google-this-mode-submap)

(global-set-key (kbd "M-i") 'ivy-yasnippet)

(global-set-key (kbd "M-s u") 'mu4e-update-mail-and-index)
(global-set-key (kbd "M-s m") 'mu4e~headers-jump-to-maildir)
(global-set-key (kbd "C-x m") 'mu4e-compose-new)

(global-set-key (kbd "C-x t") 'org-insert-todo-heading)
(global-set-key (kbd "C-c d") 'org-time-stamp)
(global-set-key (kbd "M-s s") 'org-save-all-org-buffers)
(global-set-key (kbd "M-s j") 'org-journal-new-entry)

(defun my/yank-more ()
  (interactive)
  (insert "[[")
  (yank)
  (insert "][link]]"))
(global-set-key (kbd "<f6>") 'my/yank-more)

(require 'ox-org)

(message "Loaded Emacs general config")

(setq python-indent-guess-indent-offset nil)
(elpy-enable)

(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt"
      python-shell-prompt-detect-failure-warning nil)

(add-to-list 'python-shell-completion-native-disabled-interpreters
             "jupyter")

(use-package py-autopep8
  :ensure t
  :defer t
  :config
  (require 'py-autopep8)
  (add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
  )

(add-to-list 'company-backends 'company-ob-ipython)
(company-mode)

(use-package crux
  :ensure t
  :bind (("C-a" . crux-move-beginning-of-line)))

(use-package dired
  :ensure nil
  :delight dired-mode "Dired"
  :preface
  (defun me/dired-directories-first ()
    "Sort dired listings with directories first before adding marks."
    (save-excursion
      (let (buffer-read-only)
        (forward-line 2)
        (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max)))
      (set-buffer-modified-p nil)))
  :hook (dired-mode . dired-hide-details-mode)
  :config
  (advice-add 'dired-readin :after #'me/dired-directories-first)
  (setq-default
   dired-auto-revert-buffer t
   dired-dwim-target t
   dired-hide-details-hide-symlink-targets nil
   dired-listing-switches "-alh"
   dired-ls-F-marks-symlinks nil
   dired-recursive-copies 'always))

(use-package dired-x
  :ensure nil
  :preface
  (defun me/dired-revert-after-command (command &optional output error)
    (revert-buffer))
  :config
  (advice-add 'dired-smart-shell-command :after #'me/dired-revert-after-command))

(message "Loaded Dired customisation")

(global-set-key (kbd "C-s") 'swiper)
(setq ivy-display-style 'fancy)

;; advise swiper to recenter on exit
(defun bjm-swiper-recenter (&rest args)
  "recenter display after swiper"
  (recenter)
  )
(advice-add 'swiper :after #'bjm-swiper-recenter)

(message "Loaded Swiper customisation")

(use-package expand-region
  :ensure t
  :bind ("C-=" . er/expand-region))

(message "Loaded easier selection")

(use-package git-gutter
  :ensure t
  :config
  (global-git-gutter-mode 't)
  :diminish git-gutter-mode)

(setq magit-revert-buffers 'silent)

(use-package git-timemachine
  :ensure t)

(message "Loaded git related config")

(with-eval-after-load 'writeroom-mode
  (define-key writeroom-mode-map (kbd "C-s-,") #'writeroom-decrease-width)
  (define-key writeroom-mode-map (kbd "C-s-.") #'writeroom-increase-width)
  (define-key writeroom-mode-map (kbd "C-s-=") #'writeroom-adjust-width))

(advice-add 'text-scale-adjust :after
	    #'visual-fill-column-adjust)

;;  loading artbollocks whenever the writeroom mode is called in particular.
(autoload 'artbollocks-mode "artbollocks-mode")
(add-hook 'writeroom-mode-hook 'artbollocks-mode)

(message "Loaded writeroom customisations")

;; Setting up emacs ess and polymode
(require 'ess)
(require 'ess-R-data-view)
(setq ess-describe-at-point-method 'tooltip)
(setq ess-switch-to-end-of-proc-buffer t)
(require 'ess-rutils)
(setq ess-rutils-keys +1)
(setq ess-eval-visibly 'nowait)

(use-package ess-view
  :ensure t
  :config
  (if (system-type-is-darwin)
      (setq ess-view--spreadsheet-program "/Applications/Tad.app/Contents/MacOS/Tad")
    ))

(message "Loaded ESS configuration")

(require 'poly-markdown)
(require 'poly-R)

;; MARKDOWN
(add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode))


;; R modes
(add-to-list 'auto-mode-alist '("\\.Snw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rnw" . poly-noweb+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd" . poly-markdown+r-mode))

(message "Loaded polymode configuration")

(use-package multiple-cursors
  :ensure t
  :config
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  )

(message "Loaded MC")

(use-package ox-reveal
  :ensure ox-reveal
  :config
  (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/3.0.0/")
  (setq org-reveal-mathjax t)
  )

(use-package htmlize
  :ensure t)

(message "Loaded ox-reveal cust")

(setq
 org-directory "~/my_org/"
 org-agenda-files '("~/my_org/")
 )

(require 'org-capture)
(require 'org-protocol)

(add-hook 'find-file-hooks
          (lambda ()
            (let ((file (buffer-file-name)))
              (when (and file (equal (file-name-directory file) "~/my_org/archive/"))
                (org-mode)))))

(add-to-list 'auto-mode-alist '("\\.org_archive\\'" . org-mode))

(defun my-org-inherited-no-file-tags ()
  (let ((tags (org-entry-get nil "ALLTAGS" 'selective))
        (ltags (org-entry-get nil "TAGS")))
    (mapc (lambda (tag)
            (setq tags
                  (replace-regexp-in-string (concat tag ":") "" tags)))
          (append org-file-tags (when ltags (split-string ltags ":" t))))
    (if (string= ":" tags) nil tags)))

(defadvice org-archive-subtree (around my-org-archive-subtree-low-level activate)
  (let ((tags (my-org-inherited-no-file-tags))
        (org-archive-location
         (if (save-excursion (org-back-to-heading)
                             (> (org-outline-level) 1))
             (concat (car (split-string org-archive-location "::"))
                     "::* "
                     (car (org-get-outline-path)))
           org-archive-location)))
    ad-do-it
    (with-current-buffer (find-file-noselect (org-extract-archive-file))
      (save-excursion
        (while (org-up-heading-safe))
        (org-set-tags-to tags)))))

(use-package org-journal
  :ensure t
  :defer t
  :custom
  (org-journal-dir "~/my_org/journal/")
  (org-journal-file-format "%Y%m%d")
  (org-journal-enable-agenda-integration t)
  (add-to-list 'auto-mode-alist '(".*/[0-9]*$" . org-mode))
  ;; (org-journal-date-format "%A, %d %B %Y")
  ;; (org-journal-enable-encryption 't)
  )

(setq org-id-method (quote uuidgen))

(setq org-hide-leading-stars t)
;;(setq org-alphabetical-lists t)
(setq org-src-fontify-natively t)  ;; you want this to activate coloring in blocks
(setq org-src-tab-acts-natively t) ;; you want this to have completion in blocks
(setq org-hide-emphasis-markers t) ;; to hide the *,=, or / markers
(setq org-pretty-entities t)       ;; to have \alpha, \to and others display as utf8 http://orgmode.org/manual/Special-symbols.html

;; Highlighting lines in the agenda, where the cursor is placed.
(add-hook 'org-agenda-mode-hook (lambda () (hl-line-mode 1)))

;; Setting up clean indenting below respective headlines at startup. - from the org mode website
(setq org-startup-indented t)

;; use org bullets from emacsist
(use-package org-bullets
  :ensure t
  :init
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.5))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.1))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 )

(setq org-fontify-done-headline t)
(custom-set-faces
 '(org-done ((t (:foreground "PaleGreen"
			     :weight normal
			     :strike-through t))))
 '(org-headline-done
   ((((class color) (min-colors 16) (background dark))
     (:foreground "LightSalmon" :strike-through t)))))

(setq org-refile-targets
      '((nil :maxlevel . 4)
        (org-agenda-files :maxlevel . 4)))

(setq org-refile-use-outline-path 'file)
(setq org-outline-path-complete-in-steps nil)
(setq org-reverse-note-order t)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(setq org-agenda-start-on-weekday 1)

(setq org-agenda-tags-column -150)

(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
         ((tags "recurr"
		((org-agenda-overriding-header "Recurring Tasks")))
          (agenda "")
          (todo "")))
        ("o" agenda "Office mode" ((org-agenda-tag-filter-preset '("-course" "-habit" "-someday" "-book" "-emacs"))))
        ("qc" tags "+commandment")
	("e" tags "+org")
	("w" agenda "Today" ((org-agenda-tag-filter-preset '("+work"))))
	("W" todo-tree "WAITING")
	("q" . "Custom queries") ;; gives label to "q"
	("d" . "ds related")	 ;; gives label to "d"
	("ds" agenda "Datascience" ((org-agenda-tag-filter-preset '("+datascience"))))
	("qw" agenda "MRPS" ((org-agenda-tag-filter-preset '("+canjs"))))
	("qa" "Archive tags search" org-tags-view ""
         ((org-agenda-files (file-expand-wildcards "~/my_org/*.org*"))))
        ("j" "Journal Search" search ""
         ''((org-agenda-text-search-extra-files (file-expand-wildcards "~/my_org/journal/"))))
        ("S" search ""
	 ((org-agenda-files '("~/my_org/"))
	  (org-agenda-text-search-extra-files )))
	)
      )

(setq org-agenda-text-search-extra-files (apply 'append
						(mapcar
						 (lambda (directory)
						   (directory-files-recursively
						    directory org-agenda-file-regexp))
						 '("~/my_org/journal/" "~/my_org/zeeco_archive/" "~/my_projects/" ))))

(setq org-agenda-text-search-extra-files '(agenda-archives))

(setq org-agenda-search-view-always-boolean t)

(setq org-agenda-sticky t)

(setq org-habit-graph-column 90)

(setq org-capture-templates
      '(("t" "Task entry")
        ("tt" "Todo - Fast" entry (file+headline "~/my_org/todo-global.org" "--Inbox")
	 "** TODO %?")
        ("tb" "Todo -BGR" entry (file+headline "~/my_org/bgr.org" "#BGR #Inbox")
	 "** TODO %?")
        ("te" "Todo - Emacs" entry (file+headline "~/my_org/todo-global.org" ";Emacs stuff")
	 "** TODO %?")
	("tm" "Mail Link Todo" entry (file+headline "~/my_org/todo-global.org" "--Inbox")
	 "** TODO Mail: %a ")
        ("l" "Link/Snippet" entry (file+headline "~/my_org/link_database.org" ".UL Unfiled Links")
         "** %? %a ")
        ("e" "Protocol info" entry ;; 'w' for 'org-protocol'
         (file+headline "~/my_org/link_database.org" ".UL Unfiled Links")
         "*** %a, %T\n %:initial")
        ("n" "Notes")
        ("ne" "Emacs note" entry (file+headline "~/my_org/todo-global.org" ";Emacs stuff")
         "** %?")
        ("nn" "General note" entry (file+headline "~/my_org/notes.org" ".NOTES")
         "** %?")
        ("n" "Note" entry (file+headline "~/my_org/notes.org" ".NOTES")
         "** %?")
        ("b" "BGR stuff")
        ("bi" "Inventory project")
        ("bil" "Daily log" entry (file+olp+datetree "~/my_org/bgr.org" "Inventory management Project") "** %? %i")
        ("C" "Commandment" entry (file+datetree "~/my_org/lifebook.org" "")
         "** %? %i %T :commandment:")
        ("c" "canjs" entry (file+headline "~/my_org/mrps_canjs.org" "MRPS #CANJS")
         "** TODO %? %i %T")
        ("r" "Self Reflection" entry (file+datetree "~/my_org/lifebook.org" "")
         "b** %? %i %T :self_reflection:")
        ("w" "Website" plain
         (function org-website-clipper)
         "* %a %T\n" :immediate-finish t)
        ("j" "Journal Note"  plain (function get-journal-file-today) "* Event: %?\n\n  %i\n\n  " :empty-lines 1)
        ("i" "Whole article capture" entry
         (file+headline "~/my_org/full_article_archive.org" "" :empty-lines 1)
         "** %a, %T\n %:initial" :empty-lines 1)
        ("d" "Datascience stuff")
        ("dt" "Datascience inbox" entry (file+headline "~/my_org/datascience.org" "@Datascience @Inbox")
         "** TODO %? %T")
        ("dn" "Datascience note" entry (file+headline "~/my_org/datascience.org" "@Datascience @Notes")
         "** %? %T")
        ))

(defadvice org-capture
    (after make-full-window-frame activate)
  "Advise capture to be the only window when used as a popup"
  (if (equal "emacs-capture" (frame-parameter nil 'name))
      (delete-other-windows)))

(defadvice org-capture-finalize
    (after delete-capture-frame activate)
  "Advise capture-finalize to close the frame"
  (if (equal "emacs-capture" (frame-parameter nil 'name))
      (delete-frame)))

(setq delete-old-versions -1)
(setq version-control t)

(unless (string-match-p "\\.gpg" org-agenda-file-regexp)
  (setq org-agenda-file-regexp
        (replace-regexp-in-string "\\\\\\.org" "\\\\.org\\\\(\\\\.gpg\\\\)?"
                                  org-agenda-file-regexp)))

(setq org-noter-set-auto-save-last-location t)

(require 'org-projectile)

(setq org-projectile-projects-file
      "~/my_org/project-tasks.org")
(push (org-projectile-project-todo-entry) org-capture-templates)

;; (setq org-agenda-files (append org-agenda-files (org-projectile-todo-files)))
;; Excluding the above since the entire my_org directory is already included in the agenda

(global-set-key (kbd "C-c n p") 'org-projectile-project-todo-completing-read)

(require 'org-expiry)
;; Configure it a bit to my liking
(setq
 org-expiry-created-property-name "CREATED" ; Name of property when an item is created
 org-expiry-inactive-timestamps   nil         ; Don't have everything in the agenda view
 )

(defun mrb/insert-created-timestamp()
  "Insert a CREATED property using org-expiry.el for TODO entries"
  (org-expiry-insert-created)
  (org-back-to-heading)
  (org-end-of-line)
  (insert " ")
  )

;; Whenever a TODO entry is created, I want a timestamp
;; Advice org-insert-todo-heading to insert a created timestamp using org-expiry
(defadvice org-insert-todo-heading (after mrb/created-timestamp-advice activate)
  "Insert a CREATED property using org-expiry.el for TODO entries"
  (mrb/insert-created-timestamp)
  )
;; Make it active
(ad-activate 'org-insert-todo-heading)

(require 'org-capture)

(defadvice org-capture (after mrb/created-timestamp-advice activate)
  "Insert a CREATED property using org-expiry.el for TODO entries"
   					; Test if the captured entry is a TODO, if so insert the created
   					; timestamp property, otherwise ignore
  (mrb/insert-created-timestamp))
;;  (when (member (org-get-todo-state) org-todo-keywords-1)
;;    (mrb/insert-created-timestamp)))
  (ad-activate 'org-capture)

;; Add feature to allow easy adding of tags in a capture window
(defun mrb/add-tags-in-capture()
  (interactive)
  "Insert tags in a capture window without losing the point"
  (save-excursion
    (org-back-to-heading)
    (org-set-tags)))
;; Bind this to a reasonable key
(define-key org-capture-mode-map "\C-c\C-t" 'mrb/add-tags-in-capture)

;; org-eww and org-w3m should be in your org distribution, but see
;; note below on patch level of org-eww.
(require 'org-eww)
(require 'org-w3m)
(defvar org-website-page-archive-file "~/my_org/full_article_archive.org")
(defun org-website-clipper ()
  "When capturing a website page, go to the right place in capture file,
   but do sneaky things. Because it's a w3m or eww page, we go
   ahead and insert the fixed-up page content, as I don't see a
   good way to do that from an org-capture template alone. Requires
   Emacs 25 and the 2017-02-12 or later patched version of org-eww.el."
  (interactive)

  ;; Check for acceptable major mode (w3m or eww) and set up a couple of
  ;; browser specific values. Error if unknown mode.

  (cond
   ((eq major-mode 'w3m-mode)
    (org-w3m-copy-for-org-mode))
   ((eq major-mode 'eww-mode)
    (org-eww-copy-for-org-mode))
   (t
    (error "Not valid -- must be in w3m or eww mode")))

  ;; Check if we have a full path to the archive file.
  ;; Create any missing directories.

  (unless (file-exists-p org-website-page-archive-file)
    (let ((dir (file-name-directory org-website-page-archive-file)))
      (unless (file-exists-p dir)
        (make-directory dir))))

  ;; Open the archive file and yank in the content.
  ;; Headers are fixed up later by org-capture.

  (find-file org-website-page-archive-file)
  (goto-char (point-max))
  ;; Leave a blank line for org-capture to fill in
  ;; with a timestamp, URL, etc.
  (insert "\n\n")
  ;; Insert the web content but keep our place.
  (save-excursion (yank))
  ;; Don't keep the page info on the kill ring.
  ;; Also fix the yank pointer.
  (setq kill-ring (cdr kill-ring))
  (setq kill-ring-yank-pointer kill-ring)
  ;; Final repositioning.
  (forward-line -1)
  )

(org-babel-do-load-languages
 'org-babel-load-languages
 '((clojure . t)
   (scheme . t))
 )

(require 'cider)
(setq org-babel-clojure-backend 'cider)

(message "Loaded org customisations")

;; Setting Helm as preferred package to use
(global-set-key (kbd "M-x") #'helm-M-x)
(global-set-key (kbd "C-x r b") #'helm-filtered-bookmarks)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(global-set-key (kbd "C-x b") #'helm-mini)

(custom-set-variables
 '(helm-follow-mode-persistent t))

(setq helm-mini-default-sources '(helm-source-buffers-list
                                  helm-source-recentf
                                  helm-source-bookmarks
                                  helm-source-buffer-not-found))

(setq helm-buffers-list-default-sources '(helm-source-buffers-list
                                          helm-source-recentf
                                          helm-source-bookmarks
                                          helm-source-buffer-not-found))

(require 'helm-ag)
(require 'helm-org-rifle)

(use-package helm-swoop
  :ensure t
  :bind (("M-i" . helm-swoop)
         ("M-I" . helm-swoop-back-to-last-point)
         ("C-c M-i" . helm-multi-swoop))
  :config
  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; From helm-swoop to helm-multi-swoop-all
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t
        ;; If this value is t, split window inside the current window
        helm-swoop-split-with-multiple-windows t
        ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
        helm-swoop-split-direction 'split-window-vertically
        ;; If nil, you can slightly boost invoke speed in exchange for text color
        helm-swoop-speed-or-color nil))

(message "Loaded Helm customisations")

(use-package flycheck
  :defer 5
  :bind (("M-g M-n" . flycheck-next-error)
         ("M-g M-p" . flycheck-previous-error)
         ("M-g M-=" . flycheck-list-errors))
  :init (global-flycheck-mode)
  :diminish flycheck-mode
  :config
  (progn
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc json-jsonlint json-python-json))
    (use-package flycheck-pos-tip
      :init (flycheck-pos-tip-mode))
    (use-package helm-flycheck
      :init (define-key flycheck-mode-map (kbd "C-c ! h") 'helm-flycheck))
    (use-package flycheck-haskell
      :init (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))))

(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(setq scheme-program-name "/Applications/MIT-GNU-Scheme.app/Contents/Resources/mit-scheme")
(require 'xscheme)

(message "Loaded scheme setup")

(defun my/refile (file headline &optional arg)
  "Refile to a specific location.

With a 'C-u' ARG argument, we jump to that location (see
`org-refile').

Use `org-agenda-refile' in `org-agenda' mode."
  (let* ((pos (with-current-buffer (or (get-buffer file) ;Is the file open in a buffer already?
				       (find-file-noselect file)) ;Otherwise, try to find the file by name (Note, default-directory matters here if it isn't absolute)
		(or (org-find-exact-headline-in-buffer headline)
		    (error "Can't find headline `%s'" headline))))
	 (filepath (buffer-file-name (marker-buffer pos))) ;If we're given a relative name, find absolute path
	 (rfloc (list headline filepath nil pos)))
    (if (and (eq major-mode 'org-agenda-mode) (not (and arg (listp arg)))) ;Don't use org-agenda-refile if we're just jumping
	(org-agenda-refile nil rfloc)
      (org-refile arg nil rfloc))))

(defun josh/refile (file headline &optional arg)
  "Refile to HEADLINE in FILE. Clean up org-capture if it's activated.

With a `C-u` ARG, just jump to the headline."
  (interactive "P")
  (let ((is-capturing (and (boundp 'org-capture-mode) org-capture-mode)))
    (cond
     ((and arg (listp arg))	    ;Are we jumping?
      (my/refile file headline arg))
     ;; Are we in org-capture-mode?
     (is-capturing      	;Minor mode variable that's defined when capturing
      (josh/org-capture-refile-but-with-args file headline arg))
     (t
      (my/refile file headline arg)))
    (when (or arg is-capturing)
      (setq hydra-deactivate t))))

(defun josh/org-capture-refile-but-with-args (file headline &optional arg)
  "Copied from `org-capture-refile' since it doesn't allow passing arguments. This does."
  (unless (eq (org-capture-get :type 'local) 'entry)
    (error
     "Refiling from a capture buffer makes only sense for `entry'-type templates"))
  (let ((pos (point))
	(base (buffer-base-buffer (current-buffer)))
	(org-capture-is-refiling t)
	(kill-buffer (org-capture-get :kill-buffer 'local)))
    (org-capture-put :kill-buffer nil)
    (org-capture-finalize)
    (save-window-excursion
      (with-current-buffer (or base (current-buffer))
	(org-with-wide-buffer
	 (goto-char pos)
	 (my/refile file headline arg))))
    (when kill-buffer (kill-buffer base))))

(defmacro josh/make-org-refile-hydra (hydraname file keyandheadline)
  "Make a hydra named HYDRANAME with refile targets to FILE.
KEYANDHEADLINE should be a list of cons cells of the form (\"key\" . \"headline\")"
  `(defhydra ,hydraname (:color blue :after-exit (unless (or hydra-deactivate
							     current-prefix-arg) ;If we're just jumping to a location, quit the hydra
						   (josh/org-refile-hydra/body)))
     ,file
     ,@(cl-loop for kv in keyandheadline
		collect (list (car kv) (list 'josh/refile file (cdr kv) 'current-prefix-arg) (cdr kv)))
     ("q" nil "cancel")))

;;;;;;;;;;
;; Here we'll define our refile headlines
;;;;;;;;;;

(josh/make-org-refile-hydra josh/org-refile-hydra-file-ds
			    "~/my_org/datascience.org"
			    (("1" . "@Datascience @Inbox")
			     ("2" . "@Datascience @Notes")))

(josh/make-org-refile-hydra josh/org-refile-hydra-file-bgr
			    "~/my_org/bgr.org"
			    (("1" . "#BGR #Inbox")
			     ("2" . "#questions @ BGR")
                             ("3" . "Inventory management Project")))

(josh/make-org-refile-hydra josh/org-refile-hydra-file-todoglobal
			    "todo-global.org"
			    (("1" . ";Emacs Stuff")
			     ("2" . ";someday")))

(defhydra josh/org-refile-hydra (:foreign-keys run)
  "Refile"
  ("a" josh/org-refile-hydra-file-ds/body "File A" :exit t)
  ("b" josh/org-refile-hydra-file-bgr/body "File B" :exit t)
  ("c" josh/org-refile-hydra-file-todoglobal/body "File C" :exit t)
  ("j" org-refile-goto-last-stored "Jump to last refile" :exit t)
  ("q" nil "cancel"))

(global-set-key (kbd "<f8> r") 'josh/org-refile-hydra/body)

(defun helm-do-ag-projects ()
  "Grep string in Project directory" (interactive)
  (let ((rootdir (concat "~/my_projects/")))
    (let ((helm-ag-command-option (concat helm-ag-command-option "")))
      (helm-do-ag rootdir))))

(defun helm-do-ag-emacs-config ()
  "Grep string in Emacs custom code"
  (interactive)
  (let ((rootdir (concat "~/scimax/user/sr-cust/")))
    (let ((helm-ag-command-option (concat helm-ag-command-option "")))
      (helm-do-ag rootdir))))

(defun helm-do-ag-journal ()
  "Grep string in journal"
  (interactive)
  (let ((specfile (concat "~/my_org/journal/")))
    (let ((helm-ag-command-option (concat helm-ag-command-option "")))
      (helm-ag-this-file rootdir))))

(defun helm-do-ag-bgr ()
  "Grep string in BGR file"
  (interactive)
  (let ((specfile (concat "~/my_org/bgr.org")))
    (let ((helm-ag-command-option (concat helm-ag-command-option "")))
      (helm-do-ag-this-file specfile))))

(defhydra shrysr/hydra-helm-ag-do-menu ()
  "
Helm-do-ag in specified locations
^location^  ^command^
----------------------------------------------------------
e:        emacs custom config
b:        bgr file
o:        org files
j:        journal search
"
  ("e" helm-do-ag-emacs-config)
  ("j" helm-do-ag-journal :color blue)
  ("p" helm-do-ag-projects)
  ("o" helm-do-ag-org)
  ("q" quit-window "quit" :color red))

(global-set-key (kbd "<f8> h") 'shrysr/hydra-helm-ag-do-menu/body)

;; scimax directory magit status
(defun sr/windows-magit-scimax ()
  (interactive)
  (ace-delete-other-windows)
  (dired "~/scimax/user/")
  (switch-window-then-split-right nil)
  (magit-status "~/scimax/")
  (switch-window)
  (split-window-vertically)
  (dired-up-directory)
  (windmove-right)
  )

;; my_org magit status
(defun sr/windows-magit-org ()
  (interactive)
  (ace-delete-other-windows)
  (magit-status "~/my_org/")
  )

;; magit status
(defun sr/windows-magit-projects ()
  (interactive)
  (ace-delete-other-windows)
  (switch-window-then-split-right nil)
  (magit-status "~/my_projects/")
  (switch-window)
  (dired "~/my_projects/")
  (switch-window)
  )

(defun sr/windows-projects ()
  (interactive)
  (ace-delete-other-windows)
  (switch-window-then-split-right nil)
  (projectile-switch-project)
  (switch-window)
  (find-file "~/my_org/project-tasks.org")
  (widen)
  (helm-org-rifle-current-buffer)
  (org-narrow-to-subtree)
  (outline-show-children)
  )

(defhydra sr/process-window-keys ()
  "
Key^^   ^Workflow^
--------------------
o       org magit
s       scimax magit
p       projects magit
w       select project and set window config
SPC     exit
"
  ("o" sr/windows-magit-org )
  ("p" sr/windows-magit-projects )
  ("s" sr/windows-magit-scimax )
  ("w" sr/windows-projects)
  ("SPC" nil)
  )

(global-set-key (kbd "<f8> m") 'sr/process-window-keys/body)

(message "Loaded Hydras")

;; use an org file to organise feeds
(use-package elfeed-org
  :ensure t
  :config
  (elfeed-org)
  (setq rmh-elfeed-org-files (list "~/my_org/elfeed.org"))
  )

(message "Loaded Elfeed customisations")

(setq browse-url-browser-function 'w3m-goto-url-new-session)
(setq w3m-default-display-inline-images t)

;;when I want to enter the web address all by hand
(defun w3m-open-site (site)
  "Opens site in new w3m session with 'http://' appended"
  (interactive
   (list (read-string "Enter website address(default: w3m-home):" nil nil w3m-home-page nil )))
  (w3m-goto-url-new-session
   (concat "http://" site)))

(eval-after-load 'w3m
  '(progn
     (define-key w3m-mode-map "q" 'w3m-previous-buffer)
     (define-key w3m-mode-map "w" 'w3m-next-buffer)
     (define-key w3m-mode-map "x" 'w3m-close-window)))

(defun wicked/w3m-open-current-page-in-firefox ()
  "Open the current URL in Mozilla Firefox."
  (interactive)
  (browse-url-default-macosx-browser w3m-current-url)) ;; (1)

(defun wicked/w3m-open-link-or-image-in-firefox ()
  "Open the current link or image in Firefox."
  (interactive)
  (browse-url-default-macosx-browser (or (w3m-anchor) ;; (2)
                                         (w3m-image)))) ;; (3)

(eval-after-load 'w3m
  '(progn
     (define-key w3m-mode-map "o" 'wicked/w3m-open-current-page-in-firefox)
     (define-key w3m-mode-map "O" 'wicked/w3m-open-link-or-image-in-firefox)))

(defun wikipedia-search (search-term)
  "Search for SEARCH-TERM on wikipedia"
  (interactive
   (let ((term (if mark-active
                   (buffer-substring (region-beginning) (region-end))
                 (word-at-point))))
     (list
      (read-string
       (format "Wikipedia (%s):" term) nil nil term)))
   )
  (browse-url
   (concat
    "http://en.m.wikipedia.org/w/index.php?search="
    search-term
    ))
  )

(defun hn ()
  (interactive)
  (browse-url "http://news.ycombinator.com"))

;; Check for org mode and existence of buffer
(defun f-ediff-org-showhide (buf command &rest cmdargs)
  "If buffer exists and is orgmode then execute command"
  (when buf
    (when (eq (buffer-local-value 'major-mode (get-buffer buf)) 'org-mode)
      (save-excursion (set-buffer buf) (apply command cmdargs)))))

(defun f-ediff-org-unfold-tree-element ()
  "Unfold tree at diff location"
  (f-ediff-org-showhide ediff-buffer-A 'org-reveal)
  (f-ediff-org-showhide ediff-buffer-B 'org-reveal)
  (f-ediff-org-showhide ediff-buffer-C 'org-reveal))

(defun f-ediff-org-fold-tree ()
  "Fold tree back to top level"
  (f-ediff-org-showhide ediff-buffer-A 'hide-sublevels 1)
  (f-ediff-org-showhide ediff-buffer-B 'hide-sublevels 1)
  (f-ediff-org-showhide ediff-buffer-C 'hide-sublevels 1))

(add-hook 'ediff-select-hook 'f-ediff-org-unfold-tree-element)
(add-hook 'ediff-unselect-hook 'f-ediff-org-fold-tree)

(setq default-frame-alist
      '((background-color . "light grey")
        (foreground-color . "black")
        (fullscreen . maximized)
        ))

(setq custom-safe-themes t)
(set-background-color "light gray")

;; For Linux
(if (system-type-is-gnu)
    (set-face-attribute 'default nil :family "ttf-iosevka" :height 140))

;; For Mac OS
(if (system-type-is-darwin)
    (set-face-attribute 'default nil :family "Iosevka Type" :height 150))

(setq
 global-visual-line-mode 1
 fill-column 80)

(defvar hugo-content-dir "~/my_gits/hugo-sr/content/post/"
  "Path to Hugo's content directory")

(defun hugo-ensure-property (property)
  "Make sure that a property exists. If not, it will be created.
Returns the property name if the property has been created, otherwise nil."
  (org-id-get-create)
  (if (org-entry-get nil property)
      nil
    (progn (org-entry-put nil property "")
           property)))

(defun hugo-ensure-properties ()

  (require 'dash)
  (let ((current-time (format-time-string
                       (org-time-stamp-format t t) (org-current-time)))
        first)
    (save-excursion
      (setq first (--first it (mapcar #'hugo-ensure-property
                                      '("HUGO_TAGS" "HUGO_CATEGORIES"))))
      (unless (org-entry-get nil "HUGO_DATE")
        (org-entry-put nil "EXPORT_DATE" current-time)))
    (org-entry-put nil "EXPORT_FILE_NAME" (org-id-get-create))
    (org-entry-put nil "EXPORT_HUGO_CUSTOM_FRONT_MATTER" ":profile false")
    (when first
      (goto-char (org-entry-beginning-position))
      ;; The following opens the drawer
      (forward-line 1)
      (beginning-of-line 1)
      (when (looking-at org-drawer-regexp)
        (org-flag-drawer nil))
      ;; And now move to the drawer property
      (search-forward (concat ":" first ":"))
      (end-of-line))
    first))

(defun hugo ()
  (interactive)
  (unless (hugo-ensure-properties)
    (let* ((type    (concat "type = \"" (org-entry-get nil "HUGO_TYPE") "\"\n"))
           (date     (concat "date = \""
                             (format-time-string "%Y-%m-%d"
                                                 (apply 'encode-time
                                                        (org-parse-time-string
                                                         (org-entry-get nil "HUGO_DATE"))) t) "\"\n"))
           (tags     (concat "tags = [ \""
                             (mapconcat 'identity
                                        (split-string
                                         (org-entry-get nil "HUGO_TAGS")
                                         "\\( *, *\\)" t) "\", \"") "\" ]\n"))
           (fm (concat "+++\n"
                       title
		       type
                       date
                       tags
                       topics
                       "+++\n\n"))
           (coding-system-for-write buffer-file-coding-system)
           (backend  'md)
           (blog))
      ;; try to load org-mode/contrib/lisp/ox-gfm.el and use it as backend
      (if (require 'ox-gfm nil t)
          (setq backend 'gfm)
        (require 'ox-md))
      (setq blog (org-export-as backend t))
      ;; Normalize save file path
      (unless (string-match "^[/~]" file)
        (setq file (concat hugo-content-dir file))
        (unless (string-match "\\.md$" file)
          (setq file (concat file ".md")))
        ;; save markdown
        (with-temp-buffer
          (insert fm)
          (insert blog)
          (untabify (point-min) (point-max))
          (write-file file)
          (message "Exported to %s" file))))))

(use-package ox-hugo
  :ensure t
  :defer t
  :custom
  (org-hugo--tag-processing-fn-replace-with-hyphens-maybe t)
  )

(defun hotspots ()
  "helm interface to my hotspots, which includes my locations,
org-files and bookmarks"
  (interactive)
  (helm :sources `(((name . "Mail and News")
                    (candidates . (("Agenda All" . (lambda () (org-agenda "" "a")))
                                   ("Agenda Office" . (lambda () (org-agenda "" "o")))
				   ("Mail" . (lambda ()
                                               (if (get-buffer "*mu4e-headers*")
                                                   (progn
                                                     (switch-to-buffer "*mu4e-headers*")
                                                     (delete-other-windows))
                                                 (mu4e))))
                                   ("Calendar" .
                                    (lambda ()
                                      (browse-url
                                       "https://www.google.com/calendar/render")))
                                   ("RSS" . elfeed)))
                    (action . (("Open" . (lambda (x) (funcall x))))))
                   ((name . "My Locations")
                    (candidates . (("CV Org" . "~/org_cv/CV_Shreyas_Ragavan.org")
                                   ("scd - scimax dir" . "~/scimax/" )
                                   ("scu - scimax user dir" . "~/scimax/user/")
                                   ( "sco - scimax org conf". "~/scimax/user/sr-config.org")
                                   ("blog" . "~/my_org/blog-book.org")
				   ("github" . "~/my_gits/")
                                   ("project" . "~/my_projects/")
                                   ("cheatsheet" . "~/my_cheatsheets/")
                                   ("passwords" . "~/my_org/secrets.org.gpg")
                                   ("references" . "~/Dropbox/bibliography/references.bib")
                                   ))
                    (action . (("Open" . (lambda (x) (find-file x))))))

                   ((name . "My org files")
                    (candidates . ,(f-entries "~/my_org"))
                    (action . (("Open" . (lambda (x) (find-file x))))))
                   helm-source-recentf
                   helm-source-bookmarks
                   helm-source-bookmark-set)))

(setq nb-notebook-directory "~/my_projects/")

(global-set-key (kbd "M-s n") 'nb-open)

(scimax-ob-ipython-turn-on-eldoc)

(require 'ox-word)

(defun sr/dotemacs-export()
  (interactive)
  "Exporting to org file and lisp"
  (org-hugo-export-to-md)
  (copy-file "~/scimax/user/sr-config.org" "~/my_projects/dotemacs/README.org" "OK-IF-ALREADY-EXISTS")
  ;; (find-file-existing "~/my_projects/dotemacs/README.org")
  (org-babel-tangle-file  "~/my_projects/dotemacs/README.org" "~/my_projects/dotemacs/config.el"))

(if (system-type-is-darwin)
    (progn
      (use-package mu4e
        :ensure nil
        :config
        (require 'mu4e)
        (require 'mu4e-contrib)
        (require 'org-mu4e)

        (setq
         mue4e-headers-skip-duplicates  t
         mu4e-view-show-images t
         mu4e-view-show-addresses 't
         mu4e-compose-format-flowed nil
         mu4e-update-interval 200
         message-ignored-cited-headers 'nil
         mu4e-date-format "%y/%m/%d"
         mu4e-headers-date-format "%Y/%m/%d"
         mu4e-change-filenames-when-moving t
         mu4e-attachments-dir "~/Downloads/Mail-Attachments/"
         mu4e-maildir (expand-file-name "~/my_mail/fmail")
         )

        ;; mu4e email refiling loations
        (setq
         mu4e-refile-folder "/Archive"
         mu4e-trash-folder  "/Trash"
         mu4e-sent-folder   "/Sent"
         mu4e-drafts-folder "/Drafts"
         )

        ;; setup some handy shortcuts
        (setq mu4e-maildir-shortcuts
              '(("/INBOX"   . ?i)
	        ("/Sent"    . ?s)
	        ("/Archive" . ?a)
	        ("/Trash"   . ?t)))

        ;;store link to message if in header view, not to header query
        (setq org-mu4e-link-query-in-headers-mode nil
              org-mu4e-convert-to-html t) ;; org -> html

        ;; Enabling view in browser for HTML heavy emails that don't render well
        (add-to-list 'mu4e-view-actions
	             '("ViewInBrowser" . mu4e-action-view-in-browser) t)

        (autoload 'mu4e "mu4e" "mu for Emacs." t)

        ;; Config for sending email
        (setq
         message-send-mail-function 'message-send-mail-with-sendmail
         send-mail-function 'sendmail-send-it
         message-kill-buffer-on-exit t
         )

        ;; allow for updating mail using 'U' in the main view:
        (setq mu4e-get-mail-command  "mbsync -a -q")

        ;; Don't keep asking for confirmation for every action
        (defun my-mu4e-mark-execute-all-no-confirm ()
          "Execute all marks without confirmation."
          (interactive)
          (mu4e-mark-execute-all 'no-confirm))
        ;; mapping x to above function
        (define-key mu4e-headers-mode-map "x" #'my-mu4e-mark-execute-all-no-confirm)
        )
      ;; source: http://matt.hackinghistory.ca/2016/11/18/sending-html-mail-with-mu4e/

      ;; this is stolen from John but it didn't work for me until I
      ;; made those changes to mu4e-compose.el
      (defun htmlize-and-send ()
        "When in an org-mu4e-compose-org-mode message, htmlize and send it."
        (interactive)
        (when
            (member 'org~mu4e-mime-switch-headers-or-body post-command-hook)
          (org-mime-htmlize)
          (org-mu4e-compose-org-mode)
          (mu4e-compose-mode)
          (message-send-and-exit)))

      ;; This overloads the amazing C-c C-c commands in org-mode with one more function
      ;; namely the htmlize-and-send, above.
      (add-hook 'org-ctrl-c-ctrl-c-hook 'htmlize-and-send t)
      )
  )