//package com.IoTBay.model;
//
//import java.io.Serializable;
//import java.util.*;
//
//public class Cart implements Serializable {
//    private final Map<Integer, CartItem> items = new LinkedHashMap<>();
//
//    public void addProduct(Product product, int quantity) {
//        int productId = product.getProductID();
//        if (items.containsKey(productId)) {
//            CartItem item = items.get(productId);
//            item.setQuantity(item.getQuantity() + quantity);
//        } else {
//            items.put(productId, new CartItem(product, quantity));
//        }
//    }
//
//    public void updateQuantity(int productId, int quantity) {
//        if (items.containsKey(productId)) {
//            if (quantity <= 0) {
//                items.remove(productId);
//            } else {
//                items.get(productId).setQuantity(quantity);
//            }
//        }
//    }
//
//    public void removeProduct(int productId) {
//        items.remove(productId);
//    }
//
//    public List<CartItem> getItems() {
//        return new ArrayList<>(items.values());
//    }
//
//    public float getTotalPrice() {
//        float total = 0;
//        for (CartItem item : items.values()) {
//            total += item.getTotalPrice();
//        }
//        return total;
//    }
//
//    public void clear() {
//        items.clear();
//    }
//
//    public boolean isEmpty() {
//        return items.isEmpty();
//    }
//
//
//}

package com.IoTBay.model;

import java.io.Serializable;
import java.util.*;

public class Cart implements Serializable {
    private final Map<Integer,CartItem> items = new LinkedHashMap<>();

    public void addProduct(Product p, int qty) {
        int id = p.getProductID();
        items.compute(id, (k,v) -> {
            if (v == null) return new CartItem(p, qty);
            v.setQuantity(v.getQuantity() + qty);
            return v;
        });
    }

    public int getQuantity(int productId) {
        return items.getOrDefault(productId, new CartItem(null,0))
                .getQuantity();
    }

    public void updateQuantity(int productId, int qty) {
        if (qty <= 0) items.remove(productId);
        else items.get(productId).setQuantity(qty);
    }

    public void removeProduct(int productId) {
        items.remove(productId);
    }

    public List<CartItem> getItems() {
        return new ArrayList<>(items.values());
    }

    public float getTotalPrice() {
        float total = 0;
        for (CartItem ci: items.values()) {
            total += ci.getTotalPrice();
        }
        return total;
    }

    public void clear() {
        items.clear();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}
