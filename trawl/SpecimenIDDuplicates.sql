-- 11/9/2015
-- Standard Survey Specimens : All Instances of Specimen Id duplications (same id assigned to two or more 
--                             specimens of the same type.)
select sample_number
       , sampling_plan_name
       , specimen_type 
       , scientific_name
       , common_name
       , survey
       , survey_cycle
       , vessel
       , op_start_time
       , trawl_id
from master.vw_spp_standard_specimen_dups
where survey_cycle between 'Cycle &beginyr' and 'Cycle &endyr'
and scientific_name in(&sp)
-- Options:  Stomach, Tissue, Ovary, Left_Pectoral_Fin, Pectoral_Fin
and specimen_type = &specimentype
order by survey_cycle, sample_number
;