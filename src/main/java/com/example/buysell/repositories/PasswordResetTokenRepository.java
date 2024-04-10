    package com.example.buysell.repositories;

    import com.example.buysell.models.PasswordResetToken;
    import org.springframework.data.jpa.repository.JpaRepository;

    public interface PasswordResetTokenRepository extends JpaRepository<PasswordResetToken, Long> {
        PasswordResetToken findByToken(String token);
    }
