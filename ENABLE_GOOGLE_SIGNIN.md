# How to Enable Google Sign-In in Firebase Console

## Quick Steps:

1. **Go to Firebase Console**
   - Visit: https://console.firebase.google.com/
   - Login with your Google account

2. **Select Your Project**
   - Project ID: **weatherapp-66e7b**
   - Project Name: **weatherapp-66e7b**

3. **Navigate to Authentication**
   - Click on **Authentication** in the left sidebar
   - If you don't see it, click **Build** → **Authentication**

4. **Enable Google Sign-In Provider**
   - Click on the **Sign-in method** tab (at the top)
   - Find **Google** in the list of providers
   - Click on **Google** row

5. **Enable Google Provider**
   - Toggle the **Enable** switch to ON (it will turn blue)
   - Enter your **Project support email** (your email address)
   - This email will be shown to users during OAuth consent
   - Click **Save**

6. **Configure OAuth Consent Screen (if prompted)**
   - You may need to configure OAuth consent screen in Google Cloud Console
   - Click the link if provided, or:
   - Go to: https://console.cloud.google.com/
   - Select project: **weatherapp-66e7b**
   - Go to: **APIs & Services** → **OAuth consent screen**
   - Choose **External** user type
   - Fill required fields:
     - App name: **Weather App**
     - User support email: (your email)
     - Developer contact: (your email)
   - Add scopes: email, profile, openid
   - Click **Save and Continue**
   - Add test users (your email) if needed
   - Review and submit

7. **Verify Configuration**
   - Back in Firebase Console → Authentication → Sign-in method
   - Check that **Google** shows as **Enabled** (green checkmark)
   - Your Web API key should be visible

## After Enabling:

- ✅ Google Sign-In will be enabled for your Firebase project
- ✅ Users can sign in with their Google accounts
- ✅ The app will use Firebase Auth with Google provider

## Testing:

Once enabled:
1. Run your Flutter app
2. Click "Sign in with Google" button
3. Select your Google account
4. Grant permissions
5. You should be signed in successfully

## Common Issues:

1. **"Google Sign-In not configured"**
   - Make sure Google provider is enabled in Firebase Console
   - Verify OAuth consent screen is configured

2. **"OAuth client not found"**
   - Check that Client IDs are configured in Google Cloud Console
   - Verify authorized domains are set (for web)

3. **"Redirect URI mismatch"**
   - Add your domain to authorized domains in Firebase Console
   - For localhost, add: `localhost`

## Note:
The code implementation may need to be updated after enabling in Firebase Console due to API compatibility. Once enabled, test the Google Sign-In button in the app.

