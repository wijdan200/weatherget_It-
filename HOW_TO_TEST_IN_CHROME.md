# How to Test Deep Links in Chrome on Android

## Quick Steps:

### Step 1: Make sure your app is installed
1. Build and install your app on your Android phone:
   ```bash
   flutter run
   ```
   OR manually install the APK file

2. Open your app at least once to register it with Android

### Step 2: Open the HTML test file in Chrome

**Option A: Transfer file to phone**
1. Copy `deep_link_test.html` to your phone (via USB, email, or cloud storage)
2. Open Chrome on your phone
3. Navigate to the file location and open it
4. Click any of the "Intent URI" links (first 4 links work best)

**Option B: Use local server (if phone and computer on same WiFi)**
1. On your computer, run:
   ```bash
   python start_test_server.py
   ```
2. Note the IP address shown (e.g., `192.168.1.100`)
3. On your phone, open Chrome and go to:
   ```
   http://YOUR_COMPUTER_IP:8000/deep_link_test.html
   ```
4. Click the links to test

**Option C: Type directly in Chrome address bar**
1. Open Chrome on your Android phone
2. Tap the address bar
3. Type one of these:

   **Intent URI format (Recommended):**
   ```
   intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
   ```

   **Or custom scheme format:**
   ```
   WeatherApp://open/weather
   ```

4. Press Enter/Go
5. Chrome should ask to open with your app - tap "Open" or "Just once"

### Step 3: Verify it works
- Your app should open
- Check the console/logs for debug messages showing the deep link was received
- The app should navigate to the correct page

## Troubleshooting:

### If Chrome doesn't ask to open the app:

1. **Clear Chrome cache:**
   - Chrome → Settings → Privacy → Clear browsing data
   - Select "Cached images and files"
   - Clear data

2. **Check app is installed:**
   - Make sure you can see "flutterweather" in your app drawer
   - Open it manually at least once

3. **Rebuild and reinstall app:**
   ```bash
   flutter clean
   flutter build apk --debug
   # Install on phone
   ```

4. **Try Intent URI format instead:**
   - Intent URI works better than custom scheme in Chrome
   - Use the format: `intent://path#Intent;scheme=WeatherApp;package=com.example.flutterweather;end`

5. **Check Android app associations (Android 12+):**
   - Settings → Apps → [Your App Name]
   - Tap "Open by default"
   - Enable "Open supported links"

## Available Deep Links:

- **Weather Page:**
  ```
  intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
  ```

- **Dashboard:**
  ```
  intent://open/dashboard#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
  ```

- **Notify Page:**
  ```
  intent://open/notify#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
  ```

- **Another Page:**
  ```
  intent://open/another#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
  ```

## Quick Test Command (if you have ADB):

```bash
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather
```


