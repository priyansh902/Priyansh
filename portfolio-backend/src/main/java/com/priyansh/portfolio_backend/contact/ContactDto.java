package com.priyansh.portfolio_backend.contact;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;

public record ContactDto(
    @NotBlank
    String name,
    @Email
    @NotBlank
    String email,
    @NotBlank
    String message
) {
    
}
