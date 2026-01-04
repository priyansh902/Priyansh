package com.priyansh.portfolio_backend.project;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class ProjectController {

    private final ProjectService service;

    public ProjectController(ProjectService service) {
        this.service = service;
    }
  


    // PUBLIC
    @GetMapping("/public/projects")
    public Page<Project> getProjects(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {
        return service.getAllProjects(page, size);
    }

    @GetMapping("/public/projects/featured")
    public Page<Project> getFeaturedProjects(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {
        return service.getFeaturedProjects(page, size);
    }

    // ADMIN
    @PostMapping("/admin/projects")
    public Project create(@RequestBody ProjectDto dto) {
        return service.create(dto);
    }

    @PutMapping("/admin/projects/{id}")
    public Project update(@PathVariable Long id, @RequestBody ProjectDto dto) {
        return service.update(id, dto);
    }

    @DeleteMapping("/admin/projects/{id}")
    public void delete(@PathVariable Long id) {
        service.delete(id);
    }
}
