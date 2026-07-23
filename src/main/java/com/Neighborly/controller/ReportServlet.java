package com.Neighborly.controller;

import com.Neighborly.dao.ReportDAO;
import com.Neighborly.model.ReportModel;
import com.Neighborly.model.UserModel;
import com.Neighborly.service.ReportService;
import com.Neighborly.utils.FileUploadUtil;
import com.Neighborly.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/report")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ReportServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads";

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			ReportDAO dao = new ReportDAO();

			List<ReportModel> reports = dao.getAllReports();

			int pendingCount = 0;

			for (ReportModel report : reports) {
				if ("pending".equals(report.getStatus())) {
					pendingCount++;
				}
			}

			request.setAttribute("reports", reports);
			request.setAttribute("totalReports", reports.size());
			request.setAttribute("pendingReports", pendingCount);
			request.setAttribute("activePage", "Report Issues");

			request.getRequestDispatcher("/WEB-INF/Pages/report.jsp").forward(request, response);

		} catch (Exception e) {
			throw new ServletException("Database error", e);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			ReportDAO dao = new ReportDAO();
			ReportService service = new ReportService();

			String title = request.getParameter("title");
			String category = request.getParameter("category");
			String location = request.getParameter("location");
			String description = request.getParameter("description");

			String validation = service.validateReport(title, category, location, description);

			if (!"Success".equals(validation)) {

				request.setAttribute("errorMessage", validation);

			} else {

				UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
				
				if (user == null) {
					
				    response.sendRedirect(request.getContextPath() + "/login");
				    return;
				}
				int userId = user.getUserId();

				String reportPhoto = null;

				Part filePart = request.getPart("photo");

				if (filePart != null && filePart.getSize() > 0) {

					if (FileUploadUtil.isImage(filePart)) {

						String extension = FileUploadUtil.getFileExtension(filePart.getSubmittedFileName());

						String fileName = "report_" + System.currentTimeMillis() + extension;

						FileUploadUtil.saveFile(filePart, UPLOAD_DIR, fileName);

						reportPhoto = fileName;

					} else {

						request.setAttribute("errorMessage", "Only image files are allowed");

						request.getRequestDispatcher("/WEB-INF/Pages/report.jsp").forward(request, response);

						return;
					}
				}

				dao.insertReport(userId, title.trim(), category.trim(), location.trim(), description.trim(),
						reportPhoto);

				request.setAttribute("successMessage", "Report submitted successfully");
			}

			List<ReportModel> reports = dao.getAllReports();

			request.setAttribute("reports", reports);

			request.getRequestDispatcher("/WEB-INF/Pages/report.jsp").forward(request, response);

		} catch (Exception e) {

			e.printStackTrace();

			throw new ServletException("Database error", e);
		}
	}
}