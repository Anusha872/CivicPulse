package com.Neighborly.service;

import com.Neighborly.dao.UserDAO;
import com.Neighborly.model.UserModel;
import com.Neighborly.utils.PasswordUtil;

public class LoginService {

    public String authenticate(String username, String password) throws Exception {
        if (username == null || username.trim().isEmpty()) {
            return "Insert Username";
        }
        if (password == null || password.trim().isEmpty()) {
            return "Password is required";
        }

        UserDAO userDAO = new UserDAO();
        UserModel user = userDAO.getUserByUsername(username);

        if (user == null) {
            return "User Not Found";
        }

        if (!PasswordUtil.checkPassword(password, user.getPassword())) {
            return "Password Incorrect";
        }

        return "Success";
        
    }
}