package com.Neighborly.service;

public class ContactService {

    public String validateContact(String fullName, String email, String subject, String message) {

        if (fullName == null || fullName.trim().isEmpty()) {
            return "Full name is required";
        }

        if (email == null || email.trim().isEmpty()) {
            return "Email address is required";
        }

        if (!email.trim().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
            return "Please enter a valid email address";
        }

        if (subject == null || subject.trim().isEmpty()) {
            return "Subject is required";
        }

        if (message == null || message.trim().isEmpty()) {
            return "Message is required";
        }

        return "Success";
    }
}
