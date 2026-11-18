
# F75 Midterm Project Makefile

# Default target
  all: report

# Render the final HTML report
  report:
	  Rscript -e "rmarkdown::render('report/final_report.Rmd')"

# Remove generated report files
  clean:
	  rm -f report/final_report.html

.PHONY: all report clean
