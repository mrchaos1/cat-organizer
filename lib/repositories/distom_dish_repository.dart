import 'package:catmanager/models/custom_dish_model.dart';
import 'package:catmanager/database.dart';

class CustomDishRepository {

  Future<List<CustomDish>> findAll() async {
    final dishesResult = await DBProvider.db.query('custom_dish');
    return dishesResult.map((element) => CustomDish.fromJson(element)).toList();
  }

  Future<CustomDish> find(int id) async {
    final dishesResult = await DBProvider.db.query('custom_dish', where: 'id = ?', whereArgs: [id], limit: 1);

    if (dishesResult.length > 0) {
      return CustomDish.fromJson(dishesResult[0]);
    }
    return null;
  }

  Future<CustomDish> save(CustomDish dish) async {
    if (dish.id == null) {
      dish.datetime = DateTime.now();
      dish.id = await DBProvider.db.insert('custom_dish', dish.toJson());
    } else {
      await DBProvider.db.update('custom_dish', dish.toJson(), where: 'id = ?', whereArgs: [dish.id]);
    }
    return dish;
  }

  Future<int> delete(CustomDish dish) async {
    return await DBProvider.db.delete('custom_dish', where: 'id = ?', whereArgs: [dish.id]);
  }

  Future<int> deleteAll() async {
    return await DBProvider.db.delete('custom_dish');
  }
}
