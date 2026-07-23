package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.ReportDAO;

/**
 * Servlet implementation class ModerateIssueServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/moderateissue" })
public class ModerateIssueServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModerateIssueServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    try {
	        
	    	String reportIdParam = request.getParameter("reportId");
	        String status = request.getParameter("status");
	        String notes = request.getParameter("notes");

	        if (reportIdParam == null || reportIdParam.isEmpty()) {
	        	
	            response.sendRedirect(request.getContextPath() + "/reportissue");
	            
	            return;
	        }

	        int reportId = Integer.parseInt(reportIdParam);
	        
	        ReportDAO dao = new ReportDAO();
	        
	        dao.updateReportStatus(reportId, status,notes);

	        response.sendRedirect(request.getContextPath() + "/reportissue");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        
	        response.sendRedirect(request.getContextPath() + "/reportissue");
	    }
	}

}
