package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.NewsDAO;

/**
 * Servlet implementation class DeleteNewsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/deletenews" })
public class DeleteNewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteNewsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect(request.getContextPath() + "/newslist");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String newsIdParam = request.getParameter("newsId");
		
        if (newsIdParam == null || newsIdParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/newslist");
            return;
        }
        
        int newsId = Integer.parseInt(newsIdParam);
        
        try {
            NewsDAO dao = new NewsDAO();
            
            dao.deleteNews(newsId);
        } catch (Exception e) {
            e.printStackTrace();
            
        }
        
        response.sendRedirect(request.getContextPath() + "/newslist");
        
    }
	}


