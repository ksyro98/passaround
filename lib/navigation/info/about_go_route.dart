import 'package:go_router/go_router.dart';
import 'package:passaround/features/info/about_screen.dart';
import 'package:passaround/navigation/navigation_base.dart';

class AboutGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'about';
  static const String path = '/about';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) => const AboutScreen());
}
