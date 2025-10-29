# Seoul-Subway-Insight🚇
프로젝트 주제: 서울 지하철 공공데이터를 이용한 시각화 및 대시보드

프로젝트 기간: 25.10.27 ~ 25.10.30

문선유, 김민국, 김성렬, 김예원



## 📝 분석 배경 및 목적

서울시 지하철 이용객들의 정보를 통해 유동인구의 이동과 관련된 인사이트를 얻고자 함.
이용객의 시간대별 승하차 정보, 사건 사고 정보, 부동산 및 축제 관련 데이터를 조합해 이용객의 움직임, 생활환경에 미치는 영향, 인근 지역 활성 정도를 파악함.

### 프로젝트의 분석 주제
1. **시간대별 승하차 정보를 활용한 유동인구 분석**
    * 시간대별 승하차 정보를 활용해 지하철 이용이 활발히 일어난 시간대와 이용객수 등을 분석한다.

2. **시간대별 승하차 정보 및 그에 따른 지하철 사고 건수 분석**
    * 시간대별 승하차 정보를 활용해 이용객수와 사고 건수의 연관성을 분석한다.

3. **유동인구와 부동산 거래 비교 분석**
    * 지하철 이용객수가 많은 지역(유동인구가 많은 지역)과 인근 지역의 부동산 거래 가격 및 빈도 등을 분석한다.

4. **유동인구와 행사 건수의 관계 분석**
    * 지하철 이용객의 변화가 지역 행사와 어떠한 관련을 보이는지 분석한다.


## 📶 사용 데이터
<b>서울 열린데이터 광장

> [서울시 역사마스터 정보](https://data.seoul.go.kr/dataList/OA-21232/S/1/datasetView.do)
>
> [서울시 지하철 호선별 역별 승하차 인원 정보](https://data.seoul.go.kr/dataList/OA-12914/S/1/datasetView.do)
>
> [서울시 지하철 호선별 역별 시간대별 승하차 인원 정보](https://data.seoul.go.kr/dataList/OA-12252/S/1/datasetView.do)
>
> [서울시 문화행사 정보](https://data.seoul.go.kr/dataList/OA-15486/S/1/datasetView.do)

<b>국가교통 데이터 오픈마켓

> [역세권 공동주책 실거래 정보](https://www.bigdata-transportation.kr/frn/prdt/detail?prdtId=PRDTNUM_000000020052)



## 🔨 사용 기술 및 프레임워크

|Step|Tool|Detail|
|---|---|---|
| Data collection | CSV | 
| Data preprocessing | Python, Pandas | 지하철 역명을 비롯한 표기 일치화 |
| Data Lake | AWS S3 | Raw data 적재 |
| Data Warehouse | Snowflake | SQL을 활용한 테이블 생성 및 관리 |
| Dashboard (Visualization) | Preset | 대시보드 생성 및 그래프와 지도를 활용한 시각화 |

## 🌊 프로젝트 흐름도
<p align="center">
    <img src="./프로젝트흐름도.png">
</p>

## 📊 프로젝트 결과
// 각자 ppt로 만든 그래프 설명 페이지 첨부 예정 (또는 그냥 그래프 캡처. 만들어지는 모양 봐서)