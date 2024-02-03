import 'package:flutter/material.dart';

import '../../../entities/question.dart';

class Faq extends StatefulWidget {
  final List<int> expandedQuestions;

  const Faq({super.key, required this.expandedQuestions});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final List<FrequentlyAskedQuestion> _questions = [
    FrequentlyAskedQuestion(
      question: "What is PassAround?",
      shortAnswer: "PassAround is a simple and easy way to transfer text and files between your devices",
      fullAnswer:
          "You can simply create an account and use it to send any text, image, or file. You can then log in on any other device, using the same account, and access your files from there.\nPassAround is meant to be a way to share file between devices, it is not a permanent file storage, nor online file system.",
    ),
    FrequentlyAskedQuestion(
      question: "Is PassAround free?",
      shortAnswer: "Yes.",
      fullAnswer: "PassAround is currently completely free. :)",
    ),
    FrequentlyAskedQuestion(
      question: "Do you use my data for ads or sell my data for any other reason?",
      shortAnswer: "No.",
      fullAnswer: "We believe your data is your data and we would never sell them.",
    ),
    FrequentlyAskedQuestion(
      question: "How does PassAround make money?",
      shortAnswer: "It doesn't.",
      fullAnswer:
          "Not yet at least. We might introduce subscription tiers in the future to ensure the sustainability of the app, we will always provide a free version however. We will also never sell your data or use them as a way to make money in any other way.",
    ),
    FrequentlyAskedQuestion(
      question: "Where are my data stored?",
      shortAnswer: "On Google's cloud.",
      fullAnswer:
          "Cloud is like a big server, owned often by a large company, parts of which are provided to others companies, organizations, or individuals.\nPassAround uses Firebase (firestore and firebase storage) to store your data, which is provided by Google.",
    ),
    FrequentlyAskedQuestion(
      question: "Are my data safe in PassAround?",
      shortAnswer: "Yes, but they are not encrypted.",
      fullAnswer:
          "To access your data someone needs access to your password or administrative access to the PassAround backend.\nHowever, your data are stored on PassAround's backend \"as is\". This means that when you send \"test\" the word \"test\" will be stored on the cloud. If data from the Google cloud get leaked your data might get exposed.\nThis is why we strongly recommend you not to send any sensitive data through PassAround and to delete your data often.\n\nWe intend to implement encryption soon, so stay tuned!",
    ),
    FrequentlyAskedQuestion(
      question: "How can I delete my account?",
      fullAnswer:
          "This feature will soon be added on the app.\nUntil then you can send as an email at info.thatcomeup@gmail.com.",
    ),
    FrequentlyAskedQuestion(
      question: "How can I reset my my password?",
      fullAnswer:
          "On the PassAround log-in screen tap on \"Recover password\" and follow the provided steps. You will receive an email, if you can't find it make sure to check your spam folder.",
    ),
    FrequentlyAskedQuestion(
      question: "How can I update my account details, like my email?",
      fullAnswer:
          "This feature will soon be added to the app.\nUntil then you can send as an email at info.thatcomeup@gmail.com.",
    ),
    FrequentlyAskedQuestion(
      question: "I need support with PassAround. Where can I ask for help?",
      fullAnswer:
          "Thanks for using PassAround, we're here to help! :)\nYou can send us an email at info.thatcomeup@gmail.com.",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _setInitiallyExpandedQuestions();
  }

  void _setInitiallyExpandedQuestions() {
    for (int i = 0; i < _questions.length; i++) {
      if (widget.expandedQuestions.contains(i)) {
        _questions[i].expanded = true;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 17),
          child: Text(
            "Frequently Asked Questions",
            style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.primary),
          ),
        ),
        // ...List.generate(_questions.length, (index) => _getQnATexts(_questions[index])),
        ..._questions.map((e) => _getQnATexts(e)),
      ],
    );
  }

  Widget _getQnATexts(FrequentlyAskedQuestion question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () => _toggleExpanded(question),
              icon: question.expanded
                  ? Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary)
                  : Icon(Icons.arrow_right, color: Theme.of(context).colorScheme.primary),
            ),
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _toggleExpanded(question),
                  child: Text(
                    question.question,
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
        Visibility(
          visible: question.expanded,
          child: Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (question.shortAnswer != null)
                  SelectableText(question.shortAnswer ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                SelectableText(question.fullAnswer),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  void _toggleExpanded(FrequentlyAskedQuestion question) {
    setState(() => question.expanded = !question.expanded);
  }
}
