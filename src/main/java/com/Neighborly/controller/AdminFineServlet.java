package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.FineDAO;
import com.Neighborly.dao.UserDAO;
import com.Neighborly.model.FineModel;
import com.Neighborly.model.UserModel;
import com.Neighborly.service.FineService;

/**
 * Servlet implementation class AdminFineServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/issuefine" })
public class AdminFineServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AdminFineServlet() {
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

			FineDAO fineDAO = new FineDAO();
			UserDAO userDAO = new UserDAO();

			List<FineModel> fines = fineDAO.getAllFines();
			List<UserModel> users = userDAO.getAllUsers();

			int unpaidFines = 0;
			int paidFines = 0;
			

			for (FineModel f : fines) {
				
				String fine = f.getStatus();
								
				if ("Unpaid".equals(fine))
					unpaidFines++;
				else if ("Paid".equals(fine))
					paidFines++;
			}

			request.setAttribute("fines", fines);
			request.setAttribute("users", users);
			request.setAttribute("totalFines", fines.size());
			request.setAttribute("unpaidFines", unpaidFines);
			request.setAttribute("paidFines", paidFines);

			request.setAttribute("activePage", "Fines");
			request.getRequestDispatcher("/WEB-INF/Pages/AdminFine.jsp").forward(request, response);
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
		try {
	        FineDAO dao = new FineDAO();
	        UserDAO userDAO = new UserDAO();
	        
	        List<FineModel> fines = dao.getAllFines();
	        List<UserModel> users = userDAO.getAllUsers();
	        
	        int unpaidFines = 0; 
	        int	paidFines = 0;

			for (FineModel f : fines) {
				if ("Unpaid".equals(f.getStatus()))
					unpaidFines++;
				else if ("Paid".equals(f.getStatus()))
					paidFines++;
	        }
	        	        
	        request.setAttribute("fines", fines);
	        request.setAttribute("users", users);
	        request.setAttribute("totalFines", fines.size());
	        request.setAttribute("unpaidFines", unpaidFines);
	        request.setAttribute("paidFines", paidFines);

	        String issueFine = request.getParameter("issueFine");

	        if (issueFine != null) {

	            String userId = request.getParameter("userId");
	            String violationType = request.getParameter("violationType");
	            String fineAmount = request.getParameter("fineAmount");
	            String violationDate = request.getParameter("violationDate");
	            String reason = request.getParameter("reason");

	            FineService service = new FineService();
	            
	            String result = service.validateFine(userId, violationType, fineAmount, violationDate, reason);

	            if (!result.equals("Success")) {
	                
	            	request.setAttribute("errorMessage", result);
	                
	                request.getRequestDispatcher("/WEB-INF/Pages/AdminFine.jsp").forward(request, response);
	                
	                return;
	            }

	            dao.insertFine(Integer.parseInt(userId), violationType, Double.parseDouble(fineAmount), violationDate, reason);
	            response.sendRedirect(request.getContextPath() + "/issuefine");
	        }
	        
	        String markPaidId = request.getParameter("markPaidId");

	        if (markPaidId != null && !markPaidId.isEmpty()) {

	        	int fineId = Integer.parseInt(markPaidId);
	            
	        	dao.markPaid(fineId);
	        	response.sendRedirect(request.getContextPath() + "/issuefine");
	        	return;

	        }
	        
	        String deleteFineId = request.getParameter("deleteFineId");


	        if (deleteFineId != null && !deleteFineId.isEmpty()) {

	        	int fineId = Integer.parseInt(deleteFineId);

	            dao.deleteFine(fineId);
	            response.sendRedirect(request.getContextPath() + "/issuefine");
	            return;
	        }
 
	      
	    } catch (Exception e) {
	        throw new ServletException("Database error", e);
	    }

	}
}
