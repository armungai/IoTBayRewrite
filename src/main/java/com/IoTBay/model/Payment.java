package com.IoTBay.model;

import java.io.Serializable;

public class Payment implements Serializable {
    private int paymentId;
    private int userId;
    private int methodId;  // FK to PaymentMethod
    private double amount;
    private String date;
    private String status;

    public Payment() {}

    public Payment(int userId, int methodId, double amount, String date, String status) {
        this.userId = userId;
        this.methodId = methodId;
        this.amount = amount;
        this.date = date;
        this.status = status;
    }

    public Payment(int paymentId, int userId, int methodId, double amount, String date, String status) {
        this.paymentId = paymentId;
        this.userId = userId;
        this.methodId = methodId;
        this.amount = amount;
        this.date = date;
        this.status = status;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public int getUserId() {
        return userId;
    }

    public int getMethodId() {
        return methodId;
    }

    public double getAmount() {
        return amount;
    }

    public String getDate() {
        return date;
    }

    public String getStatus() {
        return status;
    }

    // Setters
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setMethodId(int methodId) {
        this.methodId = methodId;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}