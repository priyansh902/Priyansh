package com.priyansh.portfolio_backend.profile;

import org.springframework.stereotype.Service;

@Service
public class ProfileService {

    private final ProfileRepository repository;

    public ProfileService(ProfileRepository repository) {
        this.repository = repository;
    }

    public Profile getProfile() {
        return repository.findAll()
                .stream()
                .findFirst()
                .orElse(null);
    }

    public Profile updateProfile(ProfileDto dto) {
        Profile profile = getProfile();

        if (profile == null) {
            profile = new Profile();
        }

        profile.setName(dto.name());
        profile.setTitle(dto.title());
        profile.setBio(dto.bio());
        profile.setLocation(dto.location());
        profile.setEmail(dto.email());
        profile.setGithubUrl(dto.githubUrl());
        profile.setLinkedinUrl(dto.linkedinUrl());

        return repository.save(profile);
    }
}
