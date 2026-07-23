<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CivicPulse</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background-color: #FAF7F4;
            color: #333333;
        }

        /* Navbar – same as 404 */
        .navbar {
            background-color: #FAFAFA;
            border-bottom: 1px solid #E0E0E0;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            z-index: 100;
        }

        .navbar-logo {
            display: flex;
            align-items: center;
            text-decoration: none;
            transition: opacity 0.2s;
        }

        .navbar-logo:hover {
            opacity: 0.8;
        }

        .navbar-logo img {
            width: 140px;
            height: auto;
            object-fit: contain;
        }

        .error-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 100px 24px 60px;
            text-align: center;
        }

        .error-code {
            font-size: 120px;
            font-weight: 800;
            color: #E86A33;
            letter-spacing: -4px;
            line-height: 1;
            margin-bottom: 24px;
        }

        .error-title {
            font-size: 28px;
            font-weight: 600;
            color: #333;
            margin-bottom: 16px;
        }

        .error-message {
            font-size: 16px;
            color: #666;
            max-width: 400px;
            margin: 0 auto 32px;
            line-height: 1.5;
        }

        .btn-home {
            display: inline-block;
            background-color: #E86A33;
            color: #FFFFFF;
            font-size: 14px;
            font-weight: 600;
            padding: 10px 24px;
            border-radius: 40px;
            text-decoration: none;
            transition: background-color 0.2s;
        }

        .btn-home:hover {
            background-color: #CC5520;
        }

        .btn-back {
            display: inline-block;
            margin-top: 16px;
            font-size: 14px;
            color: #E86A33;
            text-decoration: underline;
            text-underline-offset: 3px;
            background: none;
            border: none;
            cursor: pointer;
        }

        @media (max-width: 768px) {
            .error-code { font-size: 90px; }
            .error-title { font-size: 24px; }
        }
    </style>
</head>
<body>

    <div class="navbar">
        <a href="${pageContext.request.contextPath}/home" class="navbar-logo">
            <img src="${pageContext.request.contextPath}/Images/CivicPulseLogo.svg" alt="CivicPulse" />
        </a>
    </div>

    <div class="error-container">
        <div class="error-code">500</div>
        <h1 class="error-title">Oops, Something Went Wrong!</h1>
        <p class="error-message">
            Our team has been notified.<br>Please try again later.
        </p>
        <a href="${pageContext.request.contextPath}/home" class="btn-home">Go Home</a>
        <button onclick="history.back()" class="btn-back">← Go back to previous page</button>
    </div>

</body>
</html>