import excel "C:\Users\LENOVO\OneDrive\Dokumente\CMAEE Documents\econometrics datasets\Cobb-Douglas Y-production dataset.xlsx", sheet("Sheet1") firstrow


*Estimate the model
reg Output Labor Capital

*Normality test; Graphically and formal
predict resid, residual
hist resid, norm
pnorm res, grid
swilk res
sfrancia res

*Heteroscedasticity test; Graphical and Breusch Pagan*
gen ressq=resid*resid
predict yhat
twoway scatter ressq yhat
estat hettest

*Autocorrelation/Serial Correlation Test*
tsset Year
reg Output Labor Capital
twoway scatter resid, Year
tsline resid
estat durbina

*Multicollinearity Test*
estat vif
