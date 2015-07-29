-- Length Age Weight with Maturities : Unsat Hauls
-- Single species select statement for length weight age maturity
-- 7/30/2014
-- 7/27/2015  Updated for Maturity additions and changes made earlier this year to the Satisfactory version of this script.

select
       aspp.scientific_name, aspp.species,
       h.project,
       h.project_cycle,
       h.vessel,
       h.haul_identifier,
       h.Capture_Date,
       h.best_lat_dd as haul_latitude_dd,
       h.best_lon_dd as haul_longitude_dd,
       h.best_position_type as position_type,
       h.best_depth_m as depth_m,
       h.best_depth_type as depth_type,
       a.sex,
       a.length_cm,
       a.weight_kg,
       a.age_yrs,
       m.IS_BIOLOGICALLY_MATURE,
       m.IS_FUNCTIONALLY_MATURE,
       m.PROPORTION_ATRESIA,
       m.IS_SPENT,
       m.IS_BIO_MATURITY_CERTAIN,
       m.OOCYTE_STAGE_01,
       m.OOCYTE_STAGE_02,
       m.OOCYTE_STAGE_03,
       m.OOCYTE_STAGE_04,
       m.OOCYTE_STAGE_04_1,
       m.OOCYTE_STAGE_04_2,
       m.OOCYTE_STAGE_05,
       m.OOCYTE_STAGE_06,
       m.OOCYTE_STAGE_07,
       m.OOCYTE_STAGE_08,
       m.OOCYTE_STAGE_09,
       m.OOCYTE_STAGE_10,
       m.IS_POF_PRESENT,
       m.IS_SPAWNING,
       m.SPECIMEN_NUMBER,
       m.SLIDE_IDENTIFIER,
       m.SPECIMEN_PROBLEM,
       m.ANALYSIS_NOTE,
       h.Operation_Status,
       h.Removal_Reason,
       h.Survey_Lat_Chk,
       h.Survey_Depth_Chk

from master.VW_Assessment_Species aspp
inner join master.VW_Haul_Chars_UnSat h
on aspp.scientific_name in(&sp)
--left join master.VW_length_distribution_sat a
inner join master.VW_Lgth_Wt_Age_All a
on a.sample_id = h.sample_id
and a.scientific_name = aspp.scientific_name
left join master.MV_maturity_All m
on m.individual_id = a.individual_id
and not(a.weight_kg is null and a.age_yrs is null and m.IS_BIOLOGICALLY_MATURE is null)
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
--order by h.haul_identifier, a.sex, a.length_cm, a.age_yrs
;
