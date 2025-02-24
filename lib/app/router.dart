import 'package:find_pe/pages/admin/admin_adding.dart';
import 'package:find_pe/pages/admin/admin_page.dart';
import 'package:find_pe/pages/auth/firebase_streem.dart';
import 'package:find_pe/pages/auth/login_screen.dart';
import 'package:find_pe/pages/home_page.dart';
import 'package:go_router/go_router.dart';


abstract class Routes {
  static const firebaseStreem = '/firebaseStreem';
  static const homePage = '/homePage';
  static const adminPage = '/adminPage';
   static const loginPage = '/loginPage';
   static const adminAdding = '/adminAdding';

//////////////////////////////////////////////////////////

}

String _initialLocation() {
   return Routes.firebaseStreem;


}

Object? _initialExtra() {
  return {};
}

final router = GoRouter(
  initialLocation: _initialLocation(),
  initialExtra: _initialExtra(),
  routes: [
     GoRoute(
      path: Routes.firebaseStreem,
      builder: (context, state) => const FirebaseStream(),
    ),
    GoRoute(
      path: Routes.homePage,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: Routes.adminPage,
      builder: (context, state) => const AdminPage(),
    ),
     GoRoute(
      path: Routes.loginPage,
      builder: (context, state) => const LoginScreen(),
    ),
     GoRoute(
      path: Routes.adminAdding,
      builder: (context, state) => const AdminAdding(),
    ),
   
   
  ],
);
