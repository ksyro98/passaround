import 'package:go_router/go_router.dart';
import 'package:passaround/features/info/faq/faq_screen.dart';
import 'package:passaround/navigation/navigation_base.dart';

class FaqGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'faq';
  static const String path = '/faq';

  @override
  GoRoute get() => GoRoute(name: name, path: path, builder: (context, state) => const FaqScreen());
}
