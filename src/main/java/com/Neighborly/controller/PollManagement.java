package com.Neighborly.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import com.Neighborly.dao.PollDAO;
import com.Neighborly.model.PollModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class PollManagement
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/pollmanagement" })
public class PollManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PollManagement() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		try {
			PollDAO dao = new PollDAO();
			List<PollModel> polls = dao.getAllPolls();
			List<PollModel> Totalpolls = dao.getTotalPolls();
			
			int activeCount = 0;
			for (PollModel p : polls)
			{
				if ("Active".equals(p.getStatus()))
				{
					activeCount++;
				}
			}
			request.setAttribute("polls", polls);
			request.setAttribute("totalPolls", Totalpolls.size());
			request.setAttribute("activePolls", activeCount);
			request.getRequestDispatcher("/WEB-INF/Pages/PollManagement.jsp").forward(request, response);
		} catch (Exception e) {
			throw new ServletException("Database error", e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		try {
			PollDAO dao = new PollDAO();
			List<PollModel> polls = dao.getAllPolls();
			List<PollModel> Totalpolls = dao.getTotalPolls();
			
			int activeCount = 0;
			
			for (PollModel p : polls) {
				if ("Active".equals(p.getStatus())) 
				{
					activeCount++;
				}
			}
			
			String openCreatePoll = request.getParameter("openCreatePoll");
			if (openCreatePoll != null) {
			    request.setAttribute("openCreatePoll", true);
			}
			request.setAttribute("polls", polls);
			request.setAttribute("totalPolls", Totalpolls.size());
			request.setAttribute("activePolls", activeCount);

			String editRequestId = request.getParameter("editPollId");
			if (editRequestId != null && !editRequestId.isEmpty()) 
			{
				int editId = Integer.parseInt(editRequestId);
				for (PollModel p : polls) {
					if (p.getPollId() == editId) 
					{
						request.setAttribute("editPoll", p);
						break;
					}
				}
			}

			String openDeletePollId = request.getParameter("openDeletePollId");
			if (openDeletePollId != null && !openDeletePollId.isEmpty()) 
			{
				request.setAttribute("openDeletePollId", openDeletePollId);
				request.setAttribute("deleteQuestion", request.getParameter("deleteQuestion"));
			}

			request.setAttribute("activePage", "Polls");
			request.getRequestDispatcher("/WEB-INF/Pages/PollManagement.jsp").forward(request, response);
		} catch (Exception e) {
			throw new ServletException("Database error", e);
		}
	}

}
