import 'package:find_pe/common/db/cache.dart';
import 'package:find_pe/pages/home_page.dart';
import 'package:go_router/go_router.dart';


abstract class Routes {
  static const permissionPage = '/permissionPage';
  static const donePage = '/donePage';

//////////////////////////////////////////////////////////
  static const passCodePage = '/passCodePage';
  static const initialPassCodePage = '/initialPassCodePage';
  static const homeScreen = '/homeScreen';
///////////////////////////////////////////////////////
  static const loginScreen = '/loginScreen';
  static const verfySMS = '/verfySMS';
  static const register = '/register';
///////////////////////////////////////////////////////

  static const civilPage = '/civilPage';
  static const taxiPage = '/taxiPage';
  static const taxiDeliveryPage = '/taxiDeliveryPage';
  static const civilAccountPage = '/civilAccountPage';
  static const civilfind_peHistoryPage = '/civilfind_peHistoryPage';
  static const nearCars = '/nearCars';
  static const nearTrucks = '/nearTrucks';

///////////////////////////////////////////////////////
  static const roleSelect = '/roleSelect';
  static const enterDetailInfo = '/enterDetailInfo';
///////////////////////////////////////////////////////
  static const taxiDriverPage = '/taxiDriverPage';

  static const taxiBalancePage = '/taxiBalancePage';
  static const paymentStatus = '/paymentStatus';
  static const paymentHistory = '/paymentHistory';
  static const accountDetailInfoPage = '/accountDetailInfoPage';
  static const tarifsPage = '/tarifsPage';
  static const settingsPage = '/settingsPage';
  static const chatPageTaxi = '/chatPageTaxi';

  ///////////////////////////////////////////////////////

  static const truckDriverPage = '/truckDriverPage';

  static const testPage = '/testPage';
  static const yandex_map_truck = '/yandex_map_truck';

  static const appInfo = '/appInfo';
}

String _initialLocation() {
   return Routes.homeScreen;

  final permission = cache.getBool("permission");
  final userToken = cache.getString("user_token");

  if (userToken != null) {
    return Routes.homeScreen;
  } else {
    if (permission == false || permission == null) {
      return Routes.permissionPage;
    }
    return Routes.loginScreen;
  }
}

Object? _initialExtra() {
  return {};
}

final router = GoRouter(
  initialLocation: _initialLocation(),
  initialExtra: _initialExtra(),
  routes: [
    GoRoute(
      path: Routes.homeScreen,
      builder: (context, state) => const HomePage(),
    ),
   
  ],
);
