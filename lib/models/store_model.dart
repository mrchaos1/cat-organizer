class Store {
	int id;
	String title;
	DateTime addedDatetime;
	double latitude;
	double longitude;

	Store({
		this.id,
		this.title,
		this.addedDatetime,
		this.latitude,
		this.longitude,
	});

	factory Store.fromJson(Map<String, dynamic> json) => Store(
		id: json["id"],
		title: json["title"],
		latitude: json["latitude"],
		longitude: json["longitude"],
		addedDatetime: json["added_datetime"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["datetime"]),
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"title": title,
		"latitude": latitude,
		"longitude": longitude,
		"addedDatetime" : addedDatetime.millisecondsSinceEpoch,
	};
}
