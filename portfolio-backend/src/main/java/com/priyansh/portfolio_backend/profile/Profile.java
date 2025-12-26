package com.priyansh.portfolio_backend.profile;


import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "profile")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Profile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String title;

    @Column(length = 1000)
    private String bio;

    private String location;
    private String email;

    private String githubUrl;
    private String linkedinUrl;
}
