package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import com.Neighborly.dao.DocumentDAO;
import com.Neighborly.dao.FineDAO;
import com.Neighborly.dao.NewsDAO;
import com.Neighborly.dao.NoticeDAO;
import com.Neighborly.dao.PollDAO;
import com.Neighborly.dao.ReportDAO;
import com.Neighborly.dao.UserDAO;
import com.Neighborly.model.DocumentModel;
import com.Neighborly.model.FineModel;
import com.Neighborly.model.NewsModel;
import com.Neighborly.model.NoticeModel;
import com.Neighborly.model.PollModel;
import com.Neighborly.model.ReportModel;
import com.Neighborly.model.UserModel;

/**
 * Servlet implementation class GenerateReportServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/generatereport" })
public class GenerateReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GenerateReportServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/plain");
	    response.setHeader("Content-Disposition", "attachment; filename=\"neighborly_report.txt\"");
		PrintWriter w = response.getWriter();

		Date Date = new java.util.Date();

		try {
			w.println("------------------------------------------------------------------------------");
			w.println("------------------------||NEIGHBORLY SYSTEM REPORT||--------------------------");
			w.println("------------------------------------------------------------------------------");
			w.println(" ");
			w.println("Generated At," + Date);
			w.println();

			// ===== CITIZENS =====
			UserDAO userDAO = new UserDAO();

			List<UserModel> users = userDAO.getAllUsers();

			int suspended = 0;
			int active = 0;

			for (UserModel u : users) {
				String Status = u.getStatus();

				if ("suspended".equals(Status)) {
					suspended++;
				} else {
					active++;
				}

			}

			w.println("-------------------------CITIZENS SUMMARY-----------------------------------------");

			w.println("Total Citizens," + users.size());
			w.println("Active," + active);
			w.println("Suspended," + suspended);
			w.println();
			w.println("Citizen ID,Name,Username,Email,Phone,Status,Registered At");

			for (UserModel u : users) {
				w.println(u.getUserId() + "," + u.getFirstName() + " " + u.getLastName() + "," + u.getUserName() + ","
						+ u.getEmail() + "," + u.getNumber() + "," + u.getStatus() + "," + u.getRegistrationDate());
			}

			// ===== FINES =====
			FineDAO fineDAO = new FineDAO();

			List<FineModel> fines = fineDAO.getAllFines();

			int paid = 0;
			int unpaid = 0;
			double totalAmount = 0;
			double paidAmount = 0;
			double unpaidAmount = 0;

			for (FineModel f : fines) {

				String Status = f.getStatus();

				totalAmount += f.getFineAmount();

				if ("Paid".equals(Status)) {
					paid++;
					paidAmount += f.getFineAmount();
				} else {
					unpaid++;
					unpaidAmount += f.getFineAmount();
				}

			}
			
			// ===== DOCUMENTS =====
			DocumentDAO documentDAO = new DocumentDAO();

			List<DocumentModel> documents = documentDAO.getAllDocuments();

			int approvedDocuments = 0;
			int pendingDocuments = 0;

			for (DocumentModel d : documents) {

				String status = d.getStatus();

				if ("Approved".equalsIgnoreCase(status)) {
					approvedDocuments++;
				} else {
					pendingDocuments++;
				}
			}

			w.println("-------------------------DOCUMENTS SUMMARY-----------------------------------------");

			w.println("Total Documents," + documents.size());
			w.println("Approved," + approvedDocuments);
			w.println("Pending," + pendingDocuments);
			w.println();

			w.println("Document ID,Citizen Name,Document Type,Phone,Status,Submitted At");

			for (DocumentModel d : documents) {

				String fullName = d.getFullName();

				if (fullName == null || fullName.isEmpty()) {
					fullName = d.getFirstName() + " " + d.getLastName();
				}

				fullName = fullName.replace(",", ";");

				w.println(
					d.getDocumentId() + "," +
					fullName + "," +
					d.getDocumentType() + "," +
					d.getPhone() + "," +
					d.getStatus() + "," +
					d.getSubmittedAt()
				);
			}

			w.println();

			w.println("-------------------------FINES SUMMARY-----------------------------------------");
			w.println("Total Fines," + fines.size());
			w.println("Paid," + paid);
			w.println("Unpaid," + unpaid);
			w.println("Total Amount (Rs)," + totalAmount);
			w.println("Paid Amount (Rs)," + paidAmount);
			w.println("Unpaid Amount (Rs)," + unpaidAmount);
			w.println();
			w.println("Fine ID,Citizen Name,Violation Type,Amount,Status,Violation Date,Issued At,Reason");

			for (FineModel f : fines) {

				String reason = f.getReason();

				if (reason == null || reason.isEmpty()) {
					reason = "N/A";
				} else {
					reason = reason.replace(",", ";");
				}
				w.println(f.getFineId() + "," + f.getFirstName() + " " + f.getLastName() + "," + f.getViolationType()
						+ "," + f.getFineAmount() + "," + f.getStatus() + "," + f.getViolationDate() + ","
						+ f.getIssuedAt() + "," + reason);
			}

			// ===== NEWS =====
			NewsDAO newsDAO = new NewsDAO();

			List<NewsModel> newsList = newsDAO.getAllNews();

			int featured = 0, normal = 0;

			for (NewsModel n : newsList) {
				String category = n.getNewsCategory();
				if ("featured".equals(category)) {
					featured++;
				} else {
					normal++;
				}
			}
			w.println("-------------------------NEWS SUMMARY-----------------------------------------");
			w.println("Total News," + newsList.size());
			w.println("Featured," + featured);
			w.println("Normal," + normal);
			w.println();
			w.println("News ID,Title,Category,Posted At");

			for (NewsModel n : newsList) {

				String title = n.getNewsTitle().replace(",", ";");
				w.println(n.getNewsId() + "," + title + "," + n.getNewsCategory() + "," + n.getPostedAt());
			}
			w.println();

			ReportDAO reportDAO = new ReportDAO();

			List<ReportModel> reports = reportDAO.getAllReports();

			int resolved = 0;
			int pending = 0;
			int inProgress = 0;

			for (ReportModel r : reports) {
				String Status = r.getStatus();
				if ("resolved".equals(Status))
					resolved++;
				else if ("in_progress".equals(Status))
					inProgress++;
				else
					pending++;
			}

			w.println("-------------------------ISSUES SUMMARY-----------------------------------------");

			w.println("Total Issues," + reports.size());
			w.println("Resolved," + resolved);
			w.println("In Progress," + inProgress);
			w.println("Pending," + pending);
			w.println();
			w.println("Issue ID,Citizen Name,Category,Status,Submitted At");
			for (ReportModel r : reports) {
				w.println(r.getReportId() + "," + r.getFirstName() + " " + r.getLastName() + "," + r.getCategory() + ","
						+ r.getStatus() + "," + r.getCreatedAt());
			}

			NoticeDAO noticeDAO = new NoticeDAO();

			List<NoticeModel> notices = noticeDAO.getAllNotices();

			w.println("-------------------------NOTICE SUMMARY-----------------------------------------");

			w.println("Total Notices," + notices.size());
			w.println();
			w.println("Notice ID,Title,Category,Posted At");
			for (NoticeModel n : notices) {

				String title = n.getNoticeTitle().replace(",", ";");

				w.println(n.getNoticeId() + "," + title + "," + n.getNoticeCategory() + "," + n.getCreatedAt());
			}

			PollDAO pollDAO = new PollDAO();

			List<PollModel> polls = pollDAO.getAllPolls();

			int activePolls = 0;
			int inactivePolls = 0;

			for (PollModel p : polls) {
				String Status = p.getStatus();
				if ("Active".equals(Status)) {
					activePolls++;
				}

				else {
					inactivePolls++;
				}
			}

			w.println("-------------------------POLLS SUMMARY-----------------------------------------");

			w.println("Total Polls," + polls.size());
			w.println("Active," + activePolls);
			w.println("Closed," + inactivePolls);
			w.println();
			w.println("Poll ID,Question,Option 1,Option 2,Status,Created At");

			for (PollModel p : polls) {

				String question = p.getQuestion().replace(",", ";");
				String option1 = p.getOption1().replace(",", ";");
				String option2 = p.getOption2().replace(",", ";");

				w.println(p.getPollId() + "," + question + "," + option1 + "," + option2 + "," + p.getStatus() + ","
						+ p.getCreatedAt());
			}

			w.println("-----------------------------------------Most Reported Issue Category----------------------------------------- ");
			w.println("-----------------------------------------");
			w.println("Category      ||     Total Issues");
			w.println("-----------------------------------------");

			String mostReportedCategory = "";
			int mostReportedCount = 0;

			for (ReportModel r : reports) {

				String category = r.getCategory();
				int categoryCount = 0;

				for (ReportModel r2 : reports) {
					if (r2.getCategory().equals(category)) {
						categoryCount++;
					}
				}
				if (categoryCount > mostReportedCount) {
					
					mostReportedCount = categoryCount;
					mostReportedCategory = category;
				}
			}
			w.println(mostReportedCategory + "||" + mostReportedCount);
			w.println();

		} catch (Exception e) {
			w.println("Error generating report: " + e.getMessage());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
