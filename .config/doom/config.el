
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"

      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:

(setq doom-font (font-spec :family "Source Code Pro" :size 10.0)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'spacemacs-light)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;
;;; Keybinds

(map! :nv "C-u" (lambda ()
                  (interactive)
                  (call-interactively #'evil-scroll-up)
                  (call-interactively #'evil-scroll-line-to-center))
      :nv "C-d" (lambda ()
                  (interactive)
                  (call-interactively #'evil-scroll-down)
                  (call-interactively #'evil-scroll-line-to-center))

      :nv "gD"  #'+lookup/type-definition
      :nv "gr"  #'+lookup/references

      :leader
      (:prefix ("d" . "debug")
               (:prefix ("b" . "breakpoints")
                :desc "Toggle a breakpoint"      "b" #'dap-breakpoint-toggle)
               (:prefix ("d" . "debugging")
                :desc "Start debugging"          "d" #'dap-debug
                :desc "Debug last configuration" "l" #'dap-debug-last)))


;; FACE
(defun set-big-font-size ()
  (setq buffer-face-mode-face '(:height 140))
  (buffer-face-mode))
(add-hook! '(prog-mode-hook text-mode-hook) #'set-big-font-size)


;; LSP
;; https://github.com/emacs-lsp/lsp-ui/issues/716
(eval-after-load 'lsp-ui-sideline
  '(progn
     (defun lsp-ui-sideline--align (&rest lengths)
       "Align sideline string by LENGTHS from the right of the window."
       (cons (+ (apply '+ lengths)
                (if (display-graphic-p) 1 2))
             'width))))

;; https://github.com/emacs-lsp/lsp-mode/issues/713
(defun ++git-ignore-p (path)
  (let* (; trailing / breaks git check-ignore if path is a symlink:
         (path (directory-file-name path))
         (default-directory (file-name-directory path))
         (relpath (file-name-nondirectory path))
         (cmd (format "git check-ignore '%s'" relpath))
         (status (call-process-shell-command cmd)))
    (eq status 0)))
(defun ++lsp--path-is-watchable-directory-a
    (fn path dir ignored-directories)
  (and (not (++git-ignore-p (f-join dir path)))
       (funcall fn path dir ignored-directories)))
(advice-add 'lsp--path-is-watchable-directory
            :around #'++lsp--path-is-watchable-directory-a)


;; DEBUGGER
(setq dap-ui-variable-length 178)
(after! dap-mode
  (setq dap-auto-configure-features '(sessions locals expressions tooltip)))
(after! dap-ui
  (remove-hook! 'dap-ui-mode-hook #'dap-ui-controls-mode))
(add-hook 'dap-stopped-hook
          (lambda (_) (call-interactively #'dap-hydra)))

;; FOLD
(define-key! 'global
  [remap evil-close-folds]   #'hs-hide-level)
(after! evil
  (evil-define-key* 'motion 'global
    "zM" #'+fold/close-all))

;; MISC
(global-subword-mode t)
(setq-default tab-width 8)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(evil-define-key 'normal dired-mode-map
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file)
(set-popup-rules!
  '(("^\\*\\(?:Launch File\\|Test function\\)" :slot 1 :vslot -1 :select t)))
(add-hook! 'prog-mode-hook #'display-fill-column-indicator-mode (set-fill-column 100))
