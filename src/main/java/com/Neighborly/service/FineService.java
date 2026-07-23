package com.Neighborly.service;

import java.util.ArrayList;
import java.util.List;

public class FineService {

	public String validateFine(String userId, String violationType, String fineAmount, String violationDate,
			String reason) {

		if (userId == null || userId.trim().isEmpty()) {
			return "Citizen is required";
		}

		if (violationType == null || violationType.trim().isEmpty()) {
			return "Violation type is required";
		}

		if (fineAmount == null || fineAmount.trim().isEmpty()) {
			return "Fine amount is required";
		}

		if (violationDate == null || violationDate.trim().isEmpty()) {
			return "Date of violation is required";
		}

		if (reason == null || reason.trim().isEmpty()) {
			return "Reason is required";
		}
		
		List<String> allowedTypes = new ArrayList<>();
		
		allowedTypes.add("Speeding");
		allowedTypes.add("No helmet");
		allowedTypes.add("No seatbelt");
		allowedTypes.add("Wrong parking");
		allowedTypes.add("No license");
		allowedTypes.add("Other");

		if (!allowedTypes.contains(violationType.trim())) {
		    return "Invalid violation type";
		}

		// userId must be a number
		try {
			
			Integer.parseInt(userId.trim());
			
		} catch (NumberFormatException e) {
			
			return "Invalid citizen ID";
		}

		// fineAmount must be a number
		try {
			
			Double.parseDouble(fineAmount.trim());
			
		} catch (NumberFormatException e) {
			
			return "Fine amount must be a valid number";
		}

		// violationDate must be a valid date
		try {
			
			java.time.LocalDate.parse(violationDate.trim());
			
		} catch (Exception e) {
			return "Invalid date format";
		}

		return "Success";
	}
}
