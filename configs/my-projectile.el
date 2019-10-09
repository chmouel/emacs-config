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
  :config
  (projectile-mode +1)
  :bind (("s-b" . projectile-switch-to-buffer)
         ("C-S-f" . projectile-find-file)
         ("s-f" . projectile-find-file)
         ("s-o" . projectile-switch-project)
         ("s-i" . my-projectile-and-ripgrep)
         ("s-p" . my-projectile-and-dired)))

(defun my-projectile-and-dired()
  (interactive)
  (let ((projectile-switch-project-action 'projectile-dired))
    (projectile-switch-project)))

(defun my-projectile-and-ripgrep()
  (interactive)
  (let ((projectile-switch-project-action 'counsel-ag))
    (projectile-switch-project)))


(provide 'my-projectile)
;;; my-projectile.el ends here
