# Google Sign-In Setup Guide

## Step 1: Enable Google Sign-In in Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: **weatherapp-66e7b**
3. Navigate to **Authentication** → **Sign-in method**
4. Click on **Google** provider
5. Click **Enable** toggle
6. Enter your **Support email** (your email address)
7. Click **Save**

## Step 2: Configure OAuth Consent Screen (if needed)

For Google Sign-In to work, you need to configure OAuth consent screen:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your project: **weatherapp-66e7b**
3. Navigate to **APIs & Services** → **OAuth consent screen**
4. Fill in the required information:
   - User Type: External
   - App name: Weather App
   - User support email: (your email)
   - Developer contact information: (your email)
5. Click **Save and Continue**
6. Add scopes (email, profile, openid)
7. Add test users if needed
8. Review and submit

## Step 3: Get OAuth 2.0 Client IDs

1. In Google Cloud Console, go to **APIs & Services** → **Credentials**
2. Create OAuth 2.0 Client ID:
   - For Android: Create Android client ID
   - For iOS: Create iOS client ID  
   - For Web: Create Web client ID
3. Copy the Client IDs - you'll need these for platform configuration

## Step 4: Configure Android (if using Android)

1. In Firebase Console, go to **Project Settings** → **Your apps**
2. Select your Android app
3. Download `google-services.json` (already done)
4. In Android app, ensure SHA-1 certificate is added in Firebase Console

## Step 5: Configure iOS (if using iOS)

1. In Firebase Console, go to **Project Settings** → **Your apps**
2. Select your iOS app
3. Download `GoogleService-Info.plist`
4. Add the REVERSED_CLIENT_ID to Info.plist

## Step 6: Configure Web (if using Web)

1. In Firebase Console, go to **Project Settings** → **Your apps**
2. Select your Web app
3. Add authorized domains:
   - `localhost` (for development)
   - Your domain (for production)

## Testing

After enabling Google Sign-In in Firebase Console:
1. Make sure Google Sign-In is enabled in Firebase Console
2. Run the app
3. Click "Sign in with Google"
4. Select your Google account
5. Grant permissions

## Troubleshooting

If Google Sign-In doesn't work:
1. Verify Google Sign-In is enabled in Firebase Console
2. Check that OAuth consent screen is configured
3. Verify Client IDs are correct
4. Check that authorized domains are set correctly (for web)
5. Ensure SHA-1 certificate is added (for Android)
6. Check Firebase project ID matches in `firebase_options.dart`

