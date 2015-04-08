-- Length Age Weight  Unsat Hauls
-- Single species select statement for length age wt
-- 9/1/2014

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
       a.age_yrs
       ,h.Operation_Status,
       h.Removal_Reason,
       h.Survey_Lat_Chk,
       h.Survey_Depth_Chk

from master.VW_Assessment_Species aspp
inner join master.VW_Haul_Chars_UnSat h
on aspp.scientific_name in(&sp)
--left join master.VW_length_distribution_sat a   -- Original
inner join master.VW_Lgth_Wt_Age_All a
on a.sample_id = h.sample_id
and a.scientific_name = aspp.scientific_name
and not(a.weight_kg is null and a.age_yrs is null)
where project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
order by haul_identifier, sex, length_cm, age_yrs
;
