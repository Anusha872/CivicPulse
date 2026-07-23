package com.Neighborly.model;

/**
 * Model class for submitting feedback or questions.
 */

public class ContactModel {

    private int contactId;
    private String fullName;
    private String email;
    private String subject;
    private String message;
    private String createdAt;

    // Getters
    public int getContactId() {
        return contactId;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getSubject() {
        return subject;
    }

    public String getMessage() {
        return message;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    // Setters
    public void setContactId(int contactId) {
        this.contactId = contactId;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
}
