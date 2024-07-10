class TextUtils {
  // Capitalize the first letter of each word in a string
  static String capitalizeEachWord(String text, {String delimiter = ' '}) {
    if (text.isEmpty) {
      return text;
    }
    return text.split(delimiter).map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1);
    }).join(' ');
  }

  // Capitalize only the first letter of a string
  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }
}
