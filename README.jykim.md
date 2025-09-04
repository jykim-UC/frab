## 메뉴얼

### SetUp

- 터미널에서 아래 명령어 입력하여 모델에 position 컬럼 추가(저자 순서 저장용)

  - ```rails generate migration AddPositionToEventPeople position:integer```

  - ```rails db:migrate```

  - ```bin/setup```

### Fly.io에 런치

```fly launch```

- 머신 용량은 적어도 1GB
- 관리자 계정은 db:seed가 실행이 되어야 생성됨(db:setup에 포함됨)
- 스크립트에 안넣었으면 콘솔로 들어가서 직접 실행하기

```fly ssh console --app frab-app```

rails 콘솔:  RAILS_ENV=production bundle exec rails console

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
    public_name: 'user2'
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
1. 웹사이트 메인화면 rab으로 뜨는 것 수정하기 => 뭐라도 다른걸로 바꾸기,도메인 살 수 있는거 고려해서 이름 바꾸기

2. 리스트 오브 컨퍼런스는 로그인하고 나서 보여주기

3. 보안 관련해서 캡챠 쓰기 (클라우드플레어)

4. 이름(퍼블릭네임 빼기) 미들네임 설네임 등 넣기

5. 일반 계정도 컨퍼런스 만드는 기능 넣기 (만들고 운영자가 컨펌하는 느낌으로)

6. 리뷰어, 등등 권한 확인할 수 있는 페이지 만들기