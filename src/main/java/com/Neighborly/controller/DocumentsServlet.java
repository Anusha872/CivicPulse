package com.Neighborly.controller;

import com.Neighborly.model.DocumentModel;
import com.Neighborly.model.UserModel;
import com.Neighborly.service.DocumentService;
import com.Neighborly.utils.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(asyncSupported = true, urlPatterns = { "/documents" })
public class DocumentsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		int userId = user.getUserId();

		request.setAttribute("activePage", "Documents");

		try {
			DocumentService service = new DocumentService();
			request.setAttribute("myDocuments", service.getDocumentsByUserId(userId));

			String docType = request.getParameter("docType");
			if (docType != null && !docType.trim().isEmpty()) {
				DocumentModel existing = service.getDocumentByTypeAndUser(docType.trim(), userId);
				request.setAttribute("showViewModal", "true");
				request.setAttribute("viewDocument", existing);
				request.setAttribute("viewDocType", docType.trim());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.getRequestDispatcher("/WEB-INF/Pages/documents.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
		int userId = user.getUserId();

		request.setAttribute("activePage", "Documents");

		// 0) Cancel / close modal
		if ("true".equals(request.getParameter("cancelApply"))) {
			response.sendRedirect(request.getContextPath() + "/documents");
			return;
		}

		DocumentService service = new DocumentService();

		// FIX: Handle "View" button in My Applications table.
		// The form POSTs openViewDoc but doPost had no handler for it — modal never opened.
		String openViewDoc = request.getParameter("openViewDoc");
		if (openViewDoc != null && !openViewDoc.isEmpty()) {
			try {
				request.setAttribute("myDocuments", service.getDocumentsByUserId(userId));
				DocumentModel viewDoc = service.getDocumentByIdAndUser(Integer.parseInt(openViewDoc), userId);
				request.setAttribute("viewDocument", viewDoc);
				request.setAttribute("showViewModal", "true");
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.getRequestDispatcher("/WEB-INF/Pages/documents.jsp").forward(request, response);
			return;
		}

		// 1) Open apply modal
		if ("true".equals(request.getParameter("openApply"))) {
			try {
				request.setAttribute("myDocuments", service.getDocumentsByUserId(userId));
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setAttribute("openApply", "true");
			request.getRequestDispatcher("/WEB-INF/Pages/documents.jsp").forward(request, response);
			return;
		}

		// 2) Submit application
		String applyDocType = request.getParameter("applyDocType");
		String fullName = request.getParameter("fullName");
		String dateOfBirth = request.getParameter("dateOfBirth");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");
		String additionalInfo = request.getParameter("additionalInfo");

		// IMPORTANT: handle empty submit here too
		String error = service.validate(applyDocType, fullName, dateOfBirth, address, phone);
		if (error != null) {
			try {
				request.setAttribute("myDocuments", service.getDocumentsByUserId(userId));
			} catch (Exception e) {
				e.printStackTrace();
			}
			request.setAttribute("openApply", "true");
			request.setAttribute("error", error);
			request.getRequestDispatcher("/WEB-INF/Pages/documents.jsp").forward(request, response);
			return;
		}

		try {
			service.applyForDocument(userId, applyDocType, fullName, dateOfBirth, address, phone, additionalInfo);
			response.sendRedirect(request.getContextPath() + "/documents?success=applied");
		} catch (Exception e) {
			e.printStackTrace();
			try {
				request.setAttribute("myDocuments", service.getDocumentsByUserId(userId));
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			request.setAttribute("openApply", "true");
			request.setAttribute("error", "Something went wrong. Please try again.");
			request.getRequestDispatcher("/WEB-INF/Pages/documents.jsp").forward(request, response);
		}
	}
}