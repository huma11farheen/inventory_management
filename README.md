# inventory_management

A  Flutter application for inventory management.

#### Basis of Architecture

This app adopts *layered architecture*.
Each layer has several role.

```

   Backend Services (Firebase, server application, etc...)
        ↑
~~~~~~~~↑~~~~~~~~~~~~~~~~~~~~~~ Border of Device ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        ↑
        ↑ →→→→→→→→→→→→  Storage (File system or on memory)
        ↑ →→→→→→→→→→→→  Device informations
        ↑
        ↑ access
 +----------------+
 |   Repository   |   ...  Abstracting the usage of backends
 +----------------+
        ↑
        ↑ depend
        ↑
 +----------------+
 |     UseCase    |   ...  Common procedures manipulationg repositories 
 +----------------+
        ↑
        ↑ depend
        ↑
 +----------------+
 |     Domain     |   ...  Abstracting features of this app and solve the problem 
 +----------------+
        ↑
        ↑ depend
        ↑
 +----------------+
 |       UI       |   ...  Presenting states of App and recieving commands from user
 +----------------+
        ↑
        ↑ launch
        ↑
       main
```


#### State management

This app adopts *ScopedModel (Provider)* pattern to manage application/screen states of the app and implement domain logic.

To separate State and Business Logic, we will use [StateNotifier](https://pub.dev/packages/state_notifier) / [ValueNotifier](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html).

##### ViewModel

ViewModel is the class to represent the State of UI.
It's the general value class. We recommend using [`freezed`](https://pub.dev/packages/freezed) to create value classes.

```dart
@freezed
abstract class UserViewModel with _$UserViewModel {
  factory UserViewModel({
    @required String userId,
    @nullable UserDocument userDocument,
    @Default(true) bool loading,
  }) = _UserViewModel;

  @late
  bool get noUserDocument => !loading && userDocument == null;
}
```

##### Controller

Controller is the class implements Business Logic and updating State.
It should extend StateNotifier (recommended) or ValueNotifier.

```dart
class SomeController extends StateNotifier<SomeViewModel> {
  SomeController(this._repository) {
    _initialize();
  }

  final SomeRepository _repository;

  void _initialize() async {
    final data = await _repository.getSomeData();
    state = state.copyOf(data: data);
  }
}
# inventory_management
# inventory_management
