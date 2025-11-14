# Step-by-Step Guide: Encapsulate Widgets with Skeletonizer

## Overview
This guide shows you how to wrap any widget with Skeletonizer to create loading states.

## Step 1: Import Skeletonizer

Add this import to your page:
```dart
import 'package:skeletonizer/skeletonizer.dart';
```

## Step 2: Create Your Skeleton Widget

Create a widget that looks like your actual content, but with placeholder text/values:

```dart
Widget _buildSkeletonCard() {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Skeleton title - use placeholder text
          Text(
            'Loading Title...',  // Placeholder text
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3C72),
            ),
          ),
          SizedBox(height: 10),
          // Skeleton description
          Text(
            'Loading Description...',  // Placeholder text
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    ),
  );
}
```

## Step 3: Wrap with Skeletonizer

Wrap your skeleton widget(s) with `Skeletonizer`:

```dart
Widget _buildSkeletonLoading() {
  return Skeletonizer(
    enabled: true,  // Enable skeleton effect
    child: ListView.builder(
      itemCount: 5,  // Number of skeleton items
      itemBuilder: (context, index) {
        return _buildSkeletonCard();  // Your skeleton widget
      },
    ),
  );
}
```

## Step 4: Use in Your BLoC Builder

Show skeleton when loading, actual data when loaded:

```dart
BlocBuilder<YourBloc, YourState>(
  builder: (context, state) {
    if (state is Loading) {
      return _buildSkeletonLoading();  // Show skeleton
    }
    
    if (state is Loaded) {
      return _buildLoadedState(state.data);  // Show actual data
    }
    
    return _buildSkeletonLoading();  // Default to skeleton
  },
)
```

## Complete Example: Dashboard Page

### Step 1: Import
```dart
import 'package:skeletonizer/skeletonizer.dart';
```

### Step 2: Create Skeleton Widget
```dart
Widget _buildSkeletonCard() {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
    ),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text('Loading Title...'),  // Placeholder
          SizedBox(height: 10),
          Text('Loading Description...'),  // Placeholder
        ],
      ),
    ),
  );
}
```

### Step 3: Wrap with Skeletonizer
```dart
Widget _buildSkeletonLoading() {
  return Skeletonizer(
    enabled: true,
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return _buildSkeletonCard();
      },
    ),
  );
}
```

### Step 4: Use in State Management
```dart
BlocBuilder<DashboardBloc, DashboardState>(
  builder: (context, state) {
    if (state is DashboardLoading) {
      return _buildSkeletonLoading();
    }
    // ... rest of states
  },
)
```

## Key Points

1. **Placeholder Text**: Use descriptive placeholder text like "Loading..." that will be skeletonized
2. **Same Structure**: Make skeleton widget structure match your actual data widget
3. **Skeletonizer Wrapper**: Always wrap with `Skeletonizer(enabled: true, ...)`
4. **List Items**: Use `ListView.builder` for multiple skeleton items
5. **Conditional Display**: Show skeleton in loading state, actual data in loaded state

## Tips

- ✅ Use placeholder text that describes what's loading
- ✅ Match the layout structure of your actual content
- ✅ Use same colors and styling as your real widgets
- ✅ Set `itemCount` to match expected number of items
- ✅ Keep skeleton simple - Skeletonizer will animate it

## Common Patterns

### Pattern 1: List of Cards
```dart
Skeletonizer(
  enabled: true,
  child: ListView.builder(
    itemCount: 5,
    itemBuilder: (context, index) => YourSkeletonCard(),
  ),
)
```

### Pattern 2: Single Widget
```dart
Skeletonizer(
  enabled: true,
  child: YourSkeletonWidget(),
)
```

### Pattern 3: Grid
```dart
Skeletonizer(
  enabled: true,
  child: GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemCount: 6,
    itemBuilder: (context, index) => YourSkeletonCard(),
  ),
)
```

