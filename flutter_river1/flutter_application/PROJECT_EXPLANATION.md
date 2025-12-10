

## 📦 LAYER 1: CORE LAYER (`lib/core/`)

**Purpose**: Shared utilities, constants, and infrastructure code used across the app.

### 1. `core/constants/api_constants.dart`
```dart
class ApiConstants
```
- **What it does**: Stores API configuration
- **Contains**:
  - `baseUrl`: The base URL for the API (`https://fakestoreapi.com`)
  - `productsEndpoint`: The products endpoint (`/products`)
  - `getProductsUrl()`: Helper method to build full URL with optional limit
- **Why**: Centralizes API URLs so you only change them in one place

### 2. `core/constants/app_constants.dart`
```dart
enum SortType { name, price }
```
- **What it does**: Defines app-wide constants
- **Contains**: `SortType` enum for sorting products by name or price
- **Why**: Reusable constants used across the app

### 3. `core/network/api_client.dart`
```dart
class ApiClient
```
- **What it does**: Generic HTTP client for making API requests
- **Methods**:
  - `get(String endpoint)`: Fetches a single JSON object
  - `getList(String endpoint)`: Fetches a list of JSON objects
- **Why**: Reusable HTTP client that handles errors and JSON parsing
- **Dependencies**: Uses `http` package

---

## 🎯 LAYER 2: DOMAIN LAYER (`lib/domain/`)

**Purpose**: Pure business logic - NO dependencies on Flutter, HTTP, or any framework!

### 1. `domain/entities/product_entity.dart`
```dart
class ProductEntity
```
- **What it does**: Represents a Product in the business domain
- **Properties**:
  - `name`: Product name (String)
  - `price`: Product price (double)
- **Why**: This is the "pure" business object - no JSON parsing, no framework code
- **Rule**: Domain layer should NOT know about JSON, HTTP, or Flutter!

### 2. `domain/repositories/product_repository.dart`
```dart
abstract class ProductRepository
```
- **What it does**: Defines the contract (interface) for getting products
- **Method**: `getProducts({int? limit})` - Returns list of ProductEntity
- **Why**: 
  - Defines WHAT we need (get products)
  - Doesn't define HOW (that's the data layer's job)
  - Allows easy testing (can create mock implementations)

---

## 💾 LAYER 3: DATA LAYER (`lib/data/`)

**Purpose**: Handles all data operations - API calls, JSON parsing, database, etc.

### 1. `data/models/product_model.dart`
```dart
class ProductModel extends ProductEntity
```
- **What it does**: 
  - Extends `ProductEntity` (domain entity)
  - Adds JSON serialization/deserialization
- **Methods**:
  - `fromJson()`: Converts JSON to ProductModel
  - `toJson()`: Converts ProductModel to JSON
- **Why**: 
  - Handles the mapping from API response to domain entity
  - API returns `title`, we map it to `name`
  - This is where framework-specific code lives

### 2. `data/datasources/product_remote_datasource.dart`
```dart
abstract class ProductRemoteDataSource
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource
```
- **What it does**: Makes actual API calls to fetch products
- **Responsibilities**:
  - Builds the API endpoint URL
  - Calls `ApiClient.getList()` to fetch data
  - Converts JSON to `ProductModel` objects
  - Handles errors
- **Why**: Separates API call logic from business logic
- **Dependencies**: Uses `ApiClient` and `ApiConstants`

### 3. `data/repositories/product_repository_impl.dart`
```dart
class ProductRepositoryImpl implements ProductRepository
```
- **What it does**: Implements the domain repository interface
- **Responsibilities**:
  - Calls the data source to get products
  - Returns `ProductEntity` (domain objects) not `ProductModel`
  - Handles repository-level errors
- **Why**: 
  - Bridges data layer and domain layer
  - Converts `ProductModel` → `ProductEntity` (upcasting works automatically)
  - Implements the contract defined in domain layer

---

## 🎨 LAYER 4: PRESENTATION LAYER (`lib/presentation/`)

**Purpose**: UI, State Management (Riverpod), and User Interaction

### 1. `presentation/providers/product_provider.dart`
**Riverpod Providers for Dependency Injection:**

#### `apiClientProvider`
```dart
final apiClientProvider = Provider<ApiClient>
```
- **What it does**: Creates and provides `ApiClient` instance
- **Why**: Dependency injection - any widget can access the API client

#### `productRemoteDataSourceProvider`
```dart
final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>
```
- **What it does**: Creates `ProductRemoteDataSourceImpl` with injected `ApiClient`
- **Why**: Provides data source with dependencies already injected

#### `productRepositoryProvider`
```dart
final productRepositoryProvider = Provider<ProductRepositoryImpl>
```
- **What it does**: Creates `ProductRepositoryImpl` with injected data source
- **Why**: Provides repository with all dependencies

#### `productApiProvider` ⭐ MAIN PROVIDER
```dart
final productApiProvider = FutureProvider<List<ProductEntity>>
```
- **What it does**: 
  - Fetches products from API
  - Returns `AsyncValue<List<ProductEntity>>`
  - Automatically handles loading/error states
- **Why**: This is what widgets watch to get product data
- **Data Flow**: 
  ```
  Widget → productApiProvider → repository → dataSource → API → JSON → Model → Entity
  ```

### 2. `presentation/providers/sort_provider.dart`
```dart
class SortTypeNotifier extends Notifier<SortType>
final sortProductProvider = NotifierProvider<SortTypeNotifier, SortType>
```
- **What it does**: Manages the sort type state (name or price)
- **Methods**:
  - `build()`: Initial state (defaults to `SortType.name`)
  - `setSortType()`: Updates the sort type
- **Why**: Separates sorting logic from UI
- **Usage**: Widgets can read/write sort type via `ref.watch(sortProductProvider)`

### 3. `presentation/screens/home_screen.dart`
```dart
class HomeScreen extends ConsumerWidget
```
- **What it does**: Main screen displaying products list
- **Features**:
  - Displays products from API
  - Shows loading spinner while fetching
  - Shows error message if API fails
  - Pull-to-refresh functionality
  - Sort dropdown (name/price)
- **Riverpod Usage**:
  - `ref.watch(productApiProvider)` - Watches product data

  - `ref.watch(sortProductProvider)` - Watches sort type
  - `ref.invalidate(productApiProvider)` - Refreshes data
  - `ref.read(sortProductProvider.notifier).setSortType()` - Updates sort

### 4. `presentation/screens/refresh_invalidate_example_screen.dart`
```dart
class RefreshInvalidateExampleScreen extends ConsumerWidget
final randomNumberProvider = FutureProvider.autoDispose<int>
```
- **What it does**: Demonstrates `ref.invalidate()` vs `ref.refresh()`
- **Purpose**: Educational screen to understand Riverpod concepts
- **Provider**: `randomNumberProvider` - Generates random number (simulates API call)
- **Buttons**:
  - **Invalidate**: Marks provider as dirty, will rebuild when watched
  - **Refresh**: Invalidates AND immediately fetches new value

---

## 🚀 MAIN ENTRY POINT

### `main.dart`
```dart
class MyApp extends StatelessWidget
```
- **What it does**: App entry point
- **Responsibilities**:
  - Wraps app in `ProviderScope` (required for Riverpod)
  - Sets up `MaterialApp`
  - Defines which screen to show first
- **Current**: Shows `RefreshInvalidateExampleScreen` by default

---

## 🔄 DATA FLOW DIAGRAM

```
User Action (Pull to Refresh)
    ↓
HomeScreen (UI)
    ↓
ref.watch(productApiProvider) ← Riverpod Provider
    ↓
ProductRepositoryImpl (Data Layer)
    ↓
ProductRemoteDataSourceImpl (Data Layer)
    ↓
ApiClient.getList() (Core Layer)
    ↓
HTTP Request → API Server
    ↓
JSON Response
    ↓
ProductModel.fromJson() (Data Layer)
    ↓
ProductEntity (Domain Layer)
    ↓
HomeScreen displays products (Presentation Layer)
```

---

## 🎯 KEY CONCEPTS

### 1. **Dependency Injection (DI)**
- Providers create dependencies and inject them
- Example: `ProductRepositoryImpl` needs `ProductRemoteDataSource`, which needs `ApiClient`
- Riverpod providers handle this automatically

### 2. **Separation of Concerns**
- **Domain**: Business logic only
- **Data**: API calls, JSON parsing
- **Presentation**: UI and state management
- **Core**: Shared utilities

### 3. **Dependency Rule**
- **Domain** ← **Data** (Data depends on Domain)
- **Presentation** ← **Domain** (Presentation depends on Domain)
- **Presentation** ← **Data** (Presentation can use Data)
- **Core** ← Used by all layers

### 4. **Riverpod Providers**
- `Provider<T>`: Provides a value (singleton)
- `FutureProvider<T>`: Provides async data (handles loading/error)
- `NotifierProvider`: Provides state that can be updated
- `ref.watch()`: Watches provider, rebuilds when it changes
- `ref.read()`: Reads provider once (for callbacks)
- `ref.invalidate()`: Marks provider as dirty, forces rebuild
- `ref.refresh()`: Invalidates and immediately fetches new value

---

## 📝 SUMMARY BY FILE

| File | Layer | Purpose |
|------|-------|---------|
| `api_constants.dart` | Core | API URLs |
| `app_constants.dart` | Core | App constants (SortType) |
| `api_client.dart` | Core | HTTP client |
| `product_entity.dart` | Domain | Business object |
| `product_repository.dart` | Domain | Repository interface |
| `product_model.dart` | Data | JSON serialization |
| `product_remote_datasource.dart` | Data | API calls |
| `product_repository_impl.dart` | Data | Repository implementation |
| `product_provider.dart` | Presentation | Riverpod providers |
| `sort_provider.dart` | Presentation | Sort state management |
| `home_screen.dart` | Presentation | Products list UI |
| `refresh_invalidate_example_screen.dart` | Presentation | Riverpod demo |
| `main.dart` | - | App entry point |

---

## 🎓 LEARNING POINTS

1. **Clean Architecture**: Each layer has a specific responsibility
2. **Dependency Injection**: Riverpod providers manage dependencies
3. **Separation**: Domain doesn't know about Flutter/HTTP
4. **Testability**: Easy to mock repositories for testing
5. **Maintainability**: Changes in one layer don't break others

---

## 🔧 HOW TO USE

1. **To fetch products**: Use `ref.watch(productApiProvider)` in any widget
2. **To sort products**: Use `ref.read(sortProductProvider.notifier).setSortType()`
3. **To refresh data**: Use `ref.invalidate(productApiProvider)`
4. **To navigate**: Use Navigator between `HomeScreen` and `RefreshInvalidateExampleScreen`

---

This architecture makes your code:
- ✅ **Testable**: Easy to mock dependencies
- ✅ **Maintainable**: Clear separation of concerns
- ✅ **Scalable**: Easy to add new features
- ✅ **Flexible**: Can swap implementations (e.g., different API)

