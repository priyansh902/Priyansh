package com.priyansh.portfolio_backend.project;

public record ProjectDto(
     String title,
     String description,
     String techStack,
     String githubUrl,
     String liveUrl,
     boolean featured
) {
    
}
