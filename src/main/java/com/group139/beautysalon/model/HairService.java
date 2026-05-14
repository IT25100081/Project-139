package com.group139.beautysalon.model;

public class HairService extends Service {
    public HairService() {
        setCategory("Hair");
    }

    public HairService(String serviceId, String name, double price, int duration) {
        super(serviceId, name, price, duration, "Hair");
    }

    public HairService(String serviceId, String name, double price, int duration, String imageUrl) {
        super(serviceId, name, price, duration, "Hair", imageUrl);
    }


    @Override
    public double calculateFinalPrice() {
        // Just return base price for hair services
        return getPrice();
    }

    @Override
    public String getServiceDetails() {
        return "Hair Service: " + getName() + " - " + getDuration() + " mins";
    }
}
