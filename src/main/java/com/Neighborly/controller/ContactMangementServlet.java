package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.ContactDAO;

/**
 * Servlet implementation class ContactMangementServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/contactmessage" })
public class ContactMangementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ContactMangementServlet() {
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
			
			ContactDAO dao = new ContactDAO();
			
			request.setAttribute("contactList", dao.getAllContacts());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		request.getRequestDispatcher("/WEB-INF/Pages/ContactManagement.jsp").forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int contactId = Integer.parseInt(request.getParameter("contactId"));
			
			ContactDAO dao = new ContactDAO();
			
			dao.deleteContact(contactId);
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		response.sendRedirect(request.getContextPath() + "/contactmessage");
	}

}
