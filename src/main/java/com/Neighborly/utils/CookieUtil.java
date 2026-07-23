package com.Neighborly.utils;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.Arrays;

/**
 * Utility class for managing HTTP cookies in the application.
 *
 * This class provides methods for:
 * - Adding cookies with configurable lifetime
 * - Retrieving cookies by name
 * - Deleting cookies by expiring them
 *
 * It ensures cookie handling is consistent across the application.
 */
public class CookieUtil {

    /**
     * Adds a cookie with the specified name, value, and maximum age.
     *
     * Input: response, name, value, maxAgeSeconds
     * Output: void
     * Function: Creates a cookie, sets its properties, and adds it to the HTTP response.
     *
     * @param response the HttpServletResponse to add the cookie to
     * @param name the name of the cookie
     * @param value the value of the cookie
     * @param maxAgeSeconds the lifetime of the cookie in seconds
     */
    public static void addCookie(HttpServletResponse response, String name, String value, int maxAgeSeconds) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAgeSeconds);
        cookie.setPath("/");
        cookie.setHttpOnly(true);
        response.addCookie(cookie);
    }

    /**
     * Retrieves a cookie by name from the HTTP request.
     *
     * Input: request, name
     * Output: Cookie
     * Function: Searches the request cookies and returns the first cookie that matches the given name.
     *
     * @param request the HttpServletRequest containing cookies
     * @param name the name of the cookie to retrieve
     * @return the matching Cookie, or null if not found
     */
    public static Cookie getCookie(HttpServletRequest request, String name) {
        if (request.getCookies() != null) {
            return Arrays.stream(request.getCookies())
                    .filter(cookie -> name.equals(cookie.getName()))
                    .findFirst()
                    .orElse(null);
        }
        return null;
    }

    /**
     * Deletes a cookie by setting its expiration time to zero.
     *
     * Input: response, name
     * Output: void
     * Function: Creates a cookie with the same name, sets its age to 0, and sends it to the browser so it gets removed.
     *
     * @param response the HttpServletResponse to send the deletion cookie
     * @param name the name of the cookie to delete
     */
    public static void deleteCookie(HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, null);
        cookie.setMaxAge(0);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
}