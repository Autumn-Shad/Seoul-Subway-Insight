CREATE TABLE autumn_gs_seoulmetro.analytics.floating_population AS
WITH calculated AS(
    SELECT
        "지하철역",
        "사용월",
        "시간",
        "위도",
        "경도",
        SUM(CASE
            WHEN direction = '승차' THEN a."인원"
            WHEN direction = '하차' THEN -a."인원"
            ELSE 0 END) AS "유동인구"
    FROM autumn_gs_seoulmetro.analytics.users_by_time a
    LEFT JOIN (
        SELECT  "역사명", AVG("위도") AS "위도", AVG("경도") AS "경도"
        FROM raw_data.metro_station_info
        GROUP BY 1
    ) b
    WHERE a."지하철역" = b."역사명"
    GROUP BY 1, 2, 3, 4, 5
    ORDER BY 1, 2),
stats AS (
    SELECT
        MIN("유동인구") AS min_flow,
        MAX("유동인구") AS max_flow
    FROM calculated
)
SELECT
    a."지하철역",
    a."사용월",
    a."시간",
    a."위도",
    a."경도",
    a."유동인구",
    (a."유동인구" - s.min_flow) / (s.max_flow - s.min_flow) AS scaled_flow
FROM calculated a
    CROSS JOIN stats s
ORDER BY 1,2;