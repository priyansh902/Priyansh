package com.priyansh.portfolio_backend.contact;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


import jakarta.validation.Valid;

@RestController
@RequestMapping("/api")
public class ContactController {

    private final ContactService service;

    public ContactController(ContactService service) {
        this.service = service;
    }

    // PUBLIC
    @PostMapping("/public/contact")
    public ContactMessage submit(@Valid @RequestBody ContactDto request) {
        return service.save(request);
    }

    // ADMIN
    @GetMapping("/admin/contact")
    public List<ContactMessage> getAll() {
        return service.getAll();
    }
}

