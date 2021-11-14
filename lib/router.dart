import 'package:flutter/material.dart';
import 'package:inventory_management/ui/home_page/home_page.dart';
import 'package:inventory_management/ui/list_details/supplier_page/add_new_supplier.dart';
import 'package:inventory_management/ui/list_details/supplier_page/supplier_list.dart';
import 'package:inventory_management/ui/list_details/supplier_page/supplier_page.dart';
import 'package:inventory_management/ui/login_page/login_page.dart';
import 'package:inventory_management/ui/raw_material/raw_material_history.dart';
import 'package:inventory_management/ui/sign_in/sign_in.dart';
import 'package:inventory_management/ui/splash_page.dart';
import 'package:recase/recase.dart';

/// A builder function to build page.
typedef WidgetPageBuilder = Widget Function(
  BuildContext context,
  RouteSettings settings,
);

/// A configuration of Route
class RouteConfiguration {
  final WidgetPageBuilder builder;

  final String screenName;

  RouteConfiguration({
    @required this.builder,
    this.screenName,
  });
}

/// A shorthand method to generate [RouteConfiguration] with [PageRouteType.material].
RouteConfiguration _standardRoute(WidgetPageBuilder b) =>
    RouteConfiguration(builder: b);

// ignore: one_member_abstracts
abstract class RouterInterface {
  Route<dynamic> onGenerateRoute(RouteSettings _settings);
}

// ignore: one_member_abstracts
abstract class ScreenNameInterface {
  String extractScreenName(RouteSettings settings);
}

/// A router which provides routing table for MaterialApp.
class GlobalRouter implements RouterInterface, ScreenNameInterface {
  final bool shouldShowDebugMenu;

  GlobalRouter({this.shouldShowDebugMenu});

  final _routes = <String, RouteConfiguration>{
    SplashPage.routeName: _standardRoute(
      (context, settings) => const SplashPage(),
    ),
    SupplierPage.routeName: _standardRoute(
      (context, settings) =>
          SupplierPage.wrapped(settings.arguments as SupplierPageArgument),
    ),
    SignInPage.routeName: _standardRoute(
      (context, settings) => SignInPage.wrapped(),
    ),
    HomePage.routeName: _standardRoute(
      (context, settings) => const HomePage(),
    ),
    SignUpPage.routeName: _standardRoute(
      (context, settings) => SignUpPage.wrapped(),
    ),
    SupplierListPage.routeName: _standardRoute(
      (context, settings) => SupplierListPage.wrapped(),
    ),
    AddNewSupplier.routeName: _standardRoute(
      (context, settings) => const AddNewSupplier(),
    ),
    RawMaterialHistory.routeName: _standardRoute(
      (context, settings) => const RawMaterialHistory(),
    ),
  };

  /// Provides control routing table
  @override
  Route<dynamic> onGenerateRoute(RouteSettings _settings) {
    final routeBuilder = _routes[_settings.name];

    if (routeBuilder == null) {
      assert(false, 'unexpected settings: $_settings');

      return null;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) => routeBuilder.builder(context, _settings),
      settings: _settings,
      fullscreenDialog: true,
    );
  }

  @override
  String extractScreenName(RouteSettings settings) {
    final routeConfig = _routes[settings.name];
    if (routeConfig == null) {
      // note: if the screen isn't defined by us, it'll not be recorded.
      return null;
    }
    final screenName = routeConfig.screenName;

    return screenName ?? convertPathToScreenName(settings.name);
  }

  static const pathSeparator = "/";

  static String convertPathToScreenName(String path) {
    var screenName = path;
    if (screenName.startsWith(pathSeparator)) {
      screenName = screenName.replaceFirst(pathSeparator, "");
    }
    if (screenName.isEmpty) {
      screenName = "(root)";
    }
    return screenName.snakeCase;
  }
}
