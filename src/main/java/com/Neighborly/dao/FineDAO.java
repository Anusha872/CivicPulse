package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.FineModel;
import com.Neighborly.utils.DBconfig;

public class FineDAO {

	/**
	 * Adds a new fine record for a user.
	 *
	 * Input: userId, violationType, fineAmount, violationDate, reason
	 * Output: void
	 * Function: Inserts a fine entry into the fines table with the provided violation details.
	 *
	 * @param userId the ID of the user being fined
	 * @param violationType the type of violation
	 * @param fineAmount the amount of the fine
	 * @param violationDate the date of the violation
	 * @param reason the explanation for the fine
	 * @throws Exception if a database error occurs
	 */
	public void insertFine(int userId, String violationType, double fineAmount, String violationDate, String reason)
			throws Exception {

		String sql = "INSERT INTO fines (user_id, violation_type, fine_amount, violation_date, reason) VALUES (?, ?, ?, ?, ?)";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		pst.setString(2, violationType);
		pst.setDouble(3, fineAmount);
		pst.setString(4, violationDate);
		pst.setString(5, reason);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all fines that are not deleted.
	 *
	 * Input: none
	 * Output: List<FineModel>
	 * Function: Fetches all active fine records with user details, sorted by newest first.
	 *
	 * @return a list of all fines
	 * @throws Exception if a database error occurs
	 */
	public List<FineModel> getAllFines() throws Exception {
		List<FineModel> fines = new ArrayList<>();
		String sql = "SELECT f.fine_id, f.user_id, u.first_name, u.last_name, f.violation_type, f.fine_amount, "
				+ "       f.violation_date, f.reason, f.fine_status, f.issued_at " + "FROM fines f "
				+ "JOIN users u ON f.user_id = u.user_id " + "WHERE f.fine_status != 'Deleted' "
				+ "ORDER BY f.issued_at DESC";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			FineModel f = new FineModel();
			f.setFineId(rs.getInt("fine_id"));
			f.setUserId(rs.getInt("user_id"));
			f.setFirstName(rs.getString("first_name"));
			f.setLastName(rs.getString("last_name"));
			f.setViolationType(rs.getString("violation_type"));
			f.setFineAmount(rs.getDouble("fine_amount"));
			f.setViolationDate(rs.getString("violation_date"));
			f.setReason(rs.getString("reason"));
			f.setStatus(rs.getString("fine_status"));
			f.setIssuedAt(rs.getString("issued_at"));
			fines.add(f);
		}

		rs.close();
		pst.close();
		con.close();

		return fines;
	}

	/**
	 * Marks a fine as paid.
	 *
	 * Input: fineId
	 * Output: void
	 * Function: Updates the selected fine status to 'Paid'.
	 *
	 * @param fineId the ID of the fine to mark as paid
	 * @throws Exception if a database error occurs
	 */
	public void markPaid(int fineId) throws Exception {

		String sql = "UPDATE fines SET fine_status = 'Paid' WHERE fine_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, fineId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Soft-deletes a fine record.
	 *
	 * Input: fineId
	 * Output: void
	 * Function: Changes the fine status to 'Deleted' instead of removing the row permanently.
	 *
	 * @param fineId the ID of the fine to delete
	 * @throws Exception if a database error occurs
	 */
	public void deleteFine(int fineId) throws Exception {

		String sql = "UPDATE fines SET fine_status = 'Deleted' WHERE fine_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, fineId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves fines for a specific user.
	 *
	 * Input: userId
	 * Output: List<FineModel>
	 * Function: Loads all non-deleted fines belonging to the given user.
	 *
	 * @param userId the ID of the user
	 * @return a list of fines for the user
	 * @throws Exception if a database error occurs
	 */
	public List<FineModel> getFinesByUser(int userId) throws Exception {

		List<FineModel> fines = new ArrayList<>();

		String sql = "SELECT f.fine_id, f.user_id, u.first_name, u.last_name, "
				+ "       f.violation_type, f.fine_amount, f.violation_date, "
				+ "       f.reason, f.fine_status, f.issued_at " + "FROM fines f "
				+ "JOIN users u ON f.user_id = u.user_id " + "WHERE f.user_id = ? AND f.fine_status != 'Deleted' "
				+ "ORDER BY f.issued_at DESC";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			FineModel f = new FineModel();
			f.setFineId(rs.getInt("fine_id"));
			f.setUserId(rs.getInt("user_id"));
			f.setFirstName(rs.getString("first_name"));
			f.setLastName(rs.getString("last_name"));
			f.setViolationType(rs.getString("violation_type"));
			f.setFineAmount(rs.getDouble("fine_amount"));
			f.setViolationDate(rs.getString("violation_date"));
			f.setReason(rs.getString("reason"));
			f.setStatus(rs.getString("fine_status"));
			f.setIssuedAt(rs.getString("issued_at"));
			fines.add(f);
		}

		rs.close();
		pst.close();
		con.close();
		return fines;
	}

	/**
	 * Retrieves unpaid fines for a specific user.
	 *
	 * Input: userId
	 * Output: List<FineModel>
	 * Function: Returns only fines with status 'Unpaid' for the given user.
	 *
	 * @param userId the ID of the user
	 * @return a list of unpaid fines
	 * @throws Exception if a database error occurs
	 */
    public List<FineModel> getPendingFinesByUser(int userId) throws Exception {
        List<FineModel> fines = new ArrayList<>();
        String sql = "SELECT fine_id, user_id, violation_type, fine_amount, violation_date, reason, fine_status, issued_at " +
                     "FROM fines WHERE user_id = ? AND fine_status = 'Unpaid' ORDER BY issued_at DESC";

        try (Connection con = DBconfig.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            pst.setInt(1, userId);
            try (ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    FineModel f = new FineModel();
                    f.setFineId(rs.getInt("fine_id"));
                    f.setUserId(rs.getInt("user_id"));
                    f.setViolationType(rs.getString("violation_type"));
                    f.setFineAmount(rs.getDouble("fine_amount"));
                    f.setViolationDate(rs.getString("violation_date"));
                    f.setReason(rs.getString("reason"));
                    f.setStatus(rs.getString("fine_status"));
                    f.setIssuedAt(rs.getString("issued_at"));
                    fines.add(f);
                }
            }
        }
        return fines;
    }
}