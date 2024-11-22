package org.example.demo2;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private LocalDateTime dateTime;
    private int totalPrice;
    private List<OrderItem> items;

    public Order(int id, LocalDateTime dateTime, int totalPrice) {
        this.id = id;
        this.dateTime = dateTime;
        this.totalPrice = totalPrice;
        this.items = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public LocalDateTime getDateTime() {
        return dateTime;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void addItem(OrderItem item) {
        items.add(item);
    }


    public LocalDateTime getOrderDate() {
        return LocalDateTime.now();
    }
}
