-- Species code inventory
select * from Master.VW_Assessment_Species
--where organism_type = 'Fish'   -- or Invertebrate
--where fmp_yn = 'FMP'
order by species_code
;