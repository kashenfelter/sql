-- Single species select statement : Unsatisfactory
-- 9/1/2014
-- 1/6/2016  Script was found to be joining using common name only instead of scientific name.  Also, the weights were being set to zero based
--           on if the common name was present.  This was a serious error since many species table entries have no common name.  Updated 
--           the join to test on both the scientific and common names [nvl(nw_sciname, nw_commonname)] because a few of the species table 
--           entries have no scientific names. Updated the weights fields to set to zero when an aggregate_catch record for the species of interest
--           is absent.  BHH
select *
from (
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
       decode(c.agg_catch_id, null, 0, c.haul_wt_kg) as haul_wt_kg,  -- 1/6/2016  Changed from testing for presence of the common name to testing presence of the aggregate catch record
       decode(c.agg_catch_id, null, 0, c.avg_wt_kg) as avg_wt_kg  -- 1/6/2016  Changed from testing for presence of the common name to testing presence of the aggregate catch record
       ,h.Operation_Status,
       h.Removal_Reason,
       h.Survey_Lat_Chk,
       h.Survey_Depth_Chk
from master.VW_Assessment_Species aspp
inner join master.VW_Haul_Chars_UnSat h
on aspp.scientific_name = &sp
left join master.VW_Catch_Wts_Nums_All c
on c.sample_id = h.sample_id
and nvl(aspp.scientific_name, aspp.species) = nvl(c.scientific_name, c.species)  -- 1/6/2016  Changed to test both scientific and common name
)
where project_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
;
