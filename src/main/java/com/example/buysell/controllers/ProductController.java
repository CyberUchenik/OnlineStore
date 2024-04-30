package com.example.buysell.controllers;

import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.services.ProductService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;
import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;

    @GetMapping("/")
    public String products(@RequestParam(name = "searchWord", required = false) String title,
                           @RequestParam(name = "searchCity", required = false) String city,
                           @RequestParam(name = "catalog", required = false) String catalog,
                           Principal principal, Model model) {
        model.addAttribute("products", productService.listProducts(title, city,catalog));
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("searchWord", title);
        model.addAttribute("searchCity", city);
        return "products";
    }
    @GetMapping("/favorites")
    public String showFavorites(Principal principal, Model model) {

        if (principal == null) {
            return "redirect:/login";
        }
        List<Product> favorites = productService.getFavorites(principal);
        model.addAttribute("favorites", favorites);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        return "favorites";
    }
    @GetMapping("/favorites/add/{productId}")
    public String addProductToFavorites(@PathVariable Long productId, Principal principal, RedirectAttributes redirectAttributes) {
        try {
            productService.addProductToFavorites(productId, principal);
            redirectAttributes.addFlashAttribute("successMessage", "Product added to favorites!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
        }
        return "redirect:/";
    }

    @GetMapping("/favorites/remove/{productId}")
    public String removeProductFromFavorites(@PathVariable Long productId, Principal principal, RedirectAttributes redirectAttributes) {
        try {
            productService.removeProductFromFavorites(productId, principal);
            redirectAttributes.addFlashAttribute("successMessage", "Product removed from favorites!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error: " + e.getMessage());
        }
        return "redirect:/";
    }


    @GetMapping("/about")
    public String aboutUs() {
        return "about_us_modal";
    }
    @GetMapping("/product/edit/{id}")
    public String editProductForm(@PathVariable Long id,Model model,Principal principal){
        Product product = productService.getProductById(id);
        if (product != null && product.getUser().getEmail().equals(principal.getName())){
            model.addAttribute("product",product);
            model.addAttribute("user", productService.getUserByPrincipal(principal));
            Integer price = product.getPrice();
            model.addAttribute("price", price != null ? price.toString() : "");
            return "product-edit";
        } return "redirect:/my/products";
    }

    @PostMapping("/product/edit")
    public String updateProduct(@RequestParam Long id,
                                @RequestParam(value = "imageIds",required = false) Long[] imageIds,
                                @RequestParam("file1") MultipartFile file1,
                                @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3,
                                Product productDetails, Principal principal) throws IOException{
        productService.updateProduct(id, productDetails, file1,file2,file3,imageIds,principal);
        return "redirect:/my/products";
    }

    @GetMapping("/product/{id}")
    public String productInfo(@PathVariable Long id, Model model, Principal principal) {
        Product product = productService.getProductById(id);
        model.addAttribute("user", productService.getUserByPrincipal(principal));
        model.addAttribute("product", product);
        model.addAttribute("images", product.getImages());
        model.addAttribute("authorProduct", product.getUser());
        model.addAttribute("catalog", product.getCatalog());
        return "product-info";
    }

    @PostMapping("/product/create")
    public String createProduct(@RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2,
                                @RequestParam("file3") MultipartFile file3, Product product, Principal principal) throws IOException {
        productService.saveProduct(principal, product, file1, file2, file3);
        return "redirect:/my/products";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable long id){
        productService.deleteProduct(id);
        return "redirect:/my/products";
    }

    @GetMapping("/my/products")
    public String userProducts(Principal principal, Model model) {
        User user = productService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "my-products";
    }
}
