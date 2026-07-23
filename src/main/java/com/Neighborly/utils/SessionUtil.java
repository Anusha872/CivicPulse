package com.Neighborly.utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HTTP sessions.
 *
 * This class provides methods for:
 * - Storing session attributes
 * - Retrieving session values
 * - Removing specific attributes
 * - Invalidating sessions completely (logout)
 *
 * It helps keep session handling clean and consistent across the app.
 */
public class SessionUtil {

    /**
     * Stores a value in session with a timeout.
     *
     * @param request HTTP request
     * @param name attribute name
     * @param value attribute value
     * @param seconds session timeout in seconds
     */
    public static void setAttribute(HttpServletRequest request, String name, Object value, int seconds) {
        HttpSession session = request.getSession(true);
        session.setAttribute(name, value);
        session.setMaxInactiveInterval(seconds);
    }

    /**
     * Retrieves a session attribute.
     *
     * @param request HTTP request
     * @param name attribute name
     * @return stored value or null if not found
     */
    public static Object getAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        return (session != null) ? session.getAttribute(name) : null;
    }

    /**
     * Removes a specific attribute from session.
     *
     * @param request HTTP request
     * @param name attribute name
     */
    public static void removeAttribute(HttpServletRequest request, String name) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(name);
        }
    }

    /**
     * Invalidates the entire session (logs user out).
     *
     * @param request HTTP request
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}