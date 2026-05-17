package com.group139.beautysalon.model;

public class SkinService extends Service {
    public SkinService() {
        setCategory("Skin");
    }

    public SkinService(String serviceId, String name, double price, int duration) {
        super(serviceId, name, price, duration, "Skin");
    }

    public SkinService(String serviceId, String name, double price, int duration, String imageUrl) {
        super(serviceId, name, price, duration, "Skin", imageUrl);
    }


    @Override
    public double calculateFinalPrice() {
        // Skin services might have a standard 5% tax/markup for products
        return getPrice() * 1.05;
    }

    @Override
    public String getServiceDetails() {
        return "Skin Care: " + getName() + " - " + getDuration() + " mins";
    }
}
