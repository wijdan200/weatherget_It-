# Google Sign-In Setup Instructions

## SHA-1 Fingerprint (for Android)
Your debug keystore SHA-1 fingerprint is:
```
SHA1: FB:C6:60:11:C7:81:E0:D1:4D:8E:08:7D:EC:FB:25:C0:6C:DC:F6:5D
SHA-256: 5A:50:65:62:93:2B:3D:AD:98:F1:29:D6:E0:5B:FF:4E:1E:63:27:C6:0E:61:6D:12:D4:07:68:82:9A:79:71:E5
```

## Steps to Configure Google Sign-In in Firebase Console

### Step 1: Enable Google Sign-In in Firebase Authentication
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project (project-387409165601)
3. Navigate to **Authentication** > **Sign-in method**
4. Click on **Google** provider
5. Enable the **Google** sign-in provider
6. Set a support email (required)
7. Click **Save**

### Step 2: Add SHA-1 Fingerprint to Firebase
1. In Firebase Console, go to **Project Settings** (gear icon)
2. Scroll down to **Your apps** section
3. Find your Android app (package name: `com.example.flutterweather`)
4. Click on the app to expand it
5. Click **Add fingerprint**
6. Add the SHA-1 fingerprint: `FB:C6:60:11:C7:81:E0:D1:4D:8E:08:7D:EC:FB:25:C0:6C:DC:F6:5D`
7. Click **Save**

### Step 3: Download Updated google-services.json
1. After adding the SHA-1 fingerprint, Firebase will automatically generate OAuth client IDs
2. Download the updated `google-services.json` file:
   - In **Project Settings** > **Your apps** > Click on your Android app
   - Click **Download google-services.json**
3. Replace the existing file at: `flutterweather/android/app/google-services.json`

### Step 4: Verify OAuth Client IDs
After downloading the new `google-services.json`, check that it contains OAuth client IDs:
- Open `google-services.json`
- Look for `"oauth_client"` array - it should NOT be empty
- It should contain entries like:
```json
"oauth_client": [
  {
    "client_id": "YOUR_CLIENT_ID.apps.googleusercontent.com",
    "client_type": 3
  }
]
```

### Step 5: Test Google Sign-In
1. Run your Flutter app: `flutter run`
2. Tap the "Sign in with Google" button
3. Select a Google account
4. You should be signed in successfully

## Troubleshooting

### Issue: "oauth_client array is empty"
- **Solution**: Make sure you've added the SHA-1 fingerprint to Firebase Console
- Wait a few minutes after adding the fingerprint
- Download a fresh `google-services.json` file

### Issue: "Sign-in failed" or "DEVELOPER_ERROR"
- **Solution**: 
  1. Verify SHA-1 fingerprint is added correctly
  2. Ensure Google Sign-In is enabled in Firebase Authentication
  3. Make sure you're using the correct `google-services.json` for your project

### Issue: "The Google Sign-In API has not been used in project"
- **Solution**: Enable the Google Sign-In API in Google Cloud Console:
  1. Go to [Google Cloud Console](https://console.cloud.google.com/)
  2. Select your project
  3. Navigate to **APIs & Services** > **Library**
  4. Search for "Google Sign-In API"
  5. Click **Enable**

## Current Project Information
- **Project ID mentioned**: project-387409165601
- **Current Firebase Project in code**: weatherapp-66e7b
- **Package Name**: com.example.flutterweather

**Note**: If your actual Firebase project is different (project-387409165601), you may need to:
1. Update the Firebase configuration in your app
2. Download the correct `google-services.json` for that project
3. Update `firebase_options.dart` with the correct project details

