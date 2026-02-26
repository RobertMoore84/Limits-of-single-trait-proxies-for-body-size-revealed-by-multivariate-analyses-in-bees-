Limits-of-single-trait-proxies-for-body-size-revealed-by-multivariate-analyses-in-bees

Multivariate and phylogenetically informed analyses of long term morphological change in Australian bees using museum specimens collected between 1900 and 2000.

Overview

This repository contains the analytical code and input files supporting Chapter 1 of my thesis on long term morphological change in native Australian bees using historical museum specimens.

The study evaluates the limits of single trait proxies for body size by applying a multivariate and phylogenetically informed framework to seven morphological traits measured across ten species. The workflow includes species level linear modelling, phylogenetic signal estimation, phylogenetic principal components analysis, and multivariate morphospace displacement metrics.

Research Objectives

The analyses in this repository aim to:

quantify species level temporal trends in individual morphological traits using log linear models

estimate phylogenetic signal in morphological traits using Blomberg's K and Pagel's lambda

characterise multivariate trait structure using phylogenetic principal components analysis

calculate cumulative multivariate displacement through time to compare the magnitude of morphological change among species

assess whether intertegular distance adequately captures long term body size dynamics relative to additional morphological traits

Study System

Morphological measurements were obtained from historical specimens of ten native Australian bee species spanning four families:

Apidae

Colletidae

Halictidae

Megachilidae

Seven morphological traits were measured from calibrated digital images:

Intertegular distance (ITD)

Head width

Compound eye length

Compound eye width

Rear ocelli diameter

Front ocelli diameter

Right wing length

Phylogenetic analyses are based on a pruned global bee backbone phylogeny.

Repository Structure
.
├── data/
│   ├── AusBeesPopDen1.csv
│   └── BEE_phylogeny.nwk
├── scripts/
│   ├── 01_data_cleaning.R
│   ├── 02_species_level_trends.R
│   ├── 03_phylogenetic_signal.R
│   ├── 04_phylogenetic_pPCA.R
│   ├── 05_morphospace_displacement.R
│   └── 06_figure_generation.R
├── figures/
│   └── (generated figures)
└── README.md
Input Files

This repository includes the core input files required to reproduce the analyses:

data/AusBeesPopDen1.csv: morphological dataset used in the Chapter 1 analyses

data/BEE_phylogeny.nwk: Newick format phylogeny used for pruning and phylogenetically informed analyses

Species names in the dataset and phylogeny should match after standardisation.

Methods Summary
Species Level Temporal Trends

For each species and trait, linear models of the form:

log(trait) ~ year

were fitted to estimate proportional change through time. Slopes were back transformed to percent change per year. Statistical support is defined as 95% confidence intervals not overlapping zero.

Phylogenetic Signal

Phylogenetic signal was assessed using:

Blomberg's K

Pagel's lambda

These analyses were conducted in R using the phytools and ape packages.

Phylogenetic Principal Components Analysis

A phylogenetically informed PCA was used to summarise multivariate trait structure while accounting for shared evolutionary history. The first two axes were used to visualise species positions in morphospace.

Cumulative Morphospace Displacement

Species decade means were projected into phylogenetic morphospace, and cumulative Euclidean displacement was calculated to quantify total multivariate morphological change through time.

Software Requirements

All analyses were conducted in R (version 4.3.0 or later).

Required packages include:

dplyr

tidyr

ggplot2

ape

phytools

Additional packages may be required for specific scripts.

Reproducibility

To reproduce the analyses:

Clone or download this repository.

Ensure the working directory is set to the repository root.

Confirm that all scripts use relative file paths, for example:

data/AusBeesPopDen1.csv

data/BEE_phylogeny.nwk

Run scripts sequentially from the scripts/ directory.

Regenerate figures into the figures/ directory.

Data Availability

Morphological measurements were derived from Australian entomological museum collections.

The processed dataset required to reproduce the analyses is included in this repository. Any additional raw specimen level records or image archives may be subject to institutional access conditions.
