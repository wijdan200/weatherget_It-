# Deep Link Troubleshooting Guide

## Problem: Chrome doesn't ask to open the app

### Step 1: Rebuild and Reinstall the App
After making changes to AndroidManifest.xml, you MUST rebuild and reinstall:

```bash
flutter clean
flutter pub get
flutter run
```

Or build and install manually:
```bash
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk
```

### Step 2: Verify App is Installed
Make sure your app is actually installed on the device:
```bash
adb shell pm list packages | grep flutterweather
```

### Step 3: Test with ADB First
Before testing in Chrome, verify deep links work with ADB:

```bash
# Test weather page
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather

# Test dashboard
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather
```

If ADB works but Chrome doesn't, it's a Chrome-specific issue.

### Step 4: Clear Chrome Cache
On your Android phone:
1. Open Chrome Settings
2. Privacy and Security → Clear browsing data
3. Select "Cached images and files"
4. Clear data

### Step 5: Try Different URL Formats
In Chrome, try these formats:

1. **With host:**
   ```
   WeatherApp://open/weather
   ```

2. **Direct path:**
   ```
   WeatherApp://weather
   ```

3. **With query parameters:**
   ```
   WeatherApp://open/weather?test=1
   ```

### Step 6: Check Chrome App Associations
On Android 12+:
1. Go to Settings → Apps → Default apps
2. Check "Opening links" or "App links"
3. Find your app and verify it's associated with `WeatherApp://`

### Step 7: Manual App Association (Android 12+)
If automatic association doesn't work:

1. Go to Settings → Apps → [Your App Name]
2. Tap "Open by default" or "Set as default"
3. Enable "Open supported links"
4. Add `WeatherApp://` manually if needed

### Step 8: Use Intent URI Format
Try using the full intent URI format in Chrome:
```
intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
```

### Step 9: Verify Manifest is Correct
Check that your AndroidManifest.xml has:
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="WeatherApp" />
</intent-filter>
```

### Step 10: Alternative Testing Methods

**Method A: Use a Link in HTML**
Create an HTML file with:
```html
<a href="WeatherApp://open/weather">Open Weather</a>
```

**Method B: Use ADB to simulate Chrome**
```bash
adb shell am start -a android.intent.action.VIEW -d "WeatherApp://open/weather" -t "text/html" com.example.flutterweather
```

**Method C: Use another app**
- Use a note-taking app
- Type: `WeatherApp://open/weather`
- Make it a clickable link
- Tap it

### Common Issues:

1. **App not installed**: Make sure app is installed on device
2. **Old version**: Rebuild and reinstall after manifest changes
3. **Chrome cache**: Clear Chrome cache
4. **Android version**: Some Android versions handle deep links differently
5. **Case sensitivity**: Try lowercase `weatherapp://` if `WeatherApp://` doesn't work

### Still Not Working?

1. Check app logs:
   ```bash
   adb logcat | grep -i "deeplink\|intent\|weather"
   ```

2. Verify the app receives the intent:
   ```bash
   adb shell dumpsys package com.example.flutterweather | grep -A 10 "intent-filter"
   ```

3. Test with a different browser (Firefox, Edge) to see if it's Chrome-specific


