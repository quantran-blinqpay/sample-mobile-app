# Augment Rules for Flutter Project

## Runtime & Environment
- Target **Flutter 3.5.2** and **Dart 2.17.x**.
- Do **not** use any Flutter APIs, widgets, or features introduced **after 3.5.2**.
- Code must compile and run in Flutter 3.5.2 without modification.

## Widgets & UI
- Use **Material 2** components only.  
  - ✅ Use: `ElevatedButton`, `TextButton`, `OutlinedButton`  
  - ❌ Do not use: `FilledButton`, `SegmentedButton`, `WidgetStateProperty` (Material 3)
- Use `Theme.of(context)` for colors, typography, etc.
- Do not use Material 3 specific constructors or parameters.

## Language & SDK
- Dart **2.17.x** features only.  
  - ✅ Null-safety  
  - ✅ Enhanced enums  
  - ❌ Do not use records, patterns, sealed classes, or other Dart 3 features.

## Packages
- Use only dependencies compatible with Flutter 3.5.2.
- Always declare dependencies in `pubspec.yaml` with explicit versions.

## Code Style
- Follow Flutter best practices:
  - Keep widgets small and composable.
  - Use `const` constructors whenever possible.
  - Use `StatefulWidget` only if local state is required.
- Code must pass `flutter analyze` without warnings on Flutter 3.5.2.

## Testing
- Generate tests with `flutter_test` where possible.
- Ensure tests run successfully in Flutter 3.5.2.

## API Usage
- Follow `/docs/recombee-session.md` for endpoints, headers, params, and responses.
- Do not invent undocumented fields.

- Follow `/docs/recommend-items.md` for endpoints, headers, params, and responses.
- Do not invent undocumented fields.

- Follow `/docs/recommend-next-items.md` for endpoints, headers, params, and responses.
- Do not invent undocumented fields.

## Rules for Each Layer

### Data Layer
- Contains **parameter models** (request DTOs) and **response models** (parsed API results).
- Use `json_serializable` or manual `fromJson`/`toJson`.
- Must not contain business logic.

### Domain Layer
- Contains **repository interfaces** (abstract classes) and their implementations.
- Handles mapping between `data` and business entities.
- Must not import `presentation` layer.

### Presentation Layer
- Contains **UI widgets**, **Cubit/BLoC classes**, and screen entrypoints.
- Cubits consume domain repositories, never directly call `data`.
- Widgets are stateless unless local state is required.

## General Guidelines
- Maintain **Flutter 3.5.2** compatibility (no Material 3, no Dart 3 features).
- Always separate concerns: 
  - `presentation` → UI & state  
  - `domain` → business rules  
  - `data` → API, persistence, models  
- Each feature should have its own subfolder inside `presentation` (e.g., `presentation/product/`).
---

## Example: Feature "Products"
lib/
├── data/
│    ├── parameter/
│    │     └── product_parameter.dart
│    └── response/
│          └── product_response.dart
│
├── domain/
│    └── repository/
│          └── product_repository.dart
│
└── presentation/
├── cubit/
│     └── product_cubit.dart
├── widgets/
│     └── product_card.dart
└── products_page.dart

# Pagination Rule

## Folder Structure
- **data**
  - `parameter/`
  - `response/`
- **domain**
  - `repository/`
- **presentation**
  - `widgets/`
  - `cubit/`
  - `pages/`

---

## Pagination Behavior

### Cubit (`HomeCubit`)
- Must manage three operations:
  - **loadRecombeeSession()**
    - Fetches sessionId if not available.
    - Emits `ProgressStatus.success` or `failure`.
  - **loadRecommendedItems()**
    - Initial fetch of items.
    - Emits:
      - `ProgressStatus.inProgress` → before request
      - `ProgressStatus.success` → with items, recommId, `canLoadMoreItems = true`
      - `ProgressStatus.failure` → if error
    - Uses `RefreshController`:
      - `loadComplete()` if items are fetched.
      - `loadNoData()` if no items.
      - `loadFailed()` on error.
  - **loadNextItems()**
    - Called when user scrolls down.
    - Appends `data.recomms` into `state.recommendedItems`.
    - Emits:
      - `ProgressStatus.inProgress`
      - `ProgressStatus.success` (with updated items, recommId, canLoadMoreItems flag).
      - `ProgressStatus.failure`
    - Uses `RefreshController` same as above.

### Repository (`HomeRepository`)
- Must define:
  - `Future<Either<Failure, String>> loadRecombeeSession()`
  - `Future<Either<Failure, RecommendedItems?>> loadRecommendedItems(String recombeeSessionId)`
  - `Future<Either<Failure, RecommendedItems?>> loadNextItems(String recommId)`
- Implementation must:
  - Handle Dio requests via `NoTokenService`.
  - Return `Right` when `success == true` or `recommId` is valid.
  - Return `Left(Failure)` on error.

### Service (`NoTokenService`)
- API Endpoints:
  - `POST /api/recombee/session`
  - `GET /api/recombee/recommend-items`
  - `GET /api/recombee/recommend-next-items`
- Must support:
  - Headers: `Accept: application/vnd.dw.v1.4+json`
  - Queries: `scenario`, `locale`, `item_id`, `recomm_id`

---

## Presentation Layer

### Widget (`RecommendedForYouWidget`)
- Uses `SliverGrid` to render product tiles.
- Must support infinite scrolling with **pull-to-refresh** or **load more**:
  - Call `cubit.loadRecommendedItems()` on refresh.
  - Call `cubit.loadNextItems()` when scrolling to bottom.

---

## State Management
- State must contain:
  - `sessionId`
  - `recommId`
  - `recommendedItems`
  - `canLoadMoreItems`
  - `fetchRecombeeSession`
  - `fetchRecommendedItemsStatus`
  - `fetchNextItemsStatus`
  - `refreshController`

---

## Error Handling
- If session fetch fails, return empty `sessionId` and retry on next call.
- If recommended items or next items fail:
  - Emit failure status.
  - Call `refreshController.loadFailed()`.

---
---