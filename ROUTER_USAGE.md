# GoRouter Usage Guide

## How the Router Works

The app uses **GoRouter** for navigation. This allows you to navigate between pages using URLs and provides better control over navigation flow.

## Setup

The router is configured in `lib/router/app_router.dart` and connected in `lib/main.dart` using `MaterialApp.router`.

## Available Routes

- `/` - Splash screen (SplashAnimated)
- `/login` - Login page
- `/weather` - Weather page (protected - requires authentication)
- `/notify` - Notification page
- `/another` - Page Two
- `/pagetwo` - Alias that redirects to `/another`

## How to Navigate

### 1. Import GoRouter

```dart
import 'package:go_router/go_router.dart';
```

### 2. Navigation Methods

#### `context.go('/route')` - Replace current route
Use this to navigate to a new page and replace the current one in the stack.

```dart
ElevatedButton(
  onPressed: () {
    context.go('/weather');  // Navigate to weather page
  },
  child: Text('Go to Weather'),
)
```

#### `context.push('/route')` - Push new route (keeps current in stack)
Use this to navigate to a new page while keeping the current page in the stack (you can go back).

```dart
ElevatedButton(
  onPressed: () {
    context.push('/notify');  // Push notify page (can go back)
  },
  child: Text('View Notifications'),
)
```

#### `context.pop()` - Go back
Use this to go back to the previous page.

```dart
ElevatedButton(
  onPressed: () {
    context.pop();  // Go back
  },
  child: Text('Back'),
)
```

#### `context.goNamed('routeName')` - Navigate by route name
Use this to navigate using the route name instead of path.

```dart
ElevatedButton(
  onPressed: () {
    context.goNamed('weather');  // Navigate using route name
  },
  child: Text('Go to Weather'),
)
```

## Examples

### Example 1: Navigate from Weather Page to Notify Page

```dart
import 'package:go_router/go_router.dart';

// In your widget
ElevatedButton(
  onPressed: () {
    context.push('/notify');
  },
  child: Text('View Notifications'),
)
```

### Example 2: Navigate after Login

The router automatically redirects after login based on authentication state. You don't need to manually navigate - the redirect logic handles it.

### Example 3: Navigate from Notification to Another Page

```dart
// In notifypage.dart
ElevatedButton(
  onPressed: () {
    context.push('/another');  // Push Page Two
  },
  child: Text('Go to Page 2'),
)
```

### Example 4: Navigate from Anywhere (without BuildContext)

```dart
import 'package:flutterweather/router/app_router.dart';

// Get router instance
final router = AppRouter.router;
if (router != null) {
  router.go('/weather');
}
```

## Automatic Redirects

The router automatically handles redirects based on authentication:

- **If authenticated** and trying to access `/login` → redirects to `/weather`
- **If unauthenticated** and trying to access protected routes → redirects to `/login`
- **If authenticated** and going to `/` (splash) → redirects to `/weather`
- **If loading/initial** state → stays on `/` (splash)

## Current Implementation

✅ Router is set up in `main.dart` using `MaterialApp.router`
✅ Routes are defined in `app_router.dart`
✅ Navigation is used in:
   - `notifypage.dart` - uses `context.push('/another')`
   - `animated.dart` - uses `context.go('/weather')` or `context.go('/login')`

## Troubleshooting

### Router not working?
1. Make sure you're using `MaterialApp.router` (not `MaterialApp`)
2. Make sure `routerConfig` is set: `routerConfig: AppRouter.createRouter(context)`
3. Make sure you import `go_router`: `import 'package:go_router/go_router.dart';`
4. Make sure you have `go_router` in your `pubspec.yaml`

### Navigation not happening?
1. Check if the route exists in `app_router.dart`
2. Check if you're using the correct path (e.g., `/weather` not `/weather/`)
3. Check console for any errors

## Testing Navigation

You can test navigation by:
1. Adding buttons with `context.go()` or `context.push()`
2. Using the browser URL bar (on web) to navigate directly
3. Checking the navigation stack

