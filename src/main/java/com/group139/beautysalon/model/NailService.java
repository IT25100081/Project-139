package com.group139.beautysalon.model;

public class NailService extends Service {
    public NailService() {
        setCategory("Nail");
    }

    public NailService(String serviceId, String name, double price, int duration) {
        super(serviceId, name, price, duration, "Nail");
    }

    public NailService(String serviceId, String name, double price, int duration, String imageUrl) {
        super(serviceId, name, price, duration, "Nail", imageUrl);
    }


    @Override
    public double calculateFinalPrice() {
        return getPrice();
    }

    @Override
    public String getServiceDetails() {
        return "Nail Treatment: " + getName() + " - " + getDuration() + " mins";
    }
}
