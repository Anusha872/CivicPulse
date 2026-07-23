package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.ReportModel;
import com.Neighborly.utils.DBconfig;

public class ReportDAO {

	/**
	 * Inserts a new issue report into the database.
	 *
	 * Input: userId, title, category, location, description, reportPhoto
	 * Output: void
	 * Function: Creates a new record in issuereports with the provided report details.
	 *
	 * @param userId the ID of the user submitting the report
	 * @param title the title of the issue report
	 * @param category the report category
	 * @param location the location of the issue
	 * @param description the detailed description of the report
	 * @param reportPhoto the filename or path of the report photo
	 * @throws Exception if a database error occurs
	 */
	public void insertReport(int userId, String title, String category, String location, String description,
			String reportPhoto) throws Exception {
		Connection con = DBconfig.getConnection();
		String sql = "INSERT INTO issuereports (user_id, title, category, location, description, reportPhoto) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		pst.setString(2, title);
		pst.setString(3, category);
		pst.setString(4, location);
		pst.setString(5, description);
		pst.setString(6, reportPhoto);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all issue reports from the database.
	 *
	 * Input: none
	 * Output: List<ReportModel>
	 * Function: Fetches all reports ordered by newest first and maps each row into a ReportModel object.
	 *
	 * @return a list of all issue reports
	 * @throws Exception if a database error occurs
	 */
	public List<ReportModel> getAllReports() throws Exception {
		List<ReportModel> reports = new ArrayList<>();
		Connection con = DBconfig.getConnection();
		String sql = "SELECT report_id, user_id, title, category, location, description, "
				+ "reportPhoto, status, created_at FROM issuereports ORDER BY created_at DESC";

		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();
		while (rs.next()) {
			ReportModel r = new ReportModel();
			r.setReportId(rs.getInt("report_id"));
			r.setUserId(rs.getInt("user_id"));
			r.setTitle(rs.getString("title"));
			r.setCategory(rs.getString("category"));
			r.setLocation(rs.getString("location"));
			r.setDescription(rs.getString("description"));
			r.setReportPhoto(rs.getString("reportPhoto"));
			r.setStatus(rs.getString("status"));
			r.setCreatedAt(rs.getString("created_at"));
			reports.add(r);
		}
		rs.close();
		pst.close();
		con.close();
		return reports;
	}

	/**
	 * Retrieves all issue reports for admin view.
	 *
	 * Input: none
	 * Output: List<ReportModel>
	 * Function: Loads reports with user first and last names, staff notes, and all report details for admin management.
	 *
	 * @return a list of reports for admin use
	 * @throws Exception if a database error occurs
	 */
	public List<ReportModel> getAllReportsAdmin() throws Exception {

		List<ReportModel> reports = new ArrayList<>();

		Connection con = DBconfig.getConnection();

		String sql = "SELECT r.report_id, r.user_id, u.first_name, u.last_name, r.title, r.category, r.location, r.description, r.reportPhoto, r.status, "
				+ "r.created_at, r.staff_notes FROM issuereports r JOIN users u ON r.user_id = u.user_id ORDER BY r.created_at DESC";

		PreparedStatement pst = con.prepareStatement(sql);

		ResultSet rs = pst.executeQuery();

		while (rs.next()) {

			ReportModel r = new ReportModel();

			r.setReportId(rs.getInt("report_id"));
			r.setUserId(rs.getInt("user_id"));
			r.setFirstName(rs.getString("first_name"));
			r.setLastName(rs.getString("last_name"));
			r.setTitle(rs.getString("title"));
			r.setCategory(rs.getString("category"));
			r.setLocation(rs.getString("location"));
			r.setDescription(rs.getString("description"));
			r.setReportPhoto(rs.getString("reportPhoto"));
			r.setStatus(rs.getString("status"));
			r.setCreatedAt(rs.getString("created_at"));
			r.setStaffNotes(rs.getString("staff_notes"));
			reports.add(r);
		}
		rs.close();
		pst.close();
		con.close();
		return reports;
	}

	/**
	 * Retrieves a single report by its ID.
	 *
	 * Input: reportId
	 * Output: ReportModel
	 * Function: Finds one report record and maps it into a ReportModel object.
	 *
	 * @param reportId the ID of the report to fetch
	 * @return the matching report, or null if not found
	 * @throws Exception if a database error occurs
	 */
	public ReportModel getReportById(int reportId) throws Exception {

		ReportModel r = null;

		Connection con = DBconfig.getConnection();

		String sql = "SELECT * FROM issuereports WHERE report_id=?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, reportId);

		ResultSet rs = pst.executeQuery();

		if (rs.next()) {

			r = new ReportModel();
			r.setReportId(rs.getInt("report_id"));
			r.setUserId(rs.getInt("user_id"));
			r.setTitle(rs.getString("title"));
			r.setCategory(rs.getString("category"));
			r.setLocation(rs.getString("location"));
			r.setDescription(rs.getString("description"));
			r.setReportPhoto(rs.getString("reportPhoto"));
			r.setStatus(rs.getString("status"));
			r.setCreatedAt(rs.getString("created_at"));
		}

		rs.close();
		pst.close();
		con.close();

		return r;
	}

	/**
	 * Updates the status and staff notes of a report.
	 *
	 * Input: reportId, status, notes
	 * Output: void
	 * Function: Changes the report status and saves internal staff notes for follow-up.
	 *
	 * @param reportId the ID of the report to update
	 * @param status the new report status
	 * @param notes the staff notes to store
	 * @throws Exception if a database error occurs
	 */
	public void updateReportStatus(int reportId, String status, String notes) throws Exception {

		Connection con = DBconfig.getConnection();

		String sql = "UPDATE issuereports SET status=?, staff_notes=? WHERE report_id=?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setString(1, status);
		pst.setString(2, notes);
		pst.setInt(3, reportId);

		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Deletes a report from the database.
	 *
	 * Input: reportId
	 * Output: void
	 * Function: Permanently removes the report record from issuereports.
	 *
	 * @param reportId the ID of the report to delete
	 * @throws Exception if a database error occurs
	 */
	public void deleteReport(int reportId) throws Exception {

		Connection con = DBconfig.getConnection();

		String sql = "DELETE FROM issuereports WHERE report_id=?";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, reportId);

		pst.executeUpdate();

		pst.close();
		con.close();
	}

	/**
	 * Retrieves all reports submitted by a specific user.
	 *
	 * Input: userId
	 * Output: List<ReportModel>
	 * Function: Fetches reports created by the given user and orders them by newest first.
	 *
	 * @param userId the ID of the user whose reports should be fetched
	 * @return a list of reports created by the user
	 * @throws Exception if a database error occurs
	 */
	public List<ReportModel> getReportsByUser(int userId) throws Exception {
		List<ReportModel> reports = new ArrayList<>();
		Connection con = DBconfig.getConnection();
		String sql = "SELECT report_id, user_id, title, category, location, description, "
				+ "reportPhoto, status, created_at " + "FROM issuereports WHERE user_id=? ORDER BY created_at DESC";

		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, userId);

		ResultSet rs = pst.executeQuery();

		while (rs.next()) {

			ReportModel r = new ReportModel();

			r.setReportId(rs.getInt("report_id"));
			r.setUserId(rs.getInt("user_id"));
			r.setTitle(rs.getString("title"));
			r.setCategory(rs.getString("category"));
			r.setLocation(rs.getString("location"));
			r.setDescription(rs.getString("description"));
			r.setReportPhoto(rs.getString("reportPhoto"));
			r.setStatus(rs.getString("status"));
			r.setCreatedAt(rs.getString("created_at"));

			reports.add(r);
		}

		rs.close();
		pst.close();
		con.close();
		return reports;
	}

}