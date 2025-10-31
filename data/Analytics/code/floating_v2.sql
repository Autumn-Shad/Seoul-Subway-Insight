CREATE OR REPLACE TABLE autumn_gs_seoulmetro.analytics.floating_v2 AS
SELECT *
FROM autumn_gs_seoulmetro.analytics.users_by_time a
LEFT JOIN (
    SELECT  "역사명", AVG("위도") AS "위도", AVG("경도") AS "경도"
    FROM raw_data.metro_station_info
    GROUP BY 1
    ) b WHERE a."지하철역" = b."역사명"