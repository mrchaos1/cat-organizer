import 'package:catmanager/database.dart';
import 'package:catmanager/models/product_model.dart';
import 'package:catmanager/models/purchase_model.dart';

class PurchaseRepository {

  Future<List<Purchase>> findAll() async {
    final purchasesResult = await DBProvider.db.query('purchase');
    return purchasesResult.map((element) => Purchase.fromJson(element)).toList();
  }

  Future<List> getWithProducts() async {
    final purchasesResult = await DBProvider.db.rawQuery(''
        'SELECT '
          'purchase.*, '
          'product.id product_id, '
          'product.code product_code, '
          'product.title product_title, '
          'product.net_weight product_net_weight, '
          'product.calorie_content product_calorie_content, '
          'product.added_datetime product_added_datetime '
        'FROM purchase '
        'LEFT JOIN product ON product.id = purchase.product '
    '');

    return purchasesResult.map((element) => Purchase.fromJson(element)).toList();

    return purchasesResult;
  }

  Future<Purchase> find(int id) async {
    final purchasesResult = await DBProvider.db.query('purchase', where: 'id = ?', whereArgs: [id], limit: 1);

    if (purchasesResult.length > 0) {
      return Purchase.fromJson(purchasesResult[0]);
    }
    return null;
  }

  Future<Purchase> save(Purchase purchase) async {
    if (purchase.id == null) {
      purchase.datetime = DateTime.now();
      purchase.id = await DBProvider.db.insert('purchase', purchase.toJson());
    } else {
      await DBProvider.db.update('purchase', purchase.toJson(), where: 'id = ?', whereArgs: [purchase.id]);
    }
    return purchase;
  }

  Future<int> delete(Purchase purchase) async {
    return await DBProvider.db.delete('purchase', where: 'id = ?', whereArgs: [purchase.id]);
  }

  Future<int> deleteAll() async {
    return await DBProvider.db.delete('purchase');
  }
}
