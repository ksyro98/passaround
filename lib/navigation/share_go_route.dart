import 'package:go_router/go_router.dart';
import 'package:passaround/navigation/navigation_base.dart';
import 'package:passaround/features/share/ui/share_screen.dart';

class ShareGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'share';
  static const String path = '/';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) => const ShareScreen());
}
