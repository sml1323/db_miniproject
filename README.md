# db_miniproject
database modeling practice

## 프로젝트 소개
database 모델링을 공부하기 위해 간단하게 기획한 프로젝트로써 youtube의 주요 기능들을 추상화하여 database를 모델링 하였다.

## 프로젝트 진행 프로세스
기존에 존재하는 앱&웹 서비스를 하나 선택하거나 서비스를 가상으로 기획 : db 모델링 경험이 없어, 새로운 서비스를 기획하는것 보다는 Youtube, Netflix 
등의 db를 잘 구축해둔 서비스들의 모델을 설계하기로 계획.

데이터 모델링 3단계인 개념적 데이터 모델링 -> 논리적 데이터 모델링 -> 물리적 데이터모델링 순서로 작성

ERD, Relation 모델, 물리적 sql 코드작성 3가지 결과물을 내는것이 목표이다.


## 데이터 모델링

1. 개념적 데이터 모델링
   - 현실 세계로부터 entity를 추출하고 개체들 간의 관계를 정의하여 ERD를 만드는 과정 (추상화)
     ![image](https://github.com/sml1323/db_miniproject/assets/124768198/e6cc4a53-8f8e-4b11-b4ff-47cde836144e)

2. 논리적 데이터 모델링
   - ERD를 바탕으로 데이터베이스에 저장할 수 있는 논리적인 구조를 Relation 모델로 표현하는 과정
     ![image](https://github.com/sml1323/db_miniproject/assets/124768198/26589c05-7272-4be8-9e51-1666fa88c59f)

3. 물리적 데이터 모델링
   - Relation모델을 DBMS의 종류에 따라 실제 물리저장장치에 저장할 수 있도록 물리적 구조로 구현하는 과정
   - SQL ( MYSQL ) 을 통해서 구현
  
     
   ```
    # 데이터베이스 생성
    CREATE DATABASE youtubepremium;

    # 위에서 생성한 데이터베이스 사용
    USE youtubepremium;
   ```
   
