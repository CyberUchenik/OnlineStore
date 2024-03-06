package com.example.utils;

import com.example.buysell.models.Image;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

public final class ImageUtils {
    private ImageUtils(){
        throw new UnsupportedOperationException();
    }
    public static Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }
}
