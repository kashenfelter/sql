-- Single species select statement : Satisfactory Only
-- 9/1/2014
select aspp.scientific_name,
       aspp.species,    -- Changed this from a repeat of aspp.scientific_name; not sure how that crept in 7/29/2014
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
       decode(c.species, null, 0, c.haul_wt_kg) as haul_wt_kg,
       decode(c.species, null, 0, c.avg_wt_kg) as avg_wt_kg,
       h.Operation_Status
from master.VW_Assessment_Species aspp
inner join master.VW_Haul_Chars_Sat h
on aspp.scientific_name = &sp
left join master.VW_Catch_Wts_Nums_All c
on c.sample_id = h.sample_id
and c.species = aspp.species
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
;

