package com.priyansh.portfolio_backend.project;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(
    name = "projects",
    indexes = {
        @Index(name = "idx_featured", columnList = "is_featured")
    }
)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Project {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Column(length = 1500)
    private String description;

    @Column(length = 500)
    private String techStack;

    private String githubUrl;
    private String liveUrl;

    @Column(name = "is_featured")
    private boolean featured;
}
