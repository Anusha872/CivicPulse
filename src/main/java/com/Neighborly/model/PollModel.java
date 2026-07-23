package com.Neighborly.model;

/**
 * Model class for opinion poll.
 */

public class PollModel {
	private int pollId;
	private String question;
	private String status;
	private String createdAt;
	private int userId;
	private String description;
	private String option1;
	private String option2;
	private String userVote;
	private int option1Count;
	private int option2Count;

	// Getters
	public int getPollId() {
		return pollId;
	}

	public String getQuestion() {
		return question;
	}

	public String getStatus() {
		return status;
	}

	public String getDescription() {
		return description;
	}

	public String getOption1() {
		return option1;
	}

	public String getOption2() {
		return option2;
	}

	public String getCreatedAt() {
		return createdAt;
	}

	public int getUserId() {
		return userId;
	}

	public String getUserVote() {
		return userVote;
	}

	public void setUserVote(String userVote) {
		this.userVote = userVote;
	}

	public int getOption2Count() {
		return option2Count;
	}

	public int getTotalVotes() {
		return option1Count + option2Count;
	}

	// Setters
	public void setPollId(int pollId) {
		this.pollId = pollId;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setOption1(String option1) {
		this.option1 = option1;
	}

	public void setOption2(String option2) {
		this.option2 = option2;
	}

	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public void setOption2Count(int option2Count) {
		this.option2Count = option2Count;
	}

	public int getOption1Count() {
		return option1Count;
	}

	public void setOption1Count(int option1Count) {
		this.option1Count = option1Count;
	}
	
	public boolean isHasVoted() {
	    return userVote != null;
	}
}
