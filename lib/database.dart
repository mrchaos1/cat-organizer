import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
	// Create a singleton
	DBProvider._();

	static final DBProvider db = DBProvider._();
	Database _database;

	Future<Database> get database async {
		if (_database != null) {
			return _database;
		}

		_database = await initDB();
		return _database;
	}

	initDB() async {
		Directory documentsDir = await getApplicationDocumentsDirectory();
		String path = join(documentsDir.path, 'app20.db');

		return await openDatabase(path, version: 1, onOpen: (db) async { }, onCreate: (Database db, int version) async {
			await db.execute('''
				CREATE TABLE meal(
					id INTEGER PRIMARY KEY NOT NULL,
					calories REAL,
					eaten_datetime INT NULL,
					description TEXT NULL,
					datetime INT,
					delayed INT NULL,
					sort_order INT,
					day INT NULL
				)
			''');

			await db.execute('''
				CREATE TABLE custom_dish(
					id INTEGER PRIMARY KEY NOT NULL,
					calories REAL,
					title TEXT NULL,
					weight REAL,
					weight_eaten REAL,
					pan_weight REAL,
					datetime INT
				)
			''');

			await db.execute('''
				CREATE TABLE day(
					id INTEGER PRIMARY KEY NOT NULL,
					calories REAL,
					start_datetime INT
				)
			''');


			await db.execute('''
				CREATE TABLE product(
					id INTEGER PRIMARY KEY NOT NULL,
					code INTEGER,
					title TEXT,
					net_weight REAL,
					calorie_content REAL,
					added_datetime,
					
					UNIQUE(code, title)
				)
			''');

			await db.execute('''
				CREATE TABLE purchase(
					id INTEGER PRIMARY KEY NOT NULL,
					product INT NULL,
					store INT NULL,
					price REAL,
					quantity REAL NOT NULL,
					datetime INT,
					purchased_datetime INT,
					eaten_datetime INT,
					description TEXT,
					latitude REAL,
					longitude REAL
				)
			''');

			await db.execute('''
				CREATE TABLE store(
					id INTEGER PRIMARY KEY NOT NULL,
					title TEXT,
					added_datetime INT,
					latitude REAL,
					longitude REAL
				)
			''');

			await db.execute('''
				CREATE TABLE user(
					id INTEGER PRIMARY KEY NOT NULL,
					name TEXT,
					day_start INT
				)
			''');
		});
	}

	Future<int> insert(String table, Map<String, dynamic> row) async {
		Database db = await database;
		return await db.insert(table, row);
	}

	Future<List<Map<String, dynamic>>> rawQuery(String sql, [List<dynamic> arguments]) async {
		final Database db = await database;
		return await db.rawQuery(sql, arguments);
	}

	Future<int> delete(String table, {String where, List<dynamic> whereArgs}) async {
		final Database db = await database;
		return db.delete(table, where: where, whereArgs: whereArgs);
	}

	Future<int> update(String table, Map<String, dynamic> values, {String where, List<dynamic> whereArgs}) async {
		final Database db = await database;
		return db.update(table, values, where: where, whereArgs: whereArgs);
	}

	Future<Batch> batch() async {
		final Database db = await database;
		Batch batch = db.batch();
		return batch;
	}

	Future<List<Map<String, dynamic>>> query(String table, {
		String where,
		List<dynamic> whereArgs,
		String groupBy,
		String having,
		String orderBy,
		int limit,
		int offset}) async {

		final db = await database;
		return db.query(table, where: where, whereArgs: whereArgs, orderBy: orderBy, limit: limit, offset: offset, groupBy: groupBy);
	}

//	Future<List<Map<String, dynamic>>> test(search) async {
//		final db = await database;
//		return db.query('product', where: "title LIKE '%?%'", whereArgs: [ search ]);
//	}



}