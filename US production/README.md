# Historical Macroeconomic Modeling (1929–1967)

A comprehensive time-series econometric project analyzing the classic Cobb-Douglas production function using historical US data. This project covers the full empirical pipeline: Exploratory Data Analysis (EDA), Ordinary Least Squares (OLS) estimation, and classical diagnostic assumption testing using Stata.

##Dataset Overview
The dataset contains annual economic observations from **1929 to 1967** (N = 39), capturing critical historical eras including the Great Depression, World War II industrial mobilization, and the post-war economic boom.

### Variables Matrix
*   `id`: Observation index.
*   `Year`: Time-series index (1929–1967).
*   `Output` (Y): Aggregate real economic output index.
*   `Labor` (L): Total labor input (person-hours / employment).
*   `Capital` (K): Aggregate capital stock (fixed physical assets).

---

##Methodology & Pipeline

### 1. Exploratory Data Analysis (EDA)
*   **Log Transformations**: Converted variables to natural logs (`ln_Output`, `ln_Labor`, `ln_Capital`) to linearize the production function.
*   **Trend Analysis**: Isolated historical macroeconomic shocks, specifically tracking the drop during the Great Depression (1929–1933) and explosive growth during WWII (1939–1945).

### 2. OLS Econometric Modeling
The empirical model is specified as a linearized Cobb-Douglas production function:

```text
ln(Output_t) = β₀ + β₁ ln(Labor_t) + β₂ ln(Capital_t) + ε_t
```

*   **Elasticities**: Coefficients represent the output elasticities of labor (β₁) and capital (β₂).
*   **Hypothesis Testing**: Structural testing for Returns to Scale using post-estimation linear restrictions.

### 3. OLS Post-Estimation Diagnostic Tests
To verify that the OLS estimators are Best Linear Unbiased Estimators (BLUE), the following Stata diagnostics were executed:

| OLS Assumption | Stata Commands / Tests Executed | Focus Area |
| :--- | :--- | :--- |
| **No Multicollinearity** | `vif` | Variance Inflation Factors for independent variables |
| **Homoscedasticity** | `hettest` / `imtest, white` | Breusch-Pagan / Cook-Weisberg and White's test |
| **No Autocorrelation** | `estat dwatson` / `estat bgodfrey` | Durbin-Watson and Breusch-Godfrey LM tests |
| **Normality of Residuals** | `predict r, resid` → `swilk r` / `sktest` | Shapiro-Wilk and skewness/kurtosis tests on residuals |
| **Model Specification** | `estat ovtest` | Ramsey RESET test for omitted variables |

---

## Repository Structure
```text
├── data/
│   └── production_data_1929_1967.csv   # Cleaned raw dataset
├── script/
│   └── analysis.do                    # Stata Do-File (EDA, OLS, and Diagnostics)
├── model/
│   ├── regression_results.txt         # Exported OLS regression tables
│   └── diagnostics/                   # Residual plots and distribution graphs
└── README.md                          # Project documentation
```

---

##  How to Run the Analysis

### Prerequisites
*   Stata (Version 14 or higher)

### Execution Steps
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com
   ```
2. Open Stata.
3. Set your working directory to the cloned repository path:
   ```stata
   cd "path/to/cloned/repository"
   ```
4. Run the master script to reproduce all results:
   ```stata
   do src/analysis.do
   ```
