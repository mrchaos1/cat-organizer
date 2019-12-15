class Day {
	int id;
	double calories;
	DateTime startDatetime;

	Day({
		this.id,
		this.calories,
		this.startDatetime,
	});

	factory Day.fromJson(Map<String, dynamic> json) => new Day(
		id: json["id"],
		calories: json["calories"],
		startDatetime: DateTime.fromMillisecondsSinceEpoch(json["start_datetime"]),
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"calories": calories,
		"start_datetime": startDatetime.millisecondsSinceEpoch,
	};
}
