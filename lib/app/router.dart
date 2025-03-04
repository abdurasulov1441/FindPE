import 'package:find_pe/pages/home_page.dart';
import 'package:go_router/go_router.dart';


abstract class Routes {

  static const homePage = '/homePage';



}

String _initialLocation() {
   return Routes.homePage;


}

Object? _initialExtra() {
  return {};
}

final router = GoRouter(
  initialLocation: _initialLocation(),
  initialExtra: _initialExtra(),
  routes: [
   
    GoRoute(
      path: Routes.homePage,
      builder: (context, state) => const HomePage(),
    ),
   
   
  ],
);
