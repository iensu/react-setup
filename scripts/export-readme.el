;;; Exports source org file to target markdown file

(defvar input-file "docs/instructions.org")
(defvar output-file "README.md")

(package-initialize)

(require 'org)

(org-babel-do-load-languages
 'org-babel-load-languages '((emacs-lisp . t)
                             (shell . t)
                             (js . t)
                             (python . t)))

(unless (package-installed-p 'ox-gfm)
  (package-install 'ox-gfm))

(eval-after-load  "org"
  '(require 'ox-gfm nil t))

(setq org-src-fontify-natively t
      make-backup-files nil
      auto-save-default nil)

(with-temp-buffer
  (insert-file-contents input-file)
  (org-gfm-export-as-markdown)
  (write-file output-file))
