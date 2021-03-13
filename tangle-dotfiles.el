(require 'org)

(make-directory "~/.emacs.d/" t)
;; Don't ask when evaluating code blocks
(setq org-confirm-babel-evaluate nil)

(let* ((dotfiles-path (expand-file-name "~/.dotfiles"))
	 (org-files (directory-files dotfiles-path nil "\\.org$")))

  (defun dw/tangle-org-file (org-file)
    (message "\n\033[1;32mUpdating %s\033[0m\n" org-file)
    (org-babel-tangle-file (expand-file-name org-file dotfiles-path)))

  ;; Tangle Systems.org first
  (dolist (org-file org-files)
    (unless (member org-file '("README.org" "Systems.org"))
    	(dw/tangle-org-file org-file))))
