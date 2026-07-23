package com.Neighborly.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.Neighborly.model.UserModel;
import com.Neighborly.utils.DBconfig;

public class UserDAO {

	/**
	 * Inserts a new user into the database.
	 *
	 * Input: firstName, lastName, username, dob, gender, email, number, password, image
	 * Output: void
	 * Function: Converts the date of birth to SQL format and stores the new user in the users table.
	 *
	 * @param firstName the user's first name
	 * @param lastName the user's last name
	 * @param username the account username
	 * @param dob the date of birth in string format
	 * @param gender the user's gender
	 * @param email the user's email address
	 * @param number the user's phone number
	 * @param password the account password
	 * @param image the profile image filename or path
	 * @throws Exception if a database error occurs
	 */
	public void insertUsers(String firstName, String lastName, String username, String dob, String gender, String email,
			String number, String password, String image) throws Exception {
		LocalDate localDate = LocalDate.parse(dob);
		Date sqlDate = Date.valueOf(localDate);

		String sql = "INSERT INTO users (first_name, last_name, username, dob, gender, email, number, password, image, role, status) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, 'citizen', 'Active')";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, firstName);
		pst.setString(2, lastName);
		pst.setString(3, username);
		pst.setDate(4, sqlDate);
		pst.setString(5, gender);
		pst.setString(6, email);
		pst.setString(7, number);
		pst.setString(8, password);
		pst.setString(9, image);
		pst.executeUpdate();
		pst.close();
		con.close();
	}

	/**
	 * Retrieves all citizen users.
	 *
	 * Input: none
	 * Output: List<UserModel>
	 * Function: Loads all users whose role is citizen and maps each row into a UserModel object.
	 *
	 * @return a list of all citizen users
	 * @throws Exception if a database error occurs
	 */
	public List<UserModel> getAllUsers() throws Exception {

		List<UserModel> users = new ArrayList<>();

		String sql = "SELECT * FROM users WHERE role = 'citizen'";
		
		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		ResultSet rs = pst.executeQuery();

		while (rs.next()) {
			UserModel u = new UserModel();
			u.setUserId(rs.getInt("user_id"));
			u.setFirstName(rs.getString("first_name"));
			u.setLastName(rs.getString("last_name"));
			u.setUserName(rs.getString("username"));
			u.setDob(rs.getDate("dob"));
			u.setGender(rs.getString("gender"));
			u.setEmail(rs.getString("email"));
			u.setNumber(rs.getString("number"));
			u.setRole(rs.getString("role"));
			u.setImage(rs.getString("image"));
			u.setStatus(rs.getString("status"));
			u.setRegistrationDate(rs.getDate("registration_date"));
			users.add(u);
		}

		rs.close();
		pst.close();
		con.close();

		return users;
	}

	/**
	 * Retrieves an active user by username for login.
	 *
	 * Input: username
	 * Output: UserModel
	 * Function: Finds a matching active user account and returns the full user record if found.
	 *
	 * @param username the username to search for
	 * @return the matching user, or null if not found
	 * @throws Exception if a database error occurs
	 */
	public UserModel getUserByUsername(String username) throws Exception {

		String sql = "SELECT * FROM users WHERE username = ? AND status = 'Active'";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, username);
		ResultSet rs = pst.executeQuery();

		UserModel u = null;
		if (rs.next()) {
			u = new UserModel();
			u.setUserId(rs.getInt("user_id"));
			u.setFirstName(rs.getString("first_name"));
			u.setLastName(rs.getString("last_name"));
			u.setUserName(rs.getString("username"));
			u.setDob(rs.getDate("dob"));
			u.setGender(rs.getString("gender"));
			u.setEmail(rs.getString("email"));
			u.setNumber(rs.getString("number"));
			u.setPassword(rs.getString("password"));
			u.setRole(rs.getString("role"));
			u.setImage(rs.getString("image"));
			u.setRegistrationDate(rs.getDate("registration_date"));
		}

		rs.close();
		pst.close();
		con.close();

		return u;
	}

	/**
	 * Retrieves a single user by ID.
	 *
	 * Input: userId
	 * Output: UserModel
	 * Function: Fetches one user record from the users table using the user ID.
	 *
	 * @param userId the ID of the user to fetch
	 * @return the matching user, or null if not found
	 * @throws Exception if a database error occurs
	 */
	public UserModel getUserById(int userId) throws Exception {
		String sql = "SELECT * FROM users WHERE user_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setInt(1, userId);
		ResultSet rs = pst.executeQuery();

		UserModel u = null;
		if (rs.next()) {
			u = new UserModel();
			u.setUserId(rs.getInt("user_id"));
			u.setFirstName(rs.getString("first_name"));
			u.setLastName(rs.getString("last_name"));
			u.setUserName(rs.getString("username"));
			u.setDob(rs.getDate("dob"));
			u.setGender(rs.getString("gender"));
			u.setEmail(rs.getString("email"));
			u.setNumber(rs.getString("number"));
			u.setRole(rs.getString("role"));
			u.setImage(rs.getString("image"));
			u.setStatus(rs.getString("status"));
		}

		rs.close();
		pst.close();
		con.close();
		return u;
	}
	
	/**
	 * Retrieves all active citizen users.
	 *
	 * Input: none
	 * Output: List<UserModel>
	 * Function: Loads only citizen users whose status is Active.
	 *
	 * @return a list of active citizen users
	 * @throws Exception if a database error occurs
	 */
	public List<UserModel> getActiveCitizens() throws Exception {
		
	    List<UserModel> users = new ArrayList<>();
	    
	    String sql = "SELECT * FROM users WHERE role = 'citizen' AND status = 'Active'";

	    Connection con = DBconfig.getConnection();
	    
	    PreparedStatement pst = con.prepareStatement(sql);
	    
	    ResultSet rs = pst.executeQuery();

	    while (rs.next()) {
	        UserModel u = new UserModel();
	        u.setUserId(rs.getInt("user_id"));
	        u.setFirstName(rs.getString("first_name"));
	        u.setLastName(rs.getString("last_name"));
	        u.setUserName(rs.getString("username"));
	        u.setDob(rs.getDate("dob"));
	        u.setGender(rs.getString("gender"));
	        u.setEmail(rs.getString("email"));
	        u.setNumber(rs.getString("number"));
	        u.setRole(rs.getString("role"));
	        u.setImage(rs.getString("image"));
	        u.setStatus(rs.getString("status"));
	        u.setRegistrationDate(rs.getDate("registration_date"));
	        users.add(u);
	    }

	    rs.close();
	    pst.close();
	    con.close();
	    return users;
	}

	/**
	 * Retrieves all inactive citizen users.
	 *
	 * Input: none
	 * Output: List<UserModel>
	 * Function: Loads only citizen users whose status is Inactive.
	 *
	 * @return a list of inactive citizen users
	 * @throws Exception if a database error occurs
	 */
	public List<UserModel> getInactiveCitizens() throws Exception {
		
	    List<UserModel> users = new ArrayList<>();
	    
	    String sql = "SELECT * FROM users WHERE role = 'citizen' AND status = 'Inactive'";
	    

	    Connection con = DBconfig.getConnection();
	    
	    PreparedStatement pst = con.prepareStatement(sql);
	    
	    ResultSet rs = pst.executeQuery();

	    while (rs.next()) {
	        UserModel u = new UserModel();
	        u.setUserId(rs.getInt("user_id"));
	        u.setFirstName(rs.getString("first_name"));
	        u.setLastName(rs.getString("last_name"));
	        u.setUserName(rs.getString("username"));
	        u.setDob(rs.getDate("dob"));
	        u.setGender(rs.getString("gender"));
	        u.setEmail(rs.getString("email"));
	        u.setNumber(rs.getString("number"));
	        u.setRole(rs.getString("role"));
	        u.setImage(rs.getString("image"));
	        u.setStatus(rs.getString("status"));
	        u.setRegistrationDate(rs.getDate("registration_date"));
	        users.add(u);
	    }

	    rs.close();
	    pst.close();
	    con.close();
	    return users;
	}

	/**
	 * Updates a user's basic profile information.
	 *
	 * Input: userId, firstName, lastName, email, number
	 * Output: int
	 * Function: Updates the user's name, email, and phone number and returns the number of affected rows.
	 *
	 * @param userId the ID of the user to update
	 * @param firstName the updated first name
	 * @param lastName the updated last name
	 * @param email the updated email address
	 * @param number the updated phone number
	 * @return the number of rows updated
	 * @throws Exception if a database error occurs
	 */
	public int updateUser(int userId, String firstName, String lastName, String email, String number) throws Exception {

		String sql = "UPDATE users SET first_name = ?, last_name = ?, " + "email = ?, number = ? "
				+ "WHERE user_id = ?";

		Connection con = DBconfig.getConnection();
		PreparedStatement pst = con.prepareStatement(sql);
		pst.setString(1, firstName);
		pst.setString(2, lastName);
		pst.setString(3, email);
		pst.setString(4, number);
		pst.setInt(5, userId);
		int rows = pst.executeUpdate();
		pst.close();
		con.close();

		return rows;
	}
	
	/**
	 * Suspends a citizen account.
	 *
	 * Input: userId, reason
	 * Output: void
	 * Function: Marks the citizen as inactive and stores the suspension reason.
	 *
	 * @param userId the ID of the user to suspend
	 * @param reason the suspension reason
	 * @throws Exception if a database error occurs
	 */
	public void suspendCitizen(int userId, String reason) throws Exception {

        Connection con = DBconfig.getConnection();

        String sql = "UPDATE users SET status = 'Inactive', suspension_reason = ? WHERE user_id = ?";

        PreparedStatement pst = con.prepareStatement(sql);
        pst.setString(1, reason);
        pst.setInt(2, userId);
        pst.executeUpdate();

        pst.close();
        con.close();
    }
    
    /**
     * Unsuspends a citizen account.
     *
     * Input: userId
     * Output: void
     * Function: Restores the user's status to Active and clears the suspension reason.
     *
     * @param userId the ID of the user to unsuspend
     * @throws Exception if a database error occurs
     */
    public void unsuspendCitizen(int userId) throws Exception {
        
    	Connection con = DBconfig.getConnection();
    	
        String sql = "UPDATE users SET status = 'Active', suspension_reason = NULL WHERE user_id = ?";
        
        PreparedStatement pst = con.prepareStatement(sql);
        
        pst.setInt(1, userId);
        pst.executeUpdate();
        pst.close();
        con.close();
    }
    
    public List<UserModel> searchCitizens(String query) throws Exception {
    	
        List<UserModel> users = new ArrayList<>();
        
        String sql = "SELECT * FROM users WHERE role = 'citizen' AND (first_name LIKE ? OR last_name LIKE ? OR username LIKE ? OR email LIKE ?)";

        Connection con = DBconfig.getConnection();
        
        PreparedStatement pst = con.prepareStatement(sql);
        
        String like = "%" + query + "%";
        
        pst.setString(1, like);
        pst.setString(2, like);
        pst.setString(3, like);
        pst.setString(4, like);

        ResultSet rs = pst.executeQuery();
        
        while (rs.next()) {
        	
            UserModel u = new UserModel();
            
            u.setUserId(rs.getInt("user_id"));
            u.setFirstName(rs.getString("first_name"));
            u.setLastName(rs.getString("last_name"));
            u.setUserName(rs.getString("username"));
            u.setEmail(rs.getString("email"));
            u.setNumber(rs.getString("number"));
            u.setStatus(rs.getString("status"));
            users.add(u);
        }
        return users;
    }
}