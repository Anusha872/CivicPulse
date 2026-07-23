<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<header class="topbar">
    <div class="topbarLeft">
        <a href="${pageContext.request.contextPath}/home" class="navbarLogo">
            <img src="${pageContext.request.contextPath}/Images/CivicPulseLogo.svg" alt="CivicPulse" class="navbarLogoImage" />
        </a>
    </div>
    <div class="topbarCenter">
        <span class="currentPageTitle">${activePage}</span>
    </div>
    <div class="topbarRight">
        <a href="${pageContext.request.contextPath}/notices" class="notificationLink" title="Notifications">
            <button class="bellIcon" type="button">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                    stroke-linecap="round" stroke-linejoin="round">
                    <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                    <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                </svg>
            </button>
        </a>
    </div>
</header>