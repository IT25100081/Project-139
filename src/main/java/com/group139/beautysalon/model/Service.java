package com.group139.beautysalon.model;

public abstract class Service {
    private String serviceId;
    private String name;
    private double price;
    private int duration; // in minutes
    private String category;
    private String imageUrl;

    public Service() {}

    public Service(String serviceId, String name, double price, int duration, String category, String imageUrl) {
        this.serviceId = serviceId;
        this.name = name;
        this.price = price;
        this.duration = duration;
        this.category = category;
        this.imageUrl = imageUrl;
    }
    
    public Service(String serviceId, String name, double price, int duration, String category) {
        this.serviceId = serviceId;
        this.name = name;
        this.price = price;
        this.duration = duration;
        this.category = category;
    }

    public String getServiceId() { return serviceId; }
    public void setServiceId(String serviceId) { this.serviceId = serviceId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    // Abstract method to demonstrate abstraction/polymorphism
    public abstract double calculateFinalPrice();
    
    // Abstract method to demonstrate polymorphism with different output messages
    public abstract String getServiceDetails();
}
