# Step-by-Step: How to Encapsulate Widgets with Skeletonizer

## Current Pattern (What You Have Now)

Your current implementation shows the perfect pattern. Here's how it works step by step:

---

## Step 1: Import Skeletonizer

```dart
import 'package:skeletonizer/skeletonizer.dart';
```

---

## Step 2: Create Skeleton Widget Method

Create a method that builds a skeleton version of your actual widget:

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
          // Skeleton title - use Container with grey color
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Grey placeholder
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 10),
          // Skeleton description lines
          Container(
            height: 15,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 15,
            width: 250,  // Shorter line
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ],
      ),
    ),
  );
}
```

**Key Points:**
- Use `Container` with `Colors.grey[300]` or `Colors.grey[200]` for skeleton placeholders
- Match the structure of your actual widget
- Use same padding, margins, and layout

---

## Step 3: Wrap with Skeletonizer

Wrap your skeleton widget(s) with `Skeletonizer`:

```dart
Widget _buildSkeletonLoading() {
  return Column(
    children: [
      _buildHeader(),  // Your header (not skeletonized)
      Expanded(
        child: Skeletonizer(
          enabled: true,  // Enable skeleton effect
          child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: 5,  // Number of skeleton items
            itemBuilder: (context, index) {
              return _buildSkeletonCard();  // Your skeleton widget
            },
          ),
        ),
      ),
    ],
  );
}
```

**Key Points:**
- `Skeletonizer(enabled: true, ...)` wraps the widgets
- Use `ListView.builder` for multiple items
- Set `itemCount` to match expected data count

---

## Step 4: Use in State Management

Show skeleton when loading, actual data when loaded:

```dart
BlocBuilder<DashboardBloc, DashboardState>(
  builder: (context, state) {
    // Show skeleton when loading
    if (state is DashboardLoading) {
      return _buildSkeletonLoading();
    }

    // Show error state
    if (state is DashboardError) {
      return _buildErrorState(state.message);
    }

    // Show actual data when loaded
    if (state is DashboardLoaded) {
      return _buildLoadedState(state.data);
    }

    // Default: show skeleton
    return _buildSkeletonLoading();
  },
)
```

---

## Complete Example: Dashboard Page Pattern

### Your Current Implementation:

```dart
// 1. Import
import 'package:skeletonizer/skeletonizer.dart';

// 2. Skeleton Card Widget
Widget _buildSkeletonCard() {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [...],
    ),
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Grey containers as placeholders
          Container(
            height: 20,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          // More placeholder containers...
        ],
      ),
    ),
  );
}

// 3. Wrap with Skeletonizer
Widget _buildSkeletonLoading() {
  return Column(
    children: [
      _buildHeader(),
      Expanded(
        child: Skeletonizer(
          enabled: true,
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => _buildSkeletonCard(),
          ),
        ),
      ),
    ],
  );
}

// 4. Use in BLoC
BlocBuilder<DashboardBloc, DashboardState>(
  builder: (context, state) {
    if (state is DashboardLoading) {
      return _buildSkeletonLoading();
    }
    // ... other states
  },
)
```

---

## How to Apply to Any New Page

### Step-by-Step for New Page:

1. **Import Skeletonizer**
   ```dart
   import 'package:skeletonizer/skeletonizer.dart';
   ```

2. **Create Skeleton Widget**
   - Copy your actual widget structure
   - Replace text with `Container` widgets with grey colors
   - Keep same layout, padding, margins

3. **Wrap with Skeletonizer**
   ```dart
   Skeletonizer(
     enabled: true,
     child: YourSkeletonWidget(),
   )
   ```

4. **Show in Loading State**
   ```dart
   if (state is Loading) {
     return _buildSkeletonLoading();
   }
   ```

---

## Pattern Summary

```
1. Create skeleton widget (grey containers)
   ↓
2. Wrap with Skeletonizer(enabled: true)
   ↓
3. Use in ListView.builder for multiple items
   ↓
4. Show in loading state
```

---

## Tips for Best Results

✅ **Match Structure**: Skeleton should match actual widget layout  
✅ **Use Grey Colors**: `Colors.grey[300]` or `Colors.grey[200]` for placeholders  
✅ **Same Dimensions**: Keep same padding, margins, sizes  
✅ **Placeholder Text**: You can use text like "Loading..." - Skeletonizer will animate it  
✅ **Multiple Items**: Use `ListView.builder` with `itemCount`

---

## Example: Weather Page Pattern

```dart
// Skeleton Weather Card
Widget _buildSkeletonWeatherCard() {
  return Container(
    // Same structure as actual weather card
    child: Row(
      children: [
        // Icon placeholder
        Container(width: 70, height: 70, ...),
        // Text placeholders
        Text('Loading Location...'),
        Text('00°C'),
      ],
    ),
  );
}

// Wrap with Skeletonizer
Widget _buildSkeletonLoadingState() {
  return Skeletonizer(
    enabled: true,
    child: ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => _buildSkeletonWeatherCard(),
    ),
  );
}
```

This is exactly the pattern you're using now! 🎉

