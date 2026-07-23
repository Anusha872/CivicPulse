package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.UserDAO;
import com.Neighborly.model.UserModel;

/**
 * Servlet implementation class CitizenManagement
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/citizenlist" })
public class CitizenManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CitizenManagementServlet() {
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
		try {

			UserDAO dao = new UserDAO();

			List<UserModel> citizens = dao.getAllUsers();
			
			String searchQuery = request.getParameter("search");

			if (searchQuery != null && !searchQuery.trim().isEmpty()) {
				
				citizens = dao.searchCitizens(searchQuery.trim());
				
				request.setAttribute("searchQuery", searchQuery);
				
			} else {
				citizens = dao.getAllUsers();
			}

			List<UserModel> activeCitizenList = dao.getActiveCitizens();
			List<UserModel> inactiveCitizenList = dao.getInactiveCitizens();

			request.setAttribute("activeCitizen", activeCitizenList);
			request.setAttribute("inactiveCitizen", inactiveCitizenList);

			request.setAttribute("citizens", citizens);
			request.setAttribute("totalCitizens", citizens.size());

			int activeCount = 0;
			int suspendedCount = 0;

			for (UserModel citizen : citizens) {
				String Status = citizen.getStatus();

				if ("Active".equalsIgnoreCase(Status)) {
					activeCount++;
				} else {
					suspendedCount++;
				}
			}

			request.setAttribute("activeCount", activeCount);
			request.setAttribute("suspendedCount", suspendedCount);
			request.setAttribute("citizens", citizens);
			request.setAttribute("totalCitizens", citizens.size());

			String previewUserId = request.getParameter("userId");

			if (previewUserId != null && !previewUserId.isEmpty()) {

				int userId = Integer.parseInt(previewUserId);

				UserModel selected = dao.getUserById(userId);

				request.setAttribute("selectedCitizen", selected);
			}

			String openSuspendId = request.getParameter("openSuspendId");

			if (openSuspendId != null && !openSuspendId.isEmpty()) {

				int userId = Integer.parseInt(openSuspendId);

				UserModel selected = dao.getUserById(userId);

				request.setAttribute("selectedCitizen", selected);

				request.setAttribute("openSuspendId", openSuspendId);
			}

			request.setAttribute("activePage", "Citizen");
			request.getRequestDispatcher("/WEB-INF/Pages/CitizenManagement.jsp").forward(request, response);
		} catch (Exception e) {
			throw new ServletException("Database error", e);
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
