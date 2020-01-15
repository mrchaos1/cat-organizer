import 'package:catmanager/models/product_model.dart';

class Purchase {
	int id;
	int productId;
	int storeId;
	double price;
	double quantity;
	DateTime datetime;
	String description;
	double latitude;
	double longitude;
	bool isEaten;
	dynamic jsonData;

	Purchase({
		this.id,
		this.productId,
		this.storeId,
		this.price,
		this.quantity,
		this.datetime,
		this.description,
		this.longitude,
		this.latitude,
		this.jsonData,
		this.isEaten,
	});

	factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
		id: json["id"],
		productId: json["product"],
		storeId: json["store"],
		price: json["price"],
		quantity: json["quantity"],
		datetime: json["datetime"] == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(json["datetime"]),
		description: json["description"],
		latitude: json["latitude"],
		longitude: json["longitude"],
		isEaten: json["is_eaten"] == 1 ? true : false,
		jsonData: json,
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"product": productId,
		"store": storeId,
		"price": price,
		"quantity" : quantity,
		"datetime" : datetime.millisecondsSinceEpoch,
		"description" : description,
		"longitude" : longitude,
		"latitude" : latitude,
		"is_eaten" : isEaten == true ? 1 : 0
	};
}

