# Deep Link Troubleshooting - Step by Step

## ❌ If Chrome Can't Open the App

### Step 1: Verify App is Installed and Running

1. **Make sure app is installed:**
   ```bash
   flutter clean
   flutter run
   ```

2. **Open app manually first:**
   - Find "flutterweather" in your app drawer
   - Open it manually at least once
   - This registers the app with Android

3. **Check if app is running:**
   - Keep the app open in background
   - Then try the deep link

### Step 2: Clear Chrome Cache

On your Android phone:
1. Open Chrome → Settings
2. Privacy and Security → Clear browsing data
3. Select "Cached images and files"
4. Clear data
5. Restart Chrome

### Step 3: Try Different URL Formats

**Format 1: Intent URI (Best for Chrome)**
```
intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
```

**Format 2: Custom Scheme**
```
WeatherApp://open/weather
```

**Format 3: Direct (no host)**
```
WeatherApp://weather
```

### Step 4: Check App Logs

While testing, check your Flutter console/logs. You should see:
```
🔧 Initializing deep links...
✅ Deep link listeners initialized
📱 Initial deep link received: WeatherApp://open/weather
🔗 Deep link received: WeatherApp://open/weather
   Scheme: WeatherApp
   Host: open
   Path: /weather
✅ Navigating to deep link path: /weather
```

**If you DON'T see these messages:**
- The deep link is not reaching your app
- Check AndroidManifest.xml configuration
- Rebuild and reinstall the app

### Step 5: Verify AndroidManifest.xml

Make sure your manifest has:
```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="WeatherApp" />
</intent-filter>
```

**Important:** NO `android:autoVerify="true"` and NO `android:host`

### Step 6: Test with ADB (If Available)

If you have ADB working:
```bash
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather
```

This bypasses Chrome and tests directly.

### Step 7: Alternative Testing Methods

**Method A: Use HTML File**
1. Open `deep_link_test.html` in Chrome
2. Click the links (works better than typing)

**Method B: Use Another App**
1. Open a note app
2. Type: `WeatherApp://open/weather`
3. Make it a clickable link
4. Tap it

**Method C: Use Intent URI in Chrome**
Type this EXACTLY in Chrome address bar:
```
intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
```

### Step 8: Check Android App Associations (Android 12+)

1. Settings → Apps → flutterweather
2. Tap "Open by default" or "Set as default"
3. Enable "Open supported links"
4. Add `WeatherApp://` if needed

### Step 9: Rebuild Everything

```bash
flutter clean
flutter pub get
flutter build apk --debug
# Install on phone
flutter install
```

### Step 10: Test Basic Deep Link First

Try the simplest format first:
```
WeatherApp://
```

This should at least open your app (even if it doesn't navigate).

---

## 🔍 Debug Checklist

- [ ] App is installed on device
- [ ] App opened manually at least once
- [ ] AndroidManifest.xml is correct (no autoVerify, no host)
- [ ] App rebuilt after manifest changes
- [ ] Chrome cache cleared
- [ ] Tried Intent URI format
- [ ] Checked Flutter console for debug messages
- [ ] Router is initialized (check logs)

---

## 🎯 Quick Test Sequence

1. **Rebuild app:**
   ```bash
   flutter clean && flutter run
   ```

2. **Open app manually** (from app drawer)

3. **In Chrome, type:**
   ```
   intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
   ```

4. **Check Flutter console** for debug messages

5. **If no messages appear:** The deep link isn't reaching your app - check manifest

6. **If messages appear but no navigation:** Check router configuration

---

## 💡 Common Issues

**Issue:** Chrome doesn't ask to open app
- **Solution:** Clear Chrome cache, use Intent URI format

**Issue:** App opens but doesn't navigate
- **Solution:** Check router logs, verify route exists

**Issue:** No debug messages in console
- **Solution:** Deep link not reaching app - rebuild and reinstall

**Issue:** "Router is null" error
- **Solution:** App started too fast - wait a moment, or check router initialization

---

## 📞 Still Not Working?

1. Share your Flutter console output
2. Share your AndroidManifest.xml
3. Tell me which URL format you tried
4. Tell me what happens (nothing? error? app opens but wrong page?)

