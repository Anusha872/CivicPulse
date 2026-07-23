package com.Neighborly.controller;

import java.io.IOException;
import com.Neighborly.dao.PollDAO;
import com.Neighborly.model.UserModel;
import com.Neighborly.service.PollService;
import com.Neighborly.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.PollDAO;

/**
 * Servlet implementation class CreatePollServlet
 */
@WebServlet("/createpoll")
public class CreatePollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreatePollServlet() {
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
		response.sendRedirect(request.getContextPath() + "/pollmanagement");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String title = request.getParameter("title");
		String description = request.getParameter("description");
		String option1 = request.getParameter("option_1");
		String option2 = request.getParameter("option_2");

		PollService service = new PollService();
		String result = service.validatePoll(title, description, option1, option2);

		if (!result.equals("Success")) {
			request.setAttribute("errorMessage", result);
			request.setAttribute("openCreatePoll", true);
			request.getRequestDispatcher("/WEB-INF/Pages/PollManagement.jsp").forward(request, response);
			return;
		}

		try {

			UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");

			if (user == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
			int userId = user.getUserId();
			
			PollDAO dao = new PollDAO();
			dao.insertPoll(title.trim(), description, option1, option2, "Active", userId);

		} catch (Exception e) {
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/pollmanagement");
	}

}
