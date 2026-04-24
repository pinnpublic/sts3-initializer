# STS3 Spring MVC 수업용 배치 파일

`sts.bat`는 STS3 Spring Legacy MVC 수업에서 프로젝트 초기화와 MyBatis 설정을 자동화하는 Windows 배치 파일입니다.

---

## 배치 파일 다운로드

[sts.bat 다운로드](https://github.com/pinnpublic/sts3-initializer/releases/latest/download/sts.bat)

---

## 실행 위치

`sts.bat`는 반드시 **워크스페이스 루트 폴더**에 둡니다.

```text
workspace
├─ sts.bat
├─ 프로젝트명
├─ Servers
└─ .metadata
````

`Servers` 폴더는 프로젝트 목록에서 자동 제외됩니다.

---

## 메뉴

```text
1. Spring MVC Project 초기화
2. MyBatis 설정
3. Spring MVC Project 초기화(MyBatis 설정 포함)
4. 워크스페이스 초기화
5. 사용법
6. 종료
```

---

## 기본 사용 순서

1. 새 워크스페이스 폴더를 만든다.
2. `sts.bat`를 워크스페이스 루트에 복사한다.
3. STS3를 한 번 실행한 뒤 종료한다.
4. `sts.bat` 실행 후 `[4. 워크스페이스 초기화]`를 선택한다.
5. STS3를 다시 실행한다.
6. `Spring MVC Project`를 생성한다.
7. 프로젝트에 맞게 1~3번 기능을 실행한다.
8. 실행 후 STS3에서 `Maven > Update Project`를 실행한다.

---

## 기능 설명

### 1. Spring MVC Project 초기화

Spring MVC Project 기본 설정을 수업용 템플릿으로 교체합니다.

주요 작업:

* `pom.xml` 다운로드 및 치환
* `web.xml` 다운로드
* `root-context.xml` 다운로드
* `servlet-context.xml` 다운로드 및 치환
* `logback.xml` 다운로드
* `log4jdbc.log4j2.properties` 다운로드
* 기존 `log4j.xml` 삭제
* 기존 `HomeController.java` 삭제
* 기존 `home.jsp` 삭제

자동 치환:

```text
$${project}  → 프로젝트명
$${group}    → 패키지명
$${artifact} → 아티팩트명
```

---

### 2. MyBatis 설정

1번 초기화가 끝난 프로젝트에 MyBatis 설정을 추가합니다.

주요 작업:

* `pom.xml`에 MyBatis/JDBC 의존성 추가
* `root-context.xml`에 MyBatis bean 설정 추가
* `mybatis-config.xml` 다운로드
* mapper XML 다운로드
* mapper 파일명을 `[아티팩트명].xml`로 저장
* mapper namespace 치환

자동 치환:

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

### 3. Spring MVC Project 초기화(MyBatis 설정 포함)

1번과 2번을 한 번에 실행합니다.

```text
Spring MVC Project 초기화
→ 성공 시 MyBatis 설정 실행
```

새 프로젝트에 기본 설정과 MyBatis 설정을 동시에 적용할 때 사용합니다.

---

### 4. 워크스페이스 초기화

STS3 워크스페이스에 Spring MVC 템플릿 정보를 적용합니다.

생성 위치:

```text
.metadata/.plugins/org.springsource.ide.eclipse.commons.content.core/https-content.xml
```

새 워크스페이스에서는 프로젝트 생성 전에 먼저 실행합니다.

---

## 중복 실행 방지

`sts.bat`는 marker 파일로 중복 실행을 막습니다.

### 워크스페이스 marker

```text
.sts-batch-workspace.done
```

있으면 `[4. 워크스페이스 초기화]` 재실행 불가.

### MVC 초기화 marker

```text
.sts-batch-mvc.done
```

있으면 `[1. Spring MVC Project 초기화]`, `[3. Spring MVC Project 초기화(MyBatis 설정 포함)]` 재실행 불가.

### MyBatis marker

```text
.sts-batch-mybatis.done
```

있으면 `[2. MyBatis 설정]` 재실행 불가.

또한 `[2. MyBatis 설정]`은 `.sts-batch-mvc.done`이 없는 프로젝트에서는 실행되지 않습니다.

marker 파일은 숨김 처리됩니다.

---

## 프로젝트 구조 전제

패키지와 아티팩트명은 다음 구조에서 자동 추출합니다.

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

---

## 재실행이 필요한 경우

숨김 파일 표시 후 marker 파일을 삭제하면 다시 실행할 수 있습니다.

프로젝트 초기화 재실행:

```text
프로젝트/.sts-batch-mvc.done
```

MyBatis 설정 재실행:

```text
프로젝트/.sts-batch-mybatis.done
```

워크스페이스 초기화 재실행:

```text
워크스페이스/.sts-batch-workspace.done
```

단, 재실행하면 기존 파일이 다시 덮어쓰기되거나 설정이 중복 삽입될 수 있으므로 주의합니다.

---

## 실행 후 필수 작업

1번, 2번, 3번 실행 후 STS3에서 반드시 실행합니다.

```text
프로젝트 우클릭
→ Maven
→ Update Project
```

---

2026.04.24
