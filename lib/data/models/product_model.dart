class ProductModel {
  final String? id;
  final int? categoryId;
  final String? categoryName;
  final String? sku;
  final String? name;
  final String? description;
  final double? weight;
  final double? width;
  final double? length;
  final double? height;
  final String? image;
  final double? harga;

  ProductModel({
    this.id,
    this.categoryId,
    this.categoryName,
    this.sku,
    this.name,
    this.description,
    this.weight,
    this.width,
    this.length,
    this.height,
    this.image,
    this.harga,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"] ?? json["id"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        sku: json["sku"],
        name: json["name"],
        description: json["description"],
        weight: json["weight"].toDouble(),
        width: json["width"].toDouble(),
        length: json["length"].toDouble(),
        height: json["height"].toDouble(),
        image: json["image"],
        harga: json["harga"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        if (id!.isNotEmpty) "id": id,
        "category_id": categoryId,
        "category_name": categoryName,
        "sku": sku,
        "name": name,
        "description": description,
        "weight": weight,
        "width": width,
        "length": length,
        "height": height,
        "image": image,
        "harga": harga,
      };
}
