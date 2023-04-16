// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    required this.id,
    required this.products,
    required this.seller,
    required this.payment,
    required this.buyer,
    required this.totalPrice,
    required this.status,
    required this.deliveryAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String id;
  final List<Product> products;
  final String seller;
  final String payment;
  final String buyer;
  final int totalPrice;
  final String status;
  final String deliveryAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["_id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        seller: json["seller"],
        payment: json["payment"],
        buyer: json["buyer"],
        totalPrice: json["totalPrice"],
        status: json["status"],
        deliveryAddress: json["deliveryAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "seller": seller,
        "payment": payment,
        "buyer": buyer,
        "totalPrice": totalPrice,
        "status": status,
        "deliveryAddress": deliveryAddress,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Product {
  Product({
    required this.product,
    required this.quantity,
    required this.id,
  });

  final String product;
  final int quantity;
  final String id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["product"],
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "_id": id,
      };
}
