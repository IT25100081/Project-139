package com.salon.review;

public class Review {
    private int id;
    private int customerId;
    private int serviceId;
    private String comment;

    public Review(int id, int customerId, int serviceId, String comment) {
        this.id = id;
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.comment = comment;
    }

    public int getId() { return id; }
    public int getCustomerId() { return customerId; }
    public int getServiceId() { return serviceId; }
    public String getComment() { return comment; }
}