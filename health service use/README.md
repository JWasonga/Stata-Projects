# Healthcare Utilization and Health Status Analysis

This repository contains an econometric analysis exploring the relationship between individual health status, demographic attributes, insurance coverage, and healthcare utilization. 

## Dataset Variables

The dataset consists of cross-sectional individual-level observations with the following attributes:

*   **NONDOCCO**: Count of non-doctor health professional consultations.
*   **SEX**: Binary indicator for gender (1 = Male / 0 = Female, or vice-versa).
*   **AGE**: Respondent age scaled or normalized relative to a baseline population sample (e.g., 0.19 years/index).
*   **INCOME**: Annual or monthly individual income (scaled in tens of thousands or normalized units).
*   **LEVYPLUS**: Binary indicator for private health insurance levy/cover coverage (1 = Yes, 0 = No).
*   **FREEPOOR**: Binary indicator for free government health insurance due to low income (1 = Yes, 0 = No).
*   **FREEREPA**: Binary indicator for free health insurance due to old age, disability, or veteran status (1 = Yes, 0 = No).
*   **ILLNESS**: The number of illnesses or conditions reported by the respondent in the past reference period.
*   **ACTDAYS**: Number of days of reduced activity due to illness or injury in the past two weeks.
*   **HSCORE**: General health status score metric.
*   **CHCOND1 / CHCOND2**: Binary indicators for chronic conditions (1 = Chronic condition present, 0 = No).

---

## Methodology & Analysis Steps

The statistical analysis follows a systematic approach implemented in STATA:

### 1. Univariate Exploratory Analysis
*   **Visualizing Health Outcomes**: A histogram was generated for the right-skewed discrete count variable `ILLNESS` to evaluate the frequency distribution of health shocks across the sample population.

### 2. Poisson Count Regression Model
Given that `ILLNESS` is a non-negative integer count variable, a standard **Poisson Regression Model** was fitted to evaluate how demographics (`SEX`, `AGE`, `INCOME`) and insurance status (`LEVYPLUS`, etc.) influence health outcomes:
```stata
poisson illness sex age income levyplus freepoor freerepa chcond1 chcond2
```

### 3. Post-Estimation Diagnostics
*   **Goodness-of-Fit Test**: Evaluated whether the data satisfies the strict Poisson assumption of equidispersion (where Conditional Variance equals the Conditional Mean) using:
```stata
estat gof
```
*(Note: A statistically significant chi-square statistic from this test indicates overdispersion, suggesting a Negative Binomial model may be a preferred alternative).*

### 4. Marginal Effects Estimation
Because Poisson coefficients represent log-expected counts and are non-linear, **Marginal Effects at the Mean (MEMs)** or **Average Marginal Effects (AMEs)** were computed to interpret the real-world, unit-level changes in expected illnesses:
```stata
margins, dxfdx(*)
```
