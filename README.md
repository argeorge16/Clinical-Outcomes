# F75 Midterm Project

## Project Overview

This project aims to develop an automated and reproducible report analyzing nutritional and clinical outcomes among children with severe acute malnutrition using data from the F75 randomized controlled trial.

The study evaluates whether a modified F75 therapeutic milk formula improves outcomes compared with standard F75. Our report will summarize baseline characteristics, nutritional changes, and clinical outcomes across the two treatment groups.

## Dataset

The project uses the following files:

- `f75_interim.csv`: Study dataset containing participant characteristics, nutritional measurements, treatment information, and clinical outcomes.
- `f75_codebook.xlsx`: Data dictionary describing the variables, their definitions, and coding.

The codebook will be used to guide variable selection, interpretation, and appropriate handling of special outcome codes.

**Primary publication:** https://pubmed.ncbi.nlm.nih.gov/30807589/

## Group Members and Responsibilities

| Group Member | Responsibility |
|---|---|
| Heeya Naik | Team Lead: GitHub management, integration, automation, and final report |
| Madhu Bulusu | Baseline characteristics |
| Hannah Johnson | Nutritional changes |
| Aniya George | Clinical outcomes |

## Repository Organization

The repository is organized into the following folders:

- `data/`: Study dataset and codebook.
- `code/`: R scripts for data analysis.
- `outputs/`: Generated tables and figures.
- `report/`: Final R Markdown report and HTML output.

Additional project files include:

- `README.md`: Project overview and instructions.
- `Makefile`: Automates the analysis and report generation.
- `config.yml`: Controls report customization.
- `renv.lock`: Records package dependencies for reproducibility.

## Analysis Components

### 1. Baseline Characteristics

Summarizes demographic and nutritional characteristics, including age, sex, weight, MUAC, and breastfeeding status, by treatment group.

### 2. Nutritional Changes

Examines changes in weight and MUAC between baseline and follow-up measurements, comparing the two treatment groups.

### 3. Clinical Outcomes

Summarizes time to clinical stabilization and discharge outcomes by treatment group, following the study definitions and outcome coding.

## Requirements

The project requires:

- R and RStudio
- The R packages specified in the project's `renv.lock` file
- GNU Make

## Building the Report

1. Clone the repository.
2. Open the project in RStudio.
3. Restore the required R packages using:

```r
renv::restore()
```

4. From the repository's root directory, run:

```bash
make
```

The Makefile will coordinate the analysis scripts and generate the updated report and outputs.

## Customization

The report will use `config.yml` to allow users to select which treatment group to include.

The planned options are:

- Both treatment groups
- Modified F75 only
- Standard F75 only

Users can change the treatment-group selection in the configuration file and rerun `make` to regenerate the report.

## Reproducibility

The analysis is designed to generate tables, figures, and report summaries dynamically from the dataset rather than relying on manually entered results or fixed sample sizes.

The workflow will also be tested using updated data to assess whether the report and its outputs update automatically.

The `renv.lock` file will help maintain consistent package versions across users and computing environments.
