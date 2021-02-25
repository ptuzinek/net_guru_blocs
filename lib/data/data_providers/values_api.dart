import 'package:net_guru_blocs/data/database/database_handler.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';

// database table and column names
final String tableValues = 'values_table';
final String columnId = '_id';
final String columnValueText = 'value_text';
final String columnIsFavorite = 'is_favorite';
final String columnTimestamp = 'timestamp';

class ValuesDataApi {
  final dbHelper = DatabaseHelper.instance;

  Future<int> insertValue(ValueBase valueBase) async {
    final db = await dbHelper.database;
    var result = db.insert(tableValues, valueBase.toMap());
    return result;
  }

  Future<int> updateValue(ValueBase value) async {
    final db = await dbHelper.database;
    print('Value.id: ${value.id}');
    return await db.update(tableValues, value.toMap(),
        where: '$columnId = ?', whereArgs: [value.id]);
  }

  Future<List<ValueBase>> getAllValues() async {
    final db = await dbHelper.database;

    List<Map> result = await db.query(tableValues);

    List<ValueBase> valuesList = List();
    result.forEach((valueMap) {
      valuesList.add(ValueBase.fromMap(valueMap));
    });
    return valuesList;
  }

  Future saveValues(List<ValueBase> valuesList) async {
    final db = await dbHelper.database;
    valuesList.forEach((valueBase) {
      db.insert(tableValues, valueBase.toMap());
    });
  }

  Future<void> clearTable() async {
    final db = await dbHelper.database;

    await db.execute('delete from $tableValues');
  }

  //Delete
  Future<int> deleteValue(int id) async {
    final db = await dbHelper.database;
    var result =
        await db.delete(tableValues, where: '_id = ?', whereArgs: [id]);

    return result;
  }
}
