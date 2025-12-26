package com.priyansh.portfolio_backend.project;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

@Service
public class ProjectService {

    private final ProjectRepository repository;

    public ProjectService(ProjectRepository repository) {
        this.repository = repository;
    }

    public Page<Project> getAllProjects(int page, int size) {
        return repository.findAll(PageRequest.of(page, size));
    }

    public Page<Project> getFeaturedProjects(int page, int size) {
        return repository.findAllByFeaturedTrue(PageRequest.of(page, size));
    }

    public Project create(ProjectDto dto) {
        Project project = Project.builder()
                .title(dto.title())
                .description(dto.description())
                .techStack(dto.techStack())
                .githubUrl(dto.githubUrl())
                .liveUrl(dto.liveUrl())
                .featured(dto.featured())
                .build();

        return repository.save(project);
    }

    public Project update(Long id, ProjectDto dto) {
        Project project = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Project not found"));

        project.setTitle(dto.title());
        project.setDescription(dto.description());
        project.setTechStack(dto.techStack());
        project.setGithubUrl(dto.githubUrl());
        project.setLiveUrl(dto.liveUrl());
        project.setFeatured(dto.featured());

        return repository.save(project);
    }

    public void delete(Long id) {
        repository.deleteById(id);
    }
}

