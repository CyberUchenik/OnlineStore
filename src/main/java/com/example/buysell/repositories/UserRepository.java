package com.example.buysell.repositories;

import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    List<User> findAllByFavoriteProductsContains(Product product);

    User findByActivationCode(String code);
}
