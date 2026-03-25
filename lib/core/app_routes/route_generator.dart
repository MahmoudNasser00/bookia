import 'package:bookia/core/network/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/auth/logic/verify_source.dart';
import '../../features/auth/presentation/pages/password_change_page_successful.dart';
import '../../features/auth/presentation/pages/welcome.dart';
import '../../features/home/data/home_data_source.dart';
import '../../features/home/data/models/product_model.dart';
import '../../features/home/logic/home_cubit.dart';
import '../../features/search/data/cubit/search_cubit.dart';
import '../../features/search/data/search_data_source.dart';
import '../../features/search/presentation/pages/search_page.dart';
import 'app_routes_name.dart';

// Auth
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/verify_code_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';

// Home
import '../../features/home/presentation/pages/home_page.dart';

// Profile
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/edit_profile_page.dart';

// Cart & Checkout
import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/checkout/presentation/pages/checkout_page.dart';

// Product
import '../../features/product/presentation/pages/product_details_page.dart';

// Splash
import '../../features/splash/presentation/pages/splash_page.dart';

class RouteGenerator {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      /// Splash
      case AppRoutes.splash:
        return _route(settings, const SplashPage());

      /// Auth
      case AppRoutes.login:
        return _route(settings, const LoginPage());
      case AppRoutes.WelcomeScreen:
        return _route(settings, const WelcomeScreen());

      case AppRoutes.register:
        return _route(settings, const RegisterPage());

      case AppRoutes.forgotPassword:
        return _route(settings, const ForgotPasswordPage());

      case AppRoutes.verifyCode:
        final args = settings.arguments as Map<String, dynamic>;

        final source = args["source"] as VerifySource;
        final email = args["email"] as String;

        return _route(settings, VerifyCodePage(source: source, email: email));

      case AppRoutes.resetPassword:
        final verify_code = settings.arguments as String;
        return _route(settings, ResetPasswordPage(verify_code: verify_code));
      case AppRoutes.passwordChange:
        return _route(settings, const PasswordChangePage());

      /// Home
      case AppRoutes.home:
        return _route(
          settings,
          BlocProvider(
            create: (context) =>
                HomeCubit(HomeDataSource(ApiClient()))..loadHome(),
            child: const HomePage(),
          ),
        );
      case AppRoutes.search:
        return _route(
          settings,
          BlocProvider(
            create: (context) => SearchCubit(SearchDataSource(ApiClient())),
            child: const SearchPage(),
          ),
        );

      /// Product Details (with arguments)
      case AppRoutes.productDetails:
        final product = settings.arguments as ProductModel;

        return _route(settings, ProductDetailsPage(product: product));

      /// Cart
      case AppRoutes.cart:
        return _route(settings, const CartTab());

      /// Checkout
      case AppRoutes.checkout:
        return _route(settings, const CheckoutPage());

      /// Profile
      case AppRoutes.profile:
        return _route(settings, const ProfileTab());

      case AppRoutes.editProfile:
        return _route(settings, const EditProfilePage());

      /// Default
      default:
        return _route(settings, const UnknownRoutePage());
    }
  }

  static MaterialPageRoute _route(RouteSettings settings, Widget page) {
    return MaterialPageRoute(settings: settings, builder: (_) => page);
  }
}

/// Unknown Route Screen
class UnknownRoutePage extends StatelessWidget {
  const UnknownRoutePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Route Not Found')));
  }
}
