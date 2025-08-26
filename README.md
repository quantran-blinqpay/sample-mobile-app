# vinhcine

# BLoC-app boilerplate

This repo is a boilerplate to create flutter application easily. It is based on **BLoC**. More info about [Bloc](https://bloclibrary.dev/#/) here. The app has been setup to work with [retrofit](https://pub.dev/packages/retrofit), [dio](https://pub.dev/packages/dio), [json_annotation](https://pub.dev/packages/json_annotation), [intl_utils](https://pub.dev/packages/intl_utils) and [shimmer](https://pub.dev/packages/shimmer)

## Getting Started

1. Install [Flutter SDK](https://flutter.dev/docs/get-started/install). Require Flutter 3.3.0
2. Install [11](https://www.oracle.com/java/technologies/downloads/#java11-mac). Require Java 11 or above
3. Install plugins in Android Studio
   - [Dart Data Class](https://plugins.jetbrains.com/plugin/12429-dart-data-class)
   - [Flutter Intl](https://plugins.jetbrains.com/plugin/13666-flutter-intl)
   - [BLoC](https://plugins.jetbrains.com/plugin/12129-bloc)
4. Clone the repo.
5. Run `flutter pub get`
6. Run `flutter pub run intl_utils:generate`
7. Run `flutter pub run build_runner build --delete-conflicting-outputs`
8. Run `fluttergen`
9. Run app.
   - `flutter run -t lib/main.dart --flavor dev --dart-define=FLAVOR=dev --dart-define=BASE_URL=http://192.168.16.15:8200`
   - `flutter run -t lib/main.dart --flavor prod --dart-define=FLAVOR=prod --dart-define=BASE_URL=http://api.vinhcine.vn`

## File structure

```
assets
└───translations
│   └───en.json
│   └───vi.json
└───fonts
└───images
|    └───2.0x
|    └───3.0x
└───svgs

src
└───components
│   └───appbar
│   └───button
│   └───loading_indicator
│   └───scaffold
│   └───text_field
└───configs
│   └───app_configs
│   │   └───app_config.dart
│   └───app_themes
│       └───app_colors.dart
│       └───app_fonts.dart
│       └───app_shadow.dart
│       └───app_styles.dart
│       └───app_themes.dart
│       └───default_themes.dart
└───core
│   └───constants
│   └───di
│   └───exceptions
│   └───extensions
│   └───failures
│   └───global
│   └───network
│   └───shared_prefs
│   └───utils
└───features
│   └───authentication
│   │   └───data
│   │   │   └───remote
│   │   │   │   └───dtos
│   │   │   │   │   └───profile_dto.dart
│   │   │   │   │   └───register_dto.dart
│   │   │   │   └───services
│   │   │   │       └───auth_service.dart
│   │   │   │       └───auth_service_no_token.dart
│   │   └───domain
│   │   └───presentation
│   └───splash
│   └───home
└───router
│   └───routes
│   │   └───guards
│   │   │   └───secure_guards.dart
│   │   └───auth_routes.dart
│   │   └───home_routes.dart
│   │   └───...
│   └───route_names.dart
│   └───router.dart
└───main.dart
```

### main.dart

The "entry point" of program.
In general, `main.dart` contain **AppMaterial**, but this repo use **GetMaterialApp** whichs has the default MaterialApp as a child.

### assets

This folder is to store static assets like fonts, images and flavor configurations.

### common

This folder hold color, dimens, image path, shadow value, text style and theme value.

### configs

This folder hold the config of your applications.

### database

### l10n

This folder contain all localized string. [See more](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)

### models

This folder contain your entities.

### networks

Retrofit configuration all available here. [See more](https://pub.dev/packages/retrofit)

### router

This folder contain the route navigation

### services

This folder contain all GetxService or any service which can not be removed from memory.

### ui

This folder contain your pages.

### utils

This folder contain your ultilities.

## How to use

### Creating a screen.

All screen should be created in the `ui/pages` folder
User the [BLoC](https://resocoder.com/2020/08/04/flutter-bloc-cubit-tutorial/) plugin to create new screen.

#### Example: Movie Section

**Logic:** `home_tab_cubit.dart`

```java=
class HomeTabCubit extends Cubit<HomeTabState> {
  MovieRepository repository;
  final messageController = PublishSubject<String>();

  HomeTabCubit({required this.repository}) : super(WaitingForWarmingUp());

  void fetchMovieList({bool isReloaded = false}) async {
    if(!(state is FetchingDataSuccessfully) && !(state is WaitingForWarmingUp)) return;

    FetchingDataSuccessfully currentState;
    /// combine data refreshing and data loading more function together
    if(state is WaitingForWarmingUp)
      currentState = FetchingDataSuccessfully(movies: List<MovieEntity>.empty(growable: true));
    else
      currentState = state as FetchingDataSuccessfully;

    if (isReloaded)
      emit(WaitingForFetchingData());
    else
      emit(WaitingForFetchingMoreData());

    try {
      if (isReloaded) {
        currentState.currentPage = 1;
        currentState.canLoadMore = true;
      }

      if (currentState.canLoadMore != true) return;

      final response = await repository.getMovies(page: currentState.currentPage);

      if (isReloaded) {
        currentState.movies?.clear();
      }

      currentState.currentPage++;
      if (response?.results?.isNotEmpty == true) {
        currentState.movies?.addAll(response?.results ?? []);
        currentState.totalPages = response?.totalPages ?? 0;
      } else {
        currentState.canLoadMore = false;
      }

      emit(FetchingDataSuccessfully(
        movies: currentState.movies,
        currentPage: currentState.currentPage,
        totalResults: 100,
        totalPages: currentState.totalPages,
        canLoadMore: currentState.canLoadMore,
      ));

    } on Exception catch (e) {
      emit(DoAnythingFail());
    }
  }
  ...
}
```

**State:** `home_tab_state.dart`

```java=
// ignore: must_be_immutable
abstract class HomeTabState extends Equatable {
  const HomeTabState();
}

// ignore: must_be_immutable
class WaitingForWarmingUp extends HomeTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class WaitingForFetchingData extends HomeTabState {
  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class FetchingDataSuccessfully extends HomeTabState {
  List<MovieEntity>? movies;
  int currentPage;
  ...

  FetchingDataSuccessfully({
    this.movies,
    this.currentPage = 1,
  });

  @override
  List<Object> get props => [
    movies ?? [],
    currentPage,
  ];
}
```

### Creating api service.

1. Create entity object in folder `lib/models/entities`
   Ex: `movie_entity.dart`

```java=
import 'package:json_annotation/json_annotation.dart';

part 'movie_entity.g.dart';

@JsonSerializable()
class MovieEntity {
  @JsonKey()
  String? title;
  ...

  factory MovieEntity.fromJson(Map<String, dynamic> json) => _$MovieEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);
}
```

Class must have `@JsonSerializable()` for generator. Read [json_serializable](https://pub.dev/packages/json_serializable)

2. Define and Generate your API in file `lib/networks/api_client.dart`
   Ex: GET movies

```java=
  /// Movie
  @GET("/3/discover/movie")
  Future<ArrayResponse<MovieEntity>> getMovies(@Query('api_key') String apiKey, @Query('page') int page);
```

Note: Using **ArrayResponse** and **ObjectResponse** for generic response

3. Require run command line:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Create api service file for your feature in folder `lib/services/api`
   Ex: `movies_api.dart`

```java=
part of 'api_service.dart';

extension MovieApiService on ApiService {
  Future<ArrayResponse<MovieEntity>> getMovies({int page = 1}) async {
    return _apiClient.getMovies(MovieAPIConfig.APIKey, page);
  }
}
```

After, add `part 'auth_api.dart';` to `services/api/api_service`

5. You can call API in the logic of screen.
   Ex:

```java=
  final apiService = Get.find<ApiService>();
  final result = await apiService.getMovies(page: 1);
```

### Support Dark Mode and Multi Language

See **SettingService** class for more detail

![](https://i.postimg.cc/v8SL0Brk/pjimage.jpg)

## How to create a button with dark mode?

1. Declare a light/dark color pair: `createAccColor` in the `app_themes.dart` folder.

```java=
extension ColorSchemeExtension on ColorScheme {
  // light: blue - dark: violet
  Color get createAccColor => this.brightness == Brightness.light
      ? AppColors.blue
      : AppColors.violet;
}
```

2. Use `createAccColor` in the Button that supports dark mode and enjoy the results.

```java=
Widget _buildCreateAccount() {
    return AppButton(
      title: S.of(Get.context!).welcome_create_account,
      backgroundColor: Theme.of(Get.context!).colorScheme.createAccColor,
      textStyle: AppTextStyle.myStyleS16.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500),
      cornerRadius: 26,
      onPressed: _doSignUp,
    );
  }
```

### Other

#### Logger

```java=
logger.d("message"); //"💙 DEBUG: message"
logger.i("message"); //"💚 INFO: message"
logger.e("message"); //"❤️ ERROR: message"
logger.log("very very very long message");
```

#### Snackbar

```java=
AppSnackbar.showInfo(message: 'Info');
AppSnackbar.showWarning(message: 'Warning');
AppSnackbar.showError(message: 'Error');
```

#### Dialog

```java=
AppDialog.defaultDialog(
          message: "An error happened. Please check your connection!",
          textConfirm: "Retry",
          onConfirm: () {
            //Do something
          },
);
```

#### Button UI when call API

```java=
return Obx(() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: AppTintButton(
          title: 'Sign In',
          onPressed: _signIn,
          isLoading: state.signInStatus.value == LoadStatus.loading,
        ),
    );
});
```

## Refer

https://bloclibrary.dev/#/gettingstarted \
https://pub.dev/packages/bloc
