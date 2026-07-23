package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.ReportDAO;
import com.Neighborly.model.ReportModel;

/**
 * Servlet implementation class ReportIssue
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/reportissue" })
public class ReportManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ReportManagementServlet() {
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

			ReportDAO dao = new ReportDAO();
			List<ReportModel> reports = dao.getAllReportsAdmin();

			int total = reports.size();
			int resolved = 0;
			int pending = 0;
			int inProgress = 0;

			for (ReportModel r : reports) {
				String Status = r.getStatus();

				if ("resolved".equals(Status))
					resolved++;

				else if ("pending".equals(Status))
					pending++;

				else if ("in_progress".equals(Status))
					inProgress++;
			}

			request.setAttribute("reports", reports);
			request.setAttribute("totalReports", total);
			request.setAttribute("resolvedReports", resolved);
			request.setAttribute("pendingReports", pending);
			request.setAttribute("inProgressReports", inProgress);

			request.setAttribute("activePage", "Report Issues");
			request.getRequestDispatcher("/WEB-INF/Pages/ReportIssue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			ReportDAO dao = new ReportDAO();
			List<ReportModel> reports = dao.getAllReports();

			int total = reports.size();
			int resolved = 0;
			int pending = 0;
			int inProgress = 0;

			for (ReportModel r : reports) {
				String Status = r.getStatus();

				if ("resolved".equals(Status))
					resolved++;

				else if ("pending".equals(Status))
					pending++;

				else if ("in_progress".equals(Status))
					inProgress++;
			}

			request.setAttribute("reports", reports);
			request.setAttribute("totalReports", total);
			request.setAttribute("resolvedReports", resolved);
			request.setAttribute("pendingReports", pending);
			request.setAttribute("inProgressReports", inProgress);

			String reviewIssueId = request.getParameter("reviewIssueId");
			ReportModel selectedIssue = null;

			if (reviewIssueId != null && !reviewIssueId.isEmpty()) {
				
			    int id = Integer.parseInt(reviewIssueId);
			    
			    for (ReportModel r : reports) {
			    	
			        if (r.getReportId() == id) {
			        	
			            selectedIssue = r; 
			            
			            request.setAttribute("selectedIssue", r);
			            
			            break;
			            
			        }
			    }
			}
			// Always default to the issue's current status
			if (selectedIssue != null) {
			    
				request.setAttribute("selectedStatus", selectedIssue.getStatus());
			}

			// Override if user clicked a status button
			String selectedStatus = request.getParameter("selectedStatus");
			
			if (selectedStatus != null && !selectedStatus.isEmpty()) {
				
			    request.setAttribute("selectedStatus", selectedStatus);
			}
			
			String openDeleteId = request.getParameter("openDeleteIssueId");

			if (openDeleteId != null && !openDeleteId.isEmpty()) {

				int id = Integer.parseInt(openDeleteId);

				for (ReportModel r : reports) {

					if (r.getReportId() == id) {

						request.setAttribute("openDeleteIssueId", openDeleteId);
						request.setAttribute("deleteIssueTitle", r.getTitle());
						break;
					}
				}
			}
			request.setAttribute("activePage", "Report Issues");
			request.getRequestDispatcher("/WEB-INF/Pages/ReportIssue.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
