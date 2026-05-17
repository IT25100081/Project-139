package com.group139.beautysalon.repository;

import com.group139.beautysalon.model.HairService;
import com.group139.beautysalon.model.NailService;
import com.group139.beautysalon.model.Service;
import com.group139.beautysalon.model.SkinService;
import org.springframework.stereotype.Repository;
import jakarta.annotation.PostConstruct;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Repository
public class FileBasedServiceRepositoryImpl implements ServiceRepository {

    private static final String FILE_PATH = "src/main/resources/data/services.txt";
    private final Path path = Paths.get(FILE_PATH);

    @PostConstruct
    public void init() {
        try {
            if (!Files.exists(path.getParent())) {
                Files.createDirectories(path.getParent());
            }
            if (!Files.exists(path)) {
                Files.createFile(path);
                // add some initial data
                try (BufferedWriter writer = Files.newBufferedWriter(path)) {
                    writer.write("S001,Haircut,Hair,45,1500.00,\n");
                    writer.write("S002,Facial,Skin,60,2500.00,\n");
                    writer.write("S003,Manicure,Nail,30,1000.00,\n");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Service> findAll() {
        List<Service> services = new ArrayList<>();
        try (BufferedReader reader = Files.newBufferedReader(path)) {
            String line;
            while ((line = reader.readLine()) != null) {
                if(line.trim().isEmpty()) continue;
                String[] parts = line.split(",", -1); // -1 to keep trailing empty strings
                if (parts.length >= 5) {
                    services.add(parseService(parts));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return services;
    }

    @Override
    public Optional<Service> findById(String serviceId) {
        return findAll().stream().filter(s -> s.getServiceId().equals(serviceId)).findFirst();
    }

    @Override
    public void save(Service service) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path.toFile(), true))) {
            writer.write(formatService(service));
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void update(Service service) {
        List<Service> services = findAll();
        for (int i = 0; i < services.size(); i++) {
            if (services.get(i).getServiceId().equals(service.getServiceId())) {
                services.set(i, service);
                break;
            }
        }
        writeAll(services);
    }

    @Override
    public void delete(String serviceId) {
        List<Service> services = findAll();
        services.removeIf(s -> s.getServiceId().equals(serviceId));
        writeAll(services);
    }

    private void writeAll(List<Service> services) {
        try (BufferedWriter writer = Files.newBufferedWriter(path)) {
            for (Service s : services) {
                writer.write(formatService(s));
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Service parseService(String[] parts) {
        String id = parts[0];
        String name = parts[1];
        String category = parts[2];
        int duration = Integer.parseInt(parts[3]);
        double price = Double.parseDouble(parts[4]);
        String imageUrl = parts.length > 5 ? parts[5] : "";

        switch (category.toLowerCase()) {
            case "hair":
                return new HairService(id, name, price, duration, imageUrl);
            case "skin":
                return new SkinService(id, name, price, duration, imageUrl);
            case "nail":
                return new NailService(id, name, price, duration, imageUrl);
            default:
                // fallback
                return new HairService(id, name, price, duration, imageUrl);
        }
    }

    private String formatService(Service service) {
        return String.join(",",
                service.getServiceId(),
                service.getName(),
                service.getCategory(),
                String.valueOf(service.getDuration()),
                String.valueOf(service.getPrice()),
                service.getImageUrl() != null ? service.getImageUrl() : ""
        );
    }
}
