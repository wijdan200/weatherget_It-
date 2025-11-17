@echo off
REM Test Deep Links - Windows Batch Script
REM Make sure your Android device is connected via USB

echo Testing Deep Links...
echo.

echo Testing Weather Page...
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather
timeout /t 3 /nobreak >nul

echo.
echo Testing Dashboard...
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather
timeout /t 3 /nobreak >nul

echo.
echo Testing Notify Page...
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather
timeout /t 3 /nobreak >nul

echo.
echo Testing Another Page...
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/another" com.example.flutterweather

echo.
echo Done! Check your app to see if it navigated correctly.

