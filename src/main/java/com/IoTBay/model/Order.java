package com.IoTBay.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Order implements Serializable {
    private int orderId;
    private int userId;
    private int paymentId;
    private LocalDateTime orderDate;

    public Order(){

    }

    public Order(int orderId, int userId, int paymentId, LocalDateTime orderDate) {
        this.orderId = orderId;
        this.userId = userId;
        this.paymentId = paymentId;
        this.orderDate = orderDate;
    }

    public Order(int userId, int paymentId, LocalDateTime orderDate) {
        this.userId = userId;
        this.paymentId = paymentId;
        this.orderDate = orderDate;
    }

    public int getOrderId() { return orderId; }
    public int getUserId() { return userId; }
    public int getPaymentId() { return paymentId; }
    public LocalDateTime getOrderDate() { return orderDate; }
}