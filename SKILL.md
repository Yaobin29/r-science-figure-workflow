---
name: r-science-figure-workflow
description: Load when a user wants to set up R and RStudio for scientific plotting, install ggplot2 and ggsci, or create figures using Nature-inspired NPG or Science-inspired AAAS palettes. Do not trigger solely for generic R help or a claim of journal compliance.
---

# R scientific figure workflow

Turn a request into a verified R environment and a reproducible figure. R packages belong to an R library; RStudio is an IDE that uses a selected R installation. Explain this simply. Install or alter software only when the user's request authorizes setup; for an inspection-only request do not install.

## Workflow

1. Determine the user's OS, architecture, desktop/headless status and whether this is a clean install or an existing project. Locate all relevant R/Rscript installations, RStudio and the R used by the IDE; inspect versions and package libraries. Don't infer absence from PATH alone. Do not replace, upgrade, switch, or delete an existing R installation, project lockfile, libraries or IDE without authorization. Respect a requested project environment and version. For newly installed tools, prefer the immediately preceding stable release if the user requests it and a compatible, verified release is available; otherwise explain the chosen release and fallback.
2. If R or RStudio is missing and setup is authorized, follow [references/platform-setup.md](references/platform-setup.md), use official sources and verify architecture, compatibility, installer authenticity, and success. Do not install RStudio in a headless setting without a suitable desktop. If admin authentication or user interface interaction is required, let the user perform it; never solicit or handle passwords. Report partial completion honestly.
3. Use the selected `Rscript` and run `Rscript --vanilla <skill>/scripts/setup_packages.R --check`. For authorized installation run it with `--install`; it creates a user-level R library if necessary and installs only missing `ggplot2` and `ggsci` plus required dependencies. Optional `--repo=https://...` selects a CRAN mirror for this invocation only. Do not silently persist a mirror or alter startup files. If the project uses renv or another lockfile, preserve it and ask before changing locked dependencies. Never claim success from an installer exit code alone: run `--check` again.
4. Run `Rscript --vanilla <skill>/scripts/setup_packages.R --verify` to load both packages, generate NPG and AAAS palettes, and create a temporary base plot and ggplot2 plot. It tests the selected R, not necessarily a running IDE. For RStudio, verify the IDE is using the same R and, where feasible, run a small test in its console. A pre-existing session may need `.libPaths(c(Sys.getenv("R_LIBS_USER"), .libPaths()))` after a user library was newly created, or a session restart. Do not overwrite session data. If no GUI or session is available, say IDE linkage was not tested.
5. For a real figure, read [references/plotting.md](references/plotting.md). Use actual user data only; never invent replicates, statistics, claims, or measurements. Show a minimal example separately and label synthetic data. Save reproducible scripts and requested figures in the user's chosen output location; inspect output and report paths, package versions, R version, test evidence and remaining limitations.

## Operational boundaries

- NPG and AAAS in `ggsci` are palettes inspired by journal figures, not official acceptance, branding, or a compliance guarantee. `ggsci` is not a complete publication styling system.
- Verify the current target journal's requirements and use the correct figure type, sample/replicate unit, visibility of raw observations, legends, dimensions, accessibility, and export format. Offer vector PDF for editable line art if suitable and requested; do not claim a single DPI fits all journals.
- Distinguish installed packages from packages loaded into a session. Use `pkg::function` or `library(pkg)` per session; no reinstall on every plot.
- On network failure use another reputable HTTPS CRAN mirror, preserve verified partial downloads where possible, and bound retries. Do not disable TLS or circumvent access controls. Do not report graphical validation if only package installation was checked.
