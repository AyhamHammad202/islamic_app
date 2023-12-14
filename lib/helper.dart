extension ArabicNumerals on int {
  String toArabic() {
    final arabicNumerals = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩'
    };
    return this
        .toString()
        .split('')
        .map((char) => arabicNumerals[char] ?? char)
        .join('');
  }
}

String fromHijriIndexToImage(int month) {
  switch (month) {
    case 1:
      return "assets/images/hijri/0.svg";
    case 2:
      return "assets/images/hijri/1.svg";
    case 3:
      return "assets/images/hijri/2.svg";
    case 4:
      return "assets/images/hijri/3.svg";
    case 5:
      return "assets/images/hijri/4.svg";
    case 6:
      return "assets/images/hijri/5.svg";
    case 7:
      return "assets/images/hijri/6.svg";
    case 8:
      return "assets/images/hijri/7.svg";
    case 9:
      return "assets/images/hijri/8.svg";
    case 10:
      return "assets/images/hijri/9.svg";
    case 11:
      return "assets/images/hijri/10.svg";
    case 12:
      return "assets/images/hijri/11.svg";
    default:
      return "assets/images/hijri/0.svg";
  }
}
