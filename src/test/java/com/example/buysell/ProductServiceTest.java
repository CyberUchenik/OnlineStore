package com.example.buysell;
import static org.mockito.Mockito.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.junit.jupiter.api.Assertions.*;

import com.example.buysell.services.ProductService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;

import java.security.Principal;
import java.util.Arrays;
import java.util.List;

@ExtendWith(SpringExtension.class)
@SpringBootTest
public class ProductServiceTest {

    @Mock
    private ProductRepository productRepository;

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private ProductService productService;

    @Test
    void testListProductsByTitle() {
        // Подготовка
        Product product = new Product(); // Здесь должны быть методы для установки свойств продукта
        when(productRepository.findByTitle(any())).thenReturn(Arrays.asList(product));

        // Действие
        List<Product> products = productService.listProducts("testTitle", null, null);

        // Проверка
        assertNotNull(products);
        assertFalse(products.isEmpty());
        verify(productRepository).findByTitle("testTitle");
    }

    @Test
    void testAddProductToFavorites() {
        Principal principal = mock(Principal.class);
        when(principal.getName()).thenReturn("test@example.com");
        User user = new User();
        Product product = new Product();
        product.setId(1L);

        when(userRepository.findByEmail(anyString())).thenReturn(user);
        when(productRepository.findById(anyLong())).thenReturn(java.util.Optional.of(product));

        // Действие
        productService.addProductToFavorites(1L, principal);

        // Проверка
        assertTrue(user.getFavoriteProducts().contains(product));
        verify(userRepository).save(any(User.class));
    }

    @Test
    void testRemoveProductFromFavorites() {
        Principal principal = mock(Principal.class);
        when(principal.getName()).thenReturn("user@example.com");
        User user = new User();
        Product product = new Product();
        product.setId(1L);
        user.getFavoriteProducts().add(product);

        when(userRepository.findByEmail(anyString())).thenReturn(user);
        when(productRepository.findById(anyLong())).thenReturn(java.util.Optional.of(product));

        // Действие
        productService.removeProductFromFavorites(1L, principal);

        // Проверка
        assertFalse(user.getFavoriteProducts().contains(product));
        verify(userRepository).save(any(User.class));
    }
}
