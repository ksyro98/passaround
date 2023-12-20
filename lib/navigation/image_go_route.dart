import 'package:go_router/go_router.dart';
import 'package:passaround/entities/image_item.dart';
import 'package:passaround/features/share/ui/image_full_screen/image_screen.dart';
import 'package:passaround/navigation/navigation_base.dart';

class ImageGoRoute implements NavigationBase<GoRoute> {
  static const String name = 'image';
  static const String path = '/image';

  @override
  GoRoute get() => GoRoute(
        name: name,
        path: path,
        builder: (context, state) {
          ImageItem item = state.extra as ImageItem;
          return ImageScreen(item: item);
        },
      );
}
