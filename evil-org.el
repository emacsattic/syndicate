;;; evil-org.el --- evil keybindings for org-mode
;;; Commentary:
;; Still in early stages, I plan to use and develop this for a while
;;; Code:
(require 'evil)
(require 'org)

(define-minor-mode evil-org-mode
  "Buffer-specific minor mode for evil-org."
  :init-value nil
  :lighter " EvilOrg"
  :keymap (make-sparse-keymap)
  :group 'evil-org)

(add-hook 'org-mode-hook 'evil-org-mode)

(evil-define-key 'normal evil-org-mode-map
  "gh" 'outline-up-heading
  "gj" 'org-forward-heading-same-level
  "gk" 'org-backward-heading-same-level
  "gl" 'outline-next-visible-heading
  "<" 'org-metaleft
  ">" 'org-metaright
  "t" 'org-todo
  (kbd "<tab>") 'org-cycle)

(provide 'evil-org)
;;; evil-org.el ends here
