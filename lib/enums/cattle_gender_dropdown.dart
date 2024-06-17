enum CattleGender {
  male("Male", "male"),
  female("Female", "female");

  const CattleGender(this.label, this.value);

  final String label;
  final String value;
}