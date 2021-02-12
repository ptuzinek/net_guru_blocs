final String tableValues = 'values';
final String columnId = '_id';
final String columnValueText = 'value_text';
final String columnIsFavorite = 'is_favorite';
final String columnTimestamp = 'timestamp';

class ValueBase {
  final int id;
  final String valueText;
  final bool isFavorite;
  final DateTime timestamp;

  const ValueBase({
    this.id,
    this.valueText,
    this.isFavorite,
    this.timestamp,
  });

  // convenience constructor to create a ValueBase object
  factory ValueBase.fromMap(Map<String, dynamic> map) {
    return ValueBase(
      id: map[columnId],
      valueText: map[columnValueText],
      isFavorite: map[columnIsFavorite] == 1,
      timestamp: DateTime.parse(map[columnTimestamp]),
    );
  }

  // convenience method to create a Map from this ValueBase object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnValueText: valueText,
      columnIsFavorite: isFavorite == true ? 1 : 0,
      columnTimestamp: timestamp.toString(),
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  // ToDo - write copyWith method.
  ValueBase copyWith(
      {int id, String valueText, bool isFavorite, DateTime timestamp}) {
    return ValueBase(
        id: this.id,
        valueText: valueText ?? this.valueText,
        isFavorite: isFavorite ?? this.isFavorite,
        timestamp: timestamp);
  }
}
