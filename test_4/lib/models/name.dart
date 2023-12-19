class Name {
  final String first, last;
  String get fullName => '$first $last';

  const Name({
    required this.first,
    required this.last,
  });
}
