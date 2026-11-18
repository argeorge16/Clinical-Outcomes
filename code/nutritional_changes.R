
# Nutritional Changes Analysis

# 1. Load packages
library(dplyr)
library(ggplot2)
library(readr)

# 2. Load dataset
heart_data <- read_csv("data/f75_interim.csv")

# 3. Check the dataset
head(heart_data)
names(heart_data)

# 4. Check treatment groups
table(heart_data$arm, useNA = "ifany")

# 5. Calculate changes from baseline to stabilization
nutritional_data <- heart_data %>%
  mutate(
    weight_change = weight1 - weight,
    muac_change = muac1 - muac
  )

# 6. Create a summary table by treatment group
summarize_nutrition <- function(data, baseline, followup, change, outcome) {
  
  data %>%
    group_by(arm) %>%
    summarise(
      outcome = outcome,
      total_children = n(),
      
      complete_pairs = sum(
        !is.na(.data[[baseline]]) &
          !is.na(.data[[followup]])
      ),
      
      missing_pairs = sum(
        is.na(.data[[baseline]]) |
          is.na(.data[[followup]])
      ),
      
      baseline_mean = mean(.data[[baseline]], na.rm = TRUE),
      followup_mean = mean(.data[[followup]], na.rm = TRUE),
      mean_change = mean(.data[[change]], na.rm = TRUE),
      sd_change = sd(.data[[change]], na.rm = TRUE),
      
      .groups = "drop"
    )
}

# 7. Summarize weight and MUAC changes
weight_summary <- summarize_nutrition(
  nutritional_data,
  "weight",
  "weight1",
  "weight_change",
  "Weight (kg)"
)

muac_summary <- summarize_nutrition(
  nutritional_data,
  "muac",
  "muac1",
  "muac_change",
  "MUAC (cm)"
)

# Combine both summaries
nutritional_summary <- bind_rows(
  weight_summary,
  muac_summary
)

# 8. View summary table
print(nutritional_summary)

# 9. Save summary table
dir.create("outputs", showWarnings = FALSE)

write_csv(
  nutritional_summary,
  "outputs/nutritional_changes_table.csv"
)

# 10. Create weight change boxplot
weight_plot_data <- nutritional_data %>%
  filter(
    !is.na(weight),
    !is.na(weight1),
    !is.na(weight_change),
    !is.na(arm)
  )

weight_boxplot <- ggplot(
  weight_plot_data,
  aes(x = arm, y = weight_change, fill = arm)
) +
  geom_boxplot() +
  labs(
    title = "Weight Change from Baseline to Stabilization",
    x = "Treatment Group",
    y = "Weight Change (kg)",
    fill = "Treatment Group"
  ) +
  theme_minimal() +
  theme(
    legend.position = "none",
    plot.title = element_text(hjust = 0.5)
  )

# 11. Display boxplot
print(weight_boxplot)

# 12. Save boxplot
ggsave(
  "outputs/weight_change_boxplot.png",
  plot = weight_boxplot,
  width = 8,
  height = 6,
  dpi = 300
)

