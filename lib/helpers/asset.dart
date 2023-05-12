import 'dart:math';

String randomUber() { int n = 1 + Random().nextInt(100); return n.toString(); }

String sampleimage = "https://picsum.photos/200/300?random=${randomUber()}";
const String defaultsample = "https://picsum.photos/200/300";


String toCamelCase(String text) {
  List<String> words = text.split(' ');

  String result = '';

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (i == 0) {
      result += word.toLowerCase();
    } else {
      result += word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
  }

  return result;
}



String capitalize(String name) {
  List<String> words = name.split(' ');

  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    if (word.isNotEmpty) {
      words[i] = word[0].toUpperCase() + word.substring(1);
    }
  }

  return words.join(' ');
}

class Asset {
  static String public(String path) {
    return 'assets/$path';
  }
}
