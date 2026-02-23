# Limits-of-single-trait-proxies-for-body-size-revealed-by-multivariate-analyses-in-bees-
Multivariate and phylogenetically informed analyses of long term morphological change in Australian bees using museum specimens from 1900 to 2000.


Multivariate Analyses of Body Size in Australian Bees
Overview

This repository contains the analytical code supporting Chapter 1 of my thesis examining long term morphological change in native Australian bees using historical museum specimens collected between 1900 and 2000.

The study evaluates the limitations of single trait proxies for body size by applying a multivariate and phylogenetically informed framework to seven morphological traits measured across ten species. The workflow integrates species level linear modelling, phylogenetic signal estimation, phylogenetic principal components analysis, and multivariate morphospace displacement metrics.

Research Objectives

The analyses in this repository aim to:

Quantify species level temporal trends in individual morphological traits using log linear models.

Estimate phylogenetic signal in morphological traits using Blomberg’s K and Pagel’s lambda.

Characterise multivariate trait structure using phylogenetic principal components analysis.

Calculate cumulative multivariate displacement through time to compare the magnitude of morphological change among species.

Assess whether intertegular distance adequately captures long term body size dynamics relative to additional morphological traits.

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
├── data/
│   └── (data files not publicly distributed unless permitted)
│
├── scripts/
│   ├── 01_data_cleaning.R
│   ├── 02_species_level_trends.R
│   ├── 03_phylogenetic_signal.R
│   ├── 04_phylogenetic_pPCA.R
│   ├── 05_morphospace_displacement.R
│   └── 06_figure_generation.R
│
├── figures/
│   └── (generated figures)
│
└── README.md

File paths within scripts are provided as placeholders and should be modified locally.

Methods Summary
Species Level Temporal Trends

For each species and trait, linear models of the form:

log(trait) ~ year

were fitted to estimate proportional change through time. Slopes were back transformed to percent change per year. Statistical support is defined as 95 percent confidence intervals not overlapping zero.

Phylogenetic Signal

Phylogenetic signal was assessed using:

Blomberg’s K

Pagel’s lambda

Analyses were conducted using the phytools and ape packages in R.

Phylogenetic Principal Components Analysis

A phylogenetically informed PCA was used to summarise multivariate trait structure while accounting for shared evolutionary history. The first two axes were used to visualise species positions in morphospace.

Cumulative Morphospace Displacement

Species decade means were projected into phylogenetic morphospace and cumulative Euclidean displacement was calculated to quantify total multivariate morphological change through time.

Software Requirements

All analyses were conducted in R (version 4.3.0 or later).

Required packages include:

dplyr
tidyr
ggplot2
ape
phytools

Additional packages may be required depending on specific scripts.

Data Availability

Morphological measurements were obtained from Australian entomological museum collections. Raw specimen data are not publicly distributed unless permitted by the holding institutions.

Processed data required to reproduce analyses may be made available upon reasonable request, subject to institutional agreements.

Reproducibility

All scripts are annotated to ensure transparency and reproducibility. Analyses can be reproduced by:

Updating file paths to local data and phylogeny files.

Running scripts sequentially.

Regenerating figures from the scripts/ directory.

Citation

If using this code or analysis framework, please cite the associated thesis or manuscript:
