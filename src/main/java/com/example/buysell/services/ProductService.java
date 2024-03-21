package com.example.buysell.services;

import com.example.buysell.models.Image;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.ImageRepository;
import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import com.example.buysell.utils.ImageUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
@Slf4j
@RequiredArgsConstructor
public class ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ImageRepository imageRepository;

    public List<Product> listProducts(String title, String city) {
        if (city != null && !city.isEmpty()) {
            if (title != null && !title.isEmpty()) {
                // Если заданы и заголовок, и город
                return productRepository.findByTitleAndCity(title, city);
            }
            // Если задан только город
            return productRepository.findByCity(city);
        } else if (title != null && !title.isEmpty()) {
            // Если задан только заголовок
            return productRepository.findByTitle(title);
        }
        return productRepository.findAll();
    }


    public void saveProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = ImageUtils.toImageEntity(file1);
            image1.setPreviewImage(true);
            product.addImageToProduct(image1);
        }
        if (file2.getSize() != 0) {
            image2 = ImageUtils.toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if (file3.getSize() != 0) {
            image3 = ImageUtils.toImageEntity(file3);
            product.addImageToProduct(image3);
        }
        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        productRepository.save(product);
    }

    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }



    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }

    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }

    @Transactional
    public void updateProduct(Long productId, Product productDetails, MultipartFile file1, MultipartFile file2, MultipartFile file3, Long[] imageIds, Principal principal) throws IOException {
        Product product = productRepository.findById(productId).orElse(null);
        if (product == null || !product.getUser().getEmail().equals(principal.getName())) {
            throw new IllegalStateException("Product not found or not owned by the principal");
        }

        product.setTitle(productDetails.getTitle());
        product.setDescription(productDetails.getDescription());
        product.setPrice(productDetails.getPrice());
        product.setCity(productDetails.getCity());

        // Обновляем изображения
        List<MultipartFile> files = Arrays.asList(file1, file2, file3);
        for (int i = 0; i < files.size(); i++) {
            MultipartFile file = files.get(i);
            if (!file.isEmpty()) {
                Image image;
                if (imageIds != null && i < imageIds.length && imageIds[i] != null) {
                    // Замена существующего изображения
                    image = imageRepository.findById(imageIds[i]).orElse(new Image());
                    image.setProduct(product);
                } else {
                    // Добавление нового изображения
                    image = new Image();
                    image.setProduct(product);
                    product.addImageToProduct(image);
                }
                image.setOriginalFileName(file.getOriginalFilename());
                image.setContentType(file.getContentType());
                image.setSize(file.getSize());
                image.setBytes(file.getBytes());
                imageRepository.save(image);
            }
        }

        productRepository.save(product);
    }


}
