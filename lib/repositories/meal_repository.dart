import 'package:catmanager/models/meal_model.dart';
import 'package:catmanager/database.dart';

class MealRepository {

  Future<List<Meal>> findAll() async {
    final mealsResult = await DBProvider.db.query('meal');
    return mealsResult.map((element) => Meal.fromJson(element)).toList();
  }

  Future<Meal> find(int id) async {
    final mealsResult = await DBProvider.db.query('meal', where: 'id = ?', whereArgs: [id], limit: 1);

    if (mealsResult.length > 0) {
      return Meal.fromJson(mealsResult[0]);
    }
    return null;
  }

  Future<Meal> save(Meal meal) async {
    if (meal.id == null) {
      meal.id = await DBProvider.db.insert('meal', meal.toJson());
    } else {
      await DBProvider.db.update('meal', meal.toJson(), where: 'id = ?', whereArgs: [meal.id]);
    }

    return meal;
  }

  Future<int> delete(Meal meal) async {
    return await DBProvider.db.delete('meal', where: 'id = ?', whereArgs: [meal.id]);
  }

  Future<int> deleteAll() async {
    return await DBProvider.db.delete('meal');
  }
}
