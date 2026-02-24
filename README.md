# Post-Traumatic-Amnesia-Survival-Analysis

**Introduction**

This repository contains my final exam project for the Survival Analysis course in my MPH Epidemiology program.
The project focused on modeling time to clearance of post-traumatic amnesia (PTA) among patients with brain injury using time-to-event methods.
In accordance with course policies, no dataset, results, tables, or numerical outputs are shared publicly. The repository is intended strictly for educational and portfolio purposes to demonstrate methodology, analytic workflow, and statistical programming skills.
The Stata do-file is included for transparency of analytic approach. However, the code may not be copied, redistributed, or reused without permission.

**Study Design and Outcome Definition
**
The primary outcome was time to clearance of post-traumatic amnesia, defined as the number of days from injury to resolution of PTA.
All observations were administratively censored at 120 days. Patients who had not cleared PTA by 120 days were treated as right-censored.
Time-to-event data were structured using Stata’s stset command.

**Modeling Strategy
**
**Functional Form Assessment
**
Continuous exposure variables were initially modeled as linear terms in Cox proportional hazards regression models.
To evaluate potential non-linear relationships, restricted cubic spline models were fit using the mkspline command in Stata. Cubic splines with three or four knots were selected based on sample size and model stability.
Spline models were compared to linear models using likelihood ratio tests. When spline analyses suggested non-linearity or instability, variables were reparameterized. For example, IRF Mobility at Admission was categorized into clinically meaningful groups following spline diagnostics.

**Proportional Hazards Assessment
**
The proportional hazards assumption was evaluated using Schoenfeld residual tests (estat phtest in Stata).
Violations were defined as p-values less than 0.05. When violations were detected, alternative parameterizations were considered.

**Univariate and Multivariable Modeling
**
Univariate Cox proportional hazards models were fit for each exposure variable.
All candidate variables were evaluated for inclusion in multivariable models. Collinearity was assessed during model development, and total length of stay was excluded due to overlap with acute and rehabilitation length of stay.

**Confounding and Effect Modification
**
Bivariate Cox models were used to evaluate confounding of mobility at admission.
A variable was classified as a confounder if it:
Was associated with the outcome in univariate analysis (p < 0.10)
Was correlated with the exposure
Changed the mobility hazard ratio by more than 10% when added to the model
Effect modification was evaluated through interaction terms and comparison of coefficient stability across models.

**Survival Curve Estimation
**
Unadjusted Kaplan–Meier curves were generated using sts graph.
Adjusted survival curves were derived from Cox regression models using stcurve.

**Software
**
All analyses were conducted using Stata.
Key commands include:
stset
stcox
estat phtest
mkspline
sts graph
stcurve

**Important Note
**
This repository does not contain any patient-level data, summary statistics, hazard ratios, or results. The included Stata code is shared to demonstrate methodological structure and analytic reasoning only. Reproduction or redistribution of the code without permission is not permitted.
