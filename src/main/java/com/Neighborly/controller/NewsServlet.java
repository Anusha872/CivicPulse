package com.Neighborly.controller;

import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.NewsDAO;
import com.Neighborly.model.NewsModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/news")
public class NewsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            NewsDAO dao = new NewsDAO();
            List<NewsModel> newsList = dao.getAllNews();

            // Split featured and normal
            NewsModel featured = null;
            List<NewsModel> stories = new java.util.ArrayList<>();

            for (NewsModel n : newsList) {
                if (featured == null && "featured".equals(n.getNewsCategory())) {
                    featured = n;
                } else {
                    stories.add(n);
                }
            }

            request.setAttribute("featured",   featured);
            request.setAttribute("stories",    stories);
            request.setAttribute("activePage", "News");

            request.getRequestDispatcher("/WEB-INF/Pages/news.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading news", e);
        }
    }
}