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
import com.Neighborly.model.UserModel;
import com.Neighborly.service.NewsService;
import com.Neighborly.utils.FileUploadUtil;
import com.Neighborly.utils.SessionUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/createnews" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,
    maxFileSize       = 1024 * 1024 * 10,
    maxRequestSize    = 1024 * 1024 * 50
)
public class CreateNewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR =
        System.getProperty("user.home") + File.separator + "news_uploads";
    

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// FIX: Was writing raw text "Served at: ..." to the response.
		// Now redirects to the news management page like the other servlets do.
		response.sendRedirect(request.getContextPath() + "/newslist");
	}

	

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Session check
        UserModel user = (UserModel) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String title    = request.getParameter("newsTitle");
        String content  = request.getParameter("newsContent");
        String category = request.getParameter("newsCategory");

        // Validate
        NewsService service = new NewsService();
        String validation = service.validateNews(title, content);

        if (!validation.equals("Success")) {
            // Reload the management page with error + re-open modal
            NewsDAO dao = new NewsDAO();
            try {
                java.util.List<com.Neighborly.model.NewsModel> newsList = dao.getAllNews();
                request.setAttribute("newsList", newsList);
                request.setAttribute("totalNews", newsList.size());
            } catch (Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("errorMessage", validation);
            request.setAttribute("openCreateNews", true);
            request.getRequestDispatcher("/WEB-INF/Pages/NewsManagement.jsp")
                   .forward(request, response);
            return;
        }

        // Handle image upload
        String imageName = null;
        Part filePart = request.getPart("newsImage");
        if (filePart != null && filePart.getSize() > 0) {
            if (FileUploadUtil.isImage(filePart)) {
                String extension = FileUploadUtil.getFileExtension(
                    filePart.getSubmittedFileName());
                imageName = System.currentTimeMillis() + extension;
                FileUploadUtil.saveFile(filePart, UPLOAD_DIR, imageName);
            }
        }

        // Insert
        try {
            NewsDAO dao = new NewsDAO();
            dao.insertNews(user.getUserId(), title.trim(), content.trim(),
                           category, imageName);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to create news. Please try again.");
            request.setAttribute("openCreateNews", true);
            request.getRequestDispatcher("/WEB-INF/Pages/NewsManagement.jsp")
                   .forward(request, response);
            return;
        }

        response.sendRedirect(request.getContextPath() + "/newslist");
    }
}