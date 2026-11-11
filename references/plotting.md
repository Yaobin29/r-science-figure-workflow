# Scientific plotting

## Base R with ggsci

With a six-element numeric `values` vector already defined, this draws NPG colours in the interactive plot pane:

```r
barplot(values,
        names.arg = paste("Group", LETTERS[seq_along(values)]),
        col = ggsci::pal_npg()(length(values)),
        xlab = "Group", ylab = "Value")
```

Use `ggsci::pal_aaas()` for the AAAS palette. Both have a finite number of colours; check the package documentation and choose another accessible palette for more categories. Do not use arbitrary palette colours to imply meaningful grouping where there is none.

## ggplot2 template

Synthetic demonstration; replace the data frame with user-provided observations and meaningful labels:

```r
library(ggplot2)
library(ggsci)
demo <- data.frame(group = LETTERS[1:6], value = c(20, 50, 80, 40, 60, 100))
p <- ggplot(demo, aes(x = group, y = value, fill = group)) +
  geom_col() + scale_fill_npg() + theme_classic() +
  labs(x = "Group", y = "Value") + guides(fill = "none")
print(p)
# Explicit filenames: use a user-selected path; these examples overwrite existing files.
ggsave("example.png", p, width = 90, height = 70, units = "mm", dpi = 300)
ggsave("example.pdf", p, width = 90, height = 70, units = "mm")
```

Switch `scale_fill_npg()` to `scale_fill_aaas()` for the AAAS-inspired palette. Use `scale_color_npg()` / `scale_color_aaas()` for mapped line or point colours rather than fill. `geom_col()` plots supplied values; it does not calculate or validate biological replicates, averages, error bars or statistics. Choose plots that reveal the structure of the actual data, and distinguish independent samples from technical replicates. Consult the target journal for final requirements; example sizes and dpi are not universal submission rules. Sources: https://cran.r-project.org/package=ggsci and https://research-figure-guide.nature.com/figures/.
