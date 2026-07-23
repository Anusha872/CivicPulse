package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.PollModel;
import com.Neighborly.utils.DBconfig;


public class PollDAO {
	
	/**
	 * Inserts a new poll.
	 *
	 * Input: question, description, option1, option2, status, adminId
	 * Output: void
	 * Function: Adds a new poll record to the polls table with the given question, options, and admin owner.
	 *
	 * @param question the poll question
	 * @param description the poll description
	 * @param option1 the first poll option
	 * @param option2 the second poll option
	 * @param status the poll status
	 * @param adminId the ID of the admin who created the poll
	 * @throws Exception if a database error occurs
	 */
	public void insertPoll(String question, String description, String option1, String option2, String status,
			int adminId) throws Exception {
		Connection con = DBconfig.getConnection();
		String sql = "INSERT INTO polls (poll_question, poll_description, poll_option1, poll_option2, poll_status, user_id) VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, question);
		pst.setString(2, description);
		pst.setString(3, option1);
		pst.setString(4, option2);
		pst.setString(5, status);
		pst.setInt(6, adminId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all active polls.
	 *
	 * Input: none
	 * Output: List<PollModel>
	 * Function: Returns only polls whose status is 'Active'.
	 *
	 * @return a list of active polls
	 * @throws Exception if a database error occurs
	 */

	public List<PollModel> getAllPolls() throws Exception {
		List<PollModel> polls = new ArrayList<>();
		String sql = "SELECT poll_id, poll_question, poll_description, poll_option1, poll_option2, "
				+ "poll_status, poll_created_at, user_id FROM polls WHERE poll_status = 'Active'";
		try (Connection con = DBconfig.getConnection();
				PreparedStatement pst = con.prepareStatement(sql);
				ResultSet rs = pst.executeQuery()) {
			while (rs.next()) {
				PollModel p = new PollModel();
				p.setPollId(rs.getInt("poll_id"));
				p.setQuestion(rs.getString("poll_question"));
				p.setDescription(rs.getString("poll_description"));
				p.setOption1(rs.getString("poll_option1"));
				p.setOption2(rs.getString("poll_option2"));
				p.setStatus(rs.getString("poll_status"));
				p.setCreatedAt(rs.getString("poll_created_at"));
				p.setUserId(rs.getInt("user_id"));
				polls.add(p);
			}
		}
		return polls;
	}
	
	/**
	 * Retrieves every poll in the database.
	 *
	 * Input: none
	 * Output: List<PollModel>
	 * Function: Loads all poll records regardless of status.
	 *
	 * @return a list of all polls
	 * @throws Exception if a database error occurs
	 */
	public List<PollModel> getTotalPolls() throws Exception {
		List<PollModel> polls = new ArrayList<>();

		Connection con = DBconfig.getConnection();

		String sql = "SELECT poll_id, poll_question, poll_description, poll_option1, poll_option2, poll_status, poll_created_at, user_id FROM polls";

		PreparedStatement pst = con.prepareStatement(sql);

		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			PollModel p = new PollModel();
			p.setPollId(rs.getInt("poll_id"));
			p.setQuestion(rs.getString("poll_question"));
			p.setDescription(rs.getString("poll_description"));
			p.setOption1(rs.getString("poll_option1"));
			p.setOption2(rs.getString("poll_option2"));
			p.setStatus(rs.getString("poll_status"));
			p.setCreatedAt(rs.getString("poll_created_at"));
			p.setUserId(rs.getInt("user_id"));
			polls.add(p);
		}

		rs.close();
		pst.close();
		con.close();
		return polls;
	}

	/**
	 * Updates a poll's question and options.
	 *
	 * Input: pollId, question, description, option1, option2
	 * Output: void
	 * Function: Modifies the poll text and option values for the selected poll.
	 *
	 * @param pollId the ID of the poll to update
	 * @param question the updated question
	 * @param description the updated description
	 * @param option1 the updated first option
	 * @param option2 the updated second option
	 * @throws Exception if a database error occurs
	 */
	public void updatePoll(int pollId, String question, String description, String option1, String option2)
			throws Exception {

		Connection con = DBconfig.getConnection();
		String sql = "UPDATE polls SET poll_question = ?, poll_description = ?, poll_option1 = ?, poll_option2 = ? WHERE poll_id = ?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setString(1, question);
		pst.setString(2, description);
		pst.setString(3, option1);
		pst.setString(4, option2);
		pst.setInt(5, pollId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Soft-deletes a poll by marking it inactive.
	 *
	 * Input: pollId
	 * Output: boolean
	 * Function: Changes the poll status to 'Inactive' instead of deleting the row permanently.
	 *
	 * @param pollId the ID of the poll to deactivate
	 * @return true if the poll was updated, otherwise false
	 * @throws Exception if a database error occurs
	 */
	public boolean deletePoll(int pollId) throws Exception {
		String sql = "UPDATE polls SET poll_status = 'Inactive' WHERE poll_id = ?";

		Connection con = DBconfig.getConnection();

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, pollId);

		int rowsAffected = pst.executeUpdate();
		pst.close();
		con.close();
		return rowsAffected > 0;

	}

	/**
	 * Records a user's vote on a poll.
	 *
	 * Input: pollId, userId, votedOption
	 * Output: boolean
	 * Function: Inserts a vote record or ignores duplicates if the user already voted.
	 *
	 * @param pollId the ID of the poll
	 * @param userId the ID of the voting user
	 * @param votedOption the selected poll option
	 * @return true if the vote was saved, otherwise false
	 * @throws Exception if a database error occurs
	 */
	public boolean vote(int pollId, int userId, String votedOption) throws Exception {

		Connection con = DBconfig.getConnection();
		String sql = "INSERT IGNORE INTO pollvote (poll_id, user_id, voted_option) VALUES (?, ?, ?)";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, pollId);
		pst.setInt(2, userId);
		pst.setString(3, votedOption);

		int rows = pst.executeUpdate();

		pst.close();
		con.close();
		return rows > 0;
	}

	/**
	 * Removes a user's vote from a poll.
	 *
	 * Input: pollId, userId
	 * Output: boolean
	 * Function: Deletes the vote record for the specified user and poll.
	 *
	 * @param pollId the ID of the poll
	 * @param userId the ID of the user
	 * @return true if a vote was removed, otherwise false
	 * @throws Exception if a database error occurs
	 */
	public boolean unvote(int pollId, int userId) throws Exception {

		Connection con = DBconfig.getConnection();

		String sql = "DELETE FROM pollvote WHERE poll_id = ? AND user_id = ?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, pollId);
		pst.setInt(2, userId);

		int rows = pst.executeUpdate();

		pst.close();
		con.close();
		return rows > 0;
	}

	/**
	 * Retrieves the option a user voted for on a poll.
	 *
	 * Input: pollId, userId
	 * Output: String
	 * Function: Returns the stored voted option for the given user and poll, or null if no vote exists.
	 *
	 * @param pollId the ID of the poll
	 * @param userId the ID of the user
	 * @return the voted option, or null if none exists
	 * @throws Exception if a database error occurs
	 */
	public String getUserVote(int pollId, int userId) throws Exception {

		Connection con = DBconfig.getConnection();

		String sql = "SELECT voted_option FROM pollvote WHERE poll_id = ? AND user_id = ?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, pollId);
		pst.setInt(2, userId);

		ResultSet rs = pst.executeQuery();

		String result = null;

		if (rs.next())
			result = rs.getString("voted_option");
		rs.close();
		pst.close();
		con.close();
		return result;
	}

	/**
	 * Counts votes for a poll.
	 *
	 * Input: pollId
	 * Output: int[]
	 * Function: Returns the number of votes for option1 and option2 as an integer array.
	 *
	 * @param pollId the ID of the poll
	 * @return an array where index 0 is the first option count and index 1 is the second option count
	 * @throws Exception if a database error occurs
	 */
	public int[] getVoteCounts(int pollId) throws Exception {

		Connection con = DBconfig.getConnection();

		String sql = "SELECT voted_option, COUNT(*) AS count FROM pollvote WHERE poll_id = ? GROUP BY voted_option";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, pollId);

		ResultSet rs = pst.executeQuery();

		int opt1 = 0;
		int opt2 = 0;

		while (rs.next()) {

			String Option = rs.getString("voted_option");
			if ("option1".equals(Option)) {

				opt1 = rs.getInt("count");
			}

			else {

				opt2 = rs.getInt("count");
			}
		}
		rs.close();
		pst.close();
		con.close();
		return new int[] { opt1, opt2 };
	}

}