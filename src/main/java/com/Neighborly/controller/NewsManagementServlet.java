package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.NewsDAO;
import com.Neighborly.model.NewsModel;

/**
 * Servlet implementation class NewsManagement
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/newslist" })
public class NewsManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NewsManagementServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			NewsDAO dao = new NewsDAO();
			List<NewsModel> newsList = dao.getAllNews();
			request.setAttribute("newsList", newsList);
			request.setAttribute("totalNews", newsList.size());
			request.setAttribute("activePage", "News");
			request.getRequestDispatcher("/WEB-INF/Pages/NewsManagement.jsp").forward(request, response);
		} catch (Exception e) {
			throw new ServletException("Database error", e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		NewsDAO dao = new NewsDAO();
		
		try {
			
			List<NewsModel>  newsList = dao.getAllNews();
			
			request.setAttribute("newsList", newsList);
			
			request.setAttribute("totalNews", newsList.size());
			
			String openCreateNews = request.getParameter("openCreateNews");
			
			if (openCreateNews != null) {
				request.setAttribute("openCreateNews", true);
			}

			String editRequestId = request.getParameter("editNewsId");
			
			if (editRequestId != null && !editRequestId.isEmpty()) {
				
				int editId = Integer.parseInt(editRequestId);
				
				for (NewsModel n : newsList) {
					if (n.getNewsId() == editId) {
						request.setAttribute("editNews", n);
						break;
					}
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getRequestDispatcher("/WEB-INF/Pages/NewsManagement.jsp").forward(request, response);
	}

}
