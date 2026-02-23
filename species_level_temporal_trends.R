############################################################

Chapter 1 Supplementary Code
Species level temporal trends in morphological traits
Author: [Your Name]
Thesis: Multivariate analyses of body size in Australian bees
Purpose:
This script estimates long term directional trends in seven
morphological traits for each species using linear models.
Slopes are calculated on a log scale and converted to
percent change per year. Forest plots are generated to
visualise species level trait trajectories.

############################################################

##############################

1. USER INPUTS

##############################

IMPORTANT:
Replace the file paths below with your own data and phylogeny files.
These are placeholders for reproducibility.

data_file <- "PATH_TO_YOUR_DATA/AusBeesPopDen1.csv"
tree_file <- "PATH_TO_YOUR_TREE/BEE_phylogeny.nwk"

List of morphological traits analysed.
These correspond to the traits described in Chapter 1 Methods.

traits <- c(
"ITD", # Intertegular distance
"Head_width", # Head width
"Rear_Ocelli_size", # Rear ocellus diameter
"Front_Ocelli_Size", # Front ocellus diameter
"Eye_Length", # Compound eye length
"Eye_width", # Compound eye width
"R_Wing_length" # Right wing length
)

##############################

2. LOAD REQUIRED PACKAGES

##############################

These packages are required for data manipulation,
plotting, and phylogenetic tree handling.

library(dplyr)
library(tidyr)
library(ggplot2)
library(ape)

##############################

3. LOAD AND CLEAN DATA

##############################

Read morphological dataset

dat <- read.csv(data_file, stringsAsFactors = FALSE)

Ensure species names are standardised

dat$species <- tolower(dat$species)

Ensure year is numeric for modelling

dat$year <- as.numeric(dat$year)

Optional: Remove specimens with missing year values

dat <- dat %>%
filter(!is.na(year))

Keep only required columns

dat <- dat %>%
select(species, year, all_of(traits))

Remove non positive values to avoid log transformation errors

dat <- dat %>%
mutate(across(all_of(traits), as.numeric)) %>%
filter(across(all_of(traits), ~ . > 0))

##############################

4. LOAD AND PRUNE PHYLOGENY

##############################

The tree is included here for consistency with the broader
phylogenetically informed workflow described in Chapter 1.
It is not directly used in the slope models but ensures that
species names align with downstream analyses.

tree <- read.tree(tree_file)

If multiple trees are present, use the first

if (inherits(tree, "multiPhylo")) {
tree <- tree[[1]]
}

Standardise tip labels

tree$tip.label <- tolower(tree$tip.label)

Prune tree to species present in dataset

tree <- drop.tip(tree, setdiff(tree$tip.label, unique(dat$species)))

##############################

5. FUNCTION TO COMPUTE LOG SLOPE

##############################

This function:
1. Fits a linear model: log(trait) ~ year
2. Extracts the slope for year
3. Calculates 95 percent confidence intervals
4. Returns a tidy tibble

compute_slope <- function(df) {

Require at least two unique years

if (length(unique(df$year)) < 2) return(NULL)

model <- lm(log(value) ~ year, data = df)

Ensure slope exists

if (!"year" %in% names(coef(model))) return(NULL)

slope <- coef(model)["year"]
se <- summary(model)$coefficients["year", "Std. Error"]

tibble(
slope = slope,
lower = slope - 1.96 * se,
upper = slope + 1.96 * se
)
}

##############################

6. ESTIMATE SPECIES x TRAIT SLOPES

##############################

Reshape dataset into long format
Each row becomes species x trait x year

slopes <- dat %>%
pivot_longer(
cols = all_of(traits),
names_to = "trait",
values_to = "value"
) %>%
filter(!is.na(value)) %>%
group_by(species, trait) %>%
group_modify(~ compute_slope(.x)) %>%
ungroup() %>%
mutate(
# Convert log slope to percent change per year
pct = (exp(slope) - 1) * 100,
pct_lower = (exp(lower) - 1) * 100,
pct_upper = (exp(upper) - 1) * 100,

# Identify slopes whose 95 percent CI does not overlap zero
significant = pct_lower > 0 | pct_upper < 0

)

##############################

7. FOREST PLOT PER SPECIES

##############################

This function generates a forest style plot for a single species.
Each point represents the percent change per year for one trait.

plot_species_forest <- function(sp) {

df <- slopes %>% filter(species == sp)

ggplot(df, aes(x = pct, y = reorder(trait, pct))) +
geom_vline(xintercept = 0, linetype = "dashed") +
geom_errorbarh(
aes(xmin = pct_lower, xmax = pct_upper),
height = 0.3
) +
geom_point(aes(color = significant), size = 2.5) +
scale_color_manual(values = c("TRUE" = "red", "FALSE" = "blue")) +
labs(
title = paste("Species:", sp),
x = "Percent change per year",
y = "Trait"
) +
theme_minimal(base_size = 12) +
theme(legend.position = "none")
}

Print plots for all species

for (sp in unique(slopes$species)) {
print(plot_species_forest(sp))
}

##############################

8. COMBINED FOREST PLOT

##############################

Order species alphabetically for consistent display

slopes$species <- factor(
slopes$species,
levels = rev(sort(unique(slopes$species)))
)

combined_forest <- ggplot(slopes, aes(x = pct, y = species)) +
geom_vline(xintercept = 0, linetype = "dashed") +
geom_errorbarh(
aes(xmin = pct_lower, xmax = pct_upper),
height = 0.3
) +
geom_point(aes(color = significant), size = 2.2) +
facet_wrap(~ trait, scales = "free_x") +
scale_color_manual(values = c("TRUE" = "red", "FALSE" = "blue")) +
labs(
x = "Percent change per year",
y = "Species"
) +
theme_minimal(base_size = 11) +
theme(
legend.position = "none",
strip.text = element_text(face = "bold"),
panel.grid.minor = element_blank()
)

print(combined_forest)

############################################################

END OF SCRIPT
This script reproduces Figure 1 of Chapter 1 and
provides species level univariate temporal slopes
for all seven morphological traits.
Percent change per year is derived from log linear models.
Significance is defined as 95 percent confidence intervals
not overlapping zero.

############################################################
