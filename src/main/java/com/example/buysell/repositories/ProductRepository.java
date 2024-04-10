    package com.example.buysell.repositories;

    import com.example.buysell.models.Product;
    import org.springframework.data.jpa.repository.JpaRepository;

    import java.util.List;

<<<<<<< HEAD
    public interface ProductRepository extends JpaRepository<Product, Long> {
        List<Product> findByTitle(String title);
        List<Product> findByCity(String city);
        List<Product> findByTitleAndCity(String title, String city);

=======
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByTitle(String title);
    List<Product> findByCity(String city);
    List<Product> findByTitleAndCity(String title, String city);
    List<Product> findByCatalog(String catalog);
    List<Product> findByCityAndCatalog(String city, String catalog);
>>>>>>> a91969f967a174362f9e966d398285aa6a2dedf0

    }
