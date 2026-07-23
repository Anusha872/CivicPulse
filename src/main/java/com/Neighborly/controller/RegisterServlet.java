package com.Neighborly.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.io.File;
import com.Neighborly.service.RegisterService;
import com.Neighborly.utils.FileUploadUtil;

@WebServlet(asyncSupported = true, urlPatterns = { "/register" })
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads";

	public RegisterServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String firstName = request.getParameter("first_name");
		String lastName = request.getParameter("last_name");
		String username = request.getParameter("username");
		String dob = request.getParameter("dob");
		String gender = request.getParameter("gender");
		String email = request.getParameter("email");
		String number = request.getParameter("number");
		String password = request.getParameter("password");

		// Set attributes so the form can repopulate values on error
		request.setAttribute("first_name", firstName);
		request.setAttribute("last_name", lastName);
		request.setAttribute("username", username);
		request.setAttribute("dob", dob);
		request.setAttribute("gender", gender);
		request.setAttribute("email", email);
		request.setAttribute("number", number);


		if (firstName == null || firstName.trim().isEmpty() || !firstName.matches("[a-zA-Z ]+")) {
			request.setAttribute("error", "Invalid First name");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (lastName == null || lastName.trim().isEmpty() || !lastName.matches("[a-zA-Z ]+")) {
			request.setAttribute("error", "Invalid Last name");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (username == null || username.trim().isEmpty() || username.length() < 3 || !username.matches("[a-zA-Z]+")) {
			request.setAttribute("error", "Username should be 3 letters or more");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (dob == null || dob.trim().isEmpty()) {
			request.setAttribute("error", "Date of birth is required");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (gender == null || gender.trim().isEmpty()) {
			request.setAttribute("error", "Gender is required");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (email == null || email.trim().isEmpty() || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
			request.setAttribute("error", "Valid email address is required");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (number == null || number.trim().isEmpty() || !number.matches("\\d{10}")) {
			request.setAttribute("error", "Phone number must be 10 digits");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}
		if (password == null || password.trim().isEmpty()) {
			request.setAttribute("error", "Password is required");
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
			return;
		}

		try {
			Part filePart = request.getPart("profileImage");

			// Photo is compulsory
			if (filePart == null || filePart.getSize() == 0) {
				request.setAttribute("error", "Profile photo is required");
				request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
				return;
			}
			if (!FileUploadUtil.isImage(filePart)) {
				request.setAttribute("error", "Invalid image type. Please upload a valid image.");
				request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
				return;
			}

			String extension = FileUploadUtil.getFileExtension(filePart.getSubmittedFileName());
			String image = username + extension;
			FileUploadUtil.saveFile(filePart, UPLOAD_DIR, image);

			RegisterService service = new RegisterService();
			service.addUser(firstName, lastName, username, dob, gender, email, number, password, image);
			response.sendRedirect(request.getContextPath() + "/login");

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "Registration failed: " + e.getMessage());
			request.getRequestDispatcher("/WEB-INF/Pages/register.jsp").forward(request, response);
		}
	}
}