@echo off
setlocal enabledelayedexpansion

REM Solicitar el nuevo nombre para reemplazar "azure"
set /p new_name="Ingrese el nuevo nombre para reemplazar 'azure': "

REM Solicitar la ruta de la carpeta
set /p folder_path="Ingrese la ruta de la carpeta: "

REM Verificar si la carpeta existe
if not exist "%folder_path%" (
    echo La carpeta no existe.
    pause
    exit /b
)

REM Recorrer todos los archivos en la carpeta
for %%f in ("%folder_path%\*.yml") do (
    set "filename=%%~nf"
    set "extension=%%~xf"

    REM Verificar si el nombre del archivo contiene el prefijo "azure_"
    if "!filename!"=="!filename:azure_=!" (
        echo Saltando archivo no relacionado: %%f
    ) else (
        REM Generar el nuevo nombre del archivo
        set "new_filename=!filename:azure_=%new_name%_!"
        
        REM Verificar si ya existe un archivo con el nuevo nombre
        if exist "%folder_path%\!new_filename!!extension!" (
            echo Ya existe un archivo con el nombre !new_filename!!extension!
        ) else (
            REM Renombrar el archivo
            echo Renombrando: %%f a "!new_filename!!extension!"
            ren "%%f" "!new_filename!!extension!"
        )
    )
)

echo Proceso completado.
pause
