with tb_1 as (  -- Table of all transfers with have column 'first_date_after_1year'. Using that date we will find the closest market value of player after 1 year of transfer 
select 
  player_id
  , transfer_date  
  , league_transfer  
  , country_transfer 
  , mv
  , min(date) as first_date_after_1year
from
  (select 
    t.player_id 
    , t.transfer_date 
    , pv.date
    , t.market_value_in_eur  as mv
    , concat('from_', c_from.domestic_competition_id, '_to_', c_to.domestic_competition_id) as league_transfer
    , concat('from_', cmp_from.country_name, '_to_', cmp_to.country_name) as country_transfer
   from 
     transfers t
     , player_valuations pv
     , clubs c_from
     , clubs c_to
     , competitions cmp_from
     , competitions cmp_to
     , players p
   where t.player_id = pv.player_id 
     and (pv.date - t.transfer_date) >= 365 
     and c_from.club_id = t.from_club_id 
     and c_to.club_id = t.to_club_id
     and c_from.domestic_competition_id = cmp_from.competition_id 
     and c_to.domestic_competition_id = cmp_to.competition_id
     and extract(year from t.transfer_date) between 2019 and 2024 -- We analyse only transfers from the last 5 years
     and p.player_id = t.player_id
     and (t.transfer_date - p.date_of_birth) < (27*365.25) -- we are interested only in transfers of young players
   order by t.player_id, t.transfer_date)
group  by 1, 2, 3, 4, 5
)

, tb_2 as ( -- Table of market value differences of players after 1 year of transfer 
select tb_1.league_transfer
  , pv.market_value_in_eur - tb_1.mv as mv_diff_after_1year
  , tb_1.country_transfer
from tb_1
  , player_valuations pv
where tb_1.player_id = pv.player_id
  and tb_1.first_date_after_1year = pv.date 
  and 1.0*(tb_1.first_date_after_1year - tb_1.transfer_date)/365 < 1.3 -- The date when we check market value after 1 year cannot be more then 1.3 year after transfer date
)

select tb_2.league_transfer -- Table of from_league_to_league transfers with the biggest average market value difference after 1 year of transfer 
  , tb_2.country_transfer
  , round(avg(tb_2.mv_diff_after_1year)) as avg_mv_diff_after_1year
  , count(*) as count_players
from tb_2
where tb_2.mv_diff_after_1year is not null
group by 1, 2
having count(*) >=7 -- The number of transfers cannot be less then 7
order by 3 desc
