@echo off
setlocal enabledelayedexpansion
REM --------------------------------------------------
SET LHAPLUS="C:\Program Files\Lhaplus\Lhaplus.exe"
SET TEMP_FOLDER="C:\TempFolder"

SET VERSION_JP_COUNTER=2030
SET VERSION_JP_SELF=20230
SET VERSION_EN_COUNTER=20430
SET VERSION_EN_SELF=20630
SET VERSION_EN_SEMISELF=20630


pushd %~dp0
    if exist %TEMP_FOLDER% (
      echo  ERROR: Folder[%TEMP_FOLDER%] exist!
      exit /b
    )

    REM 一時フォルダ作成
    mkdir %TEMP_FOLDER%

    REM 国内機
    pushd "01.JP"
        REM 店頭機
        pushd "国内店頭機\オフラインインストーラ"
            REM 一般
            pushd "一般\Download"
                REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
                if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

                REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
                for /f %%i in ('dir /b /ad') do (
                    SET zipFolderName=%%i
                    call :getAppFilesFolder %%i !zipFolderName:JPITR000000001=JPI0!_%VERSION_JP_COUNTER%
                )

                REM ファイルリストを出力
                dir /B /S /A-D > "%~dp0\01-01_FileList(JPITR000000001).txt"
            popd

            REM キタムラ
            pushd "キタムラ\Download"
                REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
                if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

                REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
                for /f %%i in ('dir /b /ad') do (
                    SET zipFolderName=%%i
                    call :getAppFilesFolder %%i !zipFolderName:JPITR001000001=JPI1!_%VERSION_JP_COUNTER%
                )

                REM ファイルリストを出力
                dir /B /S /A-D > %~dp0\01-02_FileList(JPITR001000001).txt
            popd

            REM コイデ
            pushd "コイデ\Download"
                REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
                if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

                REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
                for /f %%i in ('dir /b /ad') do (
                    SET zipFolderName=%%i
                    call :getAppFilesFolder %%i !zipFolderName:JPITR015000001=JPI15!_%VERSION_JP_COUNTER%
                )

                REM ファイルリストを出力
                dir /B /S /A-D > %~dp0\01-03_FileList(JPITR015000001).txt
            popd
        popd

        REM 国内セルフ機
        pushd "国内セルフ機\JPPSR000000001\x64\Download"
            REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:JPPSR000000001=JPPSR!_%VERSION_JP_SELF%
            )

            REM ファイルリストを出力
            dir /B /S /A-D > %~dp0\02_FileList(JPPSR000000001).txt
        popd
    popd


    REM 海外機
    pushd 02.Global
        REM 海外店頭機
        pushd "Global_Counter\Download"
            REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:USITR100000001=USI0!_%VERSION_EN_COUNTER%
            )

            REM ファイルリストを出力
            dir /B /S /A-D > %~dp0\03_FileList(USITR100000001).txt
        popd

        REM 海外セルフ機
        pushd "Global_Self\Download"
            REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:USPSR100000001=USPSR!_%VERSION_EN_SELF%
            )

            REM ファイルリストを出力
            dir /B /S /A-D > %~dp0\04_FileList(USPSR100000001).txt
        popd

        REM 海外セミセルフ機
        pushd "Global_Self\Download"
            REM SPK_SYSTEMフォルダにはAppFilesフォルダがないため削除
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM 各サブシステムフォルダの解凍とAppFilesフォルダの抽出
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:USSSR100000001=USSSR!_%VERSION_EN_SEMISELF%
            )

            REM ファイルリストを出力
            dir /B /S /A-D > %~dp0\05_FileList(USSSR100000001).txt
        popd
    popd

    REM 一時フォルダ削除
    rd /s /q %TEMP_FOLDER%
popd

exit /b
REM --------------------------------------------------

REM --------------------------------------------------------------------------------
REM Zipを一時フォルダに解凍し、AppFilesを取得
REM %1: SubSystemフォルダ名
REM %2: Zipフォルダ名(Version番号付)
REM --------------------------------------------------------------------------------
:getAppFilesFolder
    REM フォルダがない場合、処理を抜ける
    if not exist %1 (
        echo NotExist %1
        exit /b 0
    )

    REM カレントフォルダ設定
    pushd %1
        REM カレントフォルダ内のフォルダ名取得
        for /f %%i in ('dir /b /ad') do (
            pushd %%i
                REM Zipファイルが有る場合
                if exist %2.zip (
                    REM Zipファイルを一時フォルダに解凍
                    %LHAPLUS% /o:%TEMP_FOLDER%\ %2.zip
                    REM 解凍したフォルダからAppFilesフォルダのみ移動
                    move /Y %TEMP_FOLDER%\%2\AppFiles AppFiles
                    REM AppFilesフォルダ以外の残骸を削除
                    rd /s /q %TEMP_FOLDER%\%2
                    REM Zipファイル削除
                    del %2.zip
                )
            popd
        )
    REM カレントフォルダ復帰
    popd

    exit /b %errorlevel%
REM --------------------------------------------------------------------------------
