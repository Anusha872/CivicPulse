package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class PortfolioServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/portfolio" })
public class PortfolioServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PortfolioServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String member = request.getParameter("member");
		if (member != null) {
			member = member.trim().toLowerCase();
		} else {
			member = "yogesh";
		}
		
		// Validate query parameter to prevent server directory traversal or 404s
		if (!member.equals("yogesh") && !member.equals("arjan") && !member.equals("rikesh") && !member.equals("prayush")) {
			member = "yogesh"; // Fallback to Yogesh's portfolio
		}
		
		// Resolve path: check capitalized first (e.g., Yogesh.jsp), then lowercase (e.g., yogesh.jsp)
		String capitalizedName = member.substring(0, 1).toUpperCase() + member.substring(1);
		String path = "/WEB-INF/Pages/" + capitalizedName + ".jsp";
		
		if (getServletContext().getResource(path) == null) {
			path = "/WEB-INF/Pages/" + member + ".jsp";
		}
		
		// Forward directly to the respective static member page
		request.getRequestDispatcher(path).forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
