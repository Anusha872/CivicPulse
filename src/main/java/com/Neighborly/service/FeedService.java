package com.Neighborly.service;

public class FeedService {

    public String validatePost(String content, String postType) {

        if (content == null || content.trim().isEmpty()) {
            return "Post content cannot be empty.";
        }
        if (content.trim().length() > 2000) {
            return "Post content must not exceed 2000 characters.";
        }
        if (postType != null && !postType.isEmpty()) {
            if (!postType.equals("general")
                    && !postType.equals("alert")
                    && !postType.equals("discussion")) {
                return "Invalid post type.";
            }
        }
        return "Success";
    }

    public String validateVote(String postIdStr, String voteType) {

        if (postIdStr == null || postIdStr.isBlank()) {
            return "Missing post ID.";
        }
        if (voteType == null
                || (!voteType.equals("up") && !voteType.equals("down"))) {
            return "Vote must be 'up' or 'down'.";
        }
        try {
            Integer.parseInt(postIdStr);
        } catch (NumberFormatException e) {
            return "Invalid post ID.";
        }
        return "Success";
    }
}