package com.salon.employee;

public class Employee {
    private int id;
    private String name;
    private String specialization;
    private String imagePath;

    public Employee() {
    }

    public Employee(int id, String name, String specialization) {
        this.id = id;
        this.name = name;
        this.specialization = specialization;
    }

    public Employee(int id, String name, String specialization, String imagePath) {
        this.id = id;
        this.name = name;
        this.specialization = specialization;
        this.imagePath = imagePath;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}