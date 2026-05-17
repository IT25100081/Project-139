package com.group139.beautysalon.service.interfaces;

import com.group139.beautysalon.model.Service;
import java.util.List;
import java.util.Optional;

public interface ServiceManager {
    List<Service> getAllServices();
    Optional<Service> getServiceById(String serviceId);
    void addService(Service service);
    void updateService(Service service);
    void deleteService(String serviceId);
}
