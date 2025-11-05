# Verify Google Sign-In Setup - Step by Step

## ⚠️ IMPORTANT: Make sure you're in the CORRECT project!

Your Android app uses:
- **Project ID**: `weatherapp-66e7b`
- **Project Number**: `387409165601`
- **App ID**: `1:387409165601:android:26dd3a474bf81d5f49d260`

## Step 1: Verify in Firebase Console

1. Go to: https://console.firebase.google.com/
2. **Select project**: `weatherapp-66e7b` (NOT any other project!)
3. Click **Authentication** → **Sign-in method**
4. Find **Google** in the list
5. Click on **Google** row
6. **VERIFY**:
   - ✅ Toggle shows **Enabled** (blue/green)
   - ✅ Project support email is filled
   - ✅ Web SDK configuration shows:
     - Web client ID: `387409165601-opsl9cit93e5b56pulihvks9va12923a.apps.googleusercontent.com`
   - ✅ Android SDK configuration shows:
     - Android client ID: `387409165601-l513c4nvhd0pv1h0hjrri5f38b8k0kcb.apps.googleusercontent.com`
     - Package name: `com.example.flutterweather`
     - SHA-1: `fbc66011c781e0d14d8e087decfb25c06cdcf65d`
7. If anything is missing, click **Save** again

## Step 2: Enable APIs in Google Cloud Console

1. Go to: https://console.cloud.google.com/
2. **Select project**: `weatherapp-66e7b` (from dropdown at top)
3. Go to: **APIs & Services** → **Library**
4. Search for and **ENABLE** these APIs:
   - ✅ **Identity Toolkit API**
   - ✅ **Google Identity Toolkit API**
   - ✅ **Firebase Authentication API**
5. Wait 1-2 minutes after enabling

## Step 3: Configure OAuth Consent Screen

1. In Google Cloud Console (same project: `weatherapp-66e7b`)
2. Go to: **APIs & Services** → **OAuth consent screen**
3. If not configured:
   - User Type: **External**
   - App name: **Weather App**
   - User support email: (your email)
   - Developer contact: (your email)
   - Click **Save and Continue**
   - Add scopes: email, profile, openid
   - Add test users (your email) if app is in testing
   - Review and submit

## Step 4: Verify OAuth Client IDs

1. In Google Cloud Console → **APIs & Services** → **Credentials**
2. **Verify** you see these OAuth 2.0 Client IDs:
   - Android client: `387409165601-l513c4nvhd0pv1h0hjrri5f38b8k0kcb.apps.googleusercontent.com`
   - Web client: `387409165601-opsl9cit93e5b56pulihvks9va12923a.apps.googleusercontent.com`
3. If missing, create them in Firebase Console → Project Settings → Your apps

## Step 5: Wait and Test

1. **Wait 3-5 minutes** after enabling (changes need to propagate)
2. **Uninstall and reinstall** the app on your device
3. Try Google Sign-In again
4. Check console logs for detailed debug messages

## Common Issues:

### Issue 1: "operation-not-allowed"
**Solution**: Google Sign-In is NOT enabled or APIs are not enabled
- Double-check Firebase Console → Authentication → Sign-in method → Google → Enable
- Verify APIs are enabled in Google Cloud Console

### Issue 2: Wrong Project
**Solution**: Make sure you're in `weatherapp-66e7b` project, not `reaelstate` or others

### Issue 3: OAuth Consent Screen Not Configured
**Solution**: Configure OAuth consent screen in Google Cloud Console

### Issue 4: SHA-1 Certificate Missing
**Solution**: Your SHA-1 is: `FB:C6:60:11:C7:81:E0:D1:4D:8E:08:7D:EC:FB:25:C0:6C:DC:F6:5D`
- Add it in Firebase Console → Project Settings → Your apps → Android app → SHA certificate fingerprints

## Still Not Working?

1. Check console logs when you try to sign in
2. Look for the debug messages starting with "Starting Google Sign-In..."
3. Share the error message you see after "Firebase Auth Exception:"

