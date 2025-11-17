# How to Test Deep Links - Step by Step

## 🚀 Quick Test (Easiest Method)

### Step 1: Build and Install App
```bash
flutter run
```
This will build and install the app on your connected Android device/emulator.

### Step 2: Test with ADB (Fastest)
Open a terminal and run:

```bash
# Test Weather Page
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather

# Test Dashboard
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather

# Test Notify Page
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather
```

**Expected Result:** Your app should open and navigate to the correct page.

---

## 📱 Test in Chrome on Android Phone

### Method 1: Use HTML Test File

1. **Transfer the HTML file to your phone:**
   - Email `deep_link_test.html` to yourself
   - Or copy via USB
   - Or upload to Google Drive

2. **Open in Chrome:**
   - Open Chrome on your phone
   - Navigate to where you saved the file
   - Tap `deep_link_test.html` to open it

3. **Click a link:**
   - Click "Open Weather (Intent URI - Recommended)"
   - Your app should open!

### Method 2: Type in Chrome Address Bar

1. Open Chrome on your Android phone
2. Tap the address bar
3. Type this exactly:
   ```
   intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
   ```
4. Press Enter/Go
5. Chrome will ask to open with your app → Tap "Open"

### Method 3: Use Local Server

1. **On your computer, start the server:**
   ```bash
   python start_test_server.py
   ```
   You'll see: `http://192.168.1.XXX:8000/deep_link_test.html`

2. **On your phone (same WiFi):**
   - Open Chrome
   - Go to: `http://YOUR_COMPUTER_IP:8000/deep_link_test.html`
   - Click the links

---

## 🧪 Test URLs

### Intent URI Format (Works Best in Chrome):
```
intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
intent://open/dashboard#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
intent://open/notify#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
intent://open/another#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
```

### Custom Scheme Format:
```
WeatherApp://open/weather
WeatherApp://open/dashboard
WeatherApp://open/notify
WeatherApp://open/another
```

### Direct Format (without /open/):
```
WeatherApp://weather
WeatherApp://dashboard
```

---

## ✅ Verify It's Working

When you test a deep link, you should see:

1. **In your app console/logs:**
   ```
   🔗 Deep link received: WeatherApp://open/weather
      Scheme: WeatherApp
      Host: open
      Path: /weather
   ✅ Navigating to deep link path: /weather
   ```

2. **In your app:**
   - App opens (if closed)
   - Navigates to the correct page
   - Shows the weather/dashboard/notify page

---

## 🔧 Troubleshooting

### If deep link doesn't work:

1. **Make sure app is installed:**
   ```bash
   flutter run
   ```

2. **Open app manually first:**
   - Launch the app from app drawer
   - This registers it with Android

3. **Clear Chrome cache:**
   - Chrome → Settings → Privacy → Clear browsing data

4. **Rebuild app:**
   ```bash
   flutter clean
   flutter run
   ```

5. **Check logs:**
   ```bash
   flutter logs
   ```
   Look for deep link debug messages

---

## 📋 Test Checklist

- [ ] App is built and installed
- [ ] App opened manually at least once
- [ ] Tested with ADB command
- [ ] Tested in Chrome (HTML file or address bar)
- [ ] Verified app navigates to correct page
- [ ] Checked console logs for debug messages

---

## 🎯 Quick Test Commands

**Copy and paste these in your terminal:**

```bash
# Test Weather
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/weather" com.example.flutterweather

# Test Dashboard  
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/dashboard" com.example.flutterweather

# Test Notify
adb shell am start -W -a android.intent.action.VIEW -d "WeatherApp://open/notify" com.example.flutterweather
```

**Or type in Chrome address bar:**
```
intent://open/weather#Intent;scheme=WeatherApp;package=com.example.flutterweather;end
```


