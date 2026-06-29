#  Avocado Sales Data: Automated Cleaning, Hypothesis Testing, & Panel Modeling

This repository contains an end-to-end econometric workflow in STATA to clean, audit, test, and model a historical dataset of United States retail avocado transactions. 

The primary goal of this project is to analyze price elasticity (how transaction volumes affect average retail prices) while enforcing strict statistical integrity by testing and correcting for core OLS violations.

---

##  Dataset Overview

The underlying dataset tracks weekly transaction volumes and average prices across several regional US markets, stratified by product characteristics.

### Variable Dictionary

| Variable Name | Original Type | Transformed Type | Analytical Role & Description |
| :--- | :--- | :--- | :--- |
| `Date` | String | Numeric (`%td`) | Calendar time dimension (Weekly cadence) |
| `averageprice` | Float | Float | **Dependent Variable (Y)**: Average retail cost per avocado |
| `Total Volume` | Double | Double | **Primary Independent Variable (X)**: Total units sold |
| `4046` / `4225` / `4770` | Double | Double | Volume breakdown by specific PLU product size keys |
| `total / Small / Large Bags` | Double | Double | Volume breakdown by packaging sizes |
| `type` | String | Labeled Numeric | Category control: `conventional` vs. `organic` |
| `year` | Int | Int | Categorical time dimension control |
| `region` | String | Labeled Numeric | Geographic market panel dimension (e.g., Albany) |

---

##  Data Cleaning & Pipeline Troubleshooting

During the development of the automation scripts, several structural data constraints and STATA execution errors were systematically handled:

1. **String Layout Error (`r(109)`)**: The cross-tabulation `table` command initially failed because `type` was a raw string. Resolved by implementing `encode type, generate(type_numeric)`.
2. **Variable Mismatch Error (`r(111)`)**: The system could not find the exact string `Date` due to leading index-column parsing shifts from Excel/CSV inputs. Resolved by mapping and forcing variable matching via `capture rename`.
3. **Repeated Time Values in Panel (`r(451)`)**: Declaring a panel using `xtset region_numeric date_clean` failed because each city contains duplicate dates (one row for *conventional* avocados and one for *organic*). Resolved by constructing a composite ID using `egen panel_id = group(region_numeric type_numeric)`.
4. **Unrecognized Command (`xtserial`)**: Automated SSC network package fetching failed due to environment/firewall constraints. Resolved by writing a manual, self-contained Wooldridge testing loop using first-differenced fixed-effects panel residuals.

---

## 🔬 Econometric Hypothesis Testing Framework

To ensure the statistical validity of our regression outputs, the master pipeline executes three core hypothesis tests after running a baseline Ordinary Least Squares (OLS) model:

* **Heteroskedasticity (Breusch-Pagan / Cook-Weisberg Test)**  
  * *Command*: `estat hettest`  
  * *Null Hypothesis ($H_0$)*: Constant variance (Homoskedasticity).  
  * *Finding*: Severely rejected ($p = 0.0000$). Residual spread varies significantly across pricing segments, rendering traditional standard errors invalid.
* **Multicollinearity (Variance Inflation Factor)**  
  * *Command*: `estat vif`  
  * *Threshold*: Mean VIF > 5 or Individual VIF > 10 flags dangerously redundant columns (e.g., introducing individual PLUs alongside `totalvolume`).
* **Serial Autocorrelation (Wooldridge Panel Residual Test)**  
  * *Command*: Manual First-Difference Residual Loop (`test l.d_resid = -0.5`)  
  * *Null Hypothesis ($H_0$)*: No first-order serial correlation within panel groups over weekly cycles.

### The Resolution: Cluster-Robust Standard Errors
To fix both the proven heteroskedasticity violation ($p=0.0000$) and regional time-series correlation simultaneously, the final model abandons vanilla OLS standard errors and implements cluster-robust covariance estimation grouped at the unique market level:
```stata
regress averageprice totalvolume i.type_numeric i.year, vce(cluster panel_id)
```

---

##  How to Run the Master Pipeline

1. Clone this repository to your local directory:
   ```bash
   git clone https://github.com
   ```
2. Place your raw avocado data file into the repository root.
3. Open STATA, navigate your working directory to the repo folder, and execute the master pipeline:
   ```stata
   do avocado_master_workflow.do
   ```
4. Check the generated `2_modelling.log` text file to see the live console outputs, test matrices, and regression coefficient panels.
