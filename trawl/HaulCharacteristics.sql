-- 9/1/2014
-- Haul Characteristics : Satisfactory Only
select h.project,
       h.project_cycle,
       h.vessel,
       h.haul_identifier,
       h.Capture_Date,
       h.best_lat_dd,
       h.best_lon_dd,
       h.best_position_type,
       h.best_depth_m,
       h.best_depth_type,
       h.DURATION_START2END_HR,
       h.area_swept_ha,
       h.Operation_Status
from master.VW_Haul_Chars_Sat h
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
order by h.haul_identifier
;
