**Estimating Poisson model**
import excel "C:\Users\LENOVO\OneDrive\Dokumente\CMAEE Documents\econometrics datasets\Poisson Data.xlsx", sheet("Sheet1") firstrow
**EDA**
hist ILLNESS, norm
**Running the model**
poisson ILLNESS NONDOCCO i.SEX AGE INCOME i.LEVYPLUS i.FREEPOOR i.FREEREPA ACTDAYS i.HSCORE i.CHCOND1 i.CHCOND2

**Goodness-of-fit**
estat gof
fitstat
 **Marginal effects**
margins, dydx(*) atmeans