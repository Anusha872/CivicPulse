package com.Neighborly.utils;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for handling password security.
 *
 * This class provides methods for:
 * - Hashing passwords using BCrypt
 * - Verifying plain text passwords against hashed values
 *
 * It ensures passwords are never stored in plain text
 * and improves overall application security.
 */
public class PasswordUtil {

    private static final int COST = 10;

    /**
     * Hashes a plain text password using BCrypt.
     *
     * @param password plain text password
     * @return hashed password
     */
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(COST));
    }

    /**
     * Checks if a plain password matches a hashed password.
     *
     * @param input plain text password
     * @param storedHash hashed password from database
     * @return true if passwords match, false otherwise
     */
    public static boolean checkPassword(String input, String storedHash) {
        return BCrypt.checkpw(input, storedHash);
    }
}