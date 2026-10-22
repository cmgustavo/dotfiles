;;; .spacemacs --- Configuración de Spacemacs para desarrollo diario -*- lexical-binding: t; -*-
;;;
;;; Esta configuración está orientada a proyectos JavaScript/TypeScript,
;;; incluidos React Native. Usa LSP, ESLint y Prettier instalados en cada
;;; proyecto (node_modules/.bin), igual que la configuración de Neovim.

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '()

   ;; `lsp' hace que javascript y typescript usen LSP en vez de Tern/Tide.
   ;; `add-node-modules-path', incluido por esas capas, resuelve primero los
   ;; binarios locales del proyecto: prettier, eslint y
   ;; typescript-language-server.
   dotspacemacs-configuration-layers
   '(auto-completion
     better-defaults
     emacs-lisp
     git
     helm
     html
     json
     lsp
     markdown
     multiple-cursors
     spell-checking
     syntax-checking
     version-control
     prettier
     (javascript :variables
                 javascript-fmt-on-save t
                 javascript-fmt-tool 'prettier)
     (typescript :variables
                 typescript-backend 'lsp
                 typescript-fmt-on-save t
                 typescript-fmt-tool 'prettier
                 typescript-linter 'eslint)
     ;; `typescript' maneja .tsx; `react' conserva el soporte para .jsx.
     react
     ruby
     (osx :variables
          osx-command-as 'hyper
          osx-option-as 'meta
          osx-right-option-as 'none)
     treemacs)

   ;; prettier-js lo instala la capa `prettier'; no hace falta declararlo dos
   ;; veces aquí. Copilot queda excluido explícitamente: no se instalará ni se
   ;; activará aunque haya quedado registrado en una instalación anterior.
   ;; code-review pertenece a la capa `git', pero no es necesario para este
   ;; flujo y su receta de Quelpa puede fallar al resolver sus metadatos.
   dotspacemacs-additional-packages '()
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(code-review copilot copilot-chat)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-enable-emacs-pdumper nil
   dotspacemacs-emacs-pdumper-executable-file "emacs"
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 15
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
   dotspacemacs-startup-lists '((recents . 5) (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-show-startup-list-numbers t
   dotspacemacs-startup-buffer-multi-digit-delay 0.4
   dotspacemacs-startup-buffer-show-icons nil
   dotspacemacs-new-empty-buffer-major-mode 'text-mode
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-scratch-buffer-persistent nil
   dotspacemacs-scratch-buffer-unkillable nil
   dotspacemacs-initial-scratch-message nil
   dotspacemacs-themes '(spacemacs-dark spacemacs-light)
   dotspacemacs-mode-line-theme '(spacemacs :separator nil :separator-scale 1.5)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("MesloLGM Nerd Font" :size 14.0 :weight normal :width normal)
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
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-enable-paste-transient-state nil
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-switch-to-buffer-prefers-purpose nil
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   ;; No maximizar ni entrar en pantalla completa al iniciar.
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-undecorated-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-background-transparency 90
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-scroll-bar-while-scrolling t
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
   dotspacemacs-frame-title-format "%I@%S"
   dotspacemacs-icon-title-format nil
   dotspacemacs-show-trailing-whitespace t
   dotspacemacs-whitespace-cleanup nil
   dotspacemacs-use-clean-aindent-mode nil
   dotspacemacs-use-SPC-as-y nil
   dotspacemacs-swap-number-row nil
   dotspacemacs-zone-out-when-idle nil
   dotspacemacs-pretty-docs nil
   dotspacemacs-home-shorten-agenda-source nil
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Carga las variables de entorno definidas por el usuario para Spacemacs."
  (spacemacs/load-spacemacs-env))

(defun dotspacemacs/user-init ())
(defun dotspacemacs/user-load ())

(defun dotspacemacs/user-config ()
  ;; Evita archivos .#* en los repositorios sin desactivar el auto-guardado.
  (setq create-lockfiles nil)

  ;; Mantiene la indentación y los finales de línea definidos por .editorconfig.
  (when (fboundp 'editorconfig-mode)
    (editorconfig-mode 1))

  ;; Valores por defecto equivalentes a la configuración actual de Neovim.
  ;; Prettier/.editorconfig pueden reemplazarlos por proyecto.
  (setq-default indent-tabs-mode nil
                tab-width 2
                js-indent-level 2
                typescript-indent-level 2)

  ;; LSP ya publica diagnósticos de TypeScript y Flycheck usa ESLint local.
  ;; Se evita la documentación flotante automática, que suele interrumpir al
  ;; escribir; la documentación sigue disponible bajo SPC m h.
  (with-eval-after-load 'lsp-mode
    ;; Registra el cliente JavaScript/TypeScript antes de invocar
    ;; `lsp-install-server`; sin esta carga el selector puede mostrar solo
    ;; servidores de lenguajes abiertos anteriormente (por ejemplo Lua).
    (require 'lsp-javascript)
    (setq lsp-enable-snippet t
          lsp-headerline-breadcrumb-enable t)
    ;; Compatibilidad con Neovim: `gd` y `gD` usan la definición que aporta
    ;; el servidor LSP en buffers donde LSP está activo. Spacemacs también
    ;; conserva sus atajos nativos: SPC m g d y SPC m g D.
    (evil-define-key 'normal lsp-mode-map (kbd "gd") #'xref-find-definitions)
    (evil-define-key 'normal lsp-mode-map (kbd "gD")
      #'xref-find-definitions-other-window))
  (with-eval-after-load 'lsp-ui
    (setq lsp-ui-doc-enable nil
          lsp-ui-sideline-enable nil))

  ;; Muestra los fallos de Prettier en el minibuffer en vez de ocultarlos.
  (with-eval-after-load 'prettier-js
    (setq prettier-js-show-errors 'echo)))

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(safe-local-variable-values
     '((evil-shift-width . 2) (web-mode-indent-style . 2)
       (web-mode-block-padding . 2) (web-mode-script-padding . 2)
       (web-mode-style-padding . 2) (typescript-backend . tide)
       (typescript-backend . lsp) (javascript-backend . tide)
       (javascript-backend . tern) (javascript-backend . lsp))))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )
