* Clear environment and optimize memory
clear all
log using "1_eda.log", replace text


* Drop systematic index to avoid structural modeling pollution
drop obs

* Assign variable and value labels for clean graphical output
label variable gpa "Entering Grade Point Average (GPA)"
label variable tuce "Economics Pre-Test Score (TUCE)"
label variable psi "Personalized System of Instruction (PSI)"
label variable y "Grade Improvement (Y)"

label define binary_lbl 0 "No Improvement / Control" 1 "Improved / Treated"
label values psi binary_lbl
label values y binary_lbl

/* =====================================================================
   2. DATA AUDIT & DATA TYPE INTEGRITY
   ===================================================================== */
* Check sample size, data types, and check for missing fields
describe
misstable summarize

* Inspect numeric formatting, uniqueness, and looking for weird anomalies
codebook gpa tuce psi y

/* =====================================================================
   3. UNIVARIATE ANALYSIS (Distributions & Summary Statistics)
   ===================================================================== */
* Continuous variables: Look at Skewness, Kurtosis, and Percentiles
summarize gpa tuce, detail

* Categorical/Binary variables: Check base frequencies and balance
tabulate psi
tabulate y

* Graphical distribution profiling (Saves plots automatically to your directory)
histogram gpa, normal title("GPA Distribution Profile") name(gpa_hist, replace)
histogram tuce, discrete normal title("TUCE Score Distribution") name(tuce_hist, replace)

/* =====================================================================
   4. BIVARIATE EDA (Identifying Signal & Multicollinearity)
   ===================================================================== */
* Correlation Matrix: Ensure continuous predictors aren't highly collinear
correlate gpa tuce

* Cross-tabulation of binary tracking: Is there a cell with zero observations?
* (Crucial for logit to check for perfect prediction/separation issues)
tabulate psi y, chi2 expected

* Mean comparison: How do GPA and TUCE break down across the outcome variable?
sort y
by y: summarize gpa tuce

* Graphical association checks
graph box gpa, over(y) title("GPA Spread by Grade Improvement Outcome") name(gpa_box, replace)
graph box tuce, over(psi) title("TUCE Baseline by Intervention Assignment") name(tuce_box, replace)

log close
