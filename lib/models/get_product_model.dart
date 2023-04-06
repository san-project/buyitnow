List<ProductModel> getProductsFromJson(List json) =>
    json.map((e) => ProductModel.fromJson(e)).toList();

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.thumbnail,
    required this.price,
    required this.countInStock,
    required this.rating,
    required this.numReviews,
    required this.seller,
    required this.feature,
    required this.reviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.isFavourite = false,
  });

  final String id;
  final String name;
  final String description;
  final Category category;
  final String brand;
  final List<KImage> images;
  final KImage thumbnail;
  final double price;
  final int countInStock;
  final int rating;
  final int numReviews;
  final Seller seller;
  final String feature;
  final List<dynamic> reviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  bool isFavourite;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: Category.fromJson(json["category"]),
        brand: json["brand"],
        images:
            List<KImage>.from(json["images"].map((x) => KImage.fromJson(x))),
        thumbnail: KImage.fromJson(json["thumbnail"]),
        price: double.parse(json["price"].toString()),
        countInStock: json["countInStock"],
        rating: json["rating"],
        numReviews: json["numReviews"],
        seller: Seller.fromJson(json["seller"]),
        feature: json["feature"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        isFavourite: json['inWishlist'] ?? false,
        v: json["__v"],
      );
  @override
  String toString() => "Product id: $id name: $name";
}

class KImage {
  KImage({
    required this.url,
    required this.publicId,
  });

  final String url;
  final String publicId;

  factory KImage.fromJson(Map<String, dynamic> json) => KImage(
        url: json["url"],
        publicId: json["publicId"],
      );
}

class Seller {
  Seller({
    required this.id,
    required this.businessName,
  });

  String id;
  String businessName;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["_id"],
        businessName: json["businessName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "businessName": businessName,
      };
}

class Category {
  Category({
    required this.id,
    required this.category,
  });

  String id;
  String category;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        category: json["category"],
      );
}
