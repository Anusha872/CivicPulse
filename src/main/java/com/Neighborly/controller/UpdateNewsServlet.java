package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.Neighborly.dao.NewsDAO;
import com.Neighborly.utils.FileUploadUtil;

/**
 * Servlet implementation class UpdateNewsServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/updatenews" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class UpdateNewsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "news_uploads";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UpdateNewsServlet() {
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
		response.sendRedirect(request.getContextPath() + "/newslist");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		int newsId = Integer.parseInt(request.getParameter("newsId"));
		String title = request.getParameter("newsTitle");
		String content = request.getParameter("newsContent");
		String category = request.getParameter("newsCategory");

		try {
			NewsDAO dao = new NewsDAO();

			Part filePart = request.getPart("newsImage");

			// Check if user actually uploaded a new image
			if (filePart != null && filePart.getSize() > 0 && FileUploadUtil.isImage(filePart)) {
				
				String ext = FileUploadUtil.getFileExtension(filePart.getSubmittedFileName());
				
				String imageName = System.currentTimeMillis() + ext;
				
				FileUploadUtil.saveFile(filePart, UPLOAD_DIR, imageName);
				
				dao.updateNewsWithImage(newsId, title, content, category, imageName);
			} else {
				// No new image uploaded — keep the existing one
				dao.updateNews(newsId, title, content, category);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		response.sendRedirect(request.getContextPath() + "/newslist");
	}

}