package com.IoTBay.model;

import java.io.Serializable;
import java.util.*;

public class Cart implements Serializable {
    private final Map<Integer, CartItem> items = new LinkedHashMap<>();

    public void addProduct(Product product, int quantity) {
        int productId = product.getProductID();
        if (items.containsKey(productId)) {
            CartItem item = items.get(productId);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            items.put(productId, new CartItem(product, quantity));
        }
    }

    public void updateQuantity(int productId, int quantity) {
        if (items.containsKey(productId)) {
            if (quantity <= 0) {
                items.remove(productId);
            } else {
                items.get(productId).setQuantity(quantity);
            }
        }
    }

    public void removeProduct(int productId) {
        items.remove(productId);
    }

    public List<CartItem> getItems() {
        return new ArrayList<>(items.values());
    }

    public float getTotalPrice() {
        float total = 0;
        for (CartItem item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }


    public CartItem getItem(int productId) {
        return items.get(productId);
    }


    public void clear() {
        items.clear();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }


}
