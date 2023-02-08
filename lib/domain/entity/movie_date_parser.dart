// эта функция была создана для того,
// чтобы если будет пустая строка, то он возвращал null,
// без нее он ломается и сериализация проходит с ошибкой:
DateTime? parseDateFromString(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) return null;
  return DateTime.tryParse(rawDate);
}
