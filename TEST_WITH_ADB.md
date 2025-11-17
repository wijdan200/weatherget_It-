# How to Test Deep Links with ADB

## Problem: ADB not found in PATH

If you get `adb : The term 'adb' is not recognized`, you need to either:

### Option 1: Find ADB and use full path

ADB is usually located in:
- `C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe`
- Or where you installed Android Studio SDK

Then use:
```bash
C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather
```

### Option 2: Add ADB to PATH (Recommended)

1. Find your Android SDK location (usually in AppData\Local\Android\Sdk)
2. Add `platform-tools` folder to Windows PATH:
   - Right-click "This PC" → Properties
   - Advanced system settings → Environment Variables
   - Edit "Path" → Add: `C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools`
3. Restart terminal/PowerShell
4. Test: `adb version`

### Option 3: Use the batch script I created

Just double-click `test_deeplink.bat` - it will test all deep links automatically!

### Option 4: Test in Chrome (Easiest - No ADB needed!)

1. Open Chrome on your Android phone
2. Type in address bar:
   ```
   intent://open/notify#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
   ```
3. Press Go
4. Tap "Open" when Chrome asks

---

## Test Commands (once ADB is working)

```bash
# Test Notify Page
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather

# Test Weather Page
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather

# Test Dashboard
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather

# Test Another Page
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/another" com.example.flutterweather
```

---

## Quick Test in Chrome (No ADB Required!)

**Just open Chrome on your phone and type:**

```
intent://open/notify#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
```

This is the easiest way to test without ADB!

