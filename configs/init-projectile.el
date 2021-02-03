;;; my-projectile.el ---                             -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Chmouel Boudjnah

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

;;; Commentary:

;; projectile
(use-package projectile
  :after ivy
  :hook (after-init-hook . projectile-mode)
  :commands (projectile-ensure-project projectile-project-root)
  :custom
  (projectile-switch-project-action 'projectile-dired)
  (projectile-completion-system 'ivy)
  (projectile-mode-line-function 'my-projectile-mode-line)
  (frame-title-format
   '(""
     "%b"
     (:eval
      (let ((project-name (projectile-project-name)))
        (unless (string= "-" project-name)
          (format " ⏤ %s" project-name))))))
  :bind (("C-c b" . projectile-switch-to-buffer)
         ("C-c o" . my-projectile-and-find-file)
         ("C-c i" . my-projectile-and-ripgrep)
         ("C-c f" . projectile-find-file)
         ("C-c S-<return>" . projectile-commander)
         ("C-c <return>" . projectile-switch-open-project)
         ("C-c p" . my-projectile-and-dired)))

(defun my-projectile-mode-line ()
  (let ((project-name (projectile-project-name)))
    (format " :%s" (or project-name "-"))))

(defun my-projectile-mode-line ()
  (let ((project-name
         (projectile-project-name)))
    (if (not (string= project-name "-"))
        (format " PRJ[%s]" project-name) "")))

(defun my-projectile-and-dired()
  (interactive)
  (let ((projectile-switch-project-action 'projectile-dired))
    (projectile-switch-project)))

(defun my-projectile-and-find-file()
  (interactive)
  (let ((projectile-switch-project-action 'my-projectile-find-file))
    (projectile-switch-project)))

(defun my-projectile-and-ripgrep()
  (interactive)
  (let ((projectile-switch-project-action 'counsel-projectile-rg))
    (projectile-switch-project)))

(defun my-projectile-find-file()
  (interactive)
  (let* ((project-root (projectile-ensure-project (projectile-project-root)))
         (files
          (if (boundp 'my-project-ignore-files)
              (--filter (not (string-match my-project-ignore-files it))
                        (projectile-project-files project-root))
            (projectile-project-files project-root)))
         (file (ido-completing-read "Find file: " (sort files #'string<))))
    (when file
      (funcall 'find-file (expand-file-name file project-root))
      (run-hooks 'projectile-find-file-hook))))

(provide 'my-projectile)
;;; my-projectile.el ends here
