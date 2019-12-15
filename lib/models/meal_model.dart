import 'package:flutter/cupertino.dart';

class Meal {
	int id;
	double calories;
	DateTime datetime;
	String description;

	Meal({
		this.id,
		this.description,
		@required this.calories,
		@required this.datetime,
	});

	factory Meal.fromJson(Map<String, dynamic> json) => new Meal(
		id: json["id"],
		calories: json["calories"],
		datetime: json["datetime"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["datetime"]),
		description: json["description"],
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"calories": calories,
		"datetime": datetime.millisecondsSinceEpoch,
		"description": description,
	};
}
