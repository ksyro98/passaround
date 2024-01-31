import 'package:flutter/material.dart';

class SingleChildScrollViewForColumn extends StatelessWidget {
  final Column column;
  final EdgeInsets? padding;

  const SingleChildScrollViewForColumn({super.key, required this.column, this.padding});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: padding ?? const EdgeInsets.all(0),
                child: column,
              ),
            ),
          ),
        );
      },
    );
  }
}
