;;; emacs/undo/config.el -*- lexical-binding: t; -*-

(use-package! undo-fu
  :unless (featurep! +tree)
  :hook (doom-first-buffer . undo-fu-mode)
  :config
  ;; Store more undo history to prevent loss of data
  (setq undo-limit 400000
        undo-strong-limit 3000000
        undo-outer-limit 3000000)

  (define-minor-mode undo-fu-mode
    "Enables `undo-fu' for the current session."
    :keymap (let ((map (make-sparse-keymap)))
              (define-key map [remap undo] #'undo-fu-only-undo)
              (define-key map [remap redo] #'undo-fu-only-redo)
              (define-key map (kbd "C-_")     #'undo-fu-only-undo)
              (define-key map (kbd "M-_")     #'undo-fu-only-redo)
              (define-key map (kbd "C-M-_")   #'undo-fu-only-redo-all)
              (define-key map (kbd "C-x r u") #'undo-fu-session-save)
              (define-key map (kbd "C-x r U") #'undo-fu-session-recover)
              map)
    :init-value nil
    :global t))


(use-package! undo-fu-session
  :unless (featurep! +tree)
  :hook (undo-fu-mode . global-undo-fu-session-mode)
  :custom (undo-fu-session-directory (concat doom-cache-dir "undo-fu-session/"))
  :config
  (setq undo-fu-session-incompatible-files '("\\.gpg$" "/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'"))

  ;; HACK Fix #4993: we've advised `make-backup-file-name-1' to produced SHA1'ed
  ;;      filenames to prevent file paths that are too long, so we force
  ;;      `undo-fu-session--make-file-name' to use it instead of its own
  ;;      home-grown overly-long-filename generator.
  ;; TODO PR this upstream; should be a universal issue
  (defadvice! +undo-fu-make-hashed-session-file-name-a (file)
    :override #'undo-fu-session--make-file-name
    (let ((backup-directory-alist `(("." . ,undo-fu-session-directory))))
      (concat (make-backup-file-name-1 file)
              (if undo-fu-session-compression ".gz" ".el"))))

  ;; HACK Use the faster zstd to compress undo files instead of gzip
  (when (executable-find "zstd")
    (defadvice! +undo--append-zst-extension-to-file-name-a (filename)
      :filter-return #'undo-fu-session--make-file-name
      (if undo-fu-session-compression
          (concat (file-name-sans-extension filename) ".zst")
        filename))))


(use-package! undo-tree
  :when (featurep! +tree)
  ;; Branching & persistent undo
  :hook (doom-first-buffer . global-undo-tree-mode)
  :custom (undo-tree-history-directory-alist `(("." . ,(concat doom-cache-dir "undo-tree-hist/"))))
  :config
  (setq undo-tree-visualizer-diff t
        undo-tree-auto-save-history t
        undo-tree-enable-undo-in-region t
        ;; Increase undo-limits by a factor of ten to avoid emacs prematurely
        ;; truncating the undo history and corrupting the tree. See
        ;; https://github.com/syl20bnr/spacemacs/issues/12110
        undo-limit 800000
        undo-strong-limit 12000000
        undo-outer-limit 120000000)

  ;; Compress undo-tree history files with zstd, if available. File size isn't
  ;; the (only) concern here: the file IO barrier is slow for Emacs to cross;
  ;; reading a tiny file and piping it in-memory through zstd is *slightly*
  ;; faster than Emacs reading the entire undo-tree file from the get go (on
  ;; SSDs). Whether or not that's true in practice, we still enjoy zstd's ~80%
  ;; file savings (these files add up over time and zstd is so incredibly fast).
  (when (executable-find "zstd")
    (defadvice! +undo--append-zst-extension-to-file-name-a (file)
      :filter-return #'undo-tree-make-history-save-file-name
      (concat file ".zst")))

  ;; Strip text properties from undo-tree data to stave off bloat. File size
  ;; isn't the concern here; undo cache files bloat easily, which can cause
  ;; freezing, crashes, GC-induced stuttering or delays when opening files.
  (defadvice! +undo--strip-text-properties-a (&rest _)
    :before #'undo-list-transfer-to-tree
    (dolist (item buffer-undo-list)
      (and (consp item)
           (stringp (car item))
           (setcar item (substring-no-properties (car item))))))

  ;; Undo-tree is too chatty about saving its history files. This doesn't
  ;; totally suppress it logging to *Messages*, it only stops it from appearing
  ;; in the echo-area.
  (advice-add #'undo-tree-save-history :around #'doom-shut-up-a))
