package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.NoticeModel;
import com.Neighborly.utils.DBconfig;

public class NoticeDAO {

	/**
	 * Inserts a new notice.
	 *
	 * Input: userId, title, category, description
	 * Output: void
	 * Function: Adds a notice record to the notices table with the provided details.
	 *
	 * @param userId the ID of the user posting the notice
	 * @param title the notice title
	 * @param category the notice category
	 * @param description the notice text
	 * @throws Exception if a database error occurs
	 */
	public void insertNotice(int userId, String title, String category, String description) throws Exception {

		String sql = "INSERT INTO notices (user_id, notice_title, notice_category, notice_description) VALUES (?, ?, ?, ?)";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		pst.setString(2, title);
		pst.setString(3, category);
		pst.setString(4, description);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all notices.
	 *
	 * Input: none
	 * Output: List<NoticeModel>
	 * Function: Loads all notices with the posting user's username and formats the posting time.
	 *
	 * @return a list of all notices
	 * @throws Exception if a database error occurs
	 */
	public List<NoticeModel> getAllNotices() throws Exception {

		List<NoticeModel> notices = new ArrayList<>();
		// FIX: Changed JOIN from `admins` (non-existent) to `users` which is the actual
		// table that stores all users including admins (identified by role = 'admin').
		String sql = "SELECT n.notice_id, n.user_id, u.username, "
				+ "       n.notice_title, n.notice_category, "
				+ "       n.notice_description, n.notice_posted_at "
				+ "FROM notices n "
				+ "JOIN users u ON n.user_id = u.user_id "
				+ "ORDER BY n.notice_posted_at DESC";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			NoticeModel n = new NoticeModel();
			n.setNoticeId(rs.getInt("notice_id"));
			n.setUserId(rs.getInt("user_id"));
			n.setNoticeTitle(rs.getString("notice_title"));
			n.setNoticeCategory(rs.getString("notice_category"));
			n.setNoticeDescription(rs.getString("notice_description"));
			n.setCreatedAt(rs.getString("notice_posted_at"));
			n.setPostTime(formatTime(rs.getTimestamp("notice_posted_at")));
			notices.add(n);
		}

		rs.close();
		pst.close();
		con.close();
		return notices;
	}

	private String formatTime(java.sql.Timestamp ts) {
		if (ts == null)
			return "Just now";
		long diff = System.currentTimeMillis() - ts.getTime();
		long mins = diff / 60000;
		long hours = mins / 60;
		long days = hours / 24;
		if (mins < 1)
			return "Just now";
		if (mins < 60)
			return mins + "m ago";
		if (hours < 24)
			return hours + "h ago";
		if (days < 7)
			return days + "d ago";
		return new java.text.SimpleDateFormat("MMM d").format(ts);
	}

	/**
	 * Updates an existing notice.
	 *
	 * Input: noticeId, title, category, description
	 * Output: void
	 * Function: Updates the title, category, and description of the specified notice.
	 *
	 * @param noticeId the ID of the notice
	 * @param title the updated title
	 * @param category the updated category
	 * @param description the updated notice description
	 * @throws Exception if a database error occurs
	 */
	public void updateNotice(int noticeId, String title, String category, String description) throws Exception {

		String sql = "UPDATE notices SET notice_title = ?, notice_category = ?, notice_description = ? WHERE notice_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, title);
		pst.setString(2, category);
		pst.setString(3, description);
		pst.setInt(4, noticeId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Deletes a notice from the database.
	 *
	 * Input: noticeId
	 * Output: boolean
	 * Function: Permanently removes the notice record and returns whether the deletion succeeded.
	 *
	 * @param noticeId the ID of the notice
	 * @return true if the notice was deleted, otherwise false
	 * @throws Exception if a database error occurs
	 */
	public boolean deleteNotice(int noticeId) throws Exception {

		String sql = "DELETE FROM notices WHERE notice_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, noticeId);
		int rows = pst.executeUpdate();
		pst.close();
		con.close();

		return rows > 0;
	}
}