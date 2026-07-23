package com.Neighborly.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Utility class for managing database connections.
 *
 * This class provides a central way to connect to the MySQL database.
 *
 * It handles:
 * - Loading the JDBC driver
 * - Creating database connections
 * - Keeping DB configuration in one place
 *
 * This avoids repeating connection logic throughout the project.
 */
public class DBconfig {

    private static final String URL = getEnvOrDefault("DB_URL", "jdbc:mysql://localhost:3306/CivicPulse?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC");
    private static final String USER = getEnvOrDefault("DB_USER", "root");
    private static final String PASSWORD = getEnvOrDefault("DB_PASSWORD", "root");

    private static String getEnvOrDefault(String envVar, String defaultValue) {
        String value = System.getenv(envVar);
        return (value != null && !value.isEmpty()) ? value : defaultValue;
    }
    
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MySQL JDBC driver", e);
        }
    }

    /**
     * Creates and returns a connection to the database.
     *
     * @return database Connection object
     * @throws SQLException if a database access error occurs or the url is null
     */
    public static Connection getConnection() throws SQLException {
        try {
            Connection connection = DriverManager.getConnection(URL, USER, PASSWORD);
            if (connection == null) {
                throw new SQLException("Failed to establish database connection: DriverManager returned null.");
            }
            return connection;
        } catch (SQLException e) {
            System.err.println("Database connection failed. Please check credentials and database status.");
            e.printStackTrace();
            throw e;
        }
    }
}