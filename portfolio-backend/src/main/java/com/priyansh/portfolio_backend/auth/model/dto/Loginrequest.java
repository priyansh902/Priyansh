package com.priyansh.portfolio_backend.auth.model.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record Loginrequest(
    @Email
        @NotBlank
        String email,

        @NotBlank
        String password
) {
    
}
