package com.Neighborly.controller;

import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.FineDAO;
import com.Neighborly.model.FineModel;
import com.Neighborly.model.UserModel;
import com.Neighborly.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/payments")
public class PaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        UserModel loggedUser = (UserModel) SessionUtil.getAttribute(request, "user");
        int userId = loggedUser.getUserId();

        try {
            FineDAO dao = new FineDAO();
            List<FineModel> fines = dao.getFinesByUser(userId);

            int unpaid = 0, paid = 0;
            double totalOwed = 0;

            for (FineModel f : fines) {
                if ("Unpaid".equals(f.getStatus())) {
                    unpaid++;
                    totalOwed += f.getFineAmount();
                } else if ("Paid".equals(f.getStatus())) {
                    paid++;
                }
            }

            request.setAttribute("fines", fines);
            request.setAttribute("unpaid", unpaid);
            request.setAttribute("paid", paid);
            request.setAttribute("totalOwed", totalOwed);
            
            request.setAttribute("activePage", "Payments");
            request.getRequestDispatcher("/WEB-INF/Pages/payments.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error loading payments", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // The user object is guaranteed to exist by the AuthenticationFilter
        UserModel loggedUser = (UserModel) SessionUtil.getAttribute(request, "user");
        int userId = loggedUser.getUserId();

        try {
            FineDAO dao = new FineDAO();
            List<FineModel> fines = dao.getFinesByUser(userId);

            int unpaid = 0, paid = 0;
            double totalOwed = 0;

            for (FineModel f : fines) {
                if ("Unpaid".equals(f.getStatus())) {
                    unpaid++;
                    totalOwed += f.getFineAmount();
                } else if ("Paid".equals(f.getStatus())) {
                    paid++;
                }
            }

            request.setAttribute("fines", fines);
            request.setAttribute("unpaid", unpaid);
            request.setAttribute("paid", paid);
            request.setAttribute("totalOwed", totalOwed);
            
            request.setAttribute("activePage", "Payments");

            // Open view details
            String openViewFine = request.getParameter("openViewFine");

            if (openViewFine != null && !openViewFine.isEmpty()) {

                int fineId = Integer.parseInt(openViewFine);

                for (FineModel f : fines) {
                    if (f.getFineId() == fineId) {
                        request.setAttribute("viewFine", f);
                        break;
                    }
                }

                request.getRequestDispatcher("/WEB-INF/Pages/payments.jsp")
                       .forward(request, response);
                return;
            }

            // Open pay 
            String openPayFine = request.getParameter("openPayFine");

            if (openPayFine != null && !openPayFine.isEmpty()) {

                int fineId = Integer.parseInt(openPayFine);

                for (FineModel f : fines) {
                    if (f.getFineId() == fineId) {
                        request.setAttribute("payFine", f);
                        break;
                    }
                }

                request.getRequestDispatcher("/WEB-INF/Pages/payments.jsp")
                       .forward(request, response);
                return;
            }

            // Confirm payment
            String confirmPayFineId = request.getParameter("confirmPayFineId");

            if (confirmPayFineId != null && !confirmPayFineId.isEmpty()) {
                dao.markPaid(Integer.parseInt(confirmPayFineId));
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Error processing payment", e);
        }

        // Fresh GET — clears all attributes, all modals hidden
        response.sendRedirect(request.getContextPath() + "/payments");
    }
}