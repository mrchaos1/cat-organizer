import 'package:flutter/cupertino.dart';

class Product {
	int id;
	int code;
	String title;
	double netWeight;
	double calorieContent;
	DateTime addedDatetime;

	Product({
		this.id,
		this.code,
		this.title,
		this.netWeight,
		this.calorieContent,
		this.addedDatetime
	});

	factory Product.fromJson(Map<String, dynamic> json) => Product(
		id: json["id"],
		code: json["code"],
		title: json["title"],
		netWeight: json["net_weight"],
		calorieContent: json["calorie_content"],
		addedDatetime: json["added_datetime"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["added_datetime"]),
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"code": code,
		"title" : title,
		"net_weight" : netWeight,
		"calorie_content" : calorieContent,
		"added_datetime": addedDatetime.millisecondsSinceEpoch,
	};
}
