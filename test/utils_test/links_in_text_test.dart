import 'package:flutter_test/flutter_test.dart';
import 'package:passaround/utils/links_in_text/link_manager.dart';

void main() {
  group("can match a URL link", () {
    const succeedingTestCases = [
      'http://www.example.com',
      'https://www.example.com/path/to/page',
      'www.example.com',
      'www.subdomain.example.co.uk',
      'http://sub.domain.example.com',
      'https://sub.domain.example.com/path/to/page',
      'http://www.example.com/page?query=param',
    ];

    const failingTestCases = [
      'invalid-url', // Should not match
      // this fails, ignore it for now
      // 'http://www.invalid-.com', // Should not match (invalid domain)
    ];

    const multipleTestCases = [
      {
        "text":
            "This is a reflection w/ https://en.wikipedia.org/wiki/2 links. https://www.dictionary.com/browse/look!",
        "links": 2,
      },
      {
        "text": "https://en.wikipedia.org/wiki/2 links. https://www.dictionary.com/browse/look!",
        "links": 2,
      },
      {
        "text": "This is a reflection w/ https://en.wikipedia.org/wiki/2https://www.dictionary.com/browse/look!",
        "links": 1,
      },
      {
        // multiple links without spaces cannot be separated
        "text":
            "This is a reflection w/ https://en.wikipedia.org/wiki/2https://en.wikipedia.org/wiki/2https://en.wikipedia.org/wiki/2https://en.wikipedia.org/wiki/2https://www.dictionary.com/browse/look!",
        "links": 1,
      },
      {
        "text": "This is a reflection w/ no links.",
        "links": 0,
      },
      {
        "text": "This is a reflection w/ https://en.wikipedia.org/wiki/2 links. https://www.dictionary.com/browse/look",
        "links": 2,
      },
      {
        "text":
            "This is a reflection w/ https://en.wikipedia.org/wiki/2 links. https://www.dictionary.com/browse/lookhttps://www.dictionary.com/browse/lookhttps://www.dictionary.com/browse/look",
        "links": 2,
      },
      {
        "text": "This is a reflection w/ https://en.wikipedia.org/wiki/2 links.",
        "links": 1,
      },
      {
        "text": "https://en.wikipedia.org/wiki/2",
        "links": 1,
      },
    ];

    succeedingTestCases.forEach(successfullyMatchSingleUrlTest);
    failingTestCases.forEach(unsuccessfullyMatchSingleUrlTest);
    multipleTestCases.forEach(matchMultipleUrlTest);
  });

  group("can match a Markup link", () {
    const testCases = [
      {
        "text":
            "This is a reflection w/ [two](https://en.wikipedia.org/wiki/2) links. [Look](https://www.dictionary.com/browse/look)!",
        "links": 2,
      },
      {
        "text": "[two](https://en.wikipedia.org/wiki/2) links. [Look](https://www.dictionary.com/browse/look)!",
        "links": 2,
      },
      {
        "text":
            "This is a reflection w/ [two](https://en.wikipedia.org/wiki/2)[Look](https://www.dictionary.com/browse/look)!",
        "links": 2,
      },
      {
        "text":
            "This is a reflection w/ [two](https://en.wikipedia.org/wiki/2)[two](https://en.wikipedia.org/wiki/2)[two](https://en.wikipedia.org/wiki/2)[Look](https://www.dictionary.com/browse/look)!",
        "links": 4,
      },
      {
        "text": "This is a reflection w/ no links.",
        "links": 0,
      },
      {
        "text":
            "This is a reflection w/ [two](https://en.wikipedia.org/wiki/2) links. [Look](https://www.dictionary.com/browse/look)",
        "links": 2,
      },
      {
        "text":
            "This is a reflection w/ [two](https://en.wikipedia.org/wiki/2) links. [Look](https://www.dictionary.com/browse/look)[Look](https://www.dictionary.com/browse/look)[Look](https://www.dictionary.com/browse/look)",
        "links": 4,
      },
      {
        "text": "This is a reflection w/ [two](https://en.wikipedia.org/wiki/2) links.",
        "links": 1,
      },
      {
        "text": "[two](https://en.wikipedia.org/wiki/2)",
        "links": 1,
      },
    ];

    testCases.forEach(matchMarkupTest);
  });
}

void successfullyMatchSingleUrlTest(String text) {
  matchLinkTest(text, amountOfMatches: 1, useMarkup: false);
}

void unsuccessfullyMatchSingleUrlTest(String text) {
  matchLinkTest(text, amountOfMatches: 0, useMarkup: false);
}

void matchMultipleUrlTest(Map<String, dynamic> testCase) {
  matchLinkTest(testCase["text"], amountOfMatches: testCase["links"], useMarkup: false);
}

void matchMarkupTest(Map<String, dynamic> testCase) {
  matchLinkTest(testCase["text"], amountOfMatches: testCase["links"], useMarkup: true);
}

void matchLinkTest(String text, {required int amountOfMatches, required bool useMarkup}) {
  test("matching '$text' ${amountOfMatches > 0 ? 'succeeds' : 'fails'}", () {
    final LinkManager sut = LinkManager(useMarkup: useMarkup);

    final List<String> matches = sut.match(text);

    expect(matches.length, amountOfMatches);
  });
}
