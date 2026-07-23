<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CivicPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/AboutUs.css">
</head>
<body>

    <jsp:include page="/Components/leftbar.jsp" />

    <div class="mainLayout">
        <main class="mainContent">
        <jsp:include page="/Components/navbar.jsp" />
            <div class="aboutContainer">
                <h1 class="pageTitle">About Us</h1>
                
                <div class="teamGrid">
                    <!-- Yogesh Pant -->
                    <a href="${pageContext.request.contextPath}/portfolio?member=yogesh" class="memberCard">
                        <div class="memberImgBox">
                            <img src="${pageContext.request.contextPath}/Images/Yogesh.png" alt="Yogesh Pant" class="memberImg">
                        </div>
                        <h3 class="memberName">Yogesh Pant</h3>
                        <p class="memberDesc">BSc (Hons) Computing student specializing in AI &amp; Digital Marketing.</p>
                        <span class="viewPortfolioBtn">View Portfolio</span>
                    </a>

                    <!-- Arjan Regmi -->
                    <a href="${pageContext.request.contextPath}/portfolio?member=arjan" class="memberCard">
                        <div class="memberImgBox">
                            <img src="${pageContext.request.contextPath}/Images/Arjan.png" alt="Arjan Regmi" class="memberImg">
                        </div>
                        <h3 class="memberName">Arjan Regmi</h3>
                        <p class="memberDesc">BSc (Hons) Computing student passionate about UI/UX &amp; Multimedia.</p>
                        <span class="viewPortfolioBtn">View Portfolio</span>
                    </a>

                    <!-- Rikesh Adhikari -->
                    <a href="${pageContext.request.contextPath}/portfolio?member=rikesh" class="memberCard">
                        <div class="memberImgBox">
                            <img src="${pageContext.request.contextPath}/Images/Rikesh.png" alt="Rikesh Adhikari" class="memberImg">
                        </div>
                        <h3 class="memberName">Rikesh Adhikari</h3>
                        <p class="memberDesc">BSc (Hons) Computing student focused on Cloud &amp; Full-Stack Development.</p>
                        <span class="viewPortfolioBtn">View Portfolio</span>
                    </a>

                    <!-- Prayush Shrestha -->
                    <a href="${pageContext.request.contextPath}/portfolio?member=prayush" class="memberCard">
                        <div class="memberImgBox">
                            <img src="${pageContext.request.contextPath}/Images/Prayush.jpeg" alt="Prayush Shrestha" class="memberImg">
                        </div>
                        <h3 class="memberName">Prayush Shrestha</h3>
                        <p class="memberDesc">BSc (Hons) Computing student skilled in Python &amp; Data Visualization.</p>
                        <span class="viewPortfolioBtn">View Portfolio</span>
                    </a>
                </div>
            </div>
        </main>
    </div>

</body>
</html>
