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

    REM �ꎞ�t�H���_�쐬
    mkdir %TEMP_FOLDER%

    REM �����@
    pushd "01.JP"
        dir /b
        echo -----

        REM �X���@
        pushd "�����X���@\�I�t���C���C���X�g�[��"
            dir /b
            echo -----

            REM ���
            pushd "���\Download"
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

            REM �L�^����
            pushd "�L�^����"
                dir /b
                echo -----
            popd

            REM �R�C�f
            pushd "�R�C�f"
                dir /b
                echo -----
            popd

        popd
    popd

    REM �C�O�@
    pushd 02.Global
        dir /b
        echo -----
    popd

    REM �ꎞ�t�H���_�폜
    rd /s /q %TEMP_FOLDER%
popd

REM 01.JP\�����Z���t�@\JPPSR000000001\x64\Download\SPK_APP_AC\2018090621275861
REM 01.JP\�����Z���t�@\JPPSR000000001\x64\Download\SPK_APP_AC\2018090621275861\SPK_APP_AC_20230\AppFiles
REM C:\FujifilmApplication\i-Base\SoftUpdate\UpdateWork\SPK_APP_AC\2018090621275861\AppFiles\C_Drive\SmartPrintKiosk\Server\htdocs\clientapps\ac\js\inputImageApp.js

exit /b
REM --------------------------------------------------

REM --------------------------------------------------------------------------------
REM AppFiles�t�H���_����executable�t�H���_�ֈړ�(�C�O�@)
REM - ��Vup����AppFiles���փR�s�[����bat�t�@�C�������킹�č쐬
REM %1: SubSystem�t�H���_��
REM %2: �R�s�[���ƂȂ�t�H���_("AppFile\C_Drive\"�ȍ~��ݒ�)
REM %3: �R�s�[��ɍ쐬����t�H���_��(���R�s�[bat�̃t�@�C������"copy_%3.bat"�ƂȂ�)
REM --------------------------------------------------------------------------------
:moveAppFilesToExecutable_EN
    REM �J�����g�t�H���_�ݒ�
    pushd %~dp0

    REM ���ʏ����R�[��(�C�O�@�̂���Output_global�t�H���_���w��)
    call :moveAppFilesToExecutable_Common %1 %2 %3 Output_global

    REM ���ʏ�������I����
    if %errorlevel% == 0 (
       REM ��Ɨp�t�H���_����executable�t�H���_�ɃR�s�[
       xcopy TEMP_WORK\executable Output_global_AddFiles\Global_Counter\%1\executable  /E /V /I /Y
       xcopy TEMP_WORK\executable Output_global_AddFiles\Global_Self\%1\executable  /E /V /I /Y
       xcopy TEMP_WORK\executable Output_global_AddFiles\Global_SemiSelf\%1\executable  /E /V /I /Y

       REM ��Ɨp�t�H���_�̍폜
       rd /s /q TEMP_WORK
    )

    REM �J�����g�t�H���_���A
    popd

    exit /b %errorlevel%
REM --------------------------------------------------------------------------------
