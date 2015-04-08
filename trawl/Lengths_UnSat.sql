-- 9/1/2014
-- 8/31/2014 Unsat length distribution
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
       l.length_cm
       ,h.Operation_Status,
       h.Removal_Reason,
       h.Survey_Lat_Chk,
       h.Survey_Depth_Chk

from master.VW_Assessment_Species aspp
inner join master.VW_Haul_Chars_UnSat h
on aspp.scientific_name in(&sp)
-- left join master.VW_Lgth_Wt_Age_All l     -- Original
inner join master.VW_Lgth_Wt_Age_All l        -- Retrieve only length records (hauls with no lengths not retained in output)
on l.sample_id = h.sample_id
and l.scientific_name = aspp.scientific_name
and l.length_cm is not null
where project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
order by haul_identifier, sex, length_cm
;
