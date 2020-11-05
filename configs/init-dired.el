;;; init-dired.el ---                                -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Chmouel Boudjnah

;; Author: Chmouel Boudjnah <chmouel@chmouel.com>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; Dired
(use-package "dired"
  :ensure nil
  :custom
  ((dired-omit-files
    (concat "^\\.\\|^\\.?#\\|^\\.$\\|^\\.\\.$\\|"
            "^Thumbs.db$\\|\\.svn$\\|\\.git\\(ignore\\)?\\|"
            "\\.pyc$\\|^\\.coverage$\\|^TAGS$\\|^tags$\\|"
            "\\.class$\\|\\.DS_Store\\|\\.localized$\\|__pycache__$")))
  :config
  (require 'dired-x)
  :init
  (if (executable-find "gls")
      (setq insert-directory-program "gls"))
  (defun my-dired-mode-hook ()
    (dired-omit-mode)
    (when (featurep 'tooltip) (tooltip-mode 0)))
  (add-hook 'dired-mode-hook 'my-dired-mode-hook)
  ;; Hack dired to launch files with 'l' key.
  ;; http://omniorthogonal.blogspot.com/2008/05/useful-emacs-dired-launch-hack.html
  (defun my-dired-launch-command ()
    (interactive)
    (dired-do-shell-command
     (case system-type
       (gnu/linux "gnome-open") ;right for gnome (ubuntu), not for other systems
       (darwin "open"))
     nil
     (dired-get-marked-files t current-prefix-arg)))
  :bind
  (:map dired-mode-map
        ("W" . browse-url-of-dired-file)
        ("l" . my-dired-launch-command)
        ("O" . dired-omit-mode)
        ("E" . wdired-change-to-wdired-mode)
        ("s" . dired-up-directory)
        ("j" . dired-next-line)
        ("k" . dired-previous-line)))

(use-package all-the-icons-dired
  :diminish
  :hook (dired-mode . all-the-icons-dired-mode)
  :config
  ;; FIXME: Refresh after creating or renaming the files/directories.
  ;; @see https://github.com/jtbm37/all-the-icons-dired/issues/34.
  (with-no-warnings
    (advice-add #'dired-do-create-files :around #'all-the-icons-dired--refresh-advice)
    (advice-add #'dired-create-directory :around #'all-the-icons-dired--refresh-advice)
    (advice-add #'wdired-abort-changes :around #'all-the-icons-dired--refresh-advice))

  (with-no-warnings
    (defun my-all-the-icons-dired--refresh ()
      "Display the icons of files in a dired buffer."
      (all-the-icons-dired--remove-all-overlays)
      ;; NOTE: don't display icons it too many items
      (if (<= (count-lines (point-min) (point-max)) 1000)
          (save-excursion
            (goto-char (point-min))
            (while (not (eobp))
              (when (dired-move-to-filename nil)
                (let ((file (file-local-name (dired-get-filename 'relative 'noerror))))
                  (when file
                    (let ((icon (if (file-directory-p file)
                                    (all-the-icons-icon-for-dir file
                                                                :face 'all-the-icons-dired-dir-face
                                                                :height 0.9
                                                                :v-adjust all-the-icons-dired-v-adjust)
                                  (all-the-icons-icon-for-file file :height 0.9 :v-adjust all-the-icons-dired-v-adjust))))
                      (if (member file '("." ".."))
                          (all-the-icons-dired--add-overlay (point) "  \t")
                        (all-the-icons-dired--add-overlay (point) (concat icon "\t")))))))
              (forward-line 1)))
        (message "Not display icons because of too many items.")))
    (advice-add #'all-the-icons-dired--refresh :override #'my-all-the-icons-dired--refresh)))

(use-package diredfl
  :ensure t
  :config
  (diredfl-global-mode 1))

(provide 'init-dired)
;;; init-dired.el ends here