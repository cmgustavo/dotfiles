# Dotfiles

Repositorio personal de archivos de configuración (*dotfiles*) para macOS, orientado al desarrollo diario (especialmente proyectos JavaScript/TypeScript, React y React Native) y al trabajo fluido en terminal.

---

## Aplicaciones y herramientas soportadas

| Aplicación / Herramienta | Archivo / Directorio | Destino del enlace simbólico | Propósito principal |
| :--- | :--- | :--- | :--- |
| **Neovim** ([LazyVim](https://www.lazyvim.org/)) | `nvim/` | `~/.config/nvim` | Editor principal moderno con LSP, Treesitter, Prettier, TypeScript, GitHub Copilot y navegación integrada con Tmux. |
| **Vim** | `vimrc` | `~/.vimrc` | Configuración clásica con `vim-plug`, FZF, NERDTree, ALE (ESLint/Prettier), Fugitive, Gruvbox y `vim-claude-code`. |
| **Spacemacs (Emacs)** | `spacemacs` | `~/.spacemacs` | Entorno Emacs con modo de edición Vim (*Evil*), LSP para JS/TS/React, ESLint, Prettier al guardar, Helm, Magit y Treemacs. |
| **Tmux** | `tmux.conf` | `~/.tmux.conf` | Multiplexor de terminal con prefijo `C-a`, tema *Catppuccin Mocha High Contrast*, integración con Vim/Neovim y popup para Claude CLI. |
| **Lazygit** | `lazygit/config.yml` | `~/Library/Application Support/lazygit/config.yml` | Interfaz de terminal para Git con tema *Catppuccin Mocha*, iconos Nerd Font, apertura de archivos en Neovim y comandos personalizados. |
| **EditorConfig** | `editorconfig` | `~/.editorconfig` | Reglas globales de formato (finales de línea LF, sin espacios al final, indentación de 2 espacios en JS/TS/HTML/CSS/JSON y tabs en `Makefile`). |
| **JetBrains IDEs (IdeaVim)** | `ideavimrc` | `~/.ideavimrc` *(enlace manual)* | Emulación de Vim y atajos con `<Space>` como tecla líder para IntelliJ IDEA, WebStorm, Android Studio, PyCharm, etc. |
| **GnuCash** | `gnucash.css` | *(Uso en plantillas de GnuCash)* | Hoja de estilos CSS personalizada para el diseño e impresión de facturas (*invoices*) en GnuCash. |

### Herramientas instaladas automáticamente vía Homebrew

El script `install.sh` instala los siguientes paquetes si aún no están presentes en el sistema:

- **Fórmulas CLI:**
  - `neovim`: Editor de texto principal.
  - `ripgrep` (`rg`): Buscador ultrarrápido de texto usado por Neovim, FZF y Spacemacs.
  - `fzf`: Buscador difuso (*fuzzy finder*) en terminal y Vim.
  - `node`: Runtime de JavaScript requerido por servidores LSP, Prettier, ESLint y GitHub Copilot.
  - `bat`: Reemplazo de `cat` con resaltado de sintaxis (usado en previsualizaciones de FZF).
  - `lazygit`: Cliente interactivo de Git para terminal.
  - `git-delta`: Visor de diferencias (`diff`) con resaltado de sintaxis.
  - `gh`: CLI oficial de GitHub.
- **Aplicaciones GUI y Fuentes (Casks):**
  - `iterm2`: Emulador de terminal para macOS.
  - `font-jetbrains-mono-nerd-font`: Fuente tipográfica con soporte de iconos Nerd Fonts para terminal y editores.

---

## Funcionalidades por componente

### 1. Neovim (`nvim/`)
Basado en **LazyVim** con carga automática de `lazy.nvim`:
- **Extras habilitados (`nvim/lazyvim.json`):**
  - Soporte completo para **TypeScript** (`lazyvim.plugins.extras.lang.typescript`).
  - Formateo con **Prettier** (`lazyvim.plugins.extras.formatting.prettier`).
  - Asistencia de IA con **GitHub Copilot** y **Copilot Chat** (`ai.copilot`, `ai.copilot-chat`).
  - Historial mejorado de copiado/pegado con **Yanky** (`coding.yanky`).
- **Opciones personalizadas (`nvim/lua/config/options.lua`):**
  - Ajuste de línea visual activado (`wrap`, `linebreak`, `breakindent`) con indicador `↳ `.
  - Indentación con espacios de tamaño 2 (`expandtab`, `shiftwidth = 2`).
- **Atajos y plugins adicionales:**
  - `<Leader><Tab>`: Alternar rápidamente al buffer anterior (`<C-^>`).
  - `vim-tmux-navigator` (`nvim/lua/plugins/tmux.lua`): Navegación transparente entre divisiones de Neovim y paneles de Tmux usando `Ctrl-h`, `Ctrl-j`, `Ctrl-k` y `Ctrl-l`.

### 2. Vim (`vimrc`)
Configuración completa e independiente que auto-instala **vim-plug** al iniciar si no existe:
- **Plugins incluidos:** `fzf` y `fzf.vim`, `nerdtree`, `bufexplorer`, `mru`, `gruvbox`, `vim-airline`, `vim-devicons`, `nerdfont.vim`, `vim-fugitive`, `vim-commentary`, `vim-surround`, `ale` y `vim-claude-code`.
- **Características principales:**
  - Tema oscuro **Gruvbox**, números de línea híbridos (`number relativenumber`) y portapapeles compartido con el sistema (`unnamedplus`).
  - Guardado automático de respaldos y deshacer persistente (`undofile`) en `~/.vim/backup/`.
  - **Linter y formateo (ALE):** Ejecución automática de ESLint y Prettier al guardar en archivos JS, TS, TSX, CSS y SCSS, además de limpieza de espacios y líneas vacías.
  - **Atajos principales (Líder `<Space>`):**
    - `<Leader>s` guardar cambios / `<Leader>q` guardar y salir.
    - `<Leader>p` (`:Files`), `<C-p>` (`:GFiles`), `<C-g>` (`:Rg`), `<Leader>b` (`:Buffers`), `<Leader>r` (`:MRU`), `<Leader>e` (`:BufExplorer`).
    - `<C-t>` alternar NERDTree, `<C-m>` localizar archivo actual en NERDTree.
    - `<Leader>gs` estado de Git, `<Leader>gc` commit, `<Leader>gP` push, `<Leader>gd` diff, `<Leader>gb` blame.
    - `gd` ir a definición, `gr` buscar referencias, `gy` definición de tipo, `ge` detalle del error (vía ALE).
    - `<Leader>v` inserta automáticamente un `console.log('[archivo:línea]', variable); /* TODO */` de la palabra bajo el cursor.
    - Las teclas de flecha están deshabilitadas en modo normal para fomentar el uso de `h`, `j`, `k`, `l`.

### 3. Spacemacs (`spacemacs`)
Configuración enfocada en el desarrollo diario con **JavaScript, TypeScript y React / React Native**:
- **Capas (*Layers*) activas:** `auto-completion`, `better-defaults`, `emacs-lisp`, `git`, `helm`, `html`, `json`, `lsp`, `markdown`, `multiple-cursors`, `spell-checking`, `syntax-checking`, `version-control`, `prettier`, `javascript`, `typescript`, `react`, `ruby`, `osx`, `treemacs`.
- **Integración con herramientas del proyecto:** Resuelve automáticamente los binarios locales en `node_modules/.bin` (`prettier`, `eslint`, `typescript-language-server`).
- **Comportamiento:**
  - Formateo con Prettier al guardar en JS/TS.
  - Atajos `gd` y `gD` en modo normal conectados a `xref-find-definitions` sobre LSP para mantener consistencia con Neovim.
  - Respeta `.editorconfig` y desactiva archivos de bloqueo (`.#*`) para no ensuciar los repositorios.
  - Tecla `Command` de macOS configurada como `Hyper` y `Option` izquierdo como `Meta`.

### 4. Tmux (`tmux.conf`)
- **Prefijo:** `Ctrl-a` (reemplaza a `Ctrl-b`) y soporte de ratón activado (`mouse on`).
- **Gestión de paneles y ventanas:**
  - `<Prefijo> |`: Dividir panel horizontalmente manteniendo la ruta actual.
  - `<Prefijo> -`: Dividir panel verticalmente manteniendo la ruta actual.
  - `<Prefijo> H / J / K / L`: Redimensionar paneles en incrementos de 5 celdas.
  - `<Prefijo> Ctrl-h / Ctrl-l`: Cambiar a la ventana anterior / siguiente.
- **Integración con Claude CLI:**
  - `<Prefijo> g`: Abre una ventana emergente (*popup* al 90% de pantalla) ejecutando `claude` en el directorio actual del panel.
- **Tema y plugins (TPM):**
  - Estilo visual **Catppuccin Mocha High Contrast** (incluye variantes comentadas para *Mocha* estándar y *Catppuccin Latte*).
  - Plugins gestionados con **TPM**: `tmux-sensible`, `vim-tmux-navigator`, `tmux-yank`, `tmux-open`.

### 5. Lazygit (`lazygit/config.yml`)
- Interfaz con bordes redondeados, iconos Nerd Fonts v3 y paleta de colores **Catppuccin Mocha**.
- Configurado para abrir y editar archivos directamente en **Neovim** (`nvim {{filename}}`), suspendiendo Lazygit hasta cerrar el editor.
- `autoFetch` desactivado al iniciar para mayor velocidad.
- **Comando personalizado:** Presionar `<Ctrl-u>` abre un prompt para hacer `git pull --rebase upstream <rama>` (por defecto `develop`).

### 6. IdeaVim (`ideavimrc`)
Configuración para el plugin IdeaVim en IDEs de JetBrains con `<Space>` como líder:
- **Búsqueda y archivos:** `<Leader>f` ir a archivo, `<Leader>p` buscar en todo, `<Leader>r` archivos recientes, `<Leader>e` seleccionar en vista de proyecto, `<Leader>s` estructura del archivo.
- **Navegación de código:** `gd` declaración, `gD` declaración de tipo, `gi` implementación, `gr` buscar usos, `gt` ir al test, `<Leader>a` acciones de intención.
- **Refactorización y formato:** `<Leader>rn` renombrar, `<Leader>cf` formatear código, `<Leader>co` optimizar imports, `<Leader>cc` comentar línea/selección.
- **Ejecución y depuración:** `<Leader>rr` ejecutar, `<Leader>rd` depurar, `<Leader>rb` alternar breakpoint, `<Leader>rc` reanudar, `<Leader>rs` step over, `<Leader>ri` step into, `<Leader>ro` step out, `<Leader>rx` detener.
- **Git / VCS:** `<Leader>gg` ventana de control de versiones, `<Leader>gl` log de Git, `<Leader>ga` anotaciones (*blame*).
- **Ventanas y pestañas:** `Shift-h` / `Shift-l` para cambiar de pestaña; `<Leader>1` Proyecto, `<Leader>3` VCS, `<Leader>4` Terminal.

### 7. GnuCash (`gnucash.css`)
Hoja de estilos CSS diseñada para mejorar la apariencia y el formato de impresión/PDF de las facturas en GnuCash (probado con GnuCash 4.x), estilizando encabezados, tablas de conceptos, totales y márgenes de página.

---

## Instalación

### Requisitos previos
1. **macOS** con [Homebrew](https://brew.sh/) instalado.
2. **Git** disponible en el sistema.

### Paso a paso

1. **Clonar el repositorio en `~/GitHub/dotfiles`:**
   > **Nota:** El script `install.sh` utiliza por defecto la ruta `$HOME/GitHub/dotfiles`.

   ```bash
   mkdir -p ~/GitHub
   git clone https://github.com/gustavomcortez/dotfiles.git ~/GitHub/dotfiles
   cd ~/GitHub/dotfiles
   ```

2. **Ejecutar el script de instalación:**

   ```bash
   bash install.sh
   ```

   **¿Qué hace `install.sh`?**
   - Instala las herramientas CLI y aplicaciones GUI mediante Homebrew (omitiendo las que ya estén instaladas).
   - Crea los directorios necesarios (`~/.config` y `~/.vim/backup`).
   - Crea los enlaces simbólicos (*symlinks*) hacia este repositorio para Neovim, Vim, Spacemacs, Tmux, EditorConfig y Lazygit.
   - Si ya existe algún archivo o carpeta real en las rutas de destino que no apunte a este repositorio, **hace una copia de seguridad automática** en `~/.dotfiles_backup/<YYYYMMDD_HHMMSS>/` antes de reemplazarlo.

3. **Configuraciones manuales opcionales:**
   - **IdeaVim:** Si usas IDEs de JetBrains, enlaza el archivo `ideavimrc`:
     ```bash
     ln -sf ~/GitHub/dotfiles/ideavimrc ~/.ideavimrc
     ```
   - **TPM (Tmux Plugin Manager):** Si es una instalación limpia, clona TPM e instala los plugins con `<Prefijo> I` (`Ctrl-a` + `Shift-i` dentro de Tmux):
     ```bash
     git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
     ```
   - **iTerm2:**
     - En *Preferences → Profiles → Colors*, importa el tema **Catppuccin Mocha**.
     - En *Preferences → Profiles → Text*, selecciona la fuente **JetBrainsMono Nerd Font Mono**.
   - **GnuCash:** En las opciones del informe de factura en GnuCash, copia o referencia el contenido de `gnucash.css` en la configuración de hoja de estilos CSS.

---

## Actualización y mantenimiento

### Actualizar el repositorio en una máquina existente
Para descargar los últimos cambios del repositorio y asegurarse de que todos los enlaces simbólicos y paquetes de Homebrew estén al día:

```bash
cd ~/GitHub/dotfiles
git pull
bash install.sh
```
`install.sh` es **idempotente**: puede ejecutarse tantas veces como sea necesario sin duplicar instalaciones ni sobrescribir enlaces que ya son correctos.

### Actualizar paquetes y plugins de cada herramienta

- **Paquetes de Homebrew:**
  ```bash
  brew update && brew upgrade
  ```

- **Neovim (LazyVim):**
  - Abre `nvim` y ejecuta `:Lazy sync` (o presiona `<Space>l` para abrir la interfaz de Lazy y luego `S`).
  - El archivo `nvim/lazy-lock.json` registra las versiones exactas de cada plugin; haz commit de este archivo cuando actualices plugins para mantener la misma versión en todas tus máquinas.
  - Para actualizar servidores LSP y formateadores gestionados por Mason, ejecuta `:MasonUpdate` dentro de Neovim.

- **Vim (vim-plug):**
  - Abre `vim` y ejecuta:
    - `:PlugInstall` para instalar plugins nuevos.
    - `:PlugUpdate` para actualizar los plugins existentes.
    - `:PlugClean` para eliminar plugins que se hayan quitado del `vimrc`.

- **Spacemacs:**
  - Dentro de Spacemacs, presiona `SPC f e U` para actualizar los paquetes de las capas instaladas y `SPC f e R` para recargar la configuración tras editar `spacemacs`.

- **Tmux (TPM):**
  - Dentro de una sesión de Tmux:
    - `Ctrl-a` + `Shift-i` (`<Prefijo> I`): Instala nuevos plugins añadidos a `tmux.conf`.
    - `Ctrl-a` + `Shift-u` (`<Prefijo> U`): Actualiza los plugins instalados.
    - Para recargar `tmux.conf` sin reiniciar Tmux: `tmux source-file ~/.tmux.conf`.

### Cómo añadir o modificar configuraciones

1. **Modificar una configuración existente:**
   Dado que los archivos en `~/` y `~/.config/` son enlaces simbólicos hacia `~/GitHub/dotfiles`, cualquier cambio que hagas en `~/.vimrc`, `~/.tmux.conf`, `~/.spacemacs` o `~/.config/nvim/` modifica directamente los archivos dentro del repositorio. Solo necesitas revisar los cambios con `git status` / `lazygit` y hacer commit.

2. **Agregar una nueva herramienta o dotfile al repositorio:**
   - Mueve o crea el archivo de configuración dentro de `~/GitHub/dotfiles/`.
   - Si requiere un paquete de Homebrew, agrégalo a la llamada `brew_install` o `brew_cask_install` en `install.sh`.
   - Añade una línea `link <ruta-en-repo> <ruta-destino>` en `install.sh`.
   - Ejecuta `bash install.sh` para crear el enlace simbólico y verifica su funcionamiento.

3. **Restaurar copias de seguridad:**
   Si necesitas recuperar un archivo previo que fue reemplazado al ejecutar `install.sh`, revisa las carpetas con marca de tiempo dentro de `~/.dotfiles_backup/`.

---

## Licencia

Distribuido bajo la licencia [MIT](LICENSE).
