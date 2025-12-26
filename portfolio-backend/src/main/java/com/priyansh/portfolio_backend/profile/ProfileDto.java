package com.priyansh.portfolio_backend.profile;

public record ProfileDto(
     String name,
     String title,
     String bio,
     String location,
     String email,
     String githubUrl,
     String linkedinUrl
) {
    
}
