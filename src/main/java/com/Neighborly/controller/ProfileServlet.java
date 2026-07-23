package com.Neighborly.controller;

import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.FeedDAO;
import com.Neighborly.model.FeedModel;
import com.Neighborly.model.UserModel;
import com.Neighborly.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserModel loggedUser =
                (UserModel) SessionUtil.getAttribute(request, "user");
        int userId = loggedUser.getUserId();

        try {

            FeedDAO dao = new FeedDAO();

            List<FeedModel> myPosts    = dao.getPostsByUser(userId);
            List<FeedModel> savedPosts = dao.getSavedPosts(userId);

            request.setAttribute("myPosts",    myPosts);
            request.setAttribute("savedPosts", savedPosts);
            request.setAttribute("activePage", "Profile");

            request.getRequestDispatcher("/WEB-INF/Pages/profile.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading profile", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}