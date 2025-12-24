package com.priyansh.portfolio_backend.auth.model.Controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import com.priyansh.portfolio_backend.auth.model.User;
import com.priyansh.portfolio_backend.auth.model.dto.LoginResponse;
import com.priyansh.portfolio_backend.auth.model.dto.Loginrequest;
import com.priyansh.portfolio_backend.auth.model.repositiory.UserRepository;
import com.priyansh.portfolio_backend.auth.model.security.JwtUtil;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtUtil jwtUtil;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;


    // public AuthController(AuthenticationManager authenticationManager,
    //                       JwtUtil jwtUtil,UserRepository userRepository) {
    //     this.authenticationManager = authenticationManager;
    //     this.jwtUtil = jwtUtil;
    //     this.userRepository = userRepository;
    //     this.passwordEncoder = null;
    // }

     // LOGIN
    @PostMapping("/login")
    public LoginResponse login(@Valid @RequestBody Loginrequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.email().toLowerCase(),
                        request.password()
                )
        );

        String token = jwtUtil.generateToken(authentication.getName());
        return new LoginResponse(token);
    }

    // REGISTER
    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody Loginrequest request) {
        if(userRepository.findByEmail(request.email()).isPresent()) {
            return ResponseEntity.badRequest().body("User already exists");
        }

        User user = User.builder()
                .email(request.email())
                .password(passwordEncoder.encode(request.password())) // now works
                .role("USER")
                .build();

        userRepository.save(user);
        return ResponseEntity.ok("User created");
    }

    // CURRENT USER
    @GetMapping("/me")
    public Object me() {
        return SecurityContextHolder
                .getContext()
                .getAuthentication()
                .getPrincipal();
    }
}
