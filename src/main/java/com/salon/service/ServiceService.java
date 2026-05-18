package com.salon.service;
import com.salon.common.FileHandler;

import com.salon.service.Service;
import java.util.ArrayList;
import java.util.List;

public class ServiceService {
    private List<Service> services = new ArrayList<>();
    private FileHandler fileHandler;

    public ServiceService() {
        // Initialize with empty list, will be populated when FileHandler is set
        services = new ArrayList<>();
    }

    public void setFileHandler(FileHandler fileHandler) {
        this.fileHandler = fileHandler;
        if (fileHandler != null) {
            services = fileHandler.loadServices();
        }
    }

    public List<Service> getAllServices() {
        if (fileHandler != null) {
            services = fileHandler.loadServices();
        }
        return services;
    }

    public Service getServiceById(int id) {
        getAllServices(); // ensure fresh data
        return services.stream()
                .filter(service -> service.getId() == id)
                .findFirst()
                .orElse(null);
    }

    public void addService(Service service) {
        getAllServices(); // ensure fresh data
        services.add(service);
        if (fileHandler != null) {
            fileHandler.saveServices(services);
        }
    }

    public void updateService(int id, String name, double price, String description, String imagePath) {
        getAllServices(); // ensure fresh data
        for (Service service : services) {
            if (service.getId() == id) {
                service.setName(name);
                service.setPrice(price);
                service.setDescription(description);
                if (imagePath != null) {
                    service.setImagePath(imagePath);
                }
                if (fileHandler != null) {
                    fileHandler.saveServices(services);
                }
                break;
            }
        }
    }

    public void deleteService(int id) {
        getAllServices(); // ensure fresh data
        services.removeIf(service -> service.getId() == id);
        if (fileHandler != null) {
            fileHandler.saveServices(services);
        }
    }
}