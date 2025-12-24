package com.priyansh.portfolio_backend.auth.model.security;

import org.springframework.stereotype.Service;


import com.priyansh.portfolio_backend.auth.model.repositiory.UserRepository;

import org.springframework.security.core.userdetails.*;


@Service
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    public CustomUserDetailsService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String email)
            throws UsernameNotFoundException {

        return userRepository.findByEmail(email.toLowerCase())
                .orElseThrow(() ->
                        new UsernameNotFoundException("User not found: " + email));
    }
}
