@echo off
TITLE PING SCAN -----------

set TT=100
set R=1
set A=192
set B=168
set C=8
set F=126
set U=127

:init
cls

echo.
echo ESTADO ACTUAL IP:%A%.%B%.%C%.%F% - %U%
echo ==================================
echo 1-Conf. de Red (tercer octeto)
echo 2-Conf. de Rango (primer y ultimo) IP
echo 3-Recorrer red
echo 4-Mostrar captura
echo 5-Conf. (Primer, Segundo, Tercer) octeto
echo 6-Salir
echo ==================================
echo.
set /P op= Escoja la opcion deseada:
  if %op%== 1 goto config
  if %op%== 2 goto rango
  if %op%== 3 goto barrido
  if %op%== 4 goto Mostrar
  if %op%== 5 goto octetos
  if %op%== 6 goto Salir
  if %op%== %op% goto error
  

:error
cls
echo ¡ERROR!
pause
goto init

:config
 cls
 echo.
 echo Configuracion del tercer octeto
 echo Red actual == %A%.%B%.%C%.%F% - %U%
 echo.
 set /P C= Tercer octeto:
 goto init

:barrido
 cls
 echo.
 echo ESCANEAR RED %A%.%B%.%C%.%F% - %U%(pulse para continuar)
 pause >nul
 echo. > SCAN.txt
 echo.
 FOR  /L  %%F IN (%F%, 1, %U%) DO (
    echo Scaneando IP: %TT% %A%.%B%.%C%.%%F
    for /f "tokens=4,5 delims= " %%A in ('ping -a -n %R% -w %TT% %A%.%B%.%C%.%%F') do (
      IF "%%B"=="[%A%.%B%.%C%.%%F]" (
        echo.
        echo ------------------------------------------------------------
        echo.
        echo %%A
        set PC= %%A
        for /f "tokens=1,2" %%A in ('arp -a ^| FIND "%A%.%B%.%C%.%%F"') do (
          echo %%A
          echo %%B 
          set IP= %%A
          set MAC= %%B 
        )
        set   PC >> SCAN.txt
        set   IP >> SCAN.txt
        set   MAC >> SCAN.txt
        echo. >> SCAN.txt
        echo ------------------------------------------------------------ >> SCAN.txt
        echo. >> SCAN.txt
        echo.
        echo ------------------------------------------------------------
        echo.
      )
        
    ) 
  )
 NOTEPAD SCAN.txt
 goto Mostrar

:Mostrar
 cls
 arp -a
 more SCAN.txt
 echo ------------------------------------------------------------
 pause
 goto init

:Salir
 cls
 exit


:octetos
 cls
 echo.
 echo ESTADO ACTUAL %A%.%B%.%C%.%F% - %U%
 set /P A=Primer octeto:
 set /P B=Segundo octeto:
 set /P C=Tercer octeto:
goto init

:rango
 cls
 echo.
 echo ESTADO ACTUAL %A%.%B%.%C%.%F% - %U%
 echo Introduce rago de IP
 echo.
 set /P F=Primer ip:
 set /P U=Ultimo ip:
goto init