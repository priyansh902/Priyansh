package com.priyansh.portfolio_backend.project;

import org.springframework.data.domain.*;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProjectRepository extends JpaRepository<Project, Long> {

    Page<Project> findAllByFeaturedTrue(Pageable pageable);
}
