package com.salon.service;

public class Service {
    private int id;
    private String name;
    private double price;
    private String description;
    private String imagePath;

    // Constructor for new format
    public Service(int id, String name, double price, String description, String imagePath) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description != null ? description : "";
        this.imagePath = imagePath != null ? imagePath : "default-service-image.jpg";
    }

    // Constructor for old format
    public Service(int id, String name, double price) {
        this(id, name, price, "", "default-service-image.jpg");
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public double getPrice() { return price; }
    public String getDescription() { return description; }
    public String getImagePath() { return imagePath; }
    
    public void setName(String name) { this.name = name; }
    public void setPrice(double price) { this.price = price; }
    public void setDescription(String description) { this.description = description != null ? description : ""; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath != null ? imagePath : "default-service-image.jpg"; }
}