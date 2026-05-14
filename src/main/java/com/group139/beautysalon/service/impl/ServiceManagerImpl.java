package com.group139.beautysalon.service.impl;

import com.group139.beautysalon.model.Service;
import com.group139.beautysalon.repository.ServiceRepository;
import com.group139.beautysalon.service.interfaces.ServiceManager;
import java.util.List;
import java.util.Optional;

@org.springframework.stereotype.Service
public class ServiceManagerImpl implements ServiceManager {

    private final ServiceRepository serviceRepository;

    public ServiceManagerImpl(ServiceRepository serviceRepository) {
        this.serviceRepository = serviceRepository;
    }

    @Override
    public List<Service> getAllServices() {
        return serviceRepository.findAll();
    }

    @Override
    public Optional<Service> getServiceById(String serviceId) {
        return serviceRepository.findById(serviceId);
    }

    @Override
    public void addService(Service service) {
        // You could add validation logic here (e.g., check if ID exists)
        serviceRepository.save(service);
    }

    @Override
    public void updateService(Service service) {
        serviceRepository.update(service);
    }

    @Override
    public void deleteService(String serviceId) {
        serviceRepository.delete(serviceId);
    }
}
