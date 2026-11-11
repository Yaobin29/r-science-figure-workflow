#!/usr/bin/env Rscript
# R package setup for the selected R installation. No system configuration is changed.
args <- commandArgs(trailingOnly = TRUE)
modes <- intersect(args, c("--check", "--install", "--verify"))
repo_arg <- grep("^--repo=", args, value = TRUE)
if (length(modes) != 1L || length(repo_arg) > 1L || any(!args %in% c(modes, repo_arg))) {
  stop("Usage: Rscript --vanilla setup_packages.R --check|--install|--verify [--repo=https://CRAN-mirror/]")
}
mode <- modes[[1]]
repo <- if (length(repo_arg)) sub("^--repo=", "", repo_arg[[1]]) else "https://cloud.r-project.org"
if (!grepl("^https://", repo)) stop("CRAN mirror must use HTTPS")
user_lib <- path.expand(Sys.getenv("R_LIBS_USER"))
if (!nzchar(user_lib)) stop("R_LIBS_USER is empty; select a user library first")
if (dir.exists(user_lib)) .libPaths(c(user_lib, .libPaths()))
packages <- c("ggplot2", "ggsci")
available <- function() vapply(packages, requireNamespace, logical(1), quietly = TRUE)
cat("R:", R.version.string, "\n")
cat("Platform:", R.version$platform, "\n")
cat("Library paths:\n", paste(.libPaths(), collapse = "\n"), "\n", sep = "")
if (mode == "--install") {
  missing <- packages[!available()]
  if (length(missing)) {
    if (!dir.exists(user_lib) && !dir.create(user_lib, recursive = TRUE, showWarnings = FALSE))
      stop("Cannot create user library: ", user_lib)
    .libPaths(c(user_lib, .libPaths()))
    options(timeout = max(300, getOption("timeout")))
    cat("Installing missing packages:", paste(missing, collapse = ", "), "\n")
    install.packages(missing, lib = user_lib, repos = repo, dependencies = NA)
  } else cat("Both packages are already available; no packages installed.\n")
}
ok <- available()
for (i in seq_along(packages)) {
  cat(packages[[i]], ": ", if (ok[[i]]) as.character(utils::packageVersion(packages[[i]])) else "MISSING", "\n", sep = "")
}
if (!all(ok)) stop("Package setup incomplete: ", paste(packages[!ok], collapse = ", "))
if (mode == "--verify") {
  verify <- function() {
    # Temporary files avoid overwriting the user's figures.
    base_file <- tempfile(fileext = ".pdf")
    gg_file <- tempfile(fileext = ".pdf")
    on.exit(unlink(c(base_file, gg_file)), add = TRUE)
    npg <- ggsci::pal_npg()(6)
    aaas <- ggsci::pal_aaas()(6)
    stopifnot(length(npg) == 6L, length(aaas) == 6L)
    grDevices::pdf(base_file)
    graphics::barplot(1:6, col = npg, main = "Palette test")
    grDevices::dev.off()
    d <- data.frame(group = LETTERS[1:6], value = 1:6)
    p <- ggplot2::ggplot(d, ggplot2::aes(x = group, y = value, fill = group)) +
      ggplot2::geom_col() + ggsci::scale_fill_aaas() + ggplot2::theme_classic()
    ggplot2::ggsave(filename = gg_file, plot = p, width = 4, height = 3, units = "in", device = "pdf")
    stopifnot(all(file.exists(c(base_file, gg_file))), all(file.info(c(base_file, gg_file))$size > 1000))
    cat("VERIFIED: packages load; NPG and AAAS palettes; base and ggplot2 PDF devices.\n")
  }
  verify()
}
