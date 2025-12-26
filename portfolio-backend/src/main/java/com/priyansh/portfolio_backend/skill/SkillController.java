package com.priyansh.portfolio_backend.skill;

import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class SkillController {

    private final SkillService service;

    public SkillController(SkillService service) {
        this.service = service;
    }

    // PUBLIC
    @GetMapping("/public/skills")
    public List<Skill> getSkills() {
        return service.getAllSkills();
    }

    // ADMIN
    @PostMapping("/admin/skills")
    public Skill create(@RequestBody SkillDto dto) {
        return service.createSkill(dto);
    }

    @PutMapping("/admin/skills/{id}")
    public Skill update(@PathVariable Long id, @RequestBody SkillDto dto) {
        return service.updateSkill(id, dto);
    }

    @DeleteMapping("/admin/skills/{id}")
    public void delete(@PathVariable Long id) {
        service.deleteSkill(id);
    }
}
