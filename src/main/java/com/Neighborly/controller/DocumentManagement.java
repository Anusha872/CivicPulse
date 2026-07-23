package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.DocumentDAO;
import com.Neighborly.model.DocumentModel;

/**
 * Servlet implementation class DocumentManagement
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/documentlist" })
public class DocumentManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DocumentManagement() {
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
			DocumentDAO dao = new DocumentDAO();

			// FIX: deleteDoc was only loading a modal — now actually deletes and redirects.
			// Triggered by the Reject button in the pending documents table.
			String deleteDoc = request.getParameter("deleteDoc");

			if (deleteDoc != null && !deleteDoc.isEmpty()) {
				int docId = Integer.parseInt(deleteDoc);
				dao.deleteDocument(docId);
				response.sendRedirect(request.getContextPath() + "/documentlist");
				return;
			}

			// FIX: editDoc was used by the verified-table Delete button but only loaded
			// a modal — now actually deletes and redirects.
			String editDoc = request.getParameter("editDoc");

			if (editDoc != null && !editDoc.isEmpty()) {
				int docId = Integer.parseInt(editDoc);
				dao.deleteDocument(docId);
				response.sendRedirect(request.getContextPath() + "/documentlist");
				return;
			}

			List<DocumentModel> documents = dao.getAllDocuments();

			int total = 0;
			int approved = 0;
			int pending = 0;

			for (DocumentModel doc : documents) {

				String Status = doc.getStatus();
				total++;

				if ("Approved".equals(Status)) {
					approved++;
				} else if ("Pending".equals(Status)) {
					pending++;
				}
			}
			request.setAttribute("documents", documents);
			request.setAttribute("totalDocuments", total);
			request.setAttribute("approvedDocuments", approved);
			request.setAttribute("pendingDocuments", pending);

			String openDoc = request.getParameter("openDoc");

			if (openDoc != null && !openDoc.isEmpty()) {
				int docId = Integer.parseInt(openDoc);
				request.setAttribute("viewDocument", dao.getDocumentById(docId));
			}

			request.setAttribute("activePage", "Documents");
			request.setAttribute("pageTitle", "Document Management");

		} catch (Exception e) {

			throw new ServletException("Database error", e);
		}
		request.setAttribute("activePage", "Documents");
		request.getRequestDispatcher("/WEB-INF/Pages/DocumentManagement.jsp").forward(request, response);
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