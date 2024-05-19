enum Gender {
  male,
  female,
  other;

  static Gender fromString(String name) {
    switch (name) {
      case 'male' || 'Male':
        return Gender.male;
      case 'female' || "Female":
        return Gender.female;
      default:
        return Gender.other;
    }
  }
}
