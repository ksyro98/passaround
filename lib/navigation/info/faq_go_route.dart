import 'package:go_router/go_router.dart';
import 'package:passaround/features/info/faq/faq_screen.dart';
import 'package:passaround/navigation/navigation_base.dart';
import 'package:passaround/utils/logger.dart';

class FaqGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'faq';
  static const String path = '/faq';

  @override
  GoRoute get() => GoRoute(
        name: name,
        path: path,
        builder: (context, state) {
          Logger.lPrint(state.pathParameters);
          final expandedQs = state.uri.queryParameters["expanded"]?.split("_").map((e) => int.parse(e)).toList() ?? [];
          return FaqScreen(expandedQuestions: expandedQs);
        },
      );
}
