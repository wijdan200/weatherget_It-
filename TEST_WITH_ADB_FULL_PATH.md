# Test Deep Links with ADB (Full Path Method)

Since ADB is not in your PATH, use the full path to ADB.

## Step 1: Find ADB Location

ADB is usually located at:
```
C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe
```

**To find it:**
1. Open File Explorer
2. Go to: `C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\`
3. Look for `adb.exe`
4. Copy the full path

**OR if you have Android Studio:**
- Usually in: `C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\`

## Step 2: Test Deep Links

Replace `YOUR_USERNAME` with your actual Windows username, then run:

```powershell
# Test Weather Page
& "C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather

# Test Dashboard
& "C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather

# Test Notify
& "C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather
```

## Step 3: Check Flutter Console

When you run the ADB command, check your Flutter console. You should see:
```
🔗 Deep link received: WeatherApp://open/weather
   Scheme: WeatherApp
   Host: open
   Path: /weather
✅ Navigating to deep link path: /weather
```

## Alternative: Create a Batch File

Create a file `test_deeplink.bat` with:

```batch
@echo off
set ADB_PATH=C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe

echo Testing Weather Page...
"%ADB_PATH%" shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather
timeout /t 3

echo Testing Dashboard...
"%ADB_PATH%" shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather
timeout /t 3

echo Testing Notify...
"%ADB_PATH%" shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather
```

Replace `YOUR_USERNAME` with your actual username, then double-click the file.

## If ADB Path is Different

If ADB is in a different location:
1. Search for `adb.exe` in File Explorer
2. Right-click → Properties → Copy the full path
3. Use that path in the commands above

