(setq-default display-line-numbers 'visual)
(menu-bar-mode 1)

(projectile-rails-global-mode)
(global-rbenv-mode)

(setq org-directory "~/Dropbox/Notes")

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
      `(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
        ("date:today..now" "Today's messages" ?t)
        ("date:7d..now" "Last 7 days" ?w)
        ("mime:image/*" "Messages with images" ?p)
        (,(mapconcat 'identity
                     (mapcar
                      (lambda (maildir)
                        (concat "maildir:" (car maildir)))
                      mu4e-maildir-shortcuts) " OR ")
         "All inboxes" ?i)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-stream-type  'ssl
      smtpmail-smtp-service 465
      )

(require 'confluence)
(setq confluence-url "https://wikiprojects.upc.biz/rpc/xmlrpc")
(with-eval-after-load 'org-jira (setq jiralib-url "https://jira.lgi.io"))

(map! :leader
     (:desc "Apps" :prefix "a"
       :desc "Email" :n "m" #'mu4e
       :desc "IRC" :n "i" #'irc
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
        :desc "Invalidate cache"        :n  "x" #'projectile-invalidate-cache)     )
