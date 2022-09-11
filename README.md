# Wanted Pre Onboarding iOS  
> 프리온보딩 iOS 코스  

<img width="300" alt="1" src="https://user-images.githubusercontent.com/63276842/189526558-220cf35c-5242-4fe2-b7cb-4dd0b02df735.png"> <img width="300" alt="2" src="https://user-images.githubusercontent.com/63276842/189526562-ace6ea21-5487-4f36-ae4e-85c367893145.png"> <img width="300" alt="3" src="https://user-images.githubusercontent.com/63276842/189526565-460d9f1e-9e00-4f75-b1cb-61577f2fffdb.png">

* [Weather API - OpenWeatherMap](https://openweathermap.org/api) 의 데이터를 사용한 날씨 정보 iOS APP 입니다.  
* 앱의 요구사항은 [원티드 프리온보딩 코스 사전과제](https://yagomacademy.notion.site/4eb46f9eb3a442efb9d0856b72f15b74) 에 안내되어 있습니다.  
***

### A. 개발 환경  
* OS: iOS 15.5  
* Language: Swift  
* IDE: XCode 13.4.1  
***

### B. 프로젝트 소개  
### 첫번째 화면  
<img width="300" alt="1" src="https://user-images.githubusercontent.com/63276842/189526558-220cf35c-5242-4fe2-b7cb-4dd0b02df735.png">

* [Weather API - OpenWeatherMap](https://openweathermap.org/api) 에서 아래 도시들의 `날씨 정보`를 보여줍니다.  
  * 공주, 광주(전라남도), 구미, 군산, 대구
  * 대전, 목포, 부산, 서산, 서울  
  * 속초, 수원, 순천, 울산, 익산  
  * 전주, 제주시, 천안, 청주, 춘천  
* 날씨 아이콘의 경우 API에서 제공하는 아이콘을 활용합니다.  
* 아래와 같은 `날씨 정보`를 포함하고 있습니다.  
  * 도시이름, 날씨 아이콘  
  * 현재기온, 현재습도  
* 첫 번째 화면의 각 도시 정보를 선택하면 두 번째 화면으로 이동합니다.  
***

### 두번째 화면  
<img width="300" alt="2" src="https://user-images.githubusercontent.com/63276842/189526562-ace6ea21-5487-4f36-ae4e-85c367893145.png">

* 첫 번째 화면에서 선택한 도시의 `현재 날씨 상세 정보`를 표현합니다.  
* 아래와 같은 `현재 날씨 상세 정보`를 포함하고 있습니다.  
  * 도시이름, 날씨 아이콘  
  * 현재기온, 체감기온, 최저기온, 최고기온  
  * 헌재습도  
  * 기압, 풍속  
  * 날씨설명  
***

### C. 적용된 기술 소개  
* 프로젝트에 `Model-View-Controller` 패턴을 적용했습니다.  
* UIImageView 에서 URL 을 통해 이미지를 load 할 수 있는 Extension 을 적용했습니다.  
* `WeatherService` 에서 `URLSession` 을 통해 `Weather API` 와 통신합니다.  
* `ImageCacheManager` 를 통해 날씨 아이콘 이미지를 불러올 때 캐시를 활용합니다.  
  * 캐시된 정보가 있다면 캐시된 이미지를 활용합니다.  
  * 캐시된 정보가 없다면 API 로부터 이미지를 받아옵니다.  
* `WeatherService` 와 `ImageCacheManager` 에 `Singleton` 패턴을 적용했습니다.  
* 서버와 통신 중에는 `데이터를 불러오는 중입니다.` 라는 `placeholder`를 사용합니다.  
