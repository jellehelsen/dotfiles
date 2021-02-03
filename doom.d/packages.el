;; -*- no-byte-compile: t; -*-
;;; ~/.doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:fetcher github :repo "username/repo"))
;; (package! builtin-package :disable t)

(package! projectile-rails)
(package! rbenv)
(package! nvm)
(package! confluence)
(package! org-jira)
(package! emmet-mode)
(package! mocha)
(package! groovy-mode)
(package! go-mode)
(package! kubernetes)
(package! kubernetes-evil)
(package! kubernetes-helm)
(package! kubernetes-tramp)
(package! exec-path-from-shell)
(package! ox-hugo)
(package! elpy)
(package! toml-mode)
(package! ox-moderncv :recipe
  (:host gitlab
   :repo "Titan-C/org-cv"
   :files ("*.el")))
(package! blacken)
(package! origami)
(package! ag)
(package! graphviz-dot-mode)
(package! feature-mode)
(package! swift-mode)
(package! terraform-mode)
(package! solidity-mode)
(package! adoc-mode)
(package! ejira
  :recipe (:host github :repo "nyyManni/ejira")
  )
(package! org-chef)
(package! lastpass)
