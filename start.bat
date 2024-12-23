@echo off
cd /d "%~dp0"

:: Открываем первый терминал для Jupyter Notebook
start cmd /k "call virtual\Scripts\activate && jupyter notebook"

:: Открываем второй терминал для активации виртуальной среды
start cmd /k "call virtual\Scripts\activate"

:: Завершаем основной процесс
exit
