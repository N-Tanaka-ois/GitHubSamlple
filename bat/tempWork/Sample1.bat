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

    REM �ꎞ�t�H���_�쐬
    mkdir %TEMP_FOLDER%

    REM �����@
    pushd "01.JP"
        REM �X���@
        pushd "�����X���@\�I�t���C���C���X�g�[��"
            REM ���
            pushd "���\Download"
                REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
                if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

                REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
                for /f %%i in ('dir /b /ad') do (
                    SET zipFolderName=%%i
                    call :getAppFilesFolder %%i !zipFolderName:JPITR000000001=JPI0!_%VERSION_JP_COUNTER%
                )

                REM �t�@�C�����X�g���o��
                dir /B /S /A-D > "%~dp0\01-01_FileList(JPITR000000001).txt"
            popd

            REM �L�^����
            pushd "�L�^����\Download"
                REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
                if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

                REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
                for /f %%i in ('dir /b /ad') do (
                    SET zipFolderName=%%i
                    call :getAppFilesFolder %%i !zipFolderName:JPITR001000001=JPI1!_%VERSION_JP_COUNTER%
                )

                REM �t�@�C�����X�g���o��
                dir /B /S /A-D > %~dp0\01-02_FileList(JPITR001000001).txt
            popd

            REM �R�C�f
            pushd "�R�C�f\Download"
                REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
                if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

                REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
                for /f %%i in ('dir /b /ad') do (
                    SET zipFolderName=%%i
                    call :getAppFilesFolder %%i !zipFolderName:JPITR015000001=JPI15!_%VERSION_JP_COUNTER%
                )

                REM �t�@�C�����X�g���o��
                dir /B /S /A-D > %~dp0\01-03_FileList(JPITR015000001).txt
            popd
        popd

        REM �����Z���t�@
        pushd "�����Z���t�@\JPPSR000000001\x64\Download"
            REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:JPPSR000000001=JPPSR!_%VERSION_JP_SELF%
            )

            REM �t�@�C�����X�g���o��
            dir /B /S /A-D > %~dp0\02_FileList(JPPSR000000001).txt
        popd
    popd


    REM �C�O�@
    pushd 02.Global
        REM �C�O�X���@
        pushd "Global_Counter\Download"
            REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:USITR100000001=USI0!_%VERSION_EN_COUNTER%
            )

            REM �t�@�C�����X�g���o��
            dir /B /S /A-D > %~dp0\03_FileList(USITR100000001).txt
        popd

        REM �C�O�Z���t�@
        pushd "Global_Self\Download"
            REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:USPSR100000001=USPSR!_%VERSION_EN_SELF%
            )

            REM �t�@�C�����X�g���o��
            dir /B /S /A-D > %~dp0\04_FileList(USPSR100000001).txt
        popd

        REM �C�O�Z�~�Z���t�@
        pushd "Global_Self\Download"
            REM SPK_SYSTEM�t�H���_�ɂ�AppFiles�t�H���_���Ȃ����ߍ폜
            if exist SPK_SYSTEM (rd /s /q SPK_SYSTEM)

            REM �e�T�u�V�X�e���t�H���_�̉𓀂�AppFiles�t�H���_�̒��o
            for /f %%i in ('dir /b /ad') do (
                SET zipFolderName=%%i
                call :getAppFilesFolder %%i !zipFolderName:USSSR100000001=USSSR!_%VERSION_EN_SEMISELF%
            )

            REM �t�@�C�����X�g���o��
            dir /B /S /A-D > %~dp0\05_FileList(USSSR100000001).txt
        popd
    popd

    REM �ꎞ�t�H���_�폜
    rd /s /q %TEMP_FOLDER%
popd

exit /b
REM --------------------------------------------------

REM --------------------------------------------------------------------------------
REM Zip���ꎞ�t�H���_�ɉ𓀂��AAppFiles���擾
REM %1: SubSystem�t�H���_��
REM %2: Zip�t�H���_��(Version�ԍ��t)
REM --------------------------------------------------------------------------------
:getAppFilesFolder
    REM �t�H���_���Ȃ��ꍇ�A�����𔲂���
    if not exist %1 (
        echo NotExist %1
        exit /b 0
    )

    REM �J�����g�t�H���_�ݒ�
    pushd %1
        REM �J�����g�t�H���_���̃t�H���_���擾
        for /f %%i in ('dir /b /ad') do (
            pushd %%i
                REM Zip�t�@�C�����L��ꍇ
                if exist %2.zip (
                    REM Zip�t�@�C�����ꎞ�t�H���_�ɉ�
                    %LHAPLUS% /o:%TEMP_FOLDER%\ %2.zip
                    REM �𓀂����t�H���_����AppFiles�t�H���_�݈̂ړ�
                    move /Y %TEMP_FOLDER%\%2\AppFiles AppFiles
                    REM AppFiles�t�H���_�ȊO�̎c�[���폜
                    rd /s /q %TEMP_FOLDER%\%2
                    REM Zip�t�@�C���폜
                    del %2.zip
                )
            popd
        )
    REM �J�����g�t�H���_���A
    popd

    exit /b %errorlevel%
REM --------------------------------------------------------------------------------
