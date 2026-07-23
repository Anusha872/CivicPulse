package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.DocumentDAO;
import com.Neighborly.dao.NewsDAO;
import com.Neighborly.dao.NoticeDAO;
import com.Neighborly.dao.PollDAO;
import com.Neighborly.dao.ReportDAO;
import com.Neighborly.dao.UserDAO;
import com.Neighborly.model.DocumentModel;
import com.Neighborly.model.NewsModel;
import com.Neighborly.model.NoticeModel;
import com.Neighborly.model.PollModel;
import com.Neighborly.model.ReportModel;
import com.Neighborly.model.UserModel;

/**
 * Servlet implementation class AdminDashboardServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/admindashboard" })
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            UserDAO userDAO = new UserDAO();
            ReportDAO reportDAO = new ReportDAO();
            NewsDAO newsDAO = new NewsDAO();
            NoticeDAO noticeDAO = new NoticeDAO();
            PollDAO pollDAO = new PollDAO();
            DocumentDAO documentDAO = new DocumentDAO();
            
          
            // Citizens
            List<UserModel> users = userDAO.getAllUsers();
            request.setAttribute("totalCitizens", users.size());

            // Issues
            List<ReportModel> reports = reportDAO.getAllReportsAdmin();
            int openIssues = 0;
            for (ReportModel r : reports) {
                if (!"resolved".equals(r.getStatus())) {
                    openIssues++;
                }
            }
            request.setAttribute("openIssues", openIssues);
            request.setAttribute("recentIssues", reports);
            
            List<DocumentModel> documents = documentDAO.getAllDocuments();

            int pendingDocuments = 0;

            for (DocumentModel d : documents) {
                if (!"Approved".equalsIgnoreCase(d.getStatus())) {
                    pendingDocuments++;
                }
            }

            request.setAttribute("totalDocuments", documents.size());
            request.setAttribute("pendingDocuments", pendingDocuments);
            request.setAttribute("recentDocuments", documents);

            // News
            List<NewsModel> newsList = newsDAO.getAllNews();
            
            request.setAttribute("totalNews", newsList.size());
            request.setAttribute("recentNews", newsList);
            
            List<NoticeModel> notices = noticeDAO.getAllNotices();
            
            request.setAttribute("totalNotices", notices.size());
            request.setAttribute("recentNotices", notices);
            
            List<PollModel> polls = pollDAO.getAllPolls();
            
            int activePolls = 0;
            for (PollModel p : polls) {
                if ("Active".equals(p.getStatus())) {
                    activePolls++;
                }
            }
            request.setAttribute("totalPolls", polls.size());
            request.setAttribute("activePolls", activePolls);
            request.setAttribute("recentPolls", polls);


            request.setAttribute("activePage", "Home");
            request.getRequestDispatcher("/WEB-INF/Pages/AdminDashboard.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
