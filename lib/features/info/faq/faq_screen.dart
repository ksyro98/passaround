import 'package:flutter/material.dart';
import 'package:passaround/features/info/faq/faq.dart';
import 'package:passaround/features/info/info_container.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoContainer(child: Faq());
  }
}
