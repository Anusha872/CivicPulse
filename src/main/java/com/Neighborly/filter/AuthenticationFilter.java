package com.Neighborly.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.Neighborly.model.UserModel;
import com.Neighborly.utils.SessionUtil;

/**
 * Servlet Filter implementation class AuthenticationFilter
 */

@WebFilter(urlPatterns = {"/home","/feed","/news","/documents","/payments","/report","/polls","/notices","/contact","/profile","/aboutus","/logout","/admindashboard","/noticelist","/pollmanagement","/issuefine","/reportissue","/newslist","/generatereport","/createnews","/updatenews","/deletenews","/createjob","/updatejob","/deletejob","/createpoll","/deletepoll","/deletenotice","/updatenotice","/moderateissue","/deleteissue","/documentmanagement","/citizenmanagement","/suspendcitizen","/unsuspendcitizen","/contactmessage","/documentlist"})
public class AuthenticationFilter extends HttpFilter implements Filter {
       
    private static final long serialVersionUID = 1L;

    public AuthenticationFilter() {
        super();
    }

	public void destroy() {
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		
	    HttpServletRequest httpRequest = (HttpServletRequest) request;
	    HttpServletResponse httpResponse = (HttpServletResponse) response;
	    boolean isLoggedIn = SessionUtil.getAttribute(httpRequest, "user") != null;

	    if (isLoggedIn) {
	        UserModel user = (UserModel) SessionUtil.getAttribute(httpRequest, "user");
	        boolean isAdmin = "admin".equalsIgnoreCase(user.getRole());
	        String path = httpRequest.getServletPath();

	        String[] citizenPages = {"/home","/feed","/polls","/notices","/report","/documents","/payments","/profile","/contact","/aboutus"};
	        String[] adminPages = {"/admindashboard","/noticelist","/pollmanagement","/issuefine","/reportissue","/newslist","/citizenmanagement","/generatereport","/contactmessage","/documentlist","/newsmanagement","/noticemanagement","/documentmanagement","/reportmanagement","/createnews","/updatenews","/deletenews","/createpoll","/updateupdatepoll","/deletepoll","/updatenotice","/deletenotice","/moderateissue","/suspendcitizen","/unsuspenduser","/deletedocument","/rejectdocument"};

	        for (String p : citizenPages) {
	            if (path.equals(p) && isAdmin) {
	                httpResponse.sendRedirect(httpRequest.getContextPath() + "/admindashboard");
	                return;
	            }
	        }

	        for (String p : adminPages) {
	            if (path.equals(p) && !isAdmin) {
	                httpResponse.sendRedirect(httpRequest.getContextPath() + "/home");
	                return;
	            }
	        }

	        chain.doFilter(request, response);
	    } else {
	        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	        httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
	    }
	}

	public void init(FilterConfig fConfig) throws ServletException {
	}

}