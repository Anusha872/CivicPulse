package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.DocumentModel;
import com.Neighborly.utils.DBconfig;

public class DocumentDAO {

	/**
	 * Submits a new document application for a user.
	 *
	 * Input: userId, documentType, fullName, dateOfBirth, address, phone, additionalInfo
	 * Output: void
	 * Function: Creates a new record in document_applications with status set to 'Pending'.
	 *
	 * @param userId the ID of the user applying for the document
	 * @param documentType the type of document being requested
	 * @param fullName the applicant's full name
	 * @param dateOfBirth the applicant's date of birth
	 * @param address the applicant's address
	 * @param phone the applicant's phone number
	 * @param additionalInfo extra details provided by the applicant
	 * @throws Exception if a database error occurs
	 */
	public void applyForDocument(int userId, String documentType, String fullName, String dateOfBirth, String address,
			String phone, String additionalInfo) throws Exception {

		String sql = "INSERT INTO document_applications (user_id, document_type, full_name, date_of_birth, address, phone, "
				+ "additional_info, status) " + "VALUES (?, ?, ?, ?, ?, ?, ?, 'Pending')";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		pst.setString(2, documentType);
		pst.setString(3, fullName);
		pst.setString(4, dateOfBirth);
		pst.setString(5, address);
		pst.setString(6, phone);
		pst.setString(7, additionalInfo);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all document applications submitted by a specific user.
	 *
	 * Input: userId
	 * Output: List<DocumentModel>
	 * Function: Fetches all document requests for the given user and returns them in descending submission order.
	 *
	 * @param userId the ID of the user whose documents should be fetched
	 * @return a list of document applications belonging to the user
	 * @throws Exception if a database error occurs
	 */
	public List<DocumentModel> getDocumentsByUserId(int userId) throws Exception {
		List<DocumentModel> docs = new ArrayList<>();
		String sql = "SELECT da.document_id, da.user_id, u.first_name, u.last_name, da.document_type, da.full_name, da.address, "
					+ "da.phone, da.additional_info, da.status, da.submitted_at FROM document_applications "
					+ "da JOIN users u ON da.user_id = u.user_id WHERE da.user_id = ? ORDER BY da.submitted_at DESC";
		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		ResultSet rs = pst.executeQuery();
		while (rs.next()) {
			DocumentModel d = new DocumentModel();
			d.setDocumentId(rs.getInt("document_id"));
			d.setUserId(rs.getInt("user_id"));
			d.setFirstName(rs.getString("first_name"));
			d.setLastName(rs.getString("last_name"));
			d.setDocumentType(rs.getString("document_type"));
			d.setFullName(rs.getString("full_name"));
			d.setAddress(rs.getString("address"));
			d.setPhone(rs.getString("phone"));
			d.setAdditionalInfo(rs.getString("additional_info"));
			d.setStatus(rs.getString("status"));
			d.setSubmittedAt(rs.getString("submitted_at"));
			docs.add(d);
		}
		rs.close();
		pst.close();
		con.close();
		return docs;
	}

	/**
	 * Retrieves every document application in the system.
	 *
	 * Input: none
	 * Output: List<DocumentModel>
	 * Function: Loads all document requests from the database, including user information, ordered by newest first.
	 *
	 * @return a list containing all document applications
	 * @throws Exception if a database error occurs
	 */
	public List<DocumentModel> getAllDocuments() throws Exception {

		List<DocumentModel> docs = new ArrayList<>();

		String sql = "SELECT da.document_id, da.user_id, u.first_name, u.last_name, da.document_type, da.full_name, da.address, "
				+ "da.phone, da.additional_info, da.status, da.submitted_at FROM document_applications da JOIN users u ON "
				+ "da.user_id = u.user_id ORDER BY da.submitted_at DESC";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {

			DocumentModel d = new DocumentModel();

			d.setDocumentId(rs.getInt("document_id"));
			d.setUserId(rs.getInt("user_id"));
			d.setFirstName(rs.getString("first_name"));
			d.setLastName(rs.getString("last_name"));
			d.setDocumentType(rs.getString("document_type"));
			d.setFullName(rs.getString("full_name"));
			d.setAddress(rs.getString("address"));
			d.setPhone(rs.getString("phone"));
			d.setAdditionalInfo(rs.getString("additional_info"));
			d.setStatus(rs.getString("status"));
			d.setSubmittedAt(rs.getString("submitted_at"));
			docs.add(d);
		}

		rs.close();
		pst.close();
		con.close();
		return docs;
	}
	
	/**
	 * Retrieves a specific document application that belongs to a user.
	 *
	 * Input: documentId, userId
	 * Output: DocumentModel
	 * Function: Finds a document by its ID only if it matches the given user ID.
	 *
	 * @param documentId the ID of the document application
	 * @param userId the ID of the owner of the document
	 * @return the matching document application, or null if not found
	 * @throws Exception if a database error occurs
	 */
	public DocumentModel getDocumentByIdAndUser(int documentId, int userId) throws Exception {
		String sql = "SELECT da.document_id, da.user_id, u.first_name, u.last_name, da.document_type, da.full_name, da.address, da.phone, "
				+ "da.additional_info, da.status, da.submitted_at FROM document_applications da JOIN users u ON da.user_id = u.user_id WHERE da.document_id = ?"
				+ " AND da.user_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, documentId);
		pst.setInt(2, userId);
		ResultSet rs = pst.executeQuery();

		DocumentModel d = null;
		if (rs.next()) {
			d = new DocumentModel();
			d.setDocumentId(rs.getInt("document_id"));
			d.setUserId(rs.getInt("user_id"));
			d.setFirstName(rs.getString("first_name"));
			d.setLastName(rs.getString("last_name"));
			d.setDocumentType(rs.getString("document_type"));
			d.setFullName(rs.getString("full_name"));
			d.setAddress(rs.getString("address"));
			d.setPhone(rs.getString("phone"));
			d.setAdditionalInfo(rs.getString("additional_info"));
			d.setStatus(rs.getString("status"));
			d.setSubmittedAt(rs.getString("submitted_at"));
		}

		rs.close();
		pst.close();
		con.close();
		return d;
	}

	/**
	 * Retrieves the latest document application of a specific type for a user.
	 *
	 * Input: documentType, userId
	 * Output: DocumentModel
	 * Function: Finds the most recent application for the given document type submitted by the specified user.
	 *
	 * @param documentType the document type to search for
	 * @param userId the ID of the user
	 * @return the latest matching document application, or null if not found
	 * @throws Exception if a database error occurs
	 */
	public DocumentModel getDocumentByTypeAndUser(String documentType, int userId) throws Exception {

		String sql = "SELECT da.document_id, da.user_id, u.first_name, u.last_name, da.document_type, da.full_name, da.address, da.phone, da.additional_info, "
				+ "da.status, da.submitted_at FROM document_applications da JOIN users u ON da.user_id = u.user_id WHERE da.document_type = ? AND da.user_id = ? "
				+ "ORDER BY da.submitted_at DESC LIMIT 1";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, documentType);
		pst.setInt(2, userId);
		ResultSet rs = pst.executeQuery();

		DocumentModel d = null;
		if (rs.next()) {
			d = new DocumentModel();
			d.setDocumentId(rs.getInt("document_id"));
			d.setUserId(rs.getInt("user_id"));
			d.setFirstName(rs.getString("first_name"));
			d.setLastName(rs.getString("last_name"));
			d.setDocumentType(rs.getString("document_type"));
			d.setFullName(rs.getString("full_name"));
			d.setAddress(rs.getString("address"));
			d.setPhone(rs.getString("phone"));
			d.setAdditionalInfo(rs.getString("additional_info"));
			d.setStatus(rs.getString("status"));
			d.setSubmittedAt(rs.getString("submitted_at"));
		}

		rs.close();
		pst.close();
		con.close();
		return d;
	}

	/**
	 * Retrieves a document application by its ID.
	 *
	 * Input: documentId
	 * Output: DocumentModel
	 * Function: Fetches one document application and includes the related user details.
	 *
	 * @param documentId the ID of the document application
	 * @return the document application, or null-equivalent object state if not found
	 * @throws Exception if a database error occurs
	 */
	public DocumentModel getDocumentById(int documentId) throws Exception {

		// FIX: Removed stray " + " that was embedded inside the SQL string, causing a syntax error
		String sql = "SELECT da.document_id, da.user_id, u.first_name, u.last_name, da.document_type, da.full_name, da.address, da.phone, "
				+ "da.additional_info, da.status, da.submitted_at FROM document_applications da JOIN users u ON da.user_id = u.user_id "
				+ "WHERE da.document_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, documentId);
		ResultSet rs = pst.executeQuery();

		DocumentModel d = new DocumentModel();
		if (rs.next()) {
			d.setDocumentId(rs.getInt("document_id"));
			d.setUserId(rs.getInt("user_id"));
			d.setFirstName(rs.getString("first_name"));
			d.setLastName(rs.getString("last_name"));
			d.setDocumentType(rs.getString("document_type"));
			d.setFullName(rs.getString("full_name"));
			d.setAddress(rs.getString("address"));
			d.setPhone(rs.getString("phone"));
			d.setAdditionalInfo(rs.getString("additional_info"));
			d.setStatus(rs.getString("status"));
			d.setSubmittedAt(rs.getString("submitted_at"));
		}

		rs.close();
		pst.close();
		con.close();
		return d;
	}

	/**
	 * Approves a document application.
	 *
	 * Input: documentId
	 * Output: void
	 * Function: Updates the document status to 'Approved' in the database.
	 *
	 * @param documentId the ID of the document application to approve
	 * @throws Exception if a database error occurs
	 */
	public void approveDocument(int documentId) throws Exception {

		String sql = "UPDATE document_applications SET status = 'Approved' WHERE document_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, documentId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}


	/**
	 * Rejects a document application.
	 *
	 * Input: documentId
	 * Output: void
	 * Function: Updates the document status to 'Rejected' in the database.
	 *
	 * @param documentId the ID of the document application to reject
	 * @throws Exception if a database error occurs
	 */
	public void rejectDocument(int documentId) throws Exception {

		String sql = "UPDATE document_applications SET status = 'Rejected' WHERE document_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, documentId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Deletes a document application from the database.
	 *
	 * Input: documentId
	 * Output: void
	 * Function: Removes the specified document application record permanently.
	 *
	 * @param documentId the ID of the document application to delete
	 * @throws Exception if a database error occurs
	 */
	public void deleteDocument(int documentId) throws Exception {

		String sql = "DELETE FROM document_applications WHERE document_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, documentId);
		pst.executeUpdate();
		pst.close();
		con.close();
	}
}