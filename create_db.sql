# 데이터베이스 생성
CREATE DATABASE youtubepremium;

# 위에서 생성한 데이터베이스 사용
USE youtubepremium;

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

# video 테이블 생성
CREATE TABLE video (
    vd_ID INT PRIMARY KEY AUTO_INCREMENT,
    vd_category VARCHAR(50),
    vd_title VARCHAR(100) NOT NULL,
    vd_views INT DEFAULT 0,
    vd_upload_time DATETIME DEFAULT CURRENT_TIMESTAMP, 
    vd_likes INT DEFAULT 0
);

# channel 테이블 생성
CREATE TABLE channel (
    chl_ID INT PRIMARY KEY AUTO_INCREMENT,
    chl_subscribers INT DEFAULT 0,
    chl_video_count INT DEFAULT 0 
);

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

# upload 테이블 생성
CREATE TABLE upload (
    upload_ID INT PRIMARY KEY AUTO_INCREMENT,
    chl_ID INT NOT NULL,
    vd_ID INT NOT NULL,
    upload_volume INT,
    upload_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(chl_ID) REFERENCES channel(chl_ID),
    FOREIGN KEY(vd_ID) REFERENCES video(vd_ID)
);

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