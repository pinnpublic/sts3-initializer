@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ==================================================
REM 스프링 수업 배치
REM 실행 위치: 워크스페이스 루트
REM ==================================================

:MAIN_MENU
cls
echo ==================================================
echo 스프링 수업 배치
echo ==================================================
echo.
echo 1. Spring MVC Project 초기화
echo 2. MyBatis 설정
echo 3. Spring MVC Project 초기화(MyBatis 설정 포함)
echo 4. 워크스페이스 초기화
echo 5. 사용법
echo 6. 종료
echo.
set /p MENU_SELECT=메뉴를 선택하세요: 

if "%MENU_SELECT%"=="1" goto SELECT_PROJECT
if "%MENU_SELECT%"=="2" goto SELECT_PROJECT_MYBATIS
if "%MENU_SELECT%"=="3" goto SELECT_PROJECT_MVC_MYBATIS
if "%MENU_SELECT%"=="4" goto INIT_WORKSPACE
if "%MENU_SELECT%"=="5" goto SHOW_USAGE

goto END_PROGRAM
REM ==================================================
REM 1. Spring MVC Project 초기화
REM    현재 워크스페이스 아래 프로젝트 폴더 선택
REM ==================================================
:SELECT_PROJECT
cls
echo ==================================================
echo Spring MVC Project 초기화
echo ==================================================
echo.
echo 현재 작업 폴더:
echo %CD%
echo.
echo 프로젝트 폴더 목록
echo --------------------------------------------------

set "WORKSPACE_DIR=%CD%"
set "PROJECT_COUNT=0"

for /d %%D in ("%WORKSPACE_DIR%\*") do (
    if /I not "%%~nxD"==".metadata" if /I not "%%~nxD"=="Servers" (
        set /a PROJECT_COUNT+=1
        set "PROJECT_!PROJECT_COUNT!=%%~fD"
        set "PROJECT_NAME_!PROJECT_COUNT!=%%~nxD"
        echo !PROJECT_COUNT!. %%~nxD
    )
)

echo --------------------------------------------------
echo.

if "%PROJECT_COUNT%"=="0" (
    echo [ERROR] 현재 작업 폴더 아래에 프로젝트 폴더가 없습니다.
    echo.
    pause
    goto MAIN_MENU
)

set /p PROJECT_SELECT=초기화할 프로젝트 번호를 선택하세요: 

if not defined PROJECT_%PROJECT_SELECT% (
    echo.
    echo [ERROR] 잘못된 선택입니다.
    echo.
    pause
    goto MAIN_MENU
)

set "PROJECT_DIR=!PROJECT_%PROJECT_SELECT%!"
set "PROJECT_NAME=!PROJECT_NAME_%PROJECT_SELECT%!"

echo.
echo 선택한 프로젝트:
echo     PROJECT_DIR  = %PROJECT_DIR%
echo     PROJECT_NAME = %PROJECT_NAME%
echo.

call :INIT_MVC_PROJECT

echo.
pause
goto MAIN_MENU


REM ==================================================
REM 2. MyBatis 설정
REM    현재 워크스페이스 아래 프로젝트 폴더 선택
REM ==================================================
:SELECT_PROJECT_MYBATIS
cls
echo ==================================================
echo MyBatis 설정
echo ==================================================
echo.
echo 현재 작업 폴더:
echo %CD%
echo.
echo 프로젝트 폴더 목록
echo --------------------------------------------------

set "WORKSPACE_DIR=%CD%"
set "PROJECT_COUNT=0"

for /d %%D in ("%WORKSPACE_DIR%\*") do (
    if /I not "%%~nxD"==".metadata" if /I not "%%~nxD"=="Servers" (
        set /a PROJECT_COUNT+=1
        set "PROJECT_!PROJECT_COUNT!=%%~fD"
        set "PROJECT_NAME_!PROJECT_COUNT!=%%~nxD"
        echo !PROJECT_COUNT!. %%~nxD
    )
)

echo --------------------------------------------------
echo.

if "%PROJECT_COUNT%"=="0" (
    echo [ERROR] 현재 작업 폴더 아래에 프로젝트 폴더가 없습니다.
    echo.
    pause
    goto MAIN_MENU
)

set /p PROJECT_SELECT=MyBatis 설정을 적용할 프로젝트 번호를 선택하세요: 

if not defined PROJECT_%PROJECT_SELECT% (
    echo.
    echo [ERROR] 잘못된 선택입니다.
    echo.
    pause
    goto MAIN_MENU
)

set "PROJECT_DIR=!PROJECT_%PROJECT_SELECT%!"
set "PROJECT_NAME=!PROJECT_NAME_%PROJECT_SELECT%!"

echo.
echo 선택한 프로젝트:
echo     PROJECT_DIR  = %PROJECT_DIR%
echo     PROJECT_NAME = %PROJECT_NAME%
echo.

call :INIT_MYBATIS

echo.
pause
goto MAIN_MENU

REM ==================================================
REM 3. Spring MVC Project 초기화(MyBatis 설정 포함)
REM    현재 워크스페이스 아래 프로젝트 폴더 선택
REM ==================================================
:SELECT_PROJECT_MVC_MYBATIS
cls
echo ==================================================
echo Spring MVC Project 초기화(MyBatis 설정 포함)
echo ==================================================
echo.
echo 현재 작업 폴더:
echo %CD%
echo.
echo 프로젝트 폴더 목록
echo --------------------------------------------------

set "WORKSPACE_DIR=%CD%"
set "PROJECT_COUNT=0"

for /d %%D in ("%WORKSPACE_DIR%\*") do (
    if /I not "%%~nxD"==".metadata" if /I not "%%~nxD"=="Servers" (
        set /a PROJECT_COUNT+=1
        set "PROJECT_!PROJECT_COUNT!=%%~fD"
        set "PROJECT_NAME_!PROJECT_COUNT!=%%~nxD"
        echo !PROJECT_COUNT!. %%~nxD
    )
)

echo --------------------------------------------------
echo.

if "%PROJECT_COUNT%"=="0" (
    echo [ERROR] 현재 작업 폴더 아래에 프로젝트 폴더가 없습니다.
    echo.
    pause
    goto MAIN_MENU
)

set /p PROJECT_SELECT=초기화 및 MyBatis 설정을 적용할 프로젝트 번호를 선택하세요: 

if not defined PROJECT_%PROJECT_SELECT% (
    echo.
    echo [ERROR] 잘못된 선택입니다.
    echo.
    pause
    goto MAIN_MENU
)

set "PROJECT_DIR=!PROJECT_%PROJECT_SELECT%!"
set "PROJECT_NAME=!PROJECT_NAME_%PROJECT_SELECT%!"

echo.
echo 선택한 프로젝트:
echo     PROJECT_DIR  = %PROJECT_DIR%
echo     PROJECT_NAME = %PROJECT_NAME%
echo.

echo ==================================================
echo 1단계: Spring MVC Project 초기화 실행
echo ==================================================
echo.

call :INIT_MVC_PROJECT

if errorlevel 1 (
    echo.
    echo [ERROR] Spring MVC Project 초기화가 실패하여 MyBatis 설정을 실행하지 않습니다.
    echo.
    pause
    goto MAIN_MENU
)

echo.
echo ==================================================
echo 2단계: MyBatis 설정 실행
echo ==================================================
echo.

call :INIT_MYBATIS

if errorlevel 1 (
    echo.
    echo [ERROR] MyBatis 설정 실패
    echo.
    pause
    goto MAIN_MENU
)

echo.
echo ==================================================
echo Spring MVC Project 초기화(MyBatis 설정 포함) 완료
echo ==================================================
echo PROJECT_NAME  = %PROJECT_NAME%
echo PACKAGE_NAME  = %PACKAGE_NAME%
echo ARTIFACT_NAME = %ARTIFACT_NAME%
echo ==================================================
echo.

pause
goto MAIN_MENU


echo.
pause
goto MAIN_MENU


REM ==================================================
REM Spring MVC Project 초기화 본 작업
REM ==================================================
:INIT_MVC_PROJECT

echo ==================================================
echo Spring MVC Project 초기화 시작
echo ==================================================
echo.

REM --------------------------------------------------
REM Spring MVC Project 초기화 중복 실행 방지
REM --------------------------------------------------
set "MVC_MARKER=%PROJECT_DIR%\.sts-batch-mvc.done"
set "MYBATIS_MARKER=%PROJECT_DIR%\.sts-batch-mybatis.done"

if exist "%MVC_MARKER%" (
    echo [ERROR] 이미 Spring MVC Project 초기화가 적용된 프로젝트입니다.
    echo         다시 실행할 수 없습니다.
    echo         MARKER = %MVC_MARKER%
    echo.
    exit /b 1
)

REM --------------------------------------------------
REM 1. 프로젝트 정보 확인
REM --------------------------------------------------
echo [1] 프로젝트 정보 확인
echo     PROJECT_DIR  = %PROJECT_DIR%
echo     PROJECT_NAME = %PROJECT_NAME%
echo.

REM --------------------------------------------------
REM 2. src/main/java 아래 3단계 폴더 탐색
REM --------------------------------------------------
set "JAVA_ROOT=%PROJECT_DIR%\src\main\java"

echo [2] Java 소스 폴더 확인
echo     JAVA_ROOT = %JAVA_ROOT%

if not exist "%JAVA_ROOT%" (
    echo [ERROR] src\main\java 폴더가 없습니다.
    goto INIT_MVC_FAIL
)

set "FOLDER1="
set "FOLDER2="
set "FOLDER3="

for /d %%A in ("%JAVA_ROOT%\*") do (
    if not defined FOLDER1 (
        set "FOLDER1=%%~nxA"

        for /d %%B in ("%%A\*") do (
            if not defined FOLDER2 (
                set "FOLDER2=%%~nxB"

                for /d %%C in ("%%B\*") do (
                    if not defined FOLDER3 (
                        set "FOLDER3=%%~nxC"
                    )
                )
            )
        )
    )
)

if not defined FOLDER1 (
    echo [ERROR] src\main\java 아래 첫 번째 폴더가 없습니다.
    goto INIT_MVC_FAIL
)

if not defined FOLDER2 (
    echo [ERROR] src\main\java\%FOLDER1% 아래 두 번째 폴더가 없습니다.
    goto INIT_MVC_FAIL
)

if not defined FOLDER3 (
    echo [ERROR] src\main\java\%FOLDER1%\%FOLDER2% 아래 세 번째 폴더가 없습니다.
    goto INIT_MVC_FAIL
)

set "PACKAGE_NAME=%FOLDER1%.%FOLDER2%"
set "ARTIFACT_NAME=%FOLDER3%"

echo     FOLDER1       = %FOLDER1%
echo     FOLDER2       = %FOLDER2%
echo     FOLDER3       = %FOLDER3%
echo     PACKAGE_NAME  = %PACKAGE_NAME%
echo     ARTIFACT_NAME = %ARTIFACT_NAME%
echo.

REM --------------------------------------------------
REM 3. 필요한 폴더 생성
REM --------------------------------------------------
echo [3] 필요한 폴더 생성

if not exist "%PROJECT_DIR%\src\main\webapp\WEB-INF" (
    mkdir "%PROJECT_DIR%\src\main\webapp\WEB-INF"
)

if not exist "%PROJECT_DIR%\src\main\webapp\WEB-INF\spring" (
    mkdir "%PROJECT_DIR%\src\main\webapp\WEB-INF\spring"
)

if not exist "%PROJECT_DIR%\src\main\webapp\WEB-INF\spring\appServlet" (
    mkdir "%PROJECT_DIR%\src\main\webapp\WEB-INF\spring\appServlet"
)

if not exist "%PROJECT_DIR%\src\main\resources" (
    mkdir "%PROJECT_DIR%\src\main\resources"
)

echo     폴더 생성 완료
echo.

REM --------------------------------------------------
REM 4. pom.xml 다운로드 후 덮어쓰기
REM --------------------------------------------------
echo [4] pom.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/pom.xml" "%PROJECT_DIR%\pom.xml"
if errorlevel 1 goto INIT_MVC_FAIL

echo.

REM --------------------------------------------------
REM 5. pom.xml 내용 수정
REM --------------------------------------------------
echo [5] pom.xml 내용 수정

set "POM_FILE=%PROJECT_DIR%\pom.xml"

if not exist "%POM_FILE%" (
    echo [ERROR] pom.xml 파일이 없습니다.
    goto INIT_MVC_FAIL
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = '%POM_FILE%';" ^
    "$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8;" ^
    "$text = $text.Replace('$${project}', '%PROJECT_NAME%');" ^
    "$text = $text.Replace('$${group}', '%PACKAGE_NAME%');" ^
    "$text = $text.Replace('$${artifact}', '%ARTIFACT_NAME%');" ^
    "Set-Content -LiteralPath $path -Value $text -Encoding UTF8"

if errorlevel 1 (
    echo [ERROR] pom.xml 치환 실패
    goto INIT_MVC_FAIL
)

echo     $${project}  -^> %PROJECT_NAME%
echo     $${group}    -^> %PACKAGE_NAME%
echo     $${artifact} -^> %ARTIFACT_NAME%
echo     pom.xml 수정 완료
echo.

REM --------------------------------------------------
REM 6. web.xml 다운로드 후 덮어쓰기
REM --------------------------------------------------
echo [6] web.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/web.xml" "%PROJECT_DIR%\src\main\webapp\WEB-INF\web.xml"
if errorlevel 1 goto INIT_MVC_FAIL

echo.

REM --------------------------------------------------
REM 7. root-context.xml 다운로드 후 덮어쓰기
REM --------------------------------------------------
echo [7] root-context.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/root-context.xml" "%PROJECT_DIR%\src\main\webapp\WEB-INF\spring\root-context.xml"
if errorlevel 1 goto INIT_MVC_FAIL

echo.

REM --------------------------------------------------
REM 8. servlet-context.xml 다운로드 후 덮어쓰기
REM --------------------------------------------------
echo [8] servlet-context.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/servlet-context.xml" "%PROJECT_DIR%\src\main\webapp\WEB-INF\spring\appServlet\servlet-context.xml"
if errorlevel 1 goto INIT_MVC_FAIL

echo.

REM --------------------------------------------------
REM 9. servlet-context.xml 내용 수정
REM --------------------------------------------------
echo [9] servlet-context.xml 내용 수정

set "SERVLET_CONTEXT_FILE=%PROJECT_DIR%\src\main\webapp\WEB-INF\spring\appServlet\servlet-context.xml"

if not exist "%SERVLET_CONTEXT_FILE%" (
    echo [ERROR] servlet-context.xml 파일이 없습니다.
    goto INIT_MVC_FAIL
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = '%SERVLET_CONTEXT_FILE%';" ^
    "$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8;" ^
    "$text = $text.Replace('$${group}', '%PACKAGE_NAME%');" ^
    "$text = $text.Replace('$${artifact}', '%ARTIFACT_NAME%');" ^
    "Set-Content -LiteralPath $path -Value $text -Encoding UTF8"

if errorlevel 1 (
    echo [ERROR] servlet-context.xml 치환 실패
    goto INIT_MVC_FAIL
)

echo     $${group}    -^> %PACKAGE_NAME%
echo     $${artifact} -^> %ARTIFACT_NAME%
echo     servlet-context.xml 수정 완료
echo.

REM --------------------------------------------------
REM 10. logback.xml 다운로드
REM --------------------------------------------------
echo [10] logback.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/logback.xml" "%PROJECT_DIR%\src\main\resources\logback.xml"
if errorlevel 1 goto INIT_MVC_FAIL

echo.

REM --------------------------------------------------
REM 11. log4jdbc.log4j2.properties 다운로드
REM --------------------------------------------------
echo [11] log4jdbc.log4j2.properties 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/log4jdbc.log4j2.properties" "%PROJECT_DIR%\src\main\resources\log4jdbc.log4j2.properties"
if errorlevel 1 goto INIT_MVC_FAIL

echo.

REM --------------------------------------------------
REM 12. 기존 log4j.xml 삭제
REM --------------------------------------------------
echo [12] 기존 log4j.xml 삭제

set "OLD_LOG4J=%PROJECT_DIR%\src\main\resources\log4j.xml"

if exist "%OLD_LOG4J%" (
    del /f /q "%OLD_LOG4J%"
    if errorlevel 1 (
        echo [ERROR] log4j.xml 삭제 실패
        goto INIT_MVC_FAIL
    )
    echo     삭제 완료: %OLD_LOG4J%
) else (
    echo     삭제 대상 없음: %OLD_LOG4J%
)

echo.

REM --------------------------------------------------
REM 13. 기존 HomeController.java 삭제
REM --------------------------------------------------
echo [13] 기존 HomeController.java 삭제

set "OLD_HOME_CONTROLLER=%PROJECT_DIR%\src\main\java\%FOLDER1%\%FOLDER2%\%FOLDER3%\HomeController.java"

if exist "%OLD_HOME_CONTROLLER%" (
    del /f /q "%OLD_HOME_CONTROLLER%"
    if errorlevel 1 (
        echo [ERROR] HomeController.java 삭제 실패
        goto INIT_MVC_FAIL
    )
    echo     삭제 완료: %OLD_HOME_CONTROLLER%
) else (
    echo     삭제 대상 없음: %OLD_HOME_CONTROLLER%
)

echo.

REM --------------------------------------------------
REM 14. 기존 home.jsp 삭제
REM --------------------------------------------------
echo [14] 기존 home.jsp 삭제

set "OLD_HOME_JSP=%PROJECT_DIR%\src\main\webapp\WEB-INF\views\home.jsp"

if exist "%OLD_HOME_JSP%" (
    del /f /q "%OLD_HOME_JSP%"
    if errorlevel 1 (
        echo [ERROR] home.jsp 삭제 실패
        goto INIT_MVC_FAIL
    )
    echo     삭제 완료: %OLD_HOME_JSP%
) else (
    echo     삭제 대상 없음: %OLD_HOME_JSP%
)

echo.

REM --------------------------------------------------
REM 완료
REM --------------------------------------------------
echo ==================================================
echo Spring MVC Project 초기화 완료
echo ==================================================
echo PROJECT_NAME  = %PROJECT_NAME%
echo PACKAGE_NAME  = %PACKAGE_NAME%
echo ARTIFACT_NAME = %ARTIFACT_NAME%
echo ==================================================
echo.

echo Spring MVC Project 초기화 완료 > "%MVC_MARKER%"
attrib +h "%MVC_MARKER%" >nul 2>&1

exit /b 0


:INIT_MVC_FAIL
echo.
echo ==================================================
echo Spring MVC Project 초기화 실패
echo ==================================================
echo 오류 내용을 확인하세요.
echo.
exit /b 1

REM ==================================================
REM MyBatis 설정 본 작업
REM ==================================================
:INIT_MYBATIS

echo ==================================================
echo MyBatis 설정 시작
echo ==================================================
echo.

REM --------------------------------------------------
REM MyBatis 설정 실행 조건 확인
REM --------------------------------------------------
set "MVC_MARKER=%PROJECT_DIR%\.sts-batch-mvc.done"
set "MYBATIS_MARKER=%PROJECT_DIR%\.sts-batch-mybatis.done"

if not exist "%MVC_MARKER%" (
    echo [ERROR] Spring MVC Project 초기화가 먼저 실행되지 않았습니다.
    echo         먼저 1번을 실행하거나, 처음부터 3번을 실행하세요.
    echo         MARKER 없음 = %MVC_MARKER%
    echo.
    exit /b 1
)

if exist "%MYBATIS_MARKER%" (
    echo [ERROR] 이미 MyBatis 설정이 적용된 프로젝트입니다.
    echo         다시 실행할 수 없습니다.
    echo         MARKER = %MYBATIS_MARKER%
    echo.
    exit /b 1
)

REM --------------------------------------------------
REM 1. src/main/java 아래 3단계 폴더 탐색
REM --------------------------------------------------
set "JAVA_ROOT=%PROJECT_DIR%\src\main\java"

echo [1] Java 소스 폴더 확인
echo     JAVA_ROOT = %JAVA_ROOT%

if not exist "%JAVA_ROOT%" (
    echo [ERROR] src\main\java 폴더가 없습니다.
    goto INIT_MYBATIS_FAIL
)

set "FOLDER1="
set "FOLDER2="
set "FOLDER3="

for /d %%A in ("%JAVA_ROOT%\*") do (
    if not defined FOLDER1 (
        set "FOLDER1=%%~nxA"

        for /d %%B in ("%%A\*") do (
            if not defined FOLDER2 (
                set "FOLDER2=%%~nxB"

                for /d %%C in ("%%B\*") do (
                    if not defined FOLDER3 (
                        set "FOLDER3=%%~nxC"
                    )
                )
            )
        )
    )
)

if not defined FOLDER1 (
    echo [ERROR] src\main\java 아래 첫 번째 폴더가 없습니다.
    goto INIT_MYBATIS_FAIL
)

if not defined FOLDER2 (
    echo [ERROR] src\main\java\%FOLDER1% 아래 두 번째 폴더가 없습니다.
    goto INIT_MYBATIS_FAIL
)

if not defined FOLDER3 (
    echo [ERROR] src\main\java\%FOLDER1%\%FOLDER2% 아래 세 번째 폴더가 없습니다.
    goto INIT_MYBATIS_FAIL
)

set "PACKAGE_NAME=%FOLDER1%.%FOLDER2%"
set "ARTIFACT_NAME=%FOLDER3%"

echo     FOLDER1       = %FOLDER1%
echo     FOLDER2       = %FOLDER2%
echo     FOLDER3       = %FOLDER3%
echo     PACKAGE_NAME  = %PACKAGE_NAME%
echo     ARTIFACT_NAME = %ARTIFACT_NAME%
echo.

REM --------------------------------------------------
REM 2. 필요한 폴더 생성
REM --------------------------------------------------
echo [2] 필요한 폴더 생성

if not exist "%PROJECT_DIR%\src\main\resources\config" (
    mkdir "%PROJECT_DIR%\src\main\resources\config"
    if errorlevel 1 (
        echo [ERROR] config 폴더 생성 실패
        goto INIT_MYBATIS_FAIL
    )
)

if not exist "%PROJECT_DIR%\src\main\resources\mappers" (
    mkdir "%PROJECT_DIR%\src\main\resources\mappers"
    if errorlevel 1 (
        echo [ERROR] mappers 폴더 생성 실패
        goto INIT_MYBATIS_FAIL
    )
)

echo     생성 확인: %PROJECT_DIR%\src\main\resources\config
echo     생성 확인: %PROJECT_DIR%\src\main\resources\mappers
echo.


REM --------------------------------------------------
REM 3. pom.xml MyBatis 의존성 추가
REM --------------------------------------------------
echo [3] pom.xml MyBatis 의존성 추가

set "POM_FILE=%PROJECT_DIR%\pom.xml"
set "POM_MYBATIS_FILE=%TEMP%\pom-mybatis-%RANDOM%.xml"

if not exist "%POM_FILE%" (
    echo [ERROR] pom.xml 파일이 없습니다.
    echo         먼저 Spring MVC Project 초기화를 실행하세요.
    goto INIT_MYBATIS_FAIL
)

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/pom-mybatis.xml" "%POM_MYBATIS_FILE%"
if errorlevel 1 goto INIT_MYBATIS_FAIL

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = $env:POM_FILE;" ^
    "$insertPath = $env:POM_MYBATIS_FILE;" ^
    "$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8;" ^
    "$insert = Get-Content -LiteralPath $insertPath -Raw -Encoding UTF8;" ^
    "$marker = [char]60 + '/dependencies' + [char]62;" ^
    "if (-not $text.Contains($marker)) { Write-Host 'ERROR: dependencies 닫는 태그를 찾을 수 없습니다.'; exit 1; }" ^
    "$text = $text.Replace($marker, $insert.TrimEnd() + [Environment]::NewLine + $marker);" ^
    "Set-Content -LiteralPath $path -Value $text -Encoding UTF8"

if errorlevel 1 (
    echo [ERROR] pom.xml MyBatis 의존성 추가 실패
    if exist "%POM_MYBATIS_FILE%" del /f /q "%POM_MYBATIS_FILE%"
    goto INIT_MYBATIS_FAIL
)

if exist "%POM_MYBATIS_FILE%" del /f /q "%POM_MYBATIS_FILE%"

echo     pom.xml MyBatis 의존성 추가 완료
echo     수정 파일: %POM_FILE%
echo.

REM --------------------------------------------------
REM 4. root-context.xml 안에 MyBatis 설정 추가
REM --------------------------------------------------
echo [4] root-context.xml MyBatis 설정 추가

set "ROOT_CONTEXT_FILE=%PROJECT_DIR%\src\main\webapp\WEB-INF\spring\root-context.xml"
set "ROOT_CONTEXT_MYBATIS_FILE=%TEMP%\root-context-mybatis-%RANDOM%.xml"

if not exist "%ROOT_CONTEXT_FILE%" (
    echo [ERROR] root-context.xml 파일이 없습니다.
    echo         먼저 Spring MVC Project 초기화를 실행하세요.
    goto INIT_MYBATIS_FAIL
)

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/root-context-mybatis.xml" "%ROOT_CONTEXT_MYBATIS_FILE%"
if errorlevel 1 goto INIT_MYBATIS_FAIL

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = $env:ROOT_CONTEXT_FILE;" ^
    "$insertPath = $env:ROOT_CONTEXT_MYBATIS_FILE;" ^
    "$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8;" ^
    "$insert = Get-Content -LiteralPath $insertPath -Raw -Encoding UTF8;" ^
    "$marker = [char]60 + '/beans' + [char]62;" ^
    "if (-not $text.Contains($marker)) { Write-Host 'ERROR: beans 닫는 태그를 찾을 수 없습니다.'; exit 1; }" ^
    "$text = $text.Replace($marker, $insert.TrimEnd() + [Environment]::NewLine + $marker);" ^
    "Set-Content -LiteralPath $path -Value $text -Encoding UTF8"

if errorlevel 1 (
    echo [ERROR] root-context.xml MyBatis 설정 추가 실패
    if exist "%ROOT_CONTEXT_MYBATIS_FILE%" del /f /q "%ROOT_CONTEXT_MYBATIS_FILE%"
    goto INIT_MYBATIS_FAIL
)

if exist "%ROOT_CONTEXT_MYBATIS_FILE%" del /f /q "%ROOT_CONTEXT_MYBATIS_FILE%"

echo     MyBatis bean 설정 추가 완료
echo     수정 파일: %ROOT_CONTEXT_FILE%
echo.


REM --------------------------------------------------
REM 5. mybatis-config.xml 다운로드
REM --------------------------------------------------
echo [5] mybatis-config.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/mybatis-config.xml" "%PROJECT_DIR%\src\main\resources\config\mybatis-config.xml"
if errorlevel 1 goto INIT_MYBATIS_FAIL

echo.

REM --------------------------------------------------
REM 6. mapper.xml 다운로드 후 아티팩트명.xml로 저장
REM --------------------------------------------------
echo [6] mapper.xml 다운로드 후 %ARTIFACT_NAME%.xml로 저장

set "MAPPER_FILE=%PROJECT_DIR%\src\main\resources\mappers\%ARTIFACT_NAME%.xml"

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/mvc/mapper.xml" "%MAPPER_FILE%"
if errorlevel 1 goto INIT_MYBATIS_FAIL

echo     mapper.xml 다운로드 완료
echo     저장 파일: %MAPPER_FILE%
echo.

REM --------------------------------------------------
REM 7. mapper namespace 수정
REM --------------------------------------------------
echo [7] mapper namespace 수정

if not exist "%MAPPER_FILE%" (
    echo [ERROR] mapper 파일이 없습니다.
    goto INIT_MYBATIS_FAIL
)

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$path = $env:MAPPER_FILE;" ^
    "$artifact = $env:ARTIFACT_NAME;" ^
    "$text = Get-Content -LiteralPath $path -Raw -Encoding UTF8;" ^
    "$text = $text.Replace('$${mapper}', $artifact);" ^
    "Set-Content -LiteralPath $path -Value $text -Encoding UTF8"

if errorlevel 1 (
    echo [ERROR] mapper namespace 수정 실패
    goto INIT_MYBATIS_FAIL
)

echo     namespace="$${mapper}" -^> namespace="%ARTIFACT_NAME%"
echo     mapper namespace 수정 완료
echo.


REM --------------------------------------------------
REM 완료
REM --------------------------------------------------
echo ==================================================
echo MyBatis 설정 완료
echo ==================================================
echo PROJECT_NAME  = %PROJECT_NAME%
echo PACKAGE_NAME  = %PACKAGE_NAME%
echo ARTIFACT_NAME = %ARTIFACT_NAME%
echo ==================================================
echo 수정 파일:
echo     %ROOT_CONTEXT_FILE%
echo 생성 파일:
echo     %PROJECT_DIR%\src\main\resources\config\mybatis-config.xml
echo     %PROJECT_DIR%\src\main\resources\mappers\%ARTIFACT_NAME%.xml
echo ==================================================
echo.

echo MyBatis 설정 완료 > "%MYBATIS_MARKER%"
attrib +h "%MYBATIS_MARKER%" >nul 2>&1

exit /b 0


:INIT_MYBATIS_FAIL
echo.
echo ==================================================
echo MyBatis 설정 실패
echo ==================================================
echo 오류 내용을 확인하세요.
echo.
exit /b 1

REM ==================================================
REM 2. 워크스페이스 초기화
REM ==================================================
:INIT_WORKSPACE
cls
echo ==================================================
echo 워크스페이스 초기화
echo ==================================================
echo.
echo 현재 작업 폴더:
echo %CD%
echo.

set "WORKSPACE_DIR=%CD%"

REM 사용자가 요청한 경로 그대로 사용
set "CONTENT_CORE_DIR=%WORKSPACE_DIR%\.metadata\.plugins\org.springsource.ide.eclipse.commons.content.core"
set "CONTENT_XML=%CONTENT_CORE_DIR%\https-content.xml"
set "WORKSPACE_MARKER=%WORKSPACE_DIR%\.sts-batch-workspace.done"

if exist "%WORKSPACE_MARKER%" (
    echo [ERROR] 이미 워크스페이스 초기화가 적용된 워크스페이스입니다.
    echo         다시 실행할 수 없습니다.
    echo         MARKER = %WORKSPACE_MARKER%
    echo.
    pause
    goto MAIN_MENU
)
echo [1] STS Content Core 폴더 생성
echo     TARGET_DIR = %CONTENT_CORE_DIR%

if not exist "%CONTENT_CORE_DIR%" (
    mkdir "%CONTENT_CORE_DIR%"
    if errorlevel 1 (
        echo [ERROR] 폴더 생성 실패
        echo.
        pause
        goto MAIN_MENU
    )
)

echo     폴더 생성 완료
echo.

echo [2] https-content.xml 다운로드

call :DOWNLOAD_FILE "https://paper.pe.kr/sts-template/https-content.xml" "%CONTENT_XML%"
if errorlevel 1 (
    echo.
    echo [ERROR] 워크스페이스 초기화 실패
    echo.
    pause
    goto MAIN_MENU
)

echo.
echo ==================================================
echo 워크스페이스 초기화 완료
echo ==================================================
echo 생성 파일:
echo %CONTENT_XML%
echo ==================================================
echo.

echo 워크스페이스 초기화 완료 > "%WORKSPACE_MARKER%"
attrib +h "%WORKSPACE_MARKER%" >nul 2>&1

pause
goto MAIN_MENU


REM ==================================================
REM 공통 다운로드 함수
REM ==================================================
:DOWNLOAD_FILE
set "URL=%~1"
set "DEST=%~2"

echo     다운로드:
echo       URL  = %URL%
echo       DEST = %DEST%

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$url = '%URL%';" ^
    "$dest = '%DEST%';" ^
    "try {" ^
    "  Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing;" ^
    "  exit 0;" ^
    "} catch {" ^
    "  Write-Host '[ERROR] 다운로드 실패:' $_.Exception.Message;" ^
    "  exit 1;" ^
    "}"

if errorlevel 1 (
    echo     [FAIL] 다운로드 실패
    exit /b 1
)

echo     [OK] 다운로드 완료
exit /b 0


REM ==================================================
REM 5. 사용법
REM ==================================================
:SHOW_USAGE
cls
echo ==================================================
echo 사용법
echo ==================================================
echo.
echo 1. 새 워크스페이스로 사용할 폴더를 생성한다.
echo 2. 'sts.bat'를 1의 위치로 이동한다.(아직 실행은 안함)
echo 3. STS3를 실행 후 종료한다.(최소 1회 실행)
echo 4. 'sts.bat'를 실행한다. ^> [4. 워크스페이스 초기화]를 선택한다.
echo 5. STS3를 다시 실행 후 'Spring MVC Project'를 생성한다.
echo 6. 프로젝트의 성격에 따라 1~3번 기능을 선택한다.
echo     - 1번: 프로젝트 기본 설정
echo     - 2번: 1번을 실행 후 추후 MyBatis 설정 추가(1번 선행 후)
echo     - 3번: 1번과 2번을 동시에 설정
echo     - 1~3번 선택 후 Maven > Update Project 실행
echo.
echo ==================================================
echo.
pause
goto MAIN_MENU


REM ==================================================
REM 종료
REM ==================================================
:END_PROGRAM
echo.
echo 프로그램을 종료합니다.
echo.
pause
exit /b 0