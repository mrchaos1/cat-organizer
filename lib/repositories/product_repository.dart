import 'package:catmanager/database.dart';
import 'package:catmanager/models/product_model.dart';

class ProductRepository {

  Future<List<Product>> findAll() async {
    final productsResult = await DBProvider.db.query('product');
    return productsResult.map((element) => Product.fromJson(element)).toList();
  }

  Future<List<Product>> search(String search) async {
    final productsResult = await DBProvider.db.rawQuery(
      'SELECT * FROM product '
          'WHERE title LIKE ?'
          'OR code LIKE ?',

      [ '${search}%', '${search}%' ]
    );
    return productsResult.map((element) => Product.fromJson(element)).toList();
  }

  Future<Product> find(int id) async {
    final productsResult = await DBProvider.db.query('product', where: 'id = ?', whereArgs: [id], limit: 1);

    if (productsResult.length > 0) {
      return Product.fromJson(productsResult[0]);
    }
    return null;
  }

  Future<Product> save(Product product) async {
    if (product.id == null) {
      product.addedDatetime = DateTime.now();
      product.id = await DBProvider.db.insert('product', product.toJson());
    } else {
      await DBProvider.db.update('product', product.toJson(), where: 'id = ?', whereArgs: [product.id]);
    }
    return product;
  }

  Future<int> delete(Product product) async {
    return await DBProvider.db.delete('product', where: 'id = ?', whereArgs: [product.id]);
  }

  Future<int> deleteAll() async {
    return await DBProvider.db.delete('product');
  }
}
