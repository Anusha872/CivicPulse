package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.ContactModel;
import com.Neighborly.utils.DBconfig;

public class ContactDAO {

	/**
	 * Inserts a new contact message into the database.
	 *
	 * Input: fullName, email, subject, message
	 * Output: void
	 * Function: Stores a new contact form submission in contactmessages.
	 *
	 * @param fullName the sender's full name
	 * @param email the sender's email address
	 * @param subject the subject of the message
	 * @param message the message content
	 * @throws Exception if a database error occurs
	 */
	public void insertContact(String fullName, String email, String subject, String message) throws Exception {
		Connection con = DBconfig.getConnection();
		String sql = "INSERT INTO contactmessages (full_name, email, subject, message) " + "VALUES (?, ?, ?, ?)";
		PreparedStatement pst = con.prepareStatement(sql);
		
		pst.setString(1, fullName);
		pst.setString(2, email);
		pst.setString(3, subject);
		pst.setString(4, message);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all contact messages.
	 *
	 * Input: none
	 * Output: List<ContactModel>
	 * Function: Loads all contact messages from the database and orders them by newest first.
	 *
	 * @return a list of all contact messages
	 * @throws Exception if a database error occurs
	 */
	public List<ContactModel> getAllContacts() throws Exception {
		List<ContactModel> contacts = new ArrayList<>();
		Connection con = DBconfig.getConnection();
		String sql = "SELECT contact_id, full_name, email, subject, message, created_at "
				+ "FROM contactmessages ORDER BY created_at DESC";

		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			ContactModel c = new ContactModel();
			c.setContactId(rs.getInt("contact_id"));
			c.setFullName(rs.getString("full_name"));
			c.setEmail(rs.getString("email"));
			c.setSubject(rs.getString("subject"));
			c.setMessage(rs.getString("message"));
			c.setCreatedAt(rs.getString("created_at"));
			contacts.add(c);
		}

		rs.close();
		pst.close();
		con.close();
		return contacts;
	}

	/**
	 * Deletes a contact message from the database.
	 *
	 * Input: contactId
	 * Output: boolean
	 * Function: Permanently removes the selected contact message and returns whether the deletion succeeded.
	 *
	 * @param contactId the ID of the contact message to delete
	 * @return true if a row was deleted, otherwise false
	 * @throws Exception if a database error occurs
	 */
	public boolean deleteContact(int contactId) throws Exception {

		Connection con = DBconfig.getConnection();
		String sql = "DELETE FROM contactMessages WHERE contact_id = ?";
		PreparedStatement pst = con.prepareStatement(sql);

		pst.setInt(1, contactId);
		int rows = pst.executeUpdate();
		
		pst.close();
		con.close();
		return rows > 0;
	}
}