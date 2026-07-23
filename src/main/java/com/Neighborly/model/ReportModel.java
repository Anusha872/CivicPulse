package com.Neighborly.model;

/**
 * Model class for Reporting incident or issuing reports.
 */

public class ReportModel {

    private int reportId;
    private int userId;
    private String title;
    private String category;
    private String location;
    private String description;
    private String reportPhoto;
    private String status;
    private String createdAt;
    private String firstName;
    private String lastName;
    private String staffNotes;

    // Getters
    public int getReportId() {
        return reportId; 
    }
    
    public int getUserId() {
        return userId;
    }

    public String getTitle() {
        return title;
    }

    public String getCategory() {
        return category;
    }

    public String getLocation() {
        return location;
    }

    public String getDescription() {
        return description;
    }

    public String getReportPhoto() {
        return reportPhoto;
    }

    public String getStatus() {
        return status;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    // Setters
    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setReportPhoto(String reportPhoto) {
        this.reportPhoto = reportPhoto;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
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

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getStaffNotes() {
		return staffNotes;
	}

	public void setStaffNotes(String staffNotes) {
		this.staffNotes = staffNotes;
	}
}
