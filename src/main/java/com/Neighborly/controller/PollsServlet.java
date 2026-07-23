package com.Neighborly.controller;

import com.Neighborly.model.UserModel;
import com.Neighborly.utils.SessionUtil;

import java.io.IOException;
import java.util.List;

import com.Neighborly.dao.PollDAO;
import com.Neighborly.model.PollModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/polls")
public class PollsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Pulls Session Details from the Authentication Filter
        UserModel loggedUser = (UserModel) SessionUtil.getAttribute(request, "user");
        int userId = loggedUser.getUserId();

        try {
            PollDAO dao = new PollDAO();
            List<PollModel> polls = dao.getAllPolls();	

            // Vote Count
            for (PollModel poll : polls) {
                String userVote = dao.getUserVote(poll.getPollId(), userId);
                
                int[] counts = dao.getVoteCounts(poll.getPollId());
                
                poll.setUserVote(userVote);
                poll.setOption1Count(counts[0]);
                poll.setOption2Count(counts[1]);
            }
            request.setAttribute("polls", polls);
            request.setAttribute("activePage", "Polls");
            request.getRequestDispatcher("/WEB-INF/Pages/Polls.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database error loading polls", e);
        }
    }

    // Voting 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Authentication Filter dosent Encode

        // Pulls Session Details from the Authentication Filter
        UserModel loggedUser = (UserModel) SessionUtil.getAttribute(request, "user");
        
        int userId = loggedUser.getUserId();

        String pollIdParam = request.getParameter("poll_id");
        String action = request.getParameter("action");
        String votedOption = request.getParameter("voted_option");

        if (pollIdParam == null || action == null) {
        	
            response.sendRedirect(request.getContextPath() + "/polls");
            
            return;
        }

        int pollId = Integer.parseInt(pollIdParam);

        try {
            PollDAO dao = new PollDAO();

            if ("vote".equals(action) && votedOption != null) {
                // Record the vote 
                dao.vote(pollId, userId, votedOption);
            } else if ("unvote".equals(action)) {
                dao.unvote(pollId, userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException("Database error processing vote", e);
        }

        // Refreshes Page
        response.sendRedirect(request.getContextPath() + "/polls");
    }
}