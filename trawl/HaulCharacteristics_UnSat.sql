-- 9/1/2014
-- Haul Characteristics : Unsat Hauls with Catch
select project,
       project_cycle,
       vessel,
       haul_identifier,
       Capture_Date,
       best_lat_dd,
       best_lon_dd,
       best_position_type,
       best_depth_m,
       best_depth_type,
       DURATION_START2END_HR,
       area_swept_ha,
       Operation_Status,
       temperature_at_gear_degc,
       gear_salinity_psu,
       gear_oxygen_ml_per_l,
       gear_light_umol_phot_per_m2sec
       Removal_Reason,
       Survey_Lat_Chk,
       Survey_Depth_Chk
from master.VW_Haul_Chars_UnSat
where project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
order by haul_identifier
;
