set from = jelle.helsen@devoteam.com
set realname = "Jelle Helsen"

# Imap settings
set imap_user = "jelle.helsen@devoteam.com"
set imap_pass = `lpass show --password 2657500617998023898`

set sendmail="/usr/local/bin/msmtp -a devoteam"

# Remote gmail folders
set folder = "imaps://imap.gmail.com/"
set spoolfile = "+INBOX"
set postponed = "+[Gmail]/Drafts"
set record = ""
set trash = ""
set signature="~/.mutt/devoteam_signature"

color status red color235
