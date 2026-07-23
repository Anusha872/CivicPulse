package com.Neighborly.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.Neighborly.utils.SessionUtil;

@WebFilter(urlPatterns = {"/login","", "/register"})
public class GuestFilter extends HttpFilter {
    
    private static final long serialVersionUID = 1L;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;

        if (isLoggedIn) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
        } else {
            chain.doFilter(request, response);
        }
    }
}