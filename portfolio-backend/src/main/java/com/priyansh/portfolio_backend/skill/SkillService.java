package com.priyansh.portfolio_backend.skill;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class SkillService {

    private final SkillRepository repository;

    public SkillService(SkillRepository repository) {
        this.repository = repository;
    }

    public List<Skill> getAllSkills() {
        return repository.findAll();
    }

    public Skill createSkill(SkillDto dto) {
        Skill skill = Skill.builder()
                .name(dto.name())
                .category(dto.category())
                .level(dto.level())
                .build();

        return repository.save(skill);
    }

    public Skill updateSkill(Long id, SkillDto dto) {
        Skill skill = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Skill not found"));

        skill.setName(dto.name());
        skill.setCategory(dto.category());
        skill.setLevel(dto.level());

        return repository.save(skill);
    }

    public void deleteSkill(Long id) {
        repository.deleteById(id);
    }
}
