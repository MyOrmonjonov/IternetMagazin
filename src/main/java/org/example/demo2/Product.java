package org.example.demo2;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Product  {
    private int id;
    private String name;
    private double price;
    private int category_Id;
    private boolean selected;
    private int count;
    private String imageUrl;
    private Date date;


    public Product(int id, String name, double price, int category_Id,String imageUrl) {

        this.id = id;
        this.name = name;
        this.price = price;
        this.category_Id = category_Id;
        this.selected = false;
        this.imageUrl=imageUrl;
    }



}
