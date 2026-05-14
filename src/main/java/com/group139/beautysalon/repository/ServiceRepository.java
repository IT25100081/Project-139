package com.group139.beautysalon.repository;

import com.group139.beautysalon.model.Service;
import java.util.List;
import java.util.Optional;

public interface ServiceRepository {
    List<Service> findAll();
    Optional<Service> findById(String serviceId);
    void save(Service service);
    void update(Service service);
    void delete(String serviceId);
}
