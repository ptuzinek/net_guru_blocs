import 'package:net_guru_blocs/data/data_providers/values_api.dart';
import 'package:net_guru_blocs/data/models/value_base.dart';

class ValuesRepository {
  final valuesApi = ValuesDataApi();

  Future getAllValues() => valuesApi.getAllValues();

  Future insertValue(ValueBase valueBase) => valuesApi.insertValue(valueBase);

  Future updateValue(ValueBase valueBase) => valuesApi.updateValue(valueBase);

  Future saveValues(List<ValueBase> valuesList) =>
      valuesApi.saveValues(valuesList);

  Future deleteValueById(int id) => valuesApi.deleteValue(id);

  Future deleteAllValues() => valuesApi.clearTable();
}
