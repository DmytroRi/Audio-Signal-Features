@echo off
REM Check if Python is installed
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Please install Python and try again.
    exit /b
)

REM Create a virtual environment
echo Creating virtual environment...
python -m venv venv

REM Check if virtual environment creation succeeded
IF NOT EXIST "venv" (
    echo Failed to create virtual environment. Ensure you have permissions and try again.
    exit /b
)

REM Activate the virtual environment
echo Activating virtual environment...
call venv\Scripts\activate

REM Check if requirements.txt exists
IF NOT EXIST "requirements.txt" (
    echo requirements.txt not found. Please provide the file and try again.
    exit /b
)

REM Install packages from requirements.txt
echo Installing packages from requirements.txt...
pip install --upgrade pip
pip install -r requirements.txt

REM Check if installation succeeded
IF %ERRORLEVEL% NEQ 0 (
    echo Failed to install some packages. Please check the requirements.txt file.
    exit /b
)

echo Environment setup is complete.
