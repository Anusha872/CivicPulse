package com.Neighborly.service;

public class ReportService {

    public String validateReport(String title, String category,
                                  String location, String description) {
        if (title == null || title.trim().isEmpty()) {
            return "Report title is required";
        }
        if (category == null || category.trim().isEmpty()) {
            return "Category is required";
        }
        if (location == null || location.trim().isEmpty()) {
            return "Location is required";
        }
        if (description == null || description.trim().isEmpty()) {
            return "Description is required";
        }
        return "Success";
    }
}