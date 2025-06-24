enum LangaugeType { ENGLISH, ARABIC }

const String ARABIC = "ar";
const String ENGLISH = "en";

extension LangaugeTypeExtension on LangaugeType {
  String getValue() {
    switch (this) {
      case LangaugeType.ENGLISH:
        return ENGLISH;
      case LangaugeType.ARABIC:
        return ARABIC;
    }
  }
}
