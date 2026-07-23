package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.DocumentDAO;

/**
 * Servlet implementation class RejectDocumentServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/rejectdocument" })
public class RejectDocumentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RejectDocumentServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int docId = Integer.parseInt(request.getParameter("documentId"));
			
			DocumentDAO dao = new DocumentDAO();
			
			dao.deleteDocument(docId);
			
			response.sendRedirect(request.getContextPath() + "/documentlist");
		} catch (Exception e) {
			throw new ServletException("Error deleting document", e);
		}

	}
}
