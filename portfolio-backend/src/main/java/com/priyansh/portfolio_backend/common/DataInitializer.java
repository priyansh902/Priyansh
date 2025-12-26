package com.priyansh.portfolio_backend.common;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.priyansh.portfolio_backend.auth.model.User;
import com.priyansh.portfolio_backend.auth.model.repositiory.UserRepository;

import jakarta.annotation.PostConstruct;

@Configuration
public class DataInitializer {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository,
                           PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostConstruct
    public void initAdmin() {

        String adminEmail = "pk953666@gmail.com";

        if (userRepository.findByEmail(adminEmail).isEmpty()) {
            User admin = User.builder()
                    .email(adminEmail)
                    .password(passwordEncoder.encode("Pk715366"))
                    .role("ADMIN")
                    .build();

            userRepository.save(admin);
        }
    }
}
