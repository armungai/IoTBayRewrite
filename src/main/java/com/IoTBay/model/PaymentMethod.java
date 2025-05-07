package com.IoTBay.model;


import java.io.Serializable;

public class PaymentMethod implements Serializable {
    private int methodId;
    private int userId;
    private String type;
    private String cardNumber;
    private String nameOnCard;
    private String expiry;
    private String cvv;

    public PaymentMethod() {
    }

    public PaymentMethod(int userId, String type, String cardNumber, String nameOnCard, String expiry, String cvv) {
        this.userId = userId;
        this.type = type;
        this.cardNumber = cardNumber;
        this.nameOnCard = nameOnCard;
        this.expiry = expiry;
        this.cvv = cvv;
    }

    public PaymentMethod(int methodId, int userId, String type, String cardNumber, String nameOnCard, String expiry, String cvv) {
        this.methodId = methodId;
        this.userId = userId;
        this.type = type;
        this.cardNumber = cardNumber;
        this.nameOnCard = nameOnCard;
        this.expiry = expiry;
        this.cvv = cvv;
    }

    public int getMethodId() {
        return methodId;
    }

    public int getUserId() {
        return userId;
    }

    public String getType() {
        return type;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public String getNameOnCard() {
        return nameOnCard;
    }

    public String getExpiry() {
        return expiry;
    }

    public String getCvv() {
        return cvv;
    }

    public void setMethodId(int methodId) {
        this.methodId = methodId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public void setNameOnCard(String nameOnCard) {
        this.nameOnCard = nameOnCard;
    }

    public void setExpiry(String expiry) {
        this.expiry = expiry;
    }

    public void setCvv(String cvv) {
        this.cvv = cvv;
    }
}
