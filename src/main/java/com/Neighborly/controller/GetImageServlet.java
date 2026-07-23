package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.File;
import java.nio.file.Files;

@WebServlet("/getimage")
public class GetImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");

        if (name == null || name.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing name parameter");
            return;
        }

        File folder = new File(UPLOAD_DIR);
        if (!folder.exists() || !folder.isDirectory()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Storage directory not found");
            return;
        }

        File[] matches = folder.listFiles((dir, fileName) -> fileName.startsWith(name + "."));

        if (matches != null && matches.length > 0) {
            File imageFile = matches[0];
            String contentType = getServletContext().getMimeType(imageFile.getName());
            if (contentType == null) contentType = "image/jpeg";
            response.setContentType(contentType);
            response.setContentLength((int) imageFile.length());
            Files.copy(imageFile.toPath(), response.getOutputStream());
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found for user: " + name);
        }
    }
}