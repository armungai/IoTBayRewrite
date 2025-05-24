//package com.IoTBay.model;
//
//public class Product {
//    private int productID;
//    private String productName;
//    private float price;
//    private String productDescription;
//    private String productImageAddress;
//
//    // Full constructor
//    public Product(int productID, String productName, float price, String productDescription, String productImageAddress) {
//        this.productID = productID;
//        this.productName = productName;
//        this.price = price;
//        this.productDescription = productDescription;
//        this.productImageAddress = productImageAddress;
//    }
//
//    // Constructor for new product (no ID yet)
//    public Product(String productName, float price, String productDescription, String productImageAddress) {
//        this.productName = productName;
//        this.price = price;
//        this.productDescription = productDescription;
//        this.productImageAddress = productImageAddress;
//    }
//
//    // Constructor for delete by ID only
//    public Product(int productID) {
//        this.productID = productID;
//    }
//
//    // Getters
//    public int getProductID() { return productID; }
//    public String getProductName() { return productName; }
//    public float getPrice() { return price; }
//    public String getProductDescription() { return productDescription; }
//    public String getProductImageAddress() { return productImageAddress; }
//
//    // Setter
//    public void setProductID(int productID) { this.productID = productID; }
//}

// src/main/java/com/IoTBay/model/Product.java
package com.IoTBay.model;

public class Product {
    private int      productID;
    private String   productName;
    private float    price;
    private String   productDescription;
    private String   productImageAddress;
    private int      stock;              // new field

    // Full constructor (all fields)
    public Product(int productID, String productName, float price,
                   String productDescription, String productImageAddress, int stock) {
        this.productID            = productID;
        this.productName          = productName;
        this.price                = price;
        this.productDescription   = productDescription;
        this.productImageAddress  = productImageAddress;
        this.stock                = stock;
    }

    // Constructor for creating brand-new product (no ID yet)
    public Product(String productName, float price,
                   String productDescription, String productImageAddress, int stock) {
        this(0, productName, price, productDescription, productImageAddress, stock);
    }

    // Constructor for deleting / fetching by ID
    public Product(int productID) {
        this(productID, null, 0f, null, null, 0);
    }

    // Getters & setters
    public int    getProductID()           { return productID; }
    public void   setProductID(int id)     { this.productID = id; }
    public String getProductName()         { return productName; }
    public float  getPrice()               { return price; }
    public String getProductDescription()  { return productDescription; }
    public String getProductImageAddress() { return productImageAddress; }
    public int    getStock()               { return stock; }
    public void   setStock(int stock)      { this.stock = stock; }
}
