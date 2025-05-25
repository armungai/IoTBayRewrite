package com.IoTBay.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Order implements Serializable {
    private int           orderId;
    private int           userId;
    private int           paymentId;
    private LocalDateTime orderDate;
    private String        status;       // new field

    public Order() {}

    // full constructor (read from DB)
    public Order(int orderId, int userId, int paymentId,
                 LocalDateTime orderDate, String status) {
        this.orderId    = orderId;
        this.userId     = userId;
        this.paymentId  = paymentId;
        this.orderDate  = orderDate;
        this.status     = status;
    }

    // when creating a brand-new order
    public Order(int userId, int paymentId, LocalDateTime orderDate) {
        this(0, userId, paymentId, orderDate, null);
    }

    // Getters / setters
    public int           getOrderId()    { return orderId; }
    public void          setOrderId(int id) { this.orderId = id; }
    public int           getUserId()     { return userId; }
    public int           getPaymentId()  { return paymentId; }
    public LocalDateTime getOrderDate()  { return orderDate; }
    public String        getStatus()     { return status; }
    public void          setStatus(String s) { this.status = s; }
}