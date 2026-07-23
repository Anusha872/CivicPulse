package com.Neighborly.model;

/**
 * Model class for fines issued to a user.
 */

public class FineModel {
	
	private int fineId;
	private int userId;
	private String firstName;
	private String lastName;
	private String violationType;
	private double fineAmount;
	private String violationDate;
	private String reason;
	private String status;
	private String issuedAt;

	public int getFineId() {
		return fineId;
	}

	// --- Getters
	public void setFineId(int fineId) {
		this.fineId = fineId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	// Setters
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getViolationType() {
		return violationType;
	}

	public void setViolationType(String violationType) {
		this.violationType = violationType;
	}

	public double getFineAmount() {
		return fineAmount;
	}

	public void setFineAmount(double fineAmount) {
		this.fineAmount = fineAmount;
	}

	public String getViolationDate() {
		return violationDate;
	}

	public void setViolationDate(String violationDate) {
		this.violationDate = violationDate;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getIssuedAt() {
		return issuedAt;
	}

	public void setIssuedAt(String issuedAt) {
		this.issuedAt = issuedAt;
	}

}
