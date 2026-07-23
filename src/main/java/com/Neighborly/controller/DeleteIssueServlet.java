package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.ReportDAO;

/**
 * Servlet implementation class DeleteIssueServlet
 */
@WebServlet("/deleteissue")
public class DeleteIssueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DeleteIssueServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		response.sendRedirect(request.getContextPath() + "/reportissue");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			
			String reportIdParam = request.getParameter("reportId");

			if (reportIdParam == null || reportIdParam.isEmpty()) {
				response.sendRedirect(request.getContextPath() + "/reportissue");
				return;
			}

			int reportId = Integer.parseInt(reportIdParam);
			
			ReportDAO dao = new ReportDAO();
			
			dao.deleteReport(reportId);

			response.sendRedirect(request.getContextPath() + "/reportissue");
			
		} catch (Exception e) {
			e.printStackTrace();
			
			response.sendRedirect(request.getContextPath() + "/reportissue");
		}
	}

}
