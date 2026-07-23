package com.Neighborly.utils;

import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.*;

/**
 * Utility class for handling file uploads in the application.
 *
 * This class provides methods for:
 * - Extracting file extensions
 * - Validating uploaded files (especially images)
 * - Creating safe filenames
 * - Saving files to the server filesystem
 *
 * It ensures uploaded files are handled safely and consistently.
 */
public class FileUploadUtil {

    /**
     * Extracts file extension from a filename.
     *
     * @param fileName the original file name
     * @return file extension including dot, or empty string if none
     */
    public static String getFileExtension(String fileName) {
        if (fileName == null || !fileName.contains(".")) return "";
        return fileName.substring(fileName.lastIndexOf("."));
    }

    /**
     * Checks whether the uploaded file is an image.
     *
     * @param part uploaded file part
     * @return true if file is an image, false otherwise
     */
    public static boolean isImage(Part part) {
        return part.getContentType() != null &&
               part.getContentType().startsWith("image/");
    }

    /**
     * Builds a safe filename using an identifier and extension.
     *
     * @param identifier unique id or name
     * @param extension file extension
     * @return combined safe filename
     */
    public static String buildFileName(String identifier, String extension) {
        return identifier + extension;
    }

    /**
     * Saves an uploaded file to the server directory.
     *
     * This method:
     * 1. Creates upload directory if it doesn't exist
     * 2. Resolves full file path
     * 3. Writes file using input stream
     * 4. Overwrites existing file if needed
     *
     * @param part uploaded file part
     * @param uploadDir directory to save file
     * @param fileName name to save file as
     * @throws IOException if file saving fails
     */
    public static void saveFile(Part part, String uploadDir, String fileName) throws IOException {
        Path path = Paths.get(uploadDir);

        if (!Files.exists(path)) {
            Files.createDirectories(path);
        }

        Path filePath = path.resolve(fileName);

        try (InputStream inputStream = part.getInputStream()) {
            Files.copy(inputStream, filePath, StandardCopyOption.REPLACE_EXISTING);
        }
    }
}