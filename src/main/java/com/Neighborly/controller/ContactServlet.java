package com.Neighborly.controller;

import com.Neighborly.dao.ContactDAO;
import com.Neighborly.service.ContactService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("activePage", "Contact");
        request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            ContactDAO dao = new ContactDAO();
            ContactService service = new ContactService();

            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            String validation = service.validateContact(fullName, email, subject, message);

            if (!"Success".equals(validation)) {

                request.setAttribute("errorMessage", validation);

                // Repopulate fields so the user doesn't lose their input
                request.setAttribute("fullName", fullName);
                request.setAttribute("email", email);
                request.setAttribute("subject", subject);
                request.setAttribute("message", message);

            } else {

                dao.insertContact(
                        fullName.trim(),
                        email.trim(),
                        subject.trim(),
                        message.trim()
                );

                request.setAttribute("successMessage", "Your message has been sent successfully!");
            }

            request.setAttribute("activePage", "Contact");
            request.getRequestDispatcher("/WEB-INF/Pages/contact.jsp").forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();
            throw new ServletException("Database error", e);
        }
    }
}
