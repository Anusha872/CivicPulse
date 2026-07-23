package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import com.Neighborly.model.UserModel;
import com.Neighborly.service.LoginService;
import com.Neighborly.utils.CookieUtil;
import com.Neighborly.utils.SessionUtil;
import com.Neighborly.dao.UserDAO;

@WebServlet(asyncSupported = true, urlPatterns = { "/login", "" })
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Empty checks
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username is required");
            request.setAttribute("typedUser", username);
            request.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(request, response);
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Password is required");
            request.setAttribute("typedUser", username);
            request.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(request, response);
            return;
        }

        // Validation
        if (username.length() < 3) {
            request.setAttribute("error", "Username must be at least 3 characters");
            request.setAttribute("typedUser", username);
            request.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(request, response);
            return;
        }

        // Authenticate
        LoginService service = new LoginService();
        String status = "";
        try {
            status = service.authenticate(username, password);
        } catch (Exception e) {
            status = "An Error Occurred";
            e.printStackTrace();
        }

        if ("Success".equals(status)) {
            try {
                UserDAO dao = new UserDAO();
                UserModel userModel = dao.getUserByUsername(username);

                // Store user object in session
                SessionUtil.setAttribute(request, "user", userModel, 3600);
                SessionUtil.setAttribute(request, "userId", userModel.getUserId(), 3600);

                // Set login time cookie
                String loginTime = LocalDateTime.now()
                        .format(DateTimeFormatter.ofPattern("yyyy-MM-dd_HH:mm:ss"));
                CookieUtil.addCookie(response, "last_login", loginTime, 3600);
                CookieUtil.addCookie(response, "logged_user", userModel.getUserName(), 3600);
                CookieUtil.addCookie(response, "user_role", userModel.getRole(), 3600);

                // Redirect based on role
                if ("admin".equalsIgnoreCase(userModel.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/admindashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/home");
                }

            } catch (Exception e) {
                e.printStackTrace();
                // Optionally forward to error page
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }

        } else {
            request.setAttribute("error", status);
            request.setAttribute("typedUser", username);
            request.getRequestDispatcher("/WEB-INF/Pages/login.jsp").forward(request, response);
        }
    }
}