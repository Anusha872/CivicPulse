package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.NoticeDAO;
import com.Neighborly.model.NoticeModel;
import com.Neighborly.model.UserModel;
import com.Neighborly.service.NoticeService;
import com.Neighborly.utils.SessionUtil;

/**
 * Servlet implementation class NoticeManagement
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/noticelist" })
public class NoticeManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public NoticeManagement() {
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
			NoticeDAO dao = new NoticeDAO();
			
			List<NoticeModel> notices = dao.getAllNotices();
			
			request.setAttribute("notices", notices);
			request.setAttribute("totalNotices", notices.size());
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("activePage", "Notices");
		request.getRequestDispatcher("/WEB-INF/Pages/NoticeManagement.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		 try {
			 
			    NoticeDAO dao = new NoticeDAO();
			
			    UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        	if (user == null) {
        	    response.sendRedirect(request.getContextPath() + "/login");
        	    return;
        	}
        	
        	int userId = user.getUserId();
        	
		        String editRequestId = request.getParameter("editNoticeId");
		        if (editRequestId != null && !editRequestId.isEmpty()) {
		            
		        	List<NoticeModel> noticeList = dao.getAllNotices();
		        	
		            int editId = Integer.parseInt(editRequestId);
		            
		            for (NoticeModel n : noticeList) {
		                if (n.getNoticeId() == editId) {
		                    request.setAttribute("editNotice", n);
		                    break;
		                }
		            }
		            
		            // FIX: Was "noticeList" — JSP expects the attribute named "notices"
		            request.setAttribute("notices", noticeList);
		            request.setAttribute("totalNotices", noticeList.size());
		            request.getRequestDispatcher("/WEB-INF/Pages/NoticeManagement.jsp").forward(request, response);
		            return;
		        }
		        
		        String deleteRequestId = request.getParameter("openDeleteNoticeId");
		        
		        if (deleteRequestId != null && !deleteRequestId.isEmpty()) {
		        	
		            List<NoticeModel> noticeList = dao.getAllNotices();
		            
		            int deleteId = Integer.parseInt(deleteRequestId);
		            
		            for (NoticeModel n : noticeList) {
		                if (n.getNoticeId() == deleteId) {
		                    request.setAttribute("deleteNoticeId", deleteRequestId);
		                    request.setAttribute("deleteNoticeTitle", n.getNoticeTitle());
		                    break;
		                }
		            }
		            request.setAttribute("notices", noticeList);
		            request.getRequestDispatcher("/WEB-INF/Pages/NoticeManagement.jsp").forward(request, response);
		            return;
		        }

		        String title = request.getParameter("noticeTitle");
		        String category = request.getParameter("noticeCategory");
		        String description = request.getParameter("noticeDescription");
		        
		        NoticeService service = new NoticeService();
		        
		        String validation = service.validateNotice(title, category, description);

		        if (!validation.equals("Success")) {
		            request.setAttribute("errorMessage", validation);
		            request.setAttribute("notices", dao.getAllNotices());
		            request.getRequestDispatcher("/WEB-INF/Pages/NoticeManagement.jsp").forward(request, response);
		            return;
		        }
		        
		        dao.insertNotice(userId, title.trim(), category, description.trim());

		    } catch (Exception e) {
		        e.printStackTrace();
		    }


		response.sendRedirect(request.getContextPath() + "/noticelist");
	}
}