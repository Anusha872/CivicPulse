package com.Neighborly.service;

public class PollService {
	
	public String validatePoll(String title, String description, String option1, String option2) {

		if (title == null || title.trim().isEmpty()) {
			return "Poll title is required";
		}
		if (description == null || description.trim().isEmpty()) {
			return "Description is required";
		}
		if (option1 == null || option1.trim().isEmpty()) {
			return "Option 1 is required";
		}
		if (option2 == null || option2.trim().isEmpty()) {
			return "Option 2 is required";
		}

		return "Success";
	}
}
