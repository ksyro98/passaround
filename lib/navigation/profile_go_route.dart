import 'package:go_router/go_router.dart';

import '../features/profile/ui/profile_screen.dart';
import 'navigation_base.dart';

class ProfileGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'user';
  static const String path = '/user/:id';

  @override
  GoRoute get() => GoRoute(
        name: name,
        path: path,
        builder: (context, state) => ProfileScreen(id: state.pathParameters["id"] ?? ""),
      );
}
