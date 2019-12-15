import 'package:catmanager/models/day_model.dart';
import 'package:catmanager/database.dart';

class DayRepository {
  Future<List<Day>> findAll() async {
    final daysResult = await DBProvider.db.query('day');
    return daysResult.map((element) => Day.fromJson(element)).toList();
  }

  Future<Day> find(int id) async {
    final daysResult = await DBProvider.db.query('day', where: 'id = ?', whereArgs: [id], limit: 1);

    if (daysResult.length > 0) {
      return Day.fromJson(daysResult[0]);
    }
    return null;
  }

  Future<Day> save(Day day) async {
    if (day.id == null) {
      day.id = await DBProvider.db.insert('day', day.toJson());
    } else {
      await DBProvider.db.update('day', day.toJson(), where: 'id = ?', whereArgs: [day.id]);
    }

    return day;
  }

  Future<int> delete(Day day) async {
    return await DBProvider.db.delete('day', where: 'id = ?', whereArgs: [day.id]);
  }
}
