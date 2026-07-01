# Maize Output Supply Response in Malawi: An ARDL Approach

![Stata Version](https://shields.io) ![License: MIT](https://shields.io) ![Econometrics](https://shields.io)


This repository contains the empirical framework, data preparation workflow, and time-series estimation codes to analyze the **Sorghum Output Supply Response in Malawi**. 

Using an **Autoregressive Distributed Lag (ARDL) Bounded Cointegration framework**, this study isolates both the short-run structural dynamics and the long-run equilibrium relationships driving sorghum production.

---

## Research Framework & Model

The empirical strategy models sorghum production response as a function of land allocation, economic incentives, input availability, climate variability, and macroeconomic shocks:

$$\ln(\text{Output}_t) = \beta_0 + \beta_1 \ln(\text{Area}_t) + \beta_2 \ln(\text{Price}_t) + \beta_3 \ln(\text{Fertilizer}_t) + \beta_4 \ln(\text{Rainfall}_t) + \beta_5 \ln(\text{CPI}_t) + \varepsilon_t$$

### Variable Definitions
* `lnoutput`: Sorghum production quantity (Dependent Variable)
* `lnarea`: Cultivated land size (captures acreage response)
* `lnprice`: Producer/market price of sorghum (incentive response)
* `lnfertilizer`: Volume of input usage (technology/intensification tracker)
* `lnrainfall`: Annual regional precipitation metrics (climate vulnerability proxy)
* `lncpi`: Consumer Price Index (macroeconomic inflation control variable)

---

## Econometric Workflow

The Stata execution pipeline follows standard rigorous time-series protocols:
### Econometric Workflow

The Stata execution pipeline follows standard rigorous time-series protocols:

```text
[Data Input & Log-Transform]
             │
             ▼
[CUSUM Structural Break Analysis]
             │
             ▼
[VARSOC Lag Optimization]
             │
             ▼
[Augmented Dickey-Fuller (ADF) Unit Root Tests]
             │
             ▼
[Bounds-Tested ARDL & Error Correction Model (ECM)]
             │
             ▼
[Post-Estimation Stability & Residual Diagnostics]
```

### Key Execution Highlights
1. **Stationarity Assessment:** Runs exact-lag `dfuller` adjustments to categorize variable integration layers (I(0) vs I(1)).
2. **Dynamic Restraints:** Restricts active modeling to the `tin(1991, 2025)` timeline to dodge historical structural distortion.
3. **Robustness Validation:** Evaluates parameter constancy and check for serial error correlation via automated post-estimations (`sbcusum`, `bgodfrey`).

---

## Getting Started

### Prerequisites
You need **Stata 16 or newer** to execute the scripts flawlessly. Ensure you install the required user-written econometric packages from the Stata SSC architecture:

```stata
ssc install ardl
ssc install cusum6
```

### Installation & Execution
1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com
   ```
2. Place your raw dataset `sorghum_malawi.xlsx` in your working directory.
3. Open the `.do` file and point the root directory string to your exact dataset file path:
   ```stata
   import excel "C:\YOUR_PATH\sorghum_malawi.xlsx", sheet("Sheet1") firstrow
   ```
4. Run the code to generate the system output, cointegration bounds, and diagnostics.

---

## Repository Structure

```text
├── Data/
│   └── sorghum_malawi.xlsx      # Primary data file (1991 - 2025 metrics)
├── Scripts/
│   └── supply_response.do       # Full Stata replication file
├── Output/
│   └── regression_results.txt   # Exported ARDL & ECM results
└── README.md                    # Project documentation
```

---

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

