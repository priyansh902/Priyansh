package com.priyansh.portfolio_backend.profile;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class ProfileController {

    private final ProfileService service;

    public ProfileController(ProfileService service) {
        this.service = service;
    }

    // PUBLIC
    @GetMapping("/public/profile")
    public Profile getProfile() {
        return service.getProfile();
    }

    // ADMIN
    @PutMapping("/admin/profile")
    public Profile updateProfile(@RequestBody ProfileDto dto) {
        return service.updateProfile(dto);
    }
}

