package com.group139.beautysalon.controllers;

import com.group139.beautysalon.model.*;
import com.group139.beautysalon.service.interfaces.ServiceManager;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Optional;
import java.util.UUID;

@Controller
@RequestMapping("/services")
public class ServiceController {

    private final ServiceManager serviceManager;
    private final String UPLOAD_DIR = "src/main/resources/static/uploads/";

    public ServiceController(ServiceManager serviceManager) {
        this.serviceManager = serviceManager;
        try {
            Files.createDirectories(Paths.get(UPLOAD_DIR));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @GetMapping
    public String listServices(Model model) {
        model.addAttribute("services", serviceManager.getAllServices());
        return "service-list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("serviceDTO", new ServiceDTO());
        return "service-add";
    }

    @PostMapping("/add")
    public String addService(@ModelAttribute("serviceDTO") ServiceDTO dto, @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = saveFile(imageFile);
            dto.setImageUrl("/uploads/" + fileName);
        }
        Service service = convertToService(dto);
        serviceManager.addService(service);
        return "redirect:/services";
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable("id") String id, Model model) {
        Optional<Service> optionalService = serviceManager.getServiceById(id);
        if (optionalService.isPresent()) {
            Service s = optionalService.get();
            ServiceDTO dto = new ServiceDTO();
            dto.setServiceId(s.getServiceId());
            dto.setName(s.getName());
            dto.setPrice(s.getPrice());
            dto.setDuration(s.getDuration());
            dto.setCategory(s.getCategory());
            dto.setImageUrl(s.getImageUrl());
            
            model.addAttribute("serviceDTO", dto);
            return "service-edit";
        }
        return "redirect:/services";
    }

    @PostMapping("/edit/{id}")
    public String updateService(@PathVariable("id") String id, @ModelAttribute("serviceDTO") ServiceDTO dto, @RequestParam(value = "imageFile", required = false) MultipartFile imageFile) {
        dto.setServiceId(id); // Ensure ID is correct
        
        Optional<Service> existingService = serviceManager.getServiceById(id);
        
        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = saveFile(imageFile);
            dto.setImageUrl("/uploads/" + fileName);
        } else if (existingService.isPresent()) {
            // retain existing image
            dto.setImageUrl(existingService.get().getImageUrl());
        }

        Service service = convertToService(dto);
        serviceManager.updateService(service);
        return "redirect:/services";
    }

    @GetMapping("/delete/{id}")
    public String deleteService(@PathVariable("id") String id) {
        serviceManager.deleteService(id);
        return "redirect:/services";
    }

    private Service convertToService(ServiceDTO dto) {
        switch (dto.getCategory().toLowerCase()) {
            case "hair":
                return new HairService(dto.getServiceId(), dto.getName(), dto.getPrice(), dto.getDuration(), dto.getImageUrl());
            case "skin":
                return new SkinService(dto.getServiceId(), dto.getName(), dto.getPrice(), dto.getDuration(), dto.getImageUrl());
            case "nail":
                return new NailService(dto.getServiceId(), dto.getName(), dto.getPrice(), dto.getDuration(), dto.getImageUrl());
            default:
                return new HairService(dto.getServiceId(), dto.getName(), dto.getPrice(), dto.getDuration(), dto.getImageUrl());
        }
    }
    
    private String saveFile(MultipartFile file) {
        try {
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            Path path = Paths.get(UPLOAD_DIR + fileName);
            Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
            return fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
