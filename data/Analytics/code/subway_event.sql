USE DATABASE AUTUMN_GS_SEOULMETRO;
USE SCHEMA RAW_DATA;

CREATE OR REPLACE TABLE AUTUMN_GS_SEOULMETRO.ANALYTICS.STATION_EVENT_DENSITY AS (
-- 1. 역별 행사 수 계산 
WITH EVENT_NEAR_STATION AS (
    SELECT
        S."역사명" AS STATION_NAME,
        COUNT(E."공연/행사명") AS EVENT_COUNT
    FROM METRO_STATION_INFO S
    JOIN SEOUL_EVENT E
      ON ST_DISTANCE(
            ST_POINT(S."경도", S."위도"),
            ST_POINT(E."경도(Y좌표)", E."위도(X좌표)")
         ) <= 1000  -- 미터 단위
    GROUP BY S."역사명"
),

-- 2. 역별 유동인구 집계 
TRAFFIC_BY_STATION AS (
    SELECT
        "역명",
        ARRAY_AGG(DISTINCT "노선명") AS "노선명_목록", -- 노선들을 배열로 묶음
        SUM("승차총승객수") AS "승차총승객수",
        SUM("하차총승객수") AS "하차총승객수"
    FROM METRO_DAILY_TRAFFIC
    GROUP BY "역명"
),

-- 3. 역별 평균 좌표 계산 (신규 CTE)
STATION_INFO_AVG AS (
    SELECT
        "역사명",
        AVG("위도") AS "위도",   -- 위도 좌표들의 평균
        AVG("경도") AS "경도"   -- 경도 다른 좌표들의 평균
    FROM METRO_STATION_INFO
    GROUP BY "역사명"
)

-- 4. 최종 데이터 결합
SELECT
    T."노선명_목록",
    T."역명",
    S."위도",
    S."경도",
    COALESCE(ENS.EVENT_COUNT, 0) AS "행사건수", -- 이벤트 없는 역은 0으로 표시
    T."승차총승객수",
    T."하차총승객수"
FROM TRAFFIC_BY_STATION T  -- 기준 테이블 (교통)
LEFT JOIN STATION_INFO_AVG S
  ON T."역명" = S."역사명"
LEFT JOIN EVENT_NEAR_STATION ENS
  ON T."역명" = ENS.STATION_NAME
  );



