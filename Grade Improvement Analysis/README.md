# Student Program Effectiveness Analysis

This repository contains an econometric analysis evaluating the impact of an educational teaching intervention on student performance benchmarks.

## Dataset Background
The dataset is drawn from Spector and Mazzeo's (1980) foundational study on binary choice frameworks in economic education. It tracks 32 students to evaluate if a Personalized System of Instruction (PSI) improves final outcomes.

## Codebook

| Variable Name | Storage Type | Value Range | Definition |
| :--- | :--- | :--- | :--- |
| `gpa` | Float | `0.00` to `4.00` | Entering Grade Point Average |
| `tuce` | Integer | `0` to `35` | Test Under College Economics entry baseline score |
| `psi` | Binary Indicator| `0` = Traditional, `1` = PSI Method | Participation in personalized program track |
| `y` | Binary Indicator| `0` = No Change, `1` = Final Grade Improved | Grade improvement indicator (Dependent Variable) |

## Analytical Methodology
A maximum-likelihood logistic regression (Logit) is specified to compute the log-odds of a student achieving grade improvements:

$$ \ln\left(\frac{P(Y=1)}{1 - P(Y=1)}\right) = \beta_0 + \beta_1(\text{gpa}) + \beta_2(\text{tuce}) + \beta_3(\text{psi}) $$

### Execution
Run the provided Stata commands in `analysis.do` to re-generate the regression parameters, odds-ratios transformations, and marginal effects estimators.
