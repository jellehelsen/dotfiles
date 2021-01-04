set from = jelle.helsen@hcode.be
set realname = "Jelle Helsen"

# Imap settings
set imap_user = "jelle.helsen@hcode.be"
set imap_pass = `lpass show --password hcode-app-pass`
set sendmail="/usr/local/bin/msmtp -a personal"

# Remote gmail folders
set folder = "imaps://imap.gmail.com/"
set spoolfile = "+INBOX"
set postponed = "+[Gmail]/Drafts"
set record = ""
set trash = "+[Gmail]/Trash"

color status blue color235
