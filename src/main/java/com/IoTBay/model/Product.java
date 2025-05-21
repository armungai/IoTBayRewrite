package com.IoTBay.model;

public class Product {
    private int productID;
    private String productName;
    private float price;
    private String productDescription;
    private String productImageAddress;

    // Full constructor
    public Product(int productID, String productName, float price, String productDescription, String productImageAddress) {
        this.productID = productID;
        this.productName = productName;
        this.price = price;
        this.productDescription = productDescription;
        this.productImageAddress = productImageAddress;
    }

    // Constructor for new product (no ID yet)
    public Product(String productName, float price, String productDescription, String productImageAddress) {
        this.productName = productName;
        this.price = price;
        this.productDescription = productDescription;
        this.productImageAddress = productImageAddress;
    }

    // Constructor for delete by ID only
    public Product(int productID) {
        this.productID = productID;
    }

    // Getters
    public int getProductID() { return productID; }
    public String getProductName() { return productName; }
    public float getPrice() { return price; }
    public String getProductDescription() { return productDescription; }
    public String getProductImageAddress() { return productImageAddress; }

    // Setter
    public void setProductID(int productID) { this.productID = productID; }
}
