//package com.IoTBay.model;
//
//import java.io.Serializable;
//
//public class OrderItem implements Serializable {
//    private int id;
//    private int orderId;
//    private int productId;
//    private String productName;
//    private float price;
//    private int quantity;
//
//    public OrderItem(int orderId, int productId, String productName, float price, int quantity) {
//        this.orderId = orderId;
//        this.productId = productId;
//        this.productName = productName;
//        this.price = price;
//        this.quantity = quantity;
//    }
//
//    public OrderItem(int id, int orderId, int productId, String productName, float price, int quantity) {
//        this.id = id;
//        this.orderId = orderId;
//        this.productId = productId;
//        this.productName = productName;
//        this.price = price;
//        this.quantity = quantity;
//    }
//
//    public int getId() { return id; }
//    public int getOrderId() { return orderId; }
//    public int getProductId() { return productId; }
//    public String getProductName() { return productName; }
//    public float getPrice() { return price; }
//    public int getQuantity() { return quantity; }
//
//    public void setId(int id) { this.id = id; }
//    public void setOrderId(int orderId) { this.orderId = orderId; }
//    public void setProductId(int productId) { this.productId = productId; }
//    public void setProductName(String productName) { this.productName = productName; }
//    public void setPrice(float price) { this.price = price; }
//    public void setQuantity(int quantity) { this.quantity = quantity; }
//}

// src/main/java/com/IoTBay/model/OrderItem.java
package com.IoTBay.model;

import java.io.Serializable;

public class OrderItem implements Serializable {
    private int    itemId;
    private int    orderId;
    private int    productId;
    private String productName;
    private float  unitPrice;
    private int    quantity;

    // full constructor (all columns + name/price from join)
    public OrderItem(int itemId, int orderId, int productId,
                     String productName, float unitPrice, int quantity) {
        this.itemId       = itemId;
        this.orderId      = orderId;
        this.productId    = productId;
        this.productName  = productName;
        this.unitPrice    = unitPrice;
        this.quantity     = quantity;
    }

    // constructor for new row (ID will be generated)
    public OrderItem(int orderId, int productId,
                     String productName, float unitPrice, int quantity) {
        this(0, orderId, productId, productName, unitPrice, quantity);
    }

    // constructor for delete by ID only
    public OrderItem(int itemId) {
        this(itemId, 0, 0, null, 0f, 0);
    }

    // Getters/setters
    public int    getId()          { return itemId; }
    public void   setId(int id)    { this.itemId = id; }
    public int    getOrderId()     { return orderId; }
    public int    getProductId()   { return productId; }
    public String getProductName(){ return productName; }
    public float  getUnitPrice()   { return unitPrice; }
    public int    getQuantity()    { return quantity; }
    public void   setQuantity(int q){ this.quantity = q; }
}
