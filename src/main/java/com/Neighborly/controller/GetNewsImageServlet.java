package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;



/**
 * Servlet implementation class GetNewsImageServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/newsimage/*" })
public class GetNewsImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "news_uploads";

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetNewsImageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = request.getPathInfo().substring(1);
        
        File file = new File(UPLOAD_DIR, fileName);
        
        if (file.exists()) {
        	
            response.setContentType(Files.probeContentType(file.toPath()));
            
            Files.copy(file.toPath(), response.getOutputStream());
            
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
