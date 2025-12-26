package com.priyansh.portfolio_backend.skill;

public record SkillDto(
    String name,
    SkillCategory category,
    SkillLevel level
) {
    
}
