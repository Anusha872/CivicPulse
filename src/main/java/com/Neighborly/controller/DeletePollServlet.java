package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.PollDAO;

/**
 * Servlet implementation class DeletePollServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/deletepoll" })
public class DeletePollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeletePollServlet() {
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
		
		int pollId = Integer.parseInt(request.getParameter("pollId"));
        try {
            PollDAO dao = new PollDAO();
            dao.deletePoll(pollId);
        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/pollmanagement");
	}

}
