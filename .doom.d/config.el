(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
(add-to-list 'exec-path "/usr/local/bin/")
(executable-find "aspell")

(setq-default display-line-numbers 'visual)
(setq display-line-numbers 'visual)
(setq doom-line-numbers-style 'visual)
(menu-bar-mode 1)
(load-theme 'doom-dark+ t)
(setq doom-font (font-spec :family "MesloLGLDZ Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "MesloLGLDZ Nerd Font" :size 14)
      doom-big-font (font-spec :family "MesloLGLDZ Nerd Font" :size 19))

(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "Emacs Is More Than A Text Editor!")
  (setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  ;; (setq dashboard-startup-banner "~/.config/doom/doom-emacs-dash.png")  ;; use custom image as banner
  (setq dashboard-center-content t) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book"))))

;; (projectile-rails-global-mode)
;; ;; (global-rbenv-mode)
;; (defun start-rails-server ()
;;   "Start the rails server"
;;   (interactive)
;;   (set-process-sentinel
;;    (start-process-shell-command "rails server" "rails server" (concat (projectile-rails-root) "bin/rails server"))
;;    (lambda (p _m)
;;      (when (eq 0 (process-exit-status p))
;;        (with-current-buffer (process-buffer p)
;;          (ansi-color-apply-on-region (point-min) (point-max))))))

;;   )
;; (map! :n :prefix ","
;;       (:desc "Test project" :n "t" #'projectile-test-project)
;;       (:desc "Start rails server" :n "S" #'start-rails-server)
;;       )

(require 'ox-md)
(require 'ox-hugo)
(require 'ox-confluence)
(require 'org-capture)
(require 'org-protocol)
;(org-babel-do-load-languages
;    'org-babel-load-languages
;    '((emacs-lisp . t)
;      (sh . t)
;      (python . t)
;      (ruby . t)
;    )
; )

(setq org-directory "~/Dropbox/Notes")
(set-face-attribute 'org-headline-done nil :strike-through t)

(setq org-capture-templates '(
  ("t" "Todo [inbox]" entry
      (file+headline "~/Documents/gtd/inbox.org" "Tasks") "* TODO %i%?")
  ("T" "Tickler" entry
      (file+headline "~/Documents/gtd/tickler.org" "Tickler") "* %i%? \n %U")
  ("l" "Temp Links from the interwebs" entry
      (file+headline "~/Documents/gtd/links.org" "Temporary Links")
          "* %a\n%?\nEntered on %U\n \%i\n")
  ("c" "Cookbook" entry (file "~/org/cookbook.org")
      "%(org-chef-get-recipe-from-url)" :empty-lines 1)
  ("m" "Manual Cookbook" entry (file "~/org/cookbook.org")
      "* %^{Recipe title: }\n  :PROPERTIES:\n  :source-url:\n  :servings:\n  :prep-time:\n  :cook-time:\n  :ready-in:\n  :END:\n** Ingredients\n   %?\n** Directions\n\n")
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

(setq base-ref ".")
(setf my-header
      (format
       "
        <base href='%s'>
        <link rel='stylesheet' href='etc/style.css' type='text/css'/>
        "
       base-ref))
(setf org-publish-project-alist
      `(("orgfiles"
         :base-directory "~/org/manmethoed/"
         :base-extension "org"
         :publishing-directory "~/public-html/"
         :publishing-function org-html-publish-to-html
         :exclude "PrivatePage.org" ;; regexp
         :headline-levels 1
         :section-numbers t
         :with-toc nil
         :with-date nil
         :with-author nil
         :with-creator nil
         :html-validation-link nil
         :html-head ,my-header
         :html-preamble "hello"
         :html-postamble nil)

        ("images"
         :base-directory "~/org/manmethoed/"
         :base-extension "jpg\\|gif\\|png"
         :publishing-directory "~/public-html/images/"
         :publishing-function org-publish-attachment)

        ("other"
         :base-directory "~/org/manmethoed/"
         :base-extension "css\\|js"
         :publishing-directory "~/public-html/etc/"
         :publishing-function org-publish-attachment)
        ("website" :components ("orgfiles" "images" "other"))))

(setq org-agenda-files '("~/Documents/gtd/inbox.org"
                         "~/Documents/gtd/gtd.org"
                         "~/Documents/gtd/tickler.org"))
(setq org-agenda-custom-commands
      '(("Y" alltodo "" nil ("~/todos.txt")))
      )

(setq diary-file "~/Documents/gtd/diary")

(require 'org-gcal)
(setq org-gcal-client-id "818210936169-7hdbvpqdg9jib2845teqf08i71h16tlv.apps.googleusercontent.com"
      org-gcal-client-secret "aq4jLz970s_JYd50y3g3-QO9"
      org-gcal-fetch-file-alist '(("jelle.helsen@hcode.be" .  "~/Documents/gtd/hcode.org")))

(setq org-refile-targets '(("~/Documents/gtd/gtd.org" :maxlevel . 3)
                           ("~/Documents/gtd/someday.org" :level . 1)
                           ("~/Documents/gtd/tickler.org" :maxlevel . 2)))

(setq user-mail-address "jelle.helsen@hcode.be")

(setq mu4e-maildir "~/email"
      mu4e-trash-folder "/Trash"
      mu4e-refile-folder "/Archive"
      mu4e-get-mail-command "mbsync -a"
      mu4e-update-interval nil
      mu4e-compose-signature-auto-include nil
      mu4e-view-show-images t
      mu4e-view-show-addresses t)

(with-eval-after-load 'mu4e (setq mu4e-contexts
                                  `(
                                    ,(make-mu4e-context
                                      :name "hcode"
                                      :enter-func (lambda () (mu4e-message "Entering HCODE context"))
                                      :match-func (lambda(msg)
                                                    (when msg
                                                      (string-match-p "^/hcode" (mu4e-message-field msg :maildir))))
                                      :vars '(
                                              (user-mail-address . "jelle.helsen@hcode.be")
                                              (user-full-name    . "Jelle Helsen")
                                              (mu4e-compose-signature . "With kind regards,\nJelle Helsen")
                                              (smtpmail-smtp-user "jelle.helsen@hcode.be")
                                              )
                                      )
                                    ,(make-mu4e-context
                                      :name "devoteam"
                                      :enter-func (lambda () (mu4e-message "Entering DevoTeam context"))
                                      :match-func (lambda(msg)
                                                    (when msg
                                                      (string-match-p "^/devoteam" (mu4e-message-field msg :maildir))))
                                      :vars '(
                                              (user-mail-address . "jelle.helsen@devoteam.com")
                                              (user-full-name    . "Jelle Helsen")
                                              (mu4e-compose-signature . "With kind regards,\nJelle Helsen")
                                              (smtpmail-smtp-user "jelle.helsen@devoteam.com")
                                              )
                                      )
                                    )
                                  ) )

(setq mu4e-maildir-shortcuts
      '(
        ("/hcode/INBOX" . ?g)
        ("/devoteam/INBOX" . ?d)
        ))

(setq mu4e-bookmarks
      `(("flag:unread AND NOT flag:trashed AND NOT maildir:/Trash/" "Unread messages" ?u)
        ("date:today..now AND NOT flag:trashed AND NOT maildir:/Trash/" "Today's messages" ?t)
        ("date:7d..now AND NOT maildir:/Trash/" "Last 7 days" ?w)
        ("mime:image/*" "Messages with images" ?p)
        (,(mapconcat 'identity
                     (mapcar
                      (lambda (maildir)
                        (concat "maildir:" (car maildir)))
                      mu4e-maildir-shortcuts) " OR ")
         "All inboxes" ?i)))

(setq sendmail-program "msmtp"
      send-mail-function 'smtpmail-send-it
      message-sendmail-f-is-evil t
      message-sendmail-extra-arguments '("--read-envelope-from")
      message-send-mail-function 'smtpmail-send-it)

(setq lastpass-user "jelle.helsen@hcode.be")
(setq lastpass-trust-login t)
;; Enable lastpass custom auth-source
;; (lastpass-auth-source-enable)
(defun lastpass-mu4e-update-mail-and-index (update-function &rest r)
  "Check if user is logged in and run UPDATE-FUNCTION with arguments R."
  (unless (lastpass-logged-in-p)
    (lastpass-login)
    (error "LastPass: Not logged in, log in and retry"))
  (apply update-function r))

(advice-add 'mu4e-update-mail-and-index :around #'lastpass-mu4e-update-mail-and-index)

(setenv "GPG_AGENT_INFO" nil)
(all-the-icons-gnus-setup)
(setq user-mail-address "jelle.helsen@hcode.be"
      user-full-name "Jelle Helsen")

(setq gnus-summary-line-format "%U%R %-18,18&user-date; %4L:%-25,25f %B%s\n")
(setq nnmail-expiry-wait 'immediate)

(setq gnus-select-method '(nnnil ""))
(setq gnus-secondary-select-methods
      '((nntp "news.gwene.org")
        (nntp "news.eternal-september.org")
        (nnimap "hcode"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnimap-streaming t)
                (nnimap-record-commands nil)
                (nnimap-list-pattern ("INBOX"))
                (nnmail-expiry-wait immediate)
                )
        (nnimap "devoteam"
                (nnimap-address "imap.gmail.com")
                (nnimap-server-port 993)
                (nnimap-stream ssl)
                (nnimap-streaming t)
                (nnimap-record-commands nil)
                (nnimap-list-pattern ("INBOX"))
                (nnmail-expiry-wait immediate)
                )
        )
      gnus-novice-user t
      gnus-expert-user nil
      gnus-agent nil
      gnus-activate-level 3
      )
;; Reply to mails with matching email address
(setq gnus-posting-styles
      '((".*" ; Matches all groups of messages
         (address "JelleHelsen <jelle.helsen@hcode.be>"))
        ("devoteam" ; Matches Gnus group called "devoteam"
         (address "Jelle Helsen <jelle.helsen@devoteam.com>")
         (organization "Devoteam")
         ;; (signature-file "~/.signature-work")
         ("X-Message-SMTP-Method" "smtp smtp.gmail.com 587 jelle.helsen@devoteam.com"))))

(setq auth-source-debug t)
(setq nnimap-record-commands t)

(add-hook 'gnus-group-mode-hook #'gnus-topic-mode)

(setq smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      gnus-ignored-newsgroups nil)

(elfeed-org)
(add-hook! 'elfeed-show-mode-hook (setq display-line-numbers nil))
(require 'elfeed-goodies)
(elfeed-goodies/setup)
(after! elfeed-goodies
  (setq elfeed-goodies/entry-pane-size 0.5)
  )
;; (add-hook! 'elfeed-show-mode-hook #'menu-bar--display-line-numbers-mode-none)

(map! :map elfeed-search-mode-map
      :localleader
      :desc "Update" "u" #'elfeed-update
      )

(require 'confluence)
(setq confluence-url "https://confluence.rel.apps.telenet.be/rpc/xmlrpc")

(map! :leader
      (:desc "Apps" :prefix "a"
       :desc "Email" :n "m" #'gnus
       :desc "IRC" :n "i" #'irc
       :desc "RSS" :n "r" #'elfeed
       ))

(map! :leader
      (:desc "project" :prefix "p"
       :desc "Browse project"          :n  "." #'+default/browse-project
       :desc "Find file in project"    :n  "/" #'projectile-find-file
       :desc "Run cmd in project root" :nv "!" #'projectile-run-shell-command-in-root
       :desc "Compile project"         :n  "c" #'projectile-compile-project
       :desc "Test project"            :n  "t" #'projectile-test-project
       :desc "Find other file"         :n  "o" #'projectile-find-other-file
       :desc "Switch project"          :n  "p" #'projectile-switch-project
       :desc "Recent project files"    :n  "r" #'projectile-recentf
       :desc "List project tasks"      :n  "T" #'+ivy/tasks
       :desc "Find in project (ag)"   :n  "a" #'counsel-projectile-ag
       :desc "Invalidate cache"        :n  "x" #'projectile-invalidate-cache)     )

;(nvm-use "10.11.0")
;(setq exec-path (append '("~/.nvm/versions/node/v10.11.0/bin/") exec-path))
;(setenv "PATH" (concat "~/.nvm/versions/node/v10.11.0/bin/:" (getenv "PATH")))

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default tab-width 2)
(setq evil-shift-width 2)
(setq-default evil-shift-width 2)
(setq-default doom-line-numbers-style 'visual)
(setq doom-line-numbers-style 'visual)
(setq display-line-numbers 'visual)
(setq-default display-line-numbers 'visual)
;; (setq visual-line-mode t)
(setq display-line-numbers-type 'visual)
(global-visual-line-mode)

(setenv "PATH" (concat "~/go/bin/:" (getenv "PATH")))
(add-to-list 'load-path "~/go/bin/")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/")

(setq yaml-indent-level 2)

;; (add-to-list 'tramp-remote-path 'tramp-own-remote-path)

(set-irc-server! "irc.freenode.net"
  `(:tls t
    :nick "doom"
    :channels ("#emacs")))

(advice-add 'python-mode :before 'elpy-enable)
(setq elpy-rpc-virtualenv-path 'current)

(setq projectile-project-search-path '("~/Documents/code/mine"
                                       "~/Documents/code/telenet"
                                       "~/Documents/code/opensource"
                                       ))

(use-package! ox-moderncv
  :init (require 'ox-moderncv))

load-path

(setq ispell-dictionary "english")
