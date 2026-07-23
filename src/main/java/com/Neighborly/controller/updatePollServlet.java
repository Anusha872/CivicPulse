package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.PollDAO;

/**
 * Servlet implementation class updatePollServlet
 */
@WebServlet("/updatepoll")
public class updatePollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updatePollServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect(request.getContextPath() + "/pollmanagement");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        int pollId = Integer.parseInt(request.getParameter("pollId"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String option1 = request.getParameter("option_1");
        String option2 = request.getParameter("option_2");

        try {
            PollDAO dao = new PollDAO();
            dao.updatePoll(pollId, title, description, option1, option2);
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/pollmanagement");
	}

}
