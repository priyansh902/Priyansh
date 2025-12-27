package com.priyansh.portfolio_backend.contact;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class ContactService {

    private final ContactRepository repository;

    public ContactService(ContactRepository repository) {
        this.repository = repository;
    }

    public ContactMessage save(ContactDto request) {
        ContactMessage msg = ContactMessage.builder()
                .name(request.name())
                .email(request.email())
                .message(request.message())
                .createdAt(LocalDateTime.now())
                .build();

        return repository.save(msg);
    }

    public List<ContactMessage> getAll() {
        return repository.findAll();
    }
}
