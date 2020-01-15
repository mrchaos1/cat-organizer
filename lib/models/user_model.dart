class User {
	int id;
	String name;
	DateTime dayStart;

	User({
		this.id,
		this.name,
		this.dayStart
	});

	factory User.fromJson(Map<String, dynamic> json) => User(
		id: json["id"],
		name: json["name"],
		dayStart: json["day_start"] == null ? null : DateTime.fromMillisecondsSinceEpoch(json["day_start"]),
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"name": name,
		"day_start" : dayStart.millisecondsSinceEpoch,
	};
}
