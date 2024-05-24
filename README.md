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
    # user 테이블 생성
    CREATE TABLE user (
    usr_ID INT PRIMARY KEY AUTO_INCREMENT,
    usr_name VARCHAR(100) NOT NULL,
    usr_email VARCHAR(40) UNIQUE NOT NULL,
    usr_age INT,
    usr_password VARCHAR(100) NOT NULL,
    usr_created_date DATETIME NOT NULL,
    usr_gender ENUM('Male', 'Female', 'Other'),
    usr_nationality VARCHAR(50)
    );
   ```
   유튜브 회원들의 정보가 담긴 table 이다.
   회원의 이름, 나이, 이메일, 성별, 국가 , 비밀번호, 가입 날짜가 속성값이다.
   gender는 enum 을 통해 male, female, other 중 하나를 선택하도록 작성하였다.

   --------
   ```
   # video 테이블 생성
   CREATE TABLE video (
    vd_ID INT PRIMARY KEY AUTO_INCREMENT,
    vd_category VARCHAR(50),
    vd_title VARCHAR(100) NOT NULL,
    vd_views INT DEFAULT 0,
    vd_upload_time DATETIME DEFAULT CURRENT_TIMESTAMP, 
    vd_likes INT DEFAULT 0
    );
   ```
   유튜브에 회원이 업로드하는 영상(Video)에 관한 테이블이다.
   vd_views (조회수), vd_likes(좋아요 수) 는 기본값을 0으로 설정하였다.
   
   -----
   ```
   # channel 테이블 생성
   CREATE TABLE channel (
    chl_ID INT PRIMARY KEY AUTO_INCREMENT,
    chl_subscribers INT DEFAULT 0,
    chl_video_count INT DEFAULT 0 
    );

   ```
   유저가 동영상을 올리는 채널에 관한 테이블이다.
   chl_subscribers는  구독자수를 나타내는 속성, video_count는 채널에 올린 영상의 수를 나타내는 속성이며 둘다 기본값을 0으로 설정했다.

   -----
   ```
   # report 테이블 생성
   CREATE TABLE report (
    rprt_ID INT PRIMARY KEY AUTO_INCREMENT,
    usr_ID INT NOT NULL, 
    chl_ID INT NOT NULL,
    vd_ID INT NOT NULL,     
    rprt_type ENUM('Video', 'Channel') NOT NULL, 
    rprt_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    rprt_content TEXT,
    
    # 외래 키 제약 조건
    FOREIGN KEY (usr_ID) REFERENCES user(usr_ID),
    FOREIGN KEY (chl_ID) REFERENCES channel(chl_ID),
    FOREIGN KEY (vd_ID) REFERENCES video(vd_ID)
   );

   ```
   동영상 또는 채널을 신고하는 테이블이다.
   usr_ID 는 신고하는 유저의 정보이며, user테이블의 usr_ID를 참조한다.
   chl_ID 는 신고당하는 채널의 정보이며, channel 테이블의 chl_ID 를 참조한다.
   vd_ID 는 신고당하는 비디오의 정보이며, video 테이블의 vd_ID를 참조한다.

   -----
   ```
   
   # view 테이블 생성
   CREATE TABLE view (
       vw_ID INT PRIMARY KEY AUTO_INCREMENT, 
       usr_ID INT NOT NULL, 
       vd_ID INT NOT NULL, 
       vw_date DATETIME DEFAULT CURRENT_TIMESTAMP,
       FOREIGN KEY (usr_ID) REFERENCES user(usr_ID)
       ON DELETE CASCADE, 
       FOREIGN KEY (vd_ID) REFERENCES video(vd_ID) 
   	ON DELETE CASCADE
   );

   ```
   시청기록을 구현한 테이블이다.
   usr_ID 는 시청한 유저의 정보이고 user테이블의 usr_ID를 참조한다.
   vd_ID는 시청한 비디오의 정보이고 video 테이블의 vd_ID를 참조한다.
   vw_date는 시청한 시각을 나타내는 속성이다.


   -----
   ```
      # create 테이블 생성
   CREATE TABLE create_chl (
   	ct_ID INT PRIMARY KEY AUTO_INCREMENT,
   	chl_ID INT NOT NULL,
   	usr_ID INT NOT NULL,
   	create_date DATETIME DEFAULT CURRENT_TIMESTAMP,
   	FOREIGN KEY (usr_ID) REFERENCES user(usr_ID)
       ON DELETE CASCADE,
   	FOREIGN KEY (chl_ID) REFERENCES channel(chl_ID)
       ON DELETE CASCADE
   );
   ```
   채널 생성에 관한 테이블이다.
   chl_ID 는 생성한 채널의 정보이고, channel 테이블의 chl_ID 를 참조한다.
   usr_ID는 채널을 생성한 유저의 정보이고, user테이블의 usr_ID를 참조한다.
   
   -----
   ```
      # subscribe 테이블 생성
   CREATE TABLE subscribe (
       sub_ID INT PRIMARY KEY AUTO_INCREMENT, 
       usr_ID INT NOT NULL, 
       chl_ID INT NOT NULL, 
       sub_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
       FOREIGN KEY (usr_ID) REFERENCES user(usr_ID)
       ON DELETE CASCADE, 
       FOREIGN KEY (chl_ID) REFERENCES channel(chl_ID) 
       ON DELETE CASCADE
   );
   ```
   구독에 관한 테이블이다.
   usr_ID는 구독을 하는 유저의 정보이고, user테이블의 usr_ID를 참조한다.
   chl_ID는 구독 되는 채널에 대한 정보이고, channel 테이블의 chl_ID를 참조한다.
   
   -----
   ```
      # recommend 테이블 생성
   CREATE TABLE recommend (
       rcmnd_ID INT PRIMARY KEY AUTO_INCREMENT,
       usr_ID INT NOT NULL,
       vd_ID INT NOT NULL,
       rcmnd_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
       FOREIGN KEY (usr_ID) REFERENCES user(usr_ID)
       ON DELETE CASCADE, 
       FOREIGN KEY (vd_ID) REFERENCES video(vd_ID)
       ON DELETE CASCADE
   );
   ```
   영상 추천에 대한 테이블이다.
   usr_ID는 추천할 대상이 되는 유저에 관한 정보이고, user 테이블의 usr_ID를 참조한다.
   vd_ID 는 user에게 추천할 비디오에 관한 정보이고, video 테이블의 vd_ID를 참조한다.








   
   
