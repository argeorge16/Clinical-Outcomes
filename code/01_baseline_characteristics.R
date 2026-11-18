
# DATA 550 Midterm Project
# Coder 1: Baseline Characteristics (Table 1)

# Read dataset
f75 <- read.csv("data/f75_interim.csv")

# Create output directory if necessary
dir.create("outputs", showWarnings = FALSE, recursive = TRUE)

# Check required variables
required_vars <- c("arm", "agemons", "sex",
                   "weight", "muac", "bfeeding")

stopifnot(all(required_vars %in% names(f75)))

# Summarize continuous variables as Mean (SD)
summarize_continuous <- function(x) {
  if (all(is.na(x))) return("NA")
  sprintf("%.2f (%.2f)", mean(x, na.rm = TRUE),
          sd(x, na.rm = TRUE))
}

# Summarize categorical variables as n (%)
summarize_categorical <- function(x, category) {
  valid <- !is.na(x)
  n <- sum(x[valid] == category)
  denominator <- sum(valid)
  if (denominator == 0) return("NA")
  sprintf("%d (%.1f%%)", n, 100 * n / denominator)
}

# Treatment groups
groups <- c("Modified F75 (intervention)", "Standard F75")

# Function to create summaries for one group
summarize_group <- function(d) {
  c(
    "Participants, n" = as.character(nrow(d)),
    "Age (months), Mean (SD)" =
      summarize_continuous(d$agemons),
    "Female, n (%)" =
      summarize_categorical(d$sex, "Female"),
    "Male, n (%)" =
      summarize_categorical(d$sex, "Male"),
    "Weight (kg), Mean (SD)" =
      summarize_continuous(d$weight),
    "MUAC (cm), Mean (SD)" =
      summarize_continuous(d$muac),
    "Currently breastfeeding: Yes, n (%)" =
      summarize_categorical(d$bfeeding, "Yes"),
    "Currently breastfeeding: No, n (%)" =
      summarize_categorical(d$bfeeding, "No"),
    "Currently breastfeeding: Missing, n" =
      as.character(sum(is.na(d$bfeeding)))
  )
}

# Build Table 1
table1 <- data.frame(
  Characteristic = names(summarize_group(f75)),
  check.names = FALSE
)

for (group in groups) {
  d <- f75[!is.na(f75$arm) & f75$arm == group, ]
  table1[[group]] <- unname(summarize_group(d))
}

# Save results for the report
saveRDS(table1, "outputs/table1_baseline.rds")
write.csv(table1, "outputs/table1_baseline.csv",
          row.names = FALSE)

# Display table in console
print(table1, row.names = FALSE)
