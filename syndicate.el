;;; evil-org.el --- evil keybindings for org-mode

;; URL: https://github.com/KNX32542/syndicate.git
;; Keywords: evil org bindings

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
;; recompute clocks in visual selection
(evil-define-operator syndicate-recompute-clocks (beg end type register yank-handler)
  :keep-visual t
  :move-point nil
  (interactive "<r>")
  (progn
        (message "start!" )
        (save-excursion
        (while (< (point) end)
            (org-evaluate-time-range)
            (next-line)
            (message "at position %S" (point))
        ))))

;; open org-mode links in visual selection

(defun syndicate-generic-open-links (beg end type register yank-handler incog)
  (progn
    (save-excursion 
      (goto-char beg)
      (catch 'break
        (while t
          (org-next-link)
          ;;; break from outer loop when there are no more
          ;;; org links
          (when (or 
                 (not (< (point) end)) 
                 (not (null org-link-search-failed)))
            (throw 'break 0))

          (if (not (null incog))
              (let* ((new-arg
                      ;;; if incog is true, decide which incognito settings to
                      ;;; use dependening on the browser
                      (cond ((not (null (string-match "^.*\\(iceweasel\\|firefox\\).*$" browse-url-generic-program)))  "--private-window")
                            ((not (null (string-match "^.*\\(chrome\\|chromium\\).*$"  browse-url-generic-program)))   "--incognito"     )
                            (t "")
                            ))
                     (old-b (list browse-url-generic-args " " ))
                     (browse-url-generic-args (add-to-ordered-list 'old-b new-arg 0)))
                (progn
                  (org-open-at-point)))
            (let ((browse-url-generic-args '("")))
              (org-open-at-point)))
          )))))


;;; open links in visual selection
(evil-define-operator syndicate-open-links (beg end type register yank-handler)
  :keep-visual t
  :move-point nil
  (interactive "<r>")
  (syndicate-generic-open-links beg end type register yank-handler nil)
)

;;; open links in visual selection in incognito mode
(evil-define-operator syndicate-open-links-incognito (beg end type register yank-handler)
  :keep-visual t
  :move-point nil
  (interactive "<r>")
  (syndicate-generic-open-links beg end type register yank-handler t)
)

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
