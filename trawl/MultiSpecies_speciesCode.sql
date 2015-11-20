-- Multi-species selected by species code: Satisfactory Only
-- 9/1/2014
select *
from (
select
       aspp.scientific_name,
       aspp.species_code,
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
on aspp.species_code in(&sp)   -- Must contain the same species as listed in the Pivot In clause below (without the aliases)
left join master.VW_Catch_Wts_Nums_All c
on c.sample_id = h.sample_id
and c.species = aspp.species
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'    -- Can be used to limit the survey year range (or can be left out entirely).
)
PIVOT (
        Max(haul_wt_kg) AS haul_wt_kg,
        Max(avg_wt_kg) AS avg_wt_kg
        FOR scientific_name
        IN(&msp)
      )
order by haul_identifier;
