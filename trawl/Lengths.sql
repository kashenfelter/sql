-- 9/1/2014
-- 8/31/2014  Changed this to limit by applying the sat or unsat haul view
-- Base Data For Length Distribution Estimations : Satisfactory Only
-- Single species select statement for length distribution base data
-- !!!!!!!!!!!  Note that original script filters out all hauls that have no lengths
-- 7/30/2014
select aspp.scientific_name, aspp.species,
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
       l.sex,
       l.length_cm,
       h.Operation_Status

from master.VW_Assessment_Species aspp
inner join master.VW_Haul_Chars_Sat h
on aspp.scientific_name in(&sp)
--left join master.VW_Lgth_Wt_Age_Sat l    -- Original
inner join master.VW_Lgth_Wt_Age_All l    -- Retrieve only length records (hauls with no lengths not retained in output)
on l.sample_id = h.sample_id
and l.scientific_name = aspp.scientific_name
and l.length_cm is not null
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
order by h.haul_identifier, l.sex, l.length_cm
;
