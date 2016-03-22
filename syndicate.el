;;; evil-org.el --- evil keybindings for org-mode
;;; Commentary:
;; Still in early stages, I plan to use and develop this for a while
;;; Code:
(require 'evil)
(require 'org)

(define-minor-mode syndicate-mode
  "Buffer-specific minor mode for evil-org."
  :init-value nil
  :lighter " Syn"
  :keymap (make-sparse-keymap)
  :group 'syndicate-mode)

(add-hook 'org-mode-hook 'syndicate-mode)

(evil-define-key 'normal syndicate-mode-map
  "gh" 'outline-up-heading
  "gj" 'org-forward-heading-same-level
  "gk" 'org-backward-heading-same-level
  "gl" 'outline-next-visible-heading
  "<" 'org-metaleft
  ">" 'org-metaright
  "t" 'org-todo
  (kbd "<tab>") 'org-cycle)

(provide 'syndicate)

;;; syndicate.el ends here
