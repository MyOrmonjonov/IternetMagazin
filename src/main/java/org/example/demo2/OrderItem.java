package org.example.demo2;

public class OrderItem {
    private int id;
    private String name;
    private double price;
    private int quantity;
    private int orderId;
    private String image;

    public OrderItem(int id, String name, Double price, int quantity) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.orderId = orderId;
    }



    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getOrderId() {
        return orderId;
    }

    public String getImageUrl() {
   return image;
    }
}
