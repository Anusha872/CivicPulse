package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.Neighborly.dao.UserDAO;
import com.Neighborly.model.UserModel;
import com.Neighborly.utils.FileUploadUtil;
import com.Neighborly.utils.SessionUtil;

@WebServlet("/editprofile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize       = 1024 * 1024 * 10,
    maxRequestSize    = 1024 * 1024 * 50
)
public class editProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR =
            System.getProperty("user.home") + File.separator + "webapp_uploads";

    // SHOW FORM

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("activePage", "Edit Profile");
        request.getRequestDispatcher("/WEB-INF/Pages/editProfile.jsp")
               .forward(request, response);
    }

    // SAVE CHANGES

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        UserModel user =
                (UserModel) SessionUtil.getAttribute(request, "user");

        String firstName = request.getParameter("first_name");
        String lastName  = request.getParameter("last_name");
        String email     = request.getParameter("email");
        String number    = request.getParameter("number");

        // validation
        if (firstName == null || firstName.trim().isEmpty()
                || !firstName.matches("[a-zA-Z ]+")) {
            request.setAttribute("error", "Invalid first name.");
            doGet(request, response);
            return;
        }
        if (lastName == null || lastName.trim().isEmpty()
                || !lastName.matches("[a-zA-Z ]+")) {
            request.setAttribute("error", "Invalid last name.");
            doGet(request, response);
            return;
        }
        if (email == null || email.trim().isEmpty()
                || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            request.setAttribute("error", "Valid email address is required.");
            doGet(request, response);
            return;
        }
        if (number == null || number.trim().isEmpty()
                || !number.matches("\\d{10}")) {
            request.setAttribute("error", "Phone number must be 10 digits.");
            doGet(request, response);
            return;
        }

        try {

            UserDAO dao = new UserDAO();

            int rows = dao.updateUser(
                    user.getUserId(), firstName, lastName, email, number);

            if (rows > 0) {

                // Update session
                user.setFirstName(firstName);
                user.setLastName(lastName);
                user.setEmail(email);
                user.setNumber(number);

                //  image upload
                Part filePart = request.getPart("profileImage");

                if (filePart != null && filePart.getSize() > 0) {
                    if (FileUploadUtil.isImage(filePart)) {
                        String ext = FileUploadUtil.getFileExtension(
                                filePart.getSubmittedFileName());
                        String fileName = user.getUserName() + ext;
                        FileUploadUtil.saveFile(filePart, UPLOAD_DIR, fileName);
                        user.setImage(fileName);
                    } else {
                        request.setAttribute("error",
                                "Info updated but invalid image type.");
                        SessionUtil.setAttribute(request, "user", user, 1800);
                        doGet(request, response);
                        return;
                    }
                }

                SessionUtil.setAttribute(request, "user", user, 1800);
                request.setAttribute("success", "Profile updated successfully.");

            } else {
                request.setAttribute("error", "No changes were made.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error updating profile: " + e.getMessage());
        }

        doGet(request, response);
    }
}
