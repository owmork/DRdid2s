library(fixest)
library(Matrix)
library(data.table)

files.sources = list.files("R/")
sapply(files.sources, \(x) source(paste0("R/", x)))

df <- DRdid2s::df_hom
df$x1 <- rnorm(nrow(df))
df$x2 <- rnorm(nrow(df))

static <- did2s(
	data = df,
	yname = "dep_var",
	treatment = "treat",
	cluster_var = "state",
	first_stage = ~ x1 + x2 | unit + year,
	second_stage = ~ i(treat, ref = FALSE),
	exposure_stage = ~ x1 + x2 | unit + year
)

summary(static)
