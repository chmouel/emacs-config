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
  :commands (projectile-ensure-project projectile-project-root)
  :custom
  ((projectile-switch-project-action 'projectile-dired)
   (projectile-mode-line-function 'my-projectile-mode-line))
  :config
  (setq frame-title-format
        '(""
          "%b"
          (:eval
           (let ((project-name (projectile-project-name)))
             (unless (string= "-" project-name)
               (format " ⏤ %s" project-name))))))
  (projectile-mode +1)
  :bind (("s-b" . projectile-switch-to-buffer)
         ("s-o" . projectile-switch-project)
         ("s-i" . my-projectile-and-ripgrep)
         ("s-f" . projectile-find-file)
         ("s-<return>" . projectile-switch-open-project)
         ("s-p" . my-projectile-and-dired)))

;; Ivy integration for Projectile
(use-package counsel-projectile
  :bind
  (("s-U" . counsel-projectile-git-grep))
  :hook (counsel-mode . counsel-projectile-mode)
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point)))


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

(defun my-projectile-and-ripgrep()
  (interactive)
  (let ((projectile-switch-project-action 'counsel-ag))
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
