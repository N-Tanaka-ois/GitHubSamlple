@echo off
setlocal enabledelayedexpansion
REM --------------------------------------------------
SET LHAPLUS="C:\Program Files\Lhaplus\Lhaplus.exe"
SET TEMP_FOLDER="C:\TempFolder"

SET var1=Hello
SET var2=World!

pushd %~dp0
    if exist %TEMP_FOLDER% (
        echo  ERROR: Folder[%TEMP_FOLDER%] exist!
        exit /b
    )

    REM 一時フォルダ作成
    mkdir %TEMP_FOLDER%

    REM 国内機
    pushd "01.JP"
        dir /b
        echo -----

        REM 店頭機
        pushd "国内店頭機\オフラインインストーラ"
            dir /b
            echo -----

            REM 一般
            pushd "一般\Download"
                dir /b
                echo -----

                REM SPK_APP_AC
                pushd "SPK_APP_AC\2018090621275861"
                    if exist SPK_APP_AC_2030.zip (
                        %LHAPLUS% /o:%TEMP_FOLDER%\ SPK_APP_AC_2030.zip
                        move /Y %TEMP_FOLDER%\SPK_APP_AC_2030\AppFiles AppFiles
                        rd /s /q %TEMP_FOLDER%\SPK_APP_AC_2030
                        del SPK_APP_AC_2030.zip
                    )
                popd
            popd

            REM キタムラ
            pushd "キタムラ"
                dir /b
                echo -----
            popd

            REM コイデ
            pushd "コイデ"
                dir /b
                echo -----
            popd

        popd
    popd

    REM 海外機
    pushd 02.Global
        dir /b
        echo -----
    popd

    REM 一時フォルダ削除
    rd /s /q %TEMP_FOLDER%
popd

REM 01.JP\国内セルフ機\JPPSR000000001\x64\Download\SPK_APP_AC\2018090621275861
REM 01.JP\国内セルフ機\JPPSR000000001\x64\Download\SPK_APP_AC\2018090621275861\SPK_APP_AC_20230\AppFiles
REM C:\FujifilmApplication\i-Base\SoftUpdate\UpdateWork\SPK_APP_AC\2018090621275861\AppFiles\C_Drive\SmartPrintKiosk\Server\htdocs\clientapps\ac\js\inputImageApp.js

exit /b
REM --------------------------------------------------

REM --------------------------------------------------------------------------------
REM AppFilesフォルダからexecutableフォルダへ移動(海外機)
REM - ※Vup時にAppFiles側へコピーするbatファイルも合わせて作成
REM %1: SubSystemフォルダ名
REM %2: コピー元となるフォルダ("AppFile\C_Drive\"以降を設定)
REM %3: コピー先に作成するフォルダ名(※コピーbatのファイル名は"copy_%3.bat"となる)
REM --------------------------------------------------------------------------------
:moveAppFilesToExecutable_EN
    REM カレントフォルダ設定
    pushd %~dp0

    REM 共通処理コール(海外機のためOutput_globalフォルダを指定)
    call :moveAppFilesToExecutable_Common %1 %2 %3 Output_global

    REM 共通処理正常終了時
    if %errorlevel% == 0 (
       REM 作業用フォルダからexecutableフォルダにコピー
       xcopy TEMP_WORK\executable Output_global_AddFiles\Global_Counter\%1\executable  /E /V /I /Y
       xcopy TEMP_WORK\executable Output_global_AddFiles\Global_Self\%1\executable  /E /V /I /Y
       xcopy TEMP_WORK\executable Output_global_AddFiles\Global_SemiSelf\%1\executable  /E /V /I /Y

       REM 作業用フォルダの削除
       rd /s /q TEMP_WORK
    )

    REM カレントフォルダ復帰
    popd

    exit /b %errorlevel%
REM --------------------------------------------------------------------------------
