package com.IoTBay.model;
import java.io.Serializable;

public class Shipment implements Serializable{
    private int shipmentId;
    private int orderId;
    private String address;
    private String shippingMethod;
    private String shippingDate;

    public Shipment() {}

    public Shipment(int shipmentId, int orderId, String address, String shippingMethod, String shippingDate) {
        this.shipmentId = shipmentId;
        this.orderId = orderId;
        this.address = address;
        this.shippingMethod = shippingMethod;
        this.shippingDate = shippingDate;
    }

    /** used when creating a brand-new Shipment before saving */
    public Shipment(int orderId, String address, String shippingMethod, String shippingDate) {
        this(0, orderId, address, shippingMethod, shippingDate);
    }

    public int getShipmentId() { return shipmentId; }
    public void setShipmentId(int shipmentId) { this.shipmentId = shipmentId; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getShippingMethod() { return shippingMethod; }
    public void setShippingMethod(String shippingMethod) { this.shippingMethod = shippingMethod; }

    public String getShippingDate() { return shippingDate; }
    public void setShippingDate(String shippingDate) { this.shippingDate = shippingDate; }
}