# R Science Figure Workflow

A Codex skill for setting up R, RStudio, ggplot2 and ggsci, verifying plotting, and using Nature-inspired NPG and Science-inspired AAAS palettes.

## Install in Codex

macOS / Linux:

```bash
mkdir -p ~/.codex/skills
git clone https://github.com/Yaobin29/r-science-figure-workflow.git ~/.codex/skills/r-science-figure-workflow
```

Windows PowerShell:

```powershell
New-Item -ItemType Directory -Force "$HOME\.codex\skills" | Out-Null
git clone https://github.com/Yaobin29/r-science-figure-workflow.git "$HOME\.codex\skills\r-science-figure-workflow"
```

Start or restart Codex, then request:

```text
$r-science-figure-workflow Check and set up R, RStudio, and the scientific plotting packages, then verify the NPG and AAAS palettes.
```

Codex inspects existing software, uses compatible trusted sources, installs missing components when authorized and verifies results. Administrator authentication, installer interaction, network access, desktop availability and OS support may require human intervention. Existing installations and project lockfiles are not silently upgraded or replaced. For read-only inspection, explicitly request no installation. Headless systems do not automatically receive RStudio Desktop.

The bundled R script handles R packages and plotting checks; Codex performs system software setup using current official platform instructions. NPG and AAAS palettes are inspired by journal figures, not official templates or compliance guarantees. Check journal requirements, accessibility, and statistical representation for each real figure.

Tested on macOS Apple Silicon with R 4.6.1; complete system installation has not been tested on every OS. See [SKILL.md](SKILL.md), [plotting examples](references/plotting.md) and [MIT License](LICENSE).
