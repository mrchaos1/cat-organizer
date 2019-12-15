class CustomDish {
	int id;
	String title;
	double calories;
	double weight;
	double panWeight;
	DateTime datetime;

	CustomDish({
		this.id,
		this.title,
		this.calories,
		this.weight,
		this.panWeight,
		this.datetime,
	});

	factory CustomDish.fromJson(Map<String, dynamic> json) => new CustomDish(
		id: json["id"],
		calories: json["calories"],
		title: json["title"],
		weight: json["weight"],
		panWeight: json["pan_weight"],
		datetime: json["datetime"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["datetime"]),
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"title": title,
		"calories": calories,
		"weight": weight,
		"pan_weight": panWeight,
		"datetime": datetime.millisecondsSinceEpoch,
	};

	double getCalorieContent() {
		if (this.weight > 0 && this.calories > 0 && this.panWeight >= 0) {
			return double.parse((this.calories / (this.weight - this.panWeight) * 100).toStringAsFixed(2));
		}
		return 0;
	}

	double getFinalWeight() {
		return this.weight - this.panWeight;
	}

}
