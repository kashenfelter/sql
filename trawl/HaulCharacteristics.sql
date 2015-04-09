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
       h.Operation_Status,
       h.temperature_at_gear_degc,
       h.gear_salinity_psu,
       h.gear_oxygen_ml_per_l,
       h.gear_light_umol_phot_per_m2sec
from master.VW_Haul_Chars_Sat h
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
order by h.haul_identifier
;
