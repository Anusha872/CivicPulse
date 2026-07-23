package com.Neighborly.model;

/**
 * Model class for storing profile information and credentials of a User.
 */

import java.util.Date;

public class UserModel {

	private int userId;
	private String firstName;
	private String lastName;
	private String userName;
	private Date dob;
	private String gender;
	private String email;
	private String number;
	private String password;
	private String role;
	private String image;
	private String status;
	private java.util.Date registrationDate;

	// Getters
	public int getUserId() {
		return userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public String getUserName() {
		return userName;
	}

	public Date getDob() {
		return dob;
	}

	public String getGender() {
		return gender;
	}

	public String getEmail() {
		return email;
	}

	public String getNumber() {
		return number;
	}

	public String getPassword() {
		return password;
	}

	public String getRole() {
		return role;
	}

	public String getImage() {
		return image;
	}

	public String getStatus() {
		return status;
	}

	// Setters
	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public java.util.Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(java.util.Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public String getInitials() {
	    if (userName != null && userName.length() >= 2) {
	    	
	        String initials = userName.substring(0, 2).toUpperCase();
	        
	        return initials;
	    }
	    return "";
	}

}
