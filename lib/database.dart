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
		String path = join(documentsDir.path, 'app13.db');

		return await openDatabase(path, version: 1, onOpen: (db) async { }, onCreate: (Database db, int version) async {
			await db.execute('''
				CREATE TABLE meal(
					id INTEGER PRIMARY KEY NOT NULL,
					calories REAL,
					description TEXT NULL,
					datetime INT,
					day INT NULL
				)
			''');

			await db.execute('''
				CREATE TABLE custom_dish(
					id INTEGER PRIMARY KEY NOT NULL,
					calories REAL,
					title TEXT NULL,
					weight REAL,
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
					net_weight INTEGER,
					calories REAL,
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
					datetime INT,
					description TEXT

				)
			''');

			await db.execute('''
				CREATE TABLE store(
					id INTEGER PRIMARY KEY NOT NULL,
					title TEXT,
					latitude REAL,
					longitude REAL,
					added_datetime INT
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

	Future<List<Map<String, dynamic>>> query(String table, {
		String where,
		List<dynamic> whereArgs,
		String groupBy,
		String having,
		String orderBy,
		int limit,
		int offset}) async {

		final db = await database;
		return db.query(table, where: where, whereArgs: whereArgs);
	}
}