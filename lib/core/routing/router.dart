import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fresh_shelf/core/routing/route_path.dart';
import 'package:fresh_shelf/layers/view/home_screen.dart';
import 'package:fresh_shelf/layers/view/screens/auth/login_screen.dart';
import 'package:fresh_shelf/layers/view/screens/auth/setup_profile_screen.dart';
import 'package:fresh_shelf/layers/view/screens/auth/signup_screen.dart';
import 'package:fresh_shelf/layers/view/screens/cart/submit_screen.dart';
import 'package:fresh_shelf/layers/view/screens/intro/splash_screen.dart';
import 'package:fresh_shelf/layers/view/screens/settings/address_screen.dart';
import 'package:fresh_shelf/layers/view/screens/settings/bills_screen.dart';
import 'package:fresh_shelf/layers/view/screens/settings/update_profile.dart';
import 'package:fresh_shelf/layers/view/screens/sub_category/sub_category.dart';

import '../../layers/view/screens/settings/app_language_screen.dart';
import '../../layers/view/screens/settings/bill_details_screen.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RoutePaths.SubCategory:
        final arguments = settings.arguments ?? <String, dynamic>{} as Map;

        return MaterialPageRoute(
            builder: (_) => SubCategoryScreen(
                  categoryId: (arguments as Map)["categoryId"],
                ));
      case RoutePaths.SubmitCart:
        return MaterialPageRoute(builder: (_) => SubmitCartScreen());
      case RoutePaths.SplashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RoutePaths.LogIn:
        return MaterialPageRoute(builder: (_) => LogInScreen());
      case RoutePaths.SignUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case RoutePaths.SetUpProfileScreen:
        return MaterialPageRoute(builder: (_) => SetUpProfileScreen());
      case RoutePaths.UpdateProfile:
        return MaterialPageRoute(builder: (_) => UpdateProfileScreen());
      case RoutePaths.AddressScreen:
        return MaterialPageRoute(builder: (_) => AddressScreen());
      case RoutePaths.BillsScreen:
        return MaterialPageRoute(builder: (_) => BillsScreen());
      case RoutePaths.BillDetailScreen:
        return MaterialPageRoute(builder: (_) => BillDetailScreen());
      case RoutePaths.AppLanguageScreen:
        return MaterialPageRoute(builder: (_) => AppLanguageScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
                // child: Text('No route defined for ${settings.name}'),
                ),
          ),
        );
    }
  }
}
