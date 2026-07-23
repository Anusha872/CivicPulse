package com.Neighborly.model;

/**
 * Model class for storing feed posts, interactionand saved posts.
 */

public class FeedModel {

    private int postId;
    private int userId;
    private String userName;
    private String content;
    private String postType;
    private String createdAt;
    private String postTime;
    private String userVote;
    private int upCount;
    private int downCount;
    private boolean savedByUser;
    private String postImage;
    private String userImage;
    
    // --- Getters ---

    public int getPostId() {
        return postId;
    }

    public int getUserId() {
        return userId;
    }

    public String getUserName() {
        return userName;
    }

    public String getContent() {
        return content;
    }

    public String getPostType() {
        return postType;
    }

    public String getCreatedAt() {
        return createdAt;
    }
    
    public String  getPostTime() {
    	return postTime;
    }

    public String getUserVote() {
        return userVote;
    }

    public int getUpCount() {
        return upCount;
    }

    public int getDownCount() {
        return downCount;
    }

    public boolean isSavedByUser() {
        return savedByUser;
    }

    public int getNetScore() {
        return upCount - downCount;
    }
    
    public String getPostImage() { 
    	return postImage;
    }
    
    public String getUserImage() {
        return userImage;
    }

    // --- Setters ---

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setPostType(String postType) {
        this.postType = postType;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }
    
    public void setPostTime(String postTime) { 
    	this.postTime = postTime; 
    }

    public void setUserVote(String userVote) {
        this.userVote = userVote;
    }

    public void setUpCount(int upCount) {
        this.upCount = upCount;
    }

    public void setDownCount(int downCount) {
        this.downCount = downCount;
    }

    public void setSavedByUser(boolean savedByUser) {
        this.savedByUser = savedByUser;
    }
    
    public void setPostImage(String postImage) {
    	this.postImage = postImage; 
    }
    
    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }
}
