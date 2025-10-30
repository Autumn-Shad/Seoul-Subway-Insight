show databases;
use autumn_gs_seoulmetro;
show tables;

-- 날짜 합쳐서 하나로 바꿔주기
select * from raw_data.house_price;

create or replace table autumn_gs_seoulmetro.analytics.house_price_date AS (
    select h.HOUSE_TYPE, TO_DATE(h.CNTRCT_YM||h.CNTCT_DE, 'YYYYMMDD') AS DATE, h.TRNS_CLSF, h.TRAMT, h.ASSRNC_AMT, h.MTHT_AMT, h.NRB_SWST_NM, h.NRB_SWST_DIST, m."노선명"
    FROM raw_data.house_price h
    left join raw_data.metro_daily_traffic m on AUTUMN_GS_SEOULMETRO.ANALYTICS.HOUSE_PRICE_DATEh.nrb_swst_nm = m."역명"
);

select * from analytics.house_price_date;

create or replace table autumn_gs_seoulmetro.analytics.house_floating AS (
    select h.house_type, h.DATE, h.TRNS_CLSF, h.TRAMT, h.ASSRNC_AMT, h.MTHT_AMT, h.NRB_SWST_NM, h.NRB_SWST_DIST, h."노선명", t."일별승차총승객수", t."일별하차총승객수"
    from analytics.house_price_date h
    left join analytics.traffic_by_station t on h.NRB_SWST_NM = t."역명" and h.date = to_date(t."사용일자", 'YYYYMMDD')
);

select * from analytics.house_floating;
select * from analytics.traffic_by_station;


-- 평균 매매가가 가장 높은 노선
select "노선명", avg(tramt), avg(assrnc_amt)
from analytics.house_floating
group by 1
order by 2 desc
limit 5;

select "노선명", avg(case
    when MTHT_AMT > 0 and ASSRNC_AMT > 0 then MTHT_AMT+ASSRNC_AMT
    when MTHT_AMT > 0 and ASSRNC_AMT = 0 then MTHT_AMT
    else 0 end) as avg_mth
from analytics.house_floating
group by 1
order by 2 desc
limit 5;
