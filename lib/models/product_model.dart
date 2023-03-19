class Product {
  final String name;
  final String description;
  final double price;
  final String image;
  final String sellerName; 

  Product(this.name, this.description, this.price, this.image, this.sellerName);

  static List<Product> getProducts() {
    List<Product> items = <Product>[];
    items.add(Product(
        "White Shirt",
        "iphone is the most featureful phone ever",
        800.00,
        "https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg",
        'Adinath Traders'
        ));
    items.add(Product(
        "White Shirt",
        "Laptop is most productive development tool",
        2000.00,
        "https://jade-media.jadeblue.com/media/wysiwyg/jadeblue/category/Formal/JB_Web_Formal_Category_B_370x470.jpg",
        'shivam Traders'
        ));
    items.add(Product(
        "White Shirt",
        "iphone is the most featureful phone ever",
        800.00,
        "https://i.pinimg.com/originals/81/f7/6c/81f76ce32c57717d887932b8030ebdc8.png",
        'prince medical'
        ));
    items.add(Product("Dress", "iphone is the most featureful phone ever", 800,
        "https://i.etsystatic.com/26295509/r/il/497760/3921387495/il_fullxfull.3921387495_lere.jpg",
        'ravi shop'
        ));
    items.add(Product(
        "White Shirt",
        "iphone is the most featureful phone ever",
        800.00,
        "https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg",
        'mateswari shose'
        ));
    items.add(Product(
        "White Shirt",
        "Laptop is most productive development tool",
        2000.00,
        "https://jade-media.jadeblue.com/media/wysiwyg/jadeblue/category/Formal/JB_Web_Formal_Category_B_370x470.jpg",
        'bhole festion'
        ));
   
         items.add(Product(
        "White Shirt",
        "iphone is the most featureful phone ever",
        800.00,
        "https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg",
        'Adinath Traders'
        ));
    items.add(Product(
        "White Shirt",
        "Laptop is most productive development tool",
        2000.00,
        "https://jade-media.jadeblue.com/media/wysiwyg/jadeblue/category/Formal/JB_Web_Formal_Category_B_370x470.jpg",
        'shivam Traders'
        ));
    items.add(Product(
        "White Shirt",
        "iphone is the most featureful phone ever",
        800.00,
        "https://i.pinimg.com/originals/81/f7/6c/81f76ce32c57717d887932b8030ebdc8.png",
        'prince medical'
        ));
    items.add(Product("Dress", "iphone is the most featureful phone ever", 800,
        "https://i.etsystatic.com/26295509/r/il/497760/3921387495/il_fullxfull.3921387495_lere.jpg",
        'ravi shop'
        ));
    items.add(Product(
        "White Shirt",
        "iphone is the most featureful phone ever",
        800.00,
        "https://i.pinimg.com/550x/72/a4/30/72a430c1c88f7a478c866d378d6fe67c.jpg",
        'mateswari shose'
        ));
    items.add(Product(
        "White Shirt",
        "Laptop is most productive development tool",
        2000.00,
        "https://jade-media.jadeblue.com/media/wysiwyg/jadeblue/category/Formal/JB_Web_Formal_Category_B_370x470.jpg",
        'bhole festion'
        ));
    return items;
  }
}
