## 메뉴얼

### SetUp

- 아래 코드로 public_name column 제거
  ```
  rails generate migration RemovePublicNameFromPeople public_name:string
  rails db:migrate
  ```

- 터미널에서 아래 명령어 입력하여 모델에 position 컬럼 추가(저자 순서 저장용)

  ```
  rails generate migration AddPositionToEventPeople position:integer
  rails db:migrate
  ```

- 회원가입 시 소속/국가 필수 필드 추가

  ```
  rails generate migration AddAffiliationAndCountryToPeople affiliation:string country:string
  rails db:migrate
  bin/setup
  ```

  일단 배포된 컨터이너에 접속해서 콘솔에 위 코드 입력하기

- 배포 환경에는 마이그레이션 파일들이 이미 있으니 아래 명령어만..

  ```
  sudo bin/rails db:migrate
  ```

### Fly.io에 런치

```
fly launch
```

- 머신 용량은 적어도 1GB
- 관리자 계정은 db:seed가 실행이 되어야 생성됨(db:setup에 포함됨)
- 스크립트에 안넣었으면 콘솔로 들어가서 직접 실행하기

```
fly ssh console --app frab-app
```

rails 콘솔:  RAILS_ENV=production bundle exec rails console

### 배포

- 개발 완료하면

```
fly deploy
```

참고로 `docker-cmd.sh`에 항상 마이그레이션 하도록 설정해둠

### 환경변수

- 리캡챠

  - RECAPTCHA_SECRET_KEY=~~~

  - RECAPTCHA_SITE_KEY=~~~

- 인증 (Google SMTP)

  ```
  fly secrets set \
    FRAB_HOST= \
    FRAB_PROTOCOL= \
    FROM_EMAIL= \
    SMTP_ADDRESS= \
    SMTP_PORT= \
    SMTP_DOMAIN= \
    SMTP_USER_NAME= \
    SMTP_PASSWORD= \
    SMTP_AUTHENTICATION= \
    SMTP_NOTLS=
  ```


- 인증 (Google Auth)

  - 


### 사용자 추가

fly 컨테이너 접속해서 레일 콘솔 실행
```
fly ssh console -a frab-app
cd /home/frab/app
bundle exec rails console
```

콘솔 내부에서 아래 코드 실행
```
User.create!(
  email: 'user2@uclab.re.kr',
  password: 'juyoung',
  password_confirmation: 'juyoung',
  role: 'submitter',
  confirmed_at: Time.current,
  person_attributes: {
    email: 'user2@uclab.re.kr',
    first_name: 'Juyoung',
    last_name: 'Kim',
    affiliation: 'UC Lab',
    country: 'South Korea'
  }
)
```
### 계정 정보 확인
```User.find_by(email: 'user1@uclab.re.kr').person.public_name```



### 계정 정보

- admin

```
admin@example.org
nj2APNPQ6zDLZ8KSSA_PjtOtZhqrDqK-MPMVuSzvTqc
```

- 일반계정

```
user1@uclab.re.kr
juyoung
```

```
user2@uclab.re.kr
juyoung
```

### 요구사항 (이다스 참고하기)
1. ~~이름(퍼블릭네임 빼기) 미들네임 설네임 등 넣기~~

2. ~~리스트 오브 컨퍼런스는 로그인하고 나서 보여주기~~

3. ~~리뷰어, 등등 권한 확인할 수 있는 페이지 만들기~~

4. ~~일반 계정도 컨퍼런스 만드는 기능 넣기 (만들고 운영자가 컨펌하는 느낌으로)~~

5. ~~보안 관련해서 캡챠 쓰기 (클라우드플레어)~~
  - 추후 보완하기

6. 웹사이트 메인화면 frab으로 뜨는 것 수정하기 => 뭐라도 다른걸로 바꾸기,도메인 살 수 있는거 고려해서 이름 바꾸기