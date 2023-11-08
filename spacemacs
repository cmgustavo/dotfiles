(defun dotspacemacs/layers ()
  "Layer configuration:
  (setq-default
   dotspacemacs-distribution 'spacemacs

   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     auto-completion
     better-defaults
     emacs-lisp
     git
     helm
     (lsp :variables
          lsp-headerline-breadcrumb-enable nil)
     markdown
     multiple-cursors
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-term-shell "/bin/zsh")
     spell-checking
     syntax-checking
     version-control
     html
     (javascript :variables
                 javascript-backend 'lsp
                 javascript-fmt-on-save t
                 javascript-fmt-tool 'prettier)
     (typescript :variables
                 typescript-backend 'lsp
                 typescript-fmt-on-save t
                 typescript-fmt-tool 'prettier)
     react
     treemacs
     (osx :variables osx-command-as 'hyper
          osx-option-as 'meta
          osx-right-option-as 'none)
     evil-better-jumper
     themes-megapack)

   dotspacemacs-additional-packages '(prettier-js)
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-enable-emacs-pdumper nil
   dotspacemacs-emacs-pdumper-executable-file "emacs"
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-gc-cons '(100000000 0.1)
   dotspacemacs-read-process-output-max (* 1024 1024)
   dotspacemacs-use-spacelpa nil
   dotspacemacs-verify-spacelpa-archives t
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory 'emacs-version
   dotspacemacs-editing-style 'vim
   dotspacemacs-startup-buffer-show-version t
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-banner-scale 'auto
   dotspacemacs-startup-lists '(recents)
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-show-startup-list-numbers t
   dotspacemacs-startup-buffer-multi-digit-delay 0.4
   dotspacemacs-startup-buffer-show-icons nil
   dotspacemacs-new-empty-buffer-major-mode 'text-mode
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-scratch-buffer-persistent nil
   dotspacemacs-scratch-buffer-unkillable nil
   dotspacemacs-initial-scratch-message nil
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light
                         grandshell
                         gandalf)
   dotspacemacs-mode-line-theme '(spacemacs :separator nil :separator-scale 1)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("MesloLGM Nerd Font"
                               :size 12.0
                               :weight normal
                               :width normal)

   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-default-layout-name "Default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-auto-generate-layout-names nil
   dotspacemacs-large-file-size 1
   dotspacemacs-auto-save-file-location 'nil
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   dotspacemacs-loading-progress-bar nil
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-undecorated-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-scroll-bar-while-scrolling nil
   dotspacemacs-line-numbers nil
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-activate-smartparens-mode t
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-enable-server nil
   dotspacemacs-server-socket-dir nil
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")
   dotspacemacs-frame-title-format "Spacemacs - %a"
   dotspacemacs-icon-title-format nil
   dotspacemacs-show-trailing-whitespace t
   dotspacemacs-whitespace-cleanup nil
   dotspacemacs-use-clean-aindent-mode t
   dotspacemacs-use-SPC-as-y nil
   dotspacemacs-swap-number-row nil
   dotspacemacs-zone-out-when-idle nil
   dotspacemacs-pretty-docs nil
   dotspacemacs-home-shorten-agenda-source nil
   dotspacemacs-byte-compile nil
   ))

(defun dotspacemacs/user-env ()
  (spacemacs/load-spacemacs-env)
)

(defun dotspacemacs/user-init ()
)


(defun dotspacemacs/user-load ()
)


(defun dotspacemacs/user-config ()
  (setq create-lockfiles nil)
  (setq editorconfig-mode 1)
  (add-hook 'doc-view-mode-hook 'auto-revert-mode)
)

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
