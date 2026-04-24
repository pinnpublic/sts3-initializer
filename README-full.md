# STS3 Spring MVC 수업용 배치 파일

`sts.bat`는 STS3 기반 Spring Legacy MVC 수업에서 반복적으로 수행해야 하는 프로젝트 초기화 작업을 자동화하기 위한 Windows 배치 파일입니다.

워크스페이스 루트에서 실행하며, 다음 작업을 메뉴 방식으로 제공합니다.

- Spring MVC Project 초기화
- MyBatis 설정 추가
- Spring MVC Project 초기화 + MyBatis 설정 일괄 적용
- STS3 워크스페이스 초기화
- 사용법 안내
- 중복 실행 방지

---

## 배치 파일 다운로드

[sts.bat 다운로드](https://github.com/pinnpublic/sts3-initializer/releases/latest/download/sts.bat)

---

## 1. 실행 환경

이 배치 파일은 다음 환경을 전제로 합니다.

- Windows
- STS3
- Spring Legacy MVC Project
- Maven 기반 프로젝트
- 프로젝트 구조

```text
workspace
├─ sts.bat
├─ 프로젝트명
│  ├─ pom.xml
│  └─ src
│     └─ main
│        ├─ java
│        │  └─ 폴더명1
│        │     └─ 폴더명2
│        │        └─ 폴더명3
│        ├─ resources
│        └─ webapp
└─ .metadata
````

배치 파일은 다음 규칙으로 프로젝트 정보를 자동 인식합니다.

```text
현재 선택한 프로젝트 폴더명 = 프로젝트명

src/main/java/폴더명1/폴더명2/폴더명3

폴더명1.폴더명2 = 패키지명
폴더명3 = 아티팩트명
```

예를 들어 다음 구조라면:

```text
src/main/java/com/test/board
```

아래처럼 인식합니다.

```text
패키지명   = com.test
아티팩트명 = board
```

---

## 2. 설치 방법

1. 새 워크스페이스로 사용할 폴더를 생성합니다.
2. `sts.bat` 파일을 워크스페이스 루트에 복사합니다.
3. STS3를 한 번 실행한 뒤 종료합니다.
4. `sts.bat`를 실행합니다.
5. 메뉴에서 `[4. 워크스페이스 초기화]`를 선택합니다.
6. STS3를 다시 실행합니다.
7. `Spring MVC Project`를 생성합니다.
8. 프로젝트 성격에 따라 1~3번 기능을 선택합니다.

---

## 3. 메뉴 구성

배치 파일을 실행하면 다음 메뉴가 표시됩니다.

```text
1. Spring MVC Project 초기화
2. MyBatis 설정
3. Spring MVC Project 초기화(MyBatis 설정 포함)
4. 워크스페이스 초기화
5. 사용법
6. 종료
```

---

## 4. 기능 설명

### 4.1 Spring MVC Project 초기화

메뉴:

```text
1. Spring MVC Project 초기화
```

선택한 Spring MVC Project에 기본 수업용 템플릿을 적용합니다.

수행 작업:

1. 프로젝트명 확인
2. `src/main/java` 아래의 3단계 패키지 폴더 분석
3. 패키지명과 아티팩트명 추출
4. 필요한 폴더 생성
5. `pom.xml` 다운로드 및 덮어쓰기
6. `pom.xml` 내부 변수 치환
7. `web.xml` 다운로드 및 덮어쓰기
8. `root-context.xml` 다운로드 및 덮어쓰기
9. `servlet-context.xml` 다운로드 및 덮어쓰기
10. `servlet-context.xml` 내부 변수 치환
11. `logback.xml` 다운로드
12. `log4jdbc.log4j2.properties` 다운로드
13. 기존 `log4j.xml` 삭제
14. 기존 `HomeController.java` 삭제
15. 기존 `home.jsp` 삭제

다운로드 대상:

```text
https://paper.pe.kr/sts-template/mvc/pom.xml
https://paper.pe.kr/sts-template/mvc/web.xml
https://paper.pe.kr/sts-template/mvc/root-context.xml
https://paper.pe.kr/sts-template/mvc/servlet-context.xml
https://paper.pe.kr/sts-template/mvc/logback.xml
https://paper.pe.kr/sts-template/mvc/log4jdbc.log4j2.properties
```

치환 항목:

```text
$${project}  → 프로젝트명
$${group}    → 패키지명
$${artifact} → 아티팩트명
```

---

### 4.2 MyBatis 설정

메뉴:

```text
2. MyBatis 설정
```

이미 Spring MVC Project 초기화가 완료된 프로젝트에 MyBatis 관련 설정을 추가합니다.

수행 작업:

1. 프로젝트 패키지 구조 분석
2. `src/main/resources/config` 폴더 생성
3. `src/main/resources/mappers` 폴더 생성
4. `pom.xml`에 MyBatis 관련 dependency 추가
5. `root-context.xml`에 MyBatis 관련 bean 설정 추가
6. `mybatis-config.xml` 다운로드
7. `mapper.xml` 다운로드 후 `[아티팩트명].xml`로 저장
8. mapper XML 내부 namespace 치환

다운로드 대상:

```text
https://paper.pe.kr/sts-template/mvc/pom-mybatis.xml
https://paper.pe.kr/sts-template/mvc/root-context-mybatis.xml
https://paper.pe.kr/sts-template/mvc/mybatis-config.xml
https://paper.pe.kr/sts-template/mvc/mapper.xml
```

생성/수정 파일:

```text
pom.xml
src/main/webapp/WEB-INF/spring/root-context.xml
src/main/resources/config/mybatis-config.xml
src/main/resources/mappers/[아티팩트명].xml
```

mapper namespace 치환:

```text
$${mapper} → 아티팩트명
```

예:

```xml
<mapper namespace="$${mapper}">
```

실행 후:

```xml
<mapper namespace="board">
```

---

### 4.3 Spring MVC Project 초기화(MyBatis 설정 포함)

메뉴:

```text
3. Spring MVC Project 초기화(MyBatis 설정 포함)
```

1번 기능과 2번 기능을 순서대로 실행합니다.

실행 순서:

```text
Spring MVC Project 초기화
→ 성공 시 MyBatis 설정 실행
```

즉, 새로 생성한 Spring MVC Project에 기본 설정과 MyBatis 설정을 한 번에 적용할 때 사용합니다.

---

### 4.4 워크스페이스 초기화

메뉴:

```text
4. 워크스페이스 초기화
```

STS3 워크스페이스의 Spring template content 설정 파일을 생성합니다.

생성 폴더:

```text
.metadata/.plugins/org.springsource.ide.eclipse.commons.content.core
```

다운로드 파일:

```text
https://paper.pe.kr/sts-template/https-content.xml
```

저장 위치:

```text
.metadata/.plugins/org.springsource.ide.eclipse.commons.content.core/https-content.xml
```

이 기능은 새 워크스페이스에서 STS3를 최소 1회 실행한 뒤 사용하는 것을 전제로 합니다.

---

### 4.5 사용법

메뉴:

```text
5. 사용법
```

배치 파일의 기본 사용 순서를 화면에 출력합니다.

---

### 4.6 종료

메뉴:

```text
6. 종료
```

배치 파일을 종료합니다.

---

## 5. 중복 실행 방지

`sts.bat`는 marker 파일을 사용하여 중복 실행을 방지합니다.

### 5.1 워크스페이스 초기화 중복 방지

워크스페이스 초기화가 성공하면 다음 파일을 생성합니다.

```text
.sts-batch-workspace.done
```

파일 위치:

```text
workspace/.sts-batch-workspace.done
```

이 파일이 이미 있으면 `[4. 워크스페이스 초기화]`는 다시 실행되지 않습니다.

---

### 5.2 Spring MVC Project 초기화 중복 방지

Spring MVC Project 초기화가 성공하면 다음 파일을 생성합니다.

```text
.sts-batch-mvc.done
```

파일 위치:

```text
workspace/프로젝트명/.sts-batch-mvc.done
```

이 파일이 이미 있으면 `[1. Spring MVC Project 초기화]`와 `[3. Spring MVC Project 초기화(MyBatis 설정 포함)]`은 다시 실행되지 않습니다.

---

### 5.3 MyBatis 설정 중복 방지

MyBatis 설정이 성공하면 다음 파일을 생성합니다.

```text
.sts-batch-mybatis.done
```

파일 위치:

```text
workspace/프로젝트명/.sts-batch-mybatis.done
```

이 파일이 이미 있으면 `[2. MyBatis 설정]`은 다시 실행되지 않습니다.

또한 `.sts-batch-mvc.done`이 없는 프로젝트에는 `[2. MyBatis 설정]`을 적용할 수 없습니다.

즉, MyBatis 설정은 반드시 Spring MVC Project 초기화 이후에만 실행할 수 있습니다.

---

### 5.4 marker 파일 숨김 처리

생성되는 marker 파일은 자동으로 숨김 처리됩니다.

```bat
attrib +h "%MVC_MARKER%"
attrib +h "%MYBATIS_MARKER%"
attrib +h "%WORKSPACE_MARKER%"
```

탐색기에서 보이지 않을 수 있으며, 다시 강제로 실행해야 할 경우 숨김 파일 표시 후 해당 marker 파일을 삭제하면 됩니다.

---

## 6. 실행 규칙 요약

### 6.1 워크스페이스 초기화

```text
.sts-batch-workspace.done 있음 → 실행 금지
.sts-batch-workspace.done 없음 → 실행
성공 후 .sts-batch-workspace.done 생성
```

### 6.2 Spring MVC Project 초기화

```text
.sts-batch-mvc.done 있음 → 실행 금지
.sts-batch-mvc.done 없음 → 실행
성공 후 .sts-batch-mvc.done 생성
```

### 6.3 MyBatis 설정

```text
.sts-batch-mvc.done 없음 → 실행 금지
.sts-batch-mybatis.done 있음 → 실행 금지
조건 통과 시 실행
성공 후 .sts-batch-mybatis.done 생성
```

### 6.4 Spring MVC Project 초기화(MyBatis 설정 포함)

```text
1번 기능 실행
→ 성공하면 2번 기능 실행
→ 둘 다 성공하면 완료
```

이미 1번 또는 3번이 적용된 프로젝트는 다시 실행되지 않습니다.

---

## 7. 프로젝트 목록 필터링

워크스페이스 안의 폴더 목록을 보여줄 때 다음 폴더는 프로젝트 목록에서 제외됩니다.

```text
.metadata
Servers
```

따라서 STS3가 자동 생성하는 `Servers` 폴더는 프로젝트 선택 목록에 표시되지 않습니다.

---

## 8. 사용 순서 예시

### 8.1 새 워크스페이스 준비

```text
1. 새 폴더 생성
2. sts.bat 복사
3. STS3 실행 후 종료
4. sts.bat 실행
5. [4. 워크스페이스 초기화] 선택
6. STS3 재실행
```

---

### 8.2 새 Spring MVC Project 생성 후 기본 설정만 적용

```text
1. STS3에서 Spring MVC Project 생성
2. sts.bat 실행
3. [1. Spring MVC Project 초기화] 선택
4. 프로젝트 선택
5. Maven > Update Project 실행
```

---

### 8.3 기존 초기화 프로젝트에 MyBatis만 추가

```text
1. sts.bat 실행
2. [2. MyBatis 설정] 선택
3. 프로젝트 선택
4. Maven > Update Project 실행
```

단, 이 기능은 `[1. Spring MVC Project 초기화]`가 먼저 적용된 프로젝트에만 실행됩니다.

---

### 8.4 새 프로젝트에 기본 설정과 MyBatis를 한 번에 적용

```text
1. STS3에서 Spring MVC Project 생성
2. sts.bat 실행
3. [3. Spring MVC Project 초기화(MyBatis 설정 포함)] 선택
4. 프로젝트 선택
5. Maven > Update Project 실행
```

---

## 9. 주의 사항

### 9.1 반드시 워크스페이스 루트에서 실행

`sts.bat`는 워크스페이스 루트에 위치해야 합니다.

정상 예:

```text
workspace
├─ sts.bat
├─ 프로젝트A
├─ 프로젝트B
├─ Servers
└─ .metadata
```

잘못된 예:

```text
workspace
├─ 프로젝트A
│  └─ sts.bat
└─ .metadata
```

---

### 9.2 프로젝트 패키지 구조 필요

이 배치 파일은 다음 구조를 기준으로 패키지명과 아티팩트명을 자동 추출합니다.

```text
src/main/java/폴더명1/폴더명2/폴더명3
```

예:

```text
src/main/java/com/test/board
```

인식 결과:

```text
패키지명   = com.test
아티팩트명 = board
```

이 구조가 없으면 초기화 또는 MyBatis 설정이 실패합니다.

---

### 9.3 중복 실행 시 차단됨

한 번 적용된 기능은 marker 파일 때문에 다시 실행되지 않습니다.

재실행이 꼭 필요하다면 해당 프로젝트 또는 워크스페이스의 marker 파일을 삭제해야 합니다.

프로젝트 marker:

```text
.sts-batch-mvc.done
.sts-batch-mybatis.done
```

워크스페이스 marker:

```text
.sts-batch-workspace.done
```

---

### 9.4 Maven Update 필요

1번, 2번, 3번 기능 실행 후에는 STS3에서 다음 작업을 수행합니다.

```text
프로젝트 우클릭
→ Maven
→ Update Project
```

---

## 10. 파일 구조 예시

초기화 및 MyBatis 설정 후 주요 파일 구조는 다음과 같습니다.

```text
프로젝트명
├─ .sts-batch-mvc.done
├─ .sts-batch-mybatis.done
├─ pom.xml
└─ src
   └─ main
      ├─ java
      │  └─ com
      │     └─ test
      │        └─ board
      ├─ resources
      │  ├─ config
      │  │  └─ mybatis-config.xml
      │  ├─ mappers
      │  │  └─ board.xml
      │  ├─ logback.xml
      │  └─ log4jdbc.log4j2.properties
      └─ webapp
         └─ WEB-INF
            ├─ spring
            │  ├─ root-context.xml
            │  └─ appServlet
            │     └─ servlet-context.xml
            └─ web.xml
```

---

## 11. 복구 방법

### 11.1 워크스페이스 초기화를 다시 실행하고 싶은 경우

워크스페이스 루트의 다음 파일을 삭제합니다.

```text
.sts-batch-workspace.done
```

그 뒤 `[4. 워크스페이스 초기화]`를 다시 실행합니다.

---

### 11.2 프로젝트 초기화를 다시 실행하고 싶은 경우

프로젝트 루트의 다음 파일을 삭제합니다.

```text
.sts-batch-mvc.done
```

그 뒤 `[1. Spring MVC Project 초기화]`를 다시 실행합니다.

주의: 기존 파일들이 다시 덮어쓰기될 수 있습니다.

---

### 11.3 MyBatis 설정을 다시 실행하고 싶은 경우

프로젝트 루트의 다음 파일을 삭제합니다.

```text
.sts-batch-mybatis.done
```

그 뒤 `[2. MyBatis 설정]`을 다시 실행합니다.

주의: `pom.xml`, `root-context.xml`에 MyBatis 설정이 중복 삽입될 수 있으므로, 기존 삽입 내용을 먼저 확인해야 합니다.

---

## 12. 라이선스

수업 및 실습용으로 자유롭게 수정하여 사용할 수 있습니다.

---

2026.04.24 in
