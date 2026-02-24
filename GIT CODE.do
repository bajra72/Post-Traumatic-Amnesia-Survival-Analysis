*** The included Stata code is shared to demonstrate methodological structure and analytic reasoning only.
*** Reproduction or redistribution of the code without permission is not permitted.
*** December 15, 2025
*****************************************************
clear all

*Setting up survival data
gen event = (pta_days <= 120 & pta_days != .)
gen new_pta = cond(pta_days <= 120, pta_days, 120)
stset new_pta, failure(event==1)

*Univariate Analysis
*Age
stcox age
estat phtest, detail
*Age checking non-linearity by spline
mkspline age_spline = age, cubic nknots(4)
stcox age_spline1 age_spline2 age_spline3
estat phtest, detail

*Male
stcox ib1.male
estat phtest, detail

*Race
stcox ib1.race
estat phtest, detail

*Onset Year
stcox onset_yr
estat phtest, detail
*Onset checking non-linearity by spline
mkspline onset_spline = onset_yr, cubic nknots(4)
stcox onset_spline1 onset_spline2 onset_spline3
estat phtest, detail

*Acute LOS
stcox acute_los
estat phtest, detail
*Acute checking non-linearity by spline
mkspline acute_los_spline = acute_los, cubic nknots(4)
stcox acute_los_spline1 acute_los_spline2 acute_los_spline3
estat phtest, detail

*Rehab LOS
stcox rehab_los
estat phtest, detail
*Rehab non-linearity by spline
mkspline rehab_los_spline = rehab_los, cubic nknots(4)
stcox rehab_los_spline1 rehab_los_spline2 rehab_los_spline3
estat phtest, detail

*Total LOS
stcox total_los
estat phtest, detail
*Total non-linearity by spline
mkspline total_los_spline = total_los, cubic nknots(4)
stcox total_los_spline1 total_los_spline2 total_los_spline3
estat phtest, detail

*DRS at admission
stcox drs_adm
estat phtest, detail
*drs_adm non-linearity by spline
mkspline drs_adm_spline = drs_adm, cubic nknots(4)
stcox drs_adm_spline1 drs_adm_spline2 drs_adm_spline3
estat phtest, detail

*DRS at discharge
stcox drs_dis
estat phtest, detail
*drs_dis non-linearity by spline
mkspline drs_dis_spline = drs_dis, cubic nknots(4)
stcox drs_dis_spline1 drs_dis_spline2 drs_dis_spline3
estat phtest, detail

*IRF self-care at admission
stcox irf_self_adm
estat phtest, detail
*irf_self_adm non-linearity by spline
mkspline irf_self_adm_spline = irf_self_adm, cubic nknots(3)
stcox irf_self_adm_spline1 irf_self_adm_spline2 
estat phtest, detail

*IRF self-care at discharge
stcox irf_self_dis
estat phtest, detail
*irf_self_dis non-linearity by spline
mkspline irf_self_dis_spline = irf_self_dis, cubic nknots(3)
stcox irf_self_dis_spline1 irf_self_dis_spline2 
estat phtest, detail

*Mobility at admission
stcox irf_mob_adm
estat phtest, detail
*irf_mob_adm non-linearity by spline
mkspline irf_mob_adm_spline = irf_mob_adm, cubic nknots(3)
stcox irf_mob_adm_spline1 irf_mob_adm_spline2 
estat phtest, detail
*Generate Categories
gen mob_cat = .
replace mob_cat = 1 if irf_mob_adm >= 15 & irf_mob_adm <= 19
replace mob_cat = 2 if irf_mob_adm >= 20 & irf_mob_adm <= 30
replace mob_cat = 3 if irf_mob_adm > 30
stcox mob_cat
estat phtest, detail

*Mobility at discharge
stcox irf_mob_dis
estat phtest, detail
*irf_mob_adm non-linearity by spline
mkspline irf_mob_dis_spline = irf_mob_dis, cubic nknots(3)
stcox irf_mob_dis_spline1 irf_mob_dis_spline2 
estat phtest, detail

*Full Cox model
stcox i.mob_cat age ib1.male ib1.race onset_yr acute_los rehab_los total_los drs_adm drs_dis irf_self_adm irf_self_dis irf_mob_dis

*Proportional hazards test for full model
estat phtest, detail

*Bivariate Analysis
*Acute LOS
stcox ib1.mob_cat acute_los
estat phtest, detail

*Rehab LOS
stcox ib1.mob_cat rehab_los
estat phtest, detail

*DRS at admission
stcox ib1.mob_cat drs_adm
estat phtest, detail

*DRS at discharge
stcox ib1.mob_cat drs_dis
estat phtest, detail

*IRF self-care at admission
stcox ib1.mob_cat irf_self_adm
estat phtest, detail

*IRF self-care at discharge
stcox ib1.mob_cat irf_self_dis
estat phtest, detail

*Mobility at discharge
stcox ib1.mob_cat irf_mob_dis
estat phtest, detail

*Table 2A Prediction model of time to clear PTA
stcox acute_los rehab_los drs_dis irf_self_dis irf_mob_dis
estat phtest, detail

*Table 2B Multiple variable models for mobility and time to clear PTA
stcox i.mob_cat drs_adm irf_self_adm
estat phtest, detail

*Unadjusted Kaplian Meir
sts graph, by(mob_cat) title("Kaplan-Meier Survival Estimates") xtitle("Days to Clear PTA") ytitle("Probability of Remaining in PTA") legend(label(1 "Mobility Category 1") label(2 "Mobility Category 2") label(3 "Mobility Category 3"))

*Adjusted Kaplian Meir
stcox i.mob_cat drs_adm irf_self_adm 
stcurve, survival at(mob_cat=(1 2 3)) legend(order(1 "Mobility 1" 2 "Mobility 2" 3 "Mobility 3")) xtitle("Days to Clear PTA") ytitle("Adjusted Survival Probability") title("Adjusted Survival Curves by Mobility Category (Model 2)")

*Proportional Hazard
estat phtest, detail

*clear
clear










