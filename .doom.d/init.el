;;; init.el -*- lexical-binding: t; -*-
;; Copy me to ~/.doom.d/init.el or ~/.config/doom/init.el, then edit me!

(add-to-list 'exec-path "/usr/local/bin/")
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")
(setq exec-path-from-shell-check-startup-files nil)
(setq exec-path-from-shell-variables '("PATH" "GOPATH"))
(use-package-hook! doom-themes
  :pre-config
  (setq exec-path-from-shell-check-startup-files nil)
  (setq exec-path-from-shell-variables '("PATH" "GOPATH"))
  (exec-path-from-shell-initialize)
  nil)

(doom! :input

       :completion
       ;; (company          ; the ultimate code completion backend
        ;; +auto)           ; as-you-type code completion
       ;; (helm             ; the *other* search engine for love and life
       ;;  +fuzzy)          ; enable fuzzy search backend for helm
       ;;ido               ; the other *other* search engine...
       (ivy
        +icons
        )              ; a search engine for love and life
       ;; +fuzzy)          ; enable fuzzy search backend for ivy


       :ui
       ;;deft              ; notational velocity for Emacs
       doom              ; what makes DOOM look the way it does
       ;; doom-dashboard    ; a nifty splash screen for Emacs
       modeline          ; a snazzy Atom-inspired mode-line
       doom-quit         ; DOOM quit-message prompts when you quit Emacs
       fill-column       ; a `fill-column' indicator
       hl-todo           ; highlight TODO/FIXME/NOTE tags
       nav-flash         ; blink the current line after jumping
       ;;neotree           ; a project drawer, like NERDTree for vim
       treemacs          ; a project drawer, like neotree but cooler
       (popup            ; tame sudden yet inevitable temporary windows
        ;; +all             ; catch all popups that start with an asterix
        +defaults)       ; default popup rules
       ligatures         ; replace bits of code with pretty symbols
       ;;tabbar            ; FIXME an (incomplete) tab bar for Emacs
       unicode           ; extended unicode support for various languages
       vc-gutter         ; vcs diff in the fringe
       vi-tilde-fringe   ; fringe tildes to mark beyond EOB
       window-select     ; visually switch windows
       workspaces
       (emoji +ascii +github +unicode)
       ;; ophints
       ;; zen

       :editor
       (format +onsave)  ; automated prettiness
       ;; multiple-cursors  ; editing in many places at once
       ;;parinfer          ; turn lisp into python, sort of
       ;; rotate-text       ; cycle region at point between text candidates
       ;;fold
       (evil +everywhere)
       file-templates
       snippets

       :emacs
       dired             ; making dired pretty [functional]
       ediff             ; comparing files in Emacs
       electric          ; smarter, keyword-based electric-indent
       ;; eshell            ; a consistent, cross-platform shell (WIP)
       ;; imenu             ; an imenu sidebar and searchable code index
       vc                ; version-control and Emacs, sitting in a tree
       undo

       :term              ; terminals in Emacs
       eshell
       shell

       :checkers
       spell
       syntax

       :tools
       ansible
       docker
       editorconfig      ; let someone else argue about tabs vs spaces
       ;;ein               ; tame Jupyter notebooks with emacs
       ;;gist              ; interacting with github gists
       make              ; run make tasks from Emacs
       magit             ; a git porcelain for Emacs
       ;; password-store    ; password manager for nerds
       pdf               ; pdf enhancements
       prodigy           ; FIXME managing external services & code builders
       rgb               ; creating color strings
       eval
       lookup
       pass
       ;;terraform         ; infrastructure as code
       tmux              ; an API for interacting with tmux
       ;;upload            ; map local to remote projects via ssh/ftp
       wakatime

       :os
       (:if IS-MAC macos)             ; MacOS-specific commands
       tty

       :lang
       ;;assembly          ; assembly for fun or debugging
       cc; C/C++/Obj-C madness
       ;;clojure           ; java with a lisp
       ;; common-lisp       ; if you've seen one lisp, you've seen them all
       ;;coq               ; proofs-as-programs
       ;;crystal           ; ruby at the speed of c
       ;;csharp            ; unity, .NET, and mono shenanigans
       data              ; config/data formats
       ;;erlang            ; an elegant language for a more civilized age
       ;;elixir            ; erlang done right
       ;;elm               ; care for a cup of TEA?
       emacs-lisp        ; drown in parentheses
       ;;ess               ; emacs speaks statistics
       go                ; the hipster dialect
       ;;(haskell +intero) ; a language that's lazier than I am
       ;;hy                ; readability of scheme w/ speed of python
       ;;idris             ;
       ;;(java +meghanada) ; the poster child for carpal tunnel syndrome
       javascript        ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia             ; a better, faster MATLAB
       latex             ; writing papers in Emacs has never been so fun
       ;; ledger            ; an accounting system in Emacs
       lua               ; one-based indices? one-based indices
       markdown          ; writing docs for people to ignore
       ;;nim               ; python + lisp at the speed of c
       ;; nix               ; I hereby declare "nix geht mehr!"
       ;;ocaml             ; an objective camel
       (org              ; organize your plain life in plain text
        +attach          ; custom attachment system
        +babel           ; running code in org
        +capture         ; org-capture in and outside of Emacs
        +export          ; Exporting org to whatever you want
        +present)        ; Emacs for presentations
       ;;perl              ; write code no one else can comprehend
       ;;php               ; perl's insecure younger brother
       ;; plantuml          ; diagrams for confusing people more
       ;;purescript        ; javascript, but functional
       python            ; beautiful is better than ugly
       ;;qt                ; the 'cutest' gui framework ever
       ;;racket            ; a DSL for DSLs
       rest              ; Emacs as a REST client
       ruby              ; 1.step do {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;rust              ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala             ; java, but good
       (sh +zsh)        ; she sells (ba|z|fi)sh shells on the C xor
       solidity          ; do you need a blockchain? No.
       swift             ; who asked for emoji variables?
       web               ; the tubes
       ;;vala              ; GObjective-C

       ;; Applications are complex and opinionated modules that transform Emacs
       ;; toward a specific purpose. They may have additional dependencies and
       ;; should be loaded late.
       :app
       irc               ; how neckbeards socialize
       (rss +org)        ; emacs as an RSS reader
       twitter           ; twitter client https://twitter.com/vnought
       (write            ; emacs as a word processor (latex + org + markdown)
       +wordnut         ; wordnet (wn) search
       +langtool)       ; a proofreader (grammar/style check) for Emacs

       :email
       (mu4e +gmail)
       ;; notmuch
       ;; (wanderlust +gmail)

       :collab
       ;;floobits          ; peer programming for a price
       ;; impatient-mode    ; show off code over HTTP

       :config
       ;; For literate config users. This will tangle+compile a config.org
       ;; literate config in your `doom-private-dir' whenever it changes.
       literate

       ;; The default module sets reasonable defaults for Emacs. It also
       ;; provides a Spacemacs-inspired keybinding scheme, a custom yasnippet
       ;; library, and additional ex commands for evil-mode. Use it as a
       ;; reference for your own modules.
       (default +bindings +snippets +evil-commands))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("728eda145ad16686d4bbb8e50d540563573592013b10c3e2defc493f390f7d83" "66d53738cc824d0bc5b703276975581b8de2b903d6ce366cd62207b5dd6d3d13" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "428754d8f3ed6449c1078ed5b4335f4949dc2ad54ed9de43c56ea9b803375c23" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
