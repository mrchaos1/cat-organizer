import 'package:flutter/material.dart';

class Meal {
	int id;
	double calories;
	DateTime datetime;
	DateTime eatenDatetime;
	String description;
	bool isEaten;
	DateTime delayed;
	int sortOrder;

	Meal({
		this.id,
		this.description,
		this.calories,
		this.datetime,
		this.isEaten,
		this.eatenDatetime,
		this.delayed,
		this.sortOrder,
	});

	factory Meal.fromJson(Map<String, dynamic> json) => new Meal(
		id: json["id"],
		calories: json["calories"],
		datetime: json["datetime"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["datetime"]),
		delayed: json["delayed"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["delayed"]),
		description: json["description"],
		isEaten: json["eaten_datetime"] == null ? false : true,
		sortOrder: json["sort_order"],
		eatenDatetime: json["eaten_datetime"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["eaten_datetime"]),

	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"calories": calories,
		"datetime": datetime.millisecondsSinceEpoch,
		"delayed": delayed == null ? null : delayed.millisecondsSinceEpoch,
		"description": description,
		"eaten_datetime" : eatenDatetime == null ? null : eatenDatetime.millisecondsSinceEpoch,
		"sort_order" : sortOrder
	};
}
