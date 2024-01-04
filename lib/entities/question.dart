class FrequentlyAskedQuestion {
  final String question;
  final String? shortAnswer;
  final String fullAnswer;
  bool expanded;

  FrequentlyAskedQuestion({
    required this.question,
    this.shortAnswer,
    required this.fullAnswer,
    this.expanded = false,
  });
}
