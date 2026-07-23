package com.Neighborly.service;

import com.Neighborly.dao.UserDAO;
import com.Neighborly.utils.PasswordUtil;

public class RegisterService {
    public void addUser(String firstName, String lastName, String username, String dob,
                        String gender, String email, String number, String password, String image) throws Exception {
    	password = PasswordUtil.hashPassword(password);
    	UserDAO dao = new UserDAO();
        dao.insertUsers(firstName, lastName, username, dob, gender, email, number, password, image);
    }
}