# Steam Deck AI Kit

Guías reutilizables para Steam Deck, juegos clásicos, Proton y Wine, compatibles con OpenCode, Claude Code y GitHub Copilot CLI.

**Alcance:** Este kit está pensado específicamente para Steam Deck con SteamOS. Otros ordenadores o dispositivos portátiles con Linux quedan fuera de alcance y no son objetivos compatibles. Aun así, el modelo de Deck, la versión de SteamOS, el juego y la combinación de Proton/Wine pueden cambiar el resultado.

El contenido de los agentes y las skills está en inglés. Este archivo contiene las instrucciones en español.

## Contenido

- `deck-helper`: perfiles de agente adaptados a cada herramienta, con pautas de seguridad compartidas.
- `dgvoodoo2-wine` y `steam-launch-wrapper`: skills portables basadas en Agent Skills.
- Scripts sencillos de instalación y desinstalación. Solo crean enlaces simbólicos a este repositorio; no instalan software, no cambian ajustes de las herramientas ni modifican SteamOS.

## Requisitos

- Una Steam Deck con SteamOS y Bash.
- Tener ya instalada y configurada la herramienta de IA elegida.
- Git para clonar o actualizar este repositorio.

El kit no incluye juegos, DLL, binarios de wrappers, credenciales, modelos, Proton ni Wine.

## Instalar

Clona el repositorio en una ubicación estable y selecciona una o varias herramientas:

```bash
git clone https://github.com/RCompanyX/steam-deck-ai-kit.git ~/.local/share/steam-deck-ai-kit
cd ~/.local/share/steam-deck-ai-kit
bash install.sh opencode
bash install.sh claude
bash install.sh copilot
# O instalar las tres:
bash install.sh opencode claude copilot
```

El instalador comprueba todos los destinos antes de crear enlaces. Nunca sobrescribe archivos ni enlaces existentes. Si detecta un conflicto, mueve o respalda manualmente el elemento conflictivo y vuelve a ejecutar el instalador.

## Actualizar

Revisa los cambios y actualiza el checkout mediante fast-forward:

```bash
cd ~/.local/share/steam-deck-ai-kit
git pull --ff-only
```

Como los archivos instalados enlazan al checkout, los cambios de este se aplican directamente. Revisa las actualizaciones antes de confiar en ellas.

## Desinstalar

Ejecuta el script para las herramientas instaladas. Solo elimina enlaces simbólicos que todavía apunten a este checkout:

```bash
bash uninstall.sh opencode claude copilot
```

El checkout y los archivos preexistentes se conservan.

## Copias de seguridad y recuperación

Antes de instalar en un entorno que quieras conservar, respalda los agentes y skills actuales. El kit detecta conflictos y no los reemplaza. Para restaurar una copia, desinstala primero los enlaces del kit y luego restaura los archivos respaldados en sus ubicaciones originales.

## Seguridad y limitaciones

Revisa los scripts, prompts y skills antes de instalarlos. Las instrucciones de un agente no sustituyen los controles de permisos de cada herramienta. El perfil de OpenCode solicita aprobación antes de acciones de shell y edición; Claude Code y Copilot CLI siguen usando sus propios permisos. No apruebes un comando únicamente porque lo sugiera este kit.

Las indicaciones de compatibilidad no son universales: varían SteamOS, modelo de Deck, juego, launcher, API gráfica, versión de Proton/Wine y herramientas instaladas. Comprueba el dispositivo y el juego concretos. Ninguna skill debe editar un prefix o instalar DLL sin explicar el cambio y proteger los archivos existentes.

## Descargo de responsabilidad

Este proyecto comunitario no está afiliado ni cuenta con el respaldo de Valve, OpenCode, Anthropic, GitHub ni de los autores de dgVoodoo2. El kit y sus instrucciones se ofrecen «tal cual», sin garantías. Úsalos bajo tu responsabilidad: revisa los comandos y las fuentes, y haz copias de seguridad de las partidas, los archivos del juego y los prefixes de compatibilidad antes de modificarlos. No se garantiza la compatibilidad ni los resultados. En la máxima medida permitida por la ley, las personas colaboradoras no serán responsables de daños, pérdida de datos u otros problemas derivados del uso del kit.

## Licencia

MIT. Las herramientas y binarios de terceros no están incluidos y conservan sus propias licencias.
