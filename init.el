(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" default)))
 '(package-selected-packages
   (quote
    (clj-refactor clojure-mode helm-spotify-plus dracula-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'dracula h )


(defun bk/kill-word ()
  "Function to correctly kill a word."
  (interactive)
  (backward-word)
  (kill-word 1)
  (message "Word killed"))

(bk/install-maybe 'smex)
(require 'smex)
(smex-initialize)
(setq smex-prompt-string "Here be dragons => ")

(global-set-key (kbd "C-x C-m") 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-m") 'smex-major-mode-commands)

(defun bk/ido-menu ()
  (interactive)
  (let ((index-alist (cdr (imenu--make-index-alist))))
    (if (equal index-alist '(nil))
        (message "No imenu tags in buffer")
      (imenu (idomenu--read index-alist nil t)))))

(global-set-key (kbd "C-x C-i") 'bk/ido-menu)
 
(defun bk/git-commit-pull-push ()
  (interactive)
  (magit-stage-modified)
  (let* ((msg-string (read-string "Commit message: "))
         (branch (magit-get-current-branch))
         (origin-branch (concat "origin/" branch)))
    (magit-commit (concat "-m " msg-string))
    (magit-pull origin-branch)
    (magit-push branch origin-branch "-v")
    (message "Your repository is synced with the remote branch now...")))

(global-set-key (kbd "C-c C-c C-g") 'bk/git-commit-pull-push)


(global-set-key (kbd "C-c s s") 'helm-spotify-plus)  ;; s for SEARCH
(global-set-key (kbd "C-c s f") 'helm-spotify-plus-next)
(global-set-key (kbd "C-c s b") 'helm-spotify-plus-previous)
(global-set-key (kbd "C-c s p") 'helm-spotify-plus-play) 
(global-set-key (kbd "C-c s g") 'helm-spotify-plus-pause) ;; g cause you know.. C-g stop things :)
