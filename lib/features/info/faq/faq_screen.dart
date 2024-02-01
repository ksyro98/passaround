import 'package:flutter/material.dart';
import 'package:passaround/features/info/faq/faq.dart';
import 'package:passaround/features/info/info_container.dart';

class FaqScreen extends StatelessWidget {
  final List<int> expandedQuestions;

  const FaqScreen({super.key, required this.expandedQuestions});

  @override
  Widget build(BuildContext context) {
    return InfoContainer(child: Faq(expandedQuestions: expandedQuestions));
  }
}
