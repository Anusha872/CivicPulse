package com.Neighborly.controller;

import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.NoticeDAO;
import com.Neighborly.model.NoticeModel;
import com.Neighborly.utils.SessionUtil;
import com.Neighborly.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/notices")
public class NoticeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserModel loggedUser =
                (UserModel) SessionUtil.getAttribute(request, "user");

        try {

            NoticeDAO dao = new NoticeDAO();
            List<NoticeModel> notices = dao.getAllNotices();

            request.setAttribute("notices", notices);
            request.setAttribute("user", loggedUser);
            request.setAttribute("activePage", "Notices");

            request.getRequestDispatcher("/WEB-INF/Pages/notices.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database error loading notices", e);
        }
    }
}