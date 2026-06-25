


*Estimate the model
reg Output Labor Capital

*Normality test; Graphically and formal
swilk res
sfrancia res

*Heteroscedasticity test; Graphical and Breusch Pagan*
estat hettest

*Autocorrelation/Serial Correlation Test*
estat durbina

*Multicollinearity Test*
estat vif
