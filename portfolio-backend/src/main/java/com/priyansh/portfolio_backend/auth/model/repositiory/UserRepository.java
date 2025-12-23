package com.priyansh.portfolio_backend.auth.model.repositiory;



import org.springframework.data.jpa.repository.JpaRepository;

import com.priyansh.portfolio_backend.auth.model.User;

import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
}

