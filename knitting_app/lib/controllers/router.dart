import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:knitting_app/controllers/app_view.dart';
import 'package:knitting_app/controllers/settings/user/register.dart';
import 'package:knitting_app/controllers/settings/user/signIn.dart';
import 'package:knitting_app/models/how_to_model.dart';
import 'package:knitting_app/models/knitting_cafe_model.dart';
import 'package:knitting_app/models/product_model.dart';
import 'package:knitting_app/views/community_view/community_view.dart';
import 'package:knitting_app/views/feed_view/feed_view.dart';
import 'package:knitting_app/views/first_open_view.dart';
import 'package:knitting_app/views/model_views/howTo_view.dart';
import 'package:knitting_app/views/model_views/knitting_cafe_view.dart';
import 'package:knitting_app/views/model_views/product_view.dart';
import 'package:knitting_app/views/profile_view/profile_view.dart';
import 'package:knitting_app/views/explore_view/explore_view.dart';
import 'package:knitting_app/views/settings_view/about_us_view.dart';
import 'package:knitting_app/views/settings_view/send_us_view.dart';
import 'package:knitting_app/views/settings_view/settings_view.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';
import 'package:knitting_app/views/settings_view/sss_view.dart';
import 'package:provider/provider.dart';

// Tüm uygulama geçişleri için tek bir navigator anahtarı oluşturuyoruz.
final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._(); // Bu sınıfın örneği oluşturulmasın diye özel yapıcı fonksiyonumuz, oluşturmaya gerek yok çünkü sabitlerimiz zaten var

  static const String feed =
      '/'; // static sayesinde nesne oluşturmadan doğruca ileride AppRoutes.search diye erişebiliyoruz
  static const String search = '/search';
  static const String community = '/community';
  static const String profile = '/profile';

  static const String settings = "/settings";
  static const String aboutUs = "/aboutUs";
  static const String sendUs = "/sendUs";
  static const String signIn = '/signIn';
  static const String register = '/register';
  static const String firstOpen = '/firstOpen';
  static const String sss = '/sss';

  static const String product = 'product';
  static const String howTo = 'howTo';
  static const String knittingCafe = 'knittingCafe';
}

final router = GoRouter(
  navigatorKey:
      _routerKey, // uygulamanın herhangi bir yerinden navigatorKey.currentState üzerinden navigator'e erişme imkanı verir

  redirect: (context, state) async {
    final sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(
      context,
      listen: false,
    );

    final isFirstOpen = sharedPreferencesProvider.isFirstOpen;
    final isOnboarding =
        state.uri.path == AppRoutes.firstOpen; // şu anda sayfada mı konrolü

    if (isFirstOpen && !isOnboarding) {
      sharedPreferencesProvider.finishSetFirstOpening();
      return AppRoutes.firstOpen;
    }

    if (!isFirstOpen && isOnboarding) {
      return AppRoutes.feed;
    }

    return null;
  },

  routes: [
    GoRoute(
      path: AppRoutes.firstOpen,
      builder: (context, state) => FirstOpenView(),
    ),

    _bottomBar(),

    GoRoute(
      path: AppRoutes.settings,
      builder: (context, state) => SettingsView(),

      routes: [
        GoRoute(
          path: AppRoutes.aboutUs,
          builder: (context, state) => AboutUsView(),
        ),

        GoRoute(
          path: AppRoutes.sendUs,
          builder: (context, state) => SendUsView(),
        ),

        GoRoute(
          path: AppRoutes.signIn,
          builder: (context, state) => SignInView(),
        ),

        GoRoute(
          path: AppRoutes.register,
          builder: (context, state) => RegisterView(),
        ),

        GoRoute(path: AppRoutes.sss, builder: (context, state) => SssView()),
      ],
    ),
  ], // bottom bar ile alt barı tek seferde hallediyoruz
);

StatefulShellRoute _bottomBar() {
  // her bir sekme için bir statefulshellbranch yaratıyor ve bunları indexlenmiş stack olarak tutuyor, yani sekmeler aynı anda çalışıyor ama arka planda bekliyor.
  return StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) =>
        AppView(navigationShell: navigationShell),

    //buradaki navigationShell aktif branchi, goBRANCH(index) bilgilerini taşır
    branches: [
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.feed,
            builder: (context, state) => FeedView(),

            routes: [
              GoRoute(
                path: AppRoutes.product,
                builder: (context, state) {
                  final product = state.extra as ProductModel;
                  return ProductView(product: product);
                },
              ),

              GoRoute(
                path: AppRoutes.knittingCafe,
                builder: (context, state) {
                  final knittingCafe = state.extra as KnittingCafeModel;
                  return KnittingCafeView(knittingCafe: knittingCafe);
                },
              ),
            ],
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.search,
            builder: (context, state) => const ExploreView(),

            routes: [
              GoRoute(
                path: AppRoutes.howTo,
                builder: (context, state) {
                  final howTo = state.extra as HowToModel;
                  return HowToView(howTo: howTo);
                },
              ),
            ],
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.community,
            builder: (context, state) => const CommunityView(),
          ),
        ],
      ),

      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileView(),
          ),
        ],
      ),
    ],
  );
}
