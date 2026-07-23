package com.Neighborly.service;

public class NewsService {
	
	public String validateNews(String title, String content) {

		if (title == null || title.trim().isEmpty()) {
			return "News title is required";
		}
		if (title.trim().length() < 5) {
			return "News title must be at least 5 characters";
		}
		if (title.trim().length() > 150) {
			return "News title cannot exceed 150 characters";
		}
		if (content == null || content.trim().isEmpty()) {
			return "News content is required";
		}
		if (content.trim().length() < 10) {
			return "News content must be at least 10 characters";
		}
		if (content.trim().length() > 5000) {
			return "News content cannot exceed 5000 characters";
		}

		return "Success";
	}
}
