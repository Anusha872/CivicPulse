package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Neighborly.dao.NoticeDAO;

/**
 * Servlet implementation class UpdateNoticeServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/updatenotice" })
public class UpdateNoticeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateNoticeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.sendRedirect(request.getContextPath() + "/noticelist");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        try {
            int noticeId = Integer.parseInt(request.getParameter("noticeId"));
            String title = request.getParameter("noticeTitle").trim();
            String category = request.getParameter("noticeCategory");
            String description = request.getParameter("noticeDescription").trim();

            NoticeDAO dao = new NoticeDAO();
            dao.updateNotice(noticeId, title, category, description);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/noticelist");
    }

}
