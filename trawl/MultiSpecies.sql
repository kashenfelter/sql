-- Multi-species : Satisfactory Only
-- 9/1/2014
select *
from (
select
       aspp.scientific_name,
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
on aspp.scientific_name in(&sp)   -- Must contain the same species as listed in the Pivot In clause below (without the aliases)
left join master.VW_Catch_Wts_Nums_All c
on c.sample_id = h.sample_id
and c.species = aspp.species
where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'    -- Can be used to limit the survey year range (or can be left out entirely).
)
PIVOT (
        Max(haul_wt_kg) AS haul_wt_kg,
        Max(avg_wt_kg) AS avg_wt_kg
        FOR scientific_name
        IN(&msp)    --'Sebastes pinniger' AS canary_rockfish, 'Coryphaenoides acrolepis' AS Pacific_grenadier, 'Anoplopoma fimbria' AS sablefish)   -- The alias (phrase after the AS) can not have any spaces; it serves as the column name.
      )
order by haul_identifier;










-- Haul/Catch
 -- Multi-species
 --  7/30/2014
-- select *
-- from (
-- select
--        aspp.scientific_name,
--        h.project,
--        h.project_cycle,
--        h.vessel,
--        h.haul_identifier,
--        h.Capture_Date,
--        h.best_lat_dd,
--        h.best_lon_dd,
--        h.best_position_type,
--        h.best_depth_m,
--        h.best_depth_type,
--        h.DURATION_START2END_HR,
--        h.area_swept_ha,
--        decode(c.species, null, 0, c.haul_wt_kg) as haul_wt_kg,
--        decode(c.species, null, 0, c.avg_wt_kg) as avg_wt_kg
-- from master.VW_Assessment_Species aspp
-- inner join master.VW_Haul_Chars_Sat h
-- on aspp.scientific_name in(&sp)   -- Must contain the same species as listed in the Pivot In clause below (without the aliases)
-- left join master.VW_Catch_Wts_Nums_Sat c
-- on c.haul_identifier = h.haul_identifier
-- and c.species = aspp.species
-- where h.project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'    -- Can be used to limit the survey year range (or can be left out entirely).
-- )
-- PIVOT (
--         Max(haul_wt_kg) AS haul_wt_kg,
--         Max(avg_wt_kg) AS avg_wt_kg
--         FOR scientific_name
--         IN(&msp)   -- 'Sebastes pinniger' AS canary_rockfish, 'Coryphaenoides acrolepis' AS Pacific_grenadier, 'Anoplopoma fimbria' AS sablefish. The alias (phrase after the AS) can not have any spaces; it serves as the column name.
--       )
-- order by haul_identifier;

