// To parse this JSON data, do
//
//     final cart = cartFromJson(jsonString);

import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    required this.success,
    required this.message,
    required this.cart,
    required this.totalPrice,
  });

  final bool success;
  final String message;
  final List<CartElement> cart;
  final int totalPrice;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        success: json["success"],
        message: json["message"],
        cart: List<CartElement>.from(
            json["cart"].map((x) => CartElement.fromJson(x))),
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "totalPrice": totalPrice,
      };
}

class CartElement {
  CartElement({
    required this.id,
    required this.user,
    required this.product,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final String user;
  final Product product;
  final int quantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory CartElement.fromJson(Map<String, dynamic> json) => CartElement(
        id: json["_id"],
        user: json["user"],
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "product": product.toJson(),
        "quantity": quantity,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Product {
  Product({
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
  });

  final String id;
  final String name;
  final String description;
  final String category;
  final String brand;
  final List<Thumbnail> images;
  final Thumbnail thumbnail;
  final int price;
  final int countInStock;
  final int rating;
  final int numReviews;
  final String seller;
  final String feature;
  final List<dynamic> reviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        brand: json["brand"],
        images: List<Thumbnail>.from(
            json["images"].map((x) => Thumbnail.fromJson(x))),
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
        price: json["price"],
        countInStock: json["countInStock"],
        rating: json["rating"],
        numReviews: json["numReviews"],
        seller: json["seller"],
        feature: json["feature"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "category": category,
        "brand": brand,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "thumbnail": thumbnail.toJson(),
        "price": price,
        "countInStock": countInStock,
        "rating": rating,
        "numReviews": numReviews,
        "seller": seller,
        "feature": feature,
        "reviews": List<dynamic>.from(reviews.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Thumbnail {
  Thumbnail({
    required this.url,
    required this.publicId,
  });

  final String url;
  final String publicId;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        url: json["url"],
        publicId: json["publicId"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "publicId": publicId,
      };
}
