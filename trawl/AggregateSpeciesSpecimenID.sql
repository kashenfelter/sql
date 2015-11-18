-- 11/9/2015
-- Specimen numbers: Standard Survey Collections for those associated by haul and species id only: Satisfactory Only
select spp_spc.sample_number,
       spp_spc.sampling_plan_name,
       spp_spc.specimen_type, 
       spp_spc.nw_sciname, 
       spp_spc.nw_commonname,
       h.project,
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
from master.vw_species_standard_specimen spp_spc
inner join master.VW_Assessment_Species aspp
on spp_spc.nw_sciname = aspp.scientific_name
inner join master.VW_Haul_Chars_Sat h
on h.sample_id = spp_spc.sample_id
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
and aspp.scientific_name in(&sp)
order by spp_spc.sample_number
;


