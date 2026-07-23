<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<aside class="sidebar">

    <p class="sidebarSectionLabel">MAIN</p>
    <ul class="sidebarNavigation">
        <li>
            <a href="${pageContext.request.contextPath}/home" class="${activePage == 'Home' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                        <polyline points="9 22 9 12 15 12 15 22"></polyline>
                    </svg>
                </span>
                Home
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/feed" class="${activePage == 'Feed' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path>
                    </svg>
                </span>Neighborhood Lost & Found</a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/news" class="${activePage == 'News' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16c0 1.1.9 2 2 2h12a2 2 0 0 0 2-2V8l-6-6z" />
                        <path d="M14 3v5h5M16 13H8M16 17H8M10 9H8" />
                    </svg>
                </span>
                News
            </a>
        </li>
    </ul>

    <p class="sidebarSectionLabel">SERVICES</p>
    <ul class="sidebarNavigation">
        <li>
            <a href="${pageContext.request.contextPath}/documents" class="${activePage == 'Documents' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M13 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V9z"></path>
                        <polyline points="13 2 13 9 20 9"></polyline>
                    </svg>
                </span>
                Document vault
            </a>
        </li>
        <li>
            <a href="javascript:void(0);" onclick="if(window.toggleCivicChatbot){window.toggleCivicChatbot(true);}" class="${activePage == 'AIAssistant' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#0d9488"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="10" rx="2"></rect>
                        <circle cx="12" cy="5" r="2"></circle>
                        <path d="M12 7v4"></path>
                        <line x1="8" y1="16" x2="8" y2="16"></line>
                        <line x1="16" y1="16" x2="16" y2="16"></line>
                    </svg>
                </span>
                <span style="font-weight: 600; color: #0d9488;">AI Assistant</span>
            </a>
        </li>
    </ul>

    <p class="sidebarSectionLabel">COMMUNITY</p>
    <ul class="sidebarNavigation">
        <li>
            <a href="${pageContext.request.contextPath}/report" class="${activePage == 'Report Issues' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <circle cx="12" cy="12" r="10"></circle>
                        <line x1="12" y1="8" x2="12" y2="12"></line>
                        <line x1="12" y1="16" x2="12.01" y2="16"></line>
                    </svg>
                </span>
                Report issue
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/polls" class="${activePage == 'Polls' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="18" y1="20" x2="18" y2="10"></line>
                        <line x1="12" y1="20" x2="12" y2="4"></line>
                        <line x1="6" y1="20" x2="6" y2="14"></line>
                    </svg>
                </span>
                Polls
            </a>
        </li>
        <li>
            <a href="${pageContext.request.contextPath}/notices" class="${activePage == 'Notices' ? 'active' : ''}">
                <span class="navigationIcon">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
                        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
                    </svg>
                </span>
                Notices
            </a>
        </li>
    </ul>

    <div class="menuWrapper" id="userMenuWrapper">
        <div class="userProfile" id="userMenuToggle">

            <div class="userAvatar" style="${empty user.image ? 'background-color: #E86A33;' : 'background-color: transparent; padding: 0;'}">
                <c:choose>
                    <c:when test="${not empty user.image}">
                        <img src="${pageContext.request.contextPath}/getimage?name=${user.userName}"
                             alt="${user.userName}"
                             style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                    </c:when>
                    <c:otherwise>
                        ${fn:toUpperCase(fn:substring(user.userName, 0, 1))}
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="userInfo">
                <span class="userName">${user.userName}</span>
                <span class="userRole">Citizen</span>
            </div>
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#666" stroke-width="2"
                stroke-linecap="round" stroke-linejoin="round" style="margin-left:auto">
                <polyline points="18 15 12 9 6 15"></polyline>
            </svg>
        </div>

        <div class="menuDropdown" id="userDropdownMenu">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/profile">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            style="margin-right: 12px;">
                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                            <circle cx="12" cy="7" r="4"></circle>
                        </svg>
                        My Profile
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/aboutus">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            style="margin-right: 12px;">
                            <circle cx="12" cy="12" r="10"></circle>
                            <line x1="12" y1="16" x2="12" y2="12"></line>
                            <line x1="12" y1="8" x2="12.01" y2="8"></line>
                        </svg>
                        About us
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/contact">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            style="margin-right: 12px;">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                        Contact us
                    </a>
                </li>
                <li style="border-top: 1px solid #E0E0E0; margin-top: 4px; padding-top: 4px;">
                    <a href="${pageContext.request.contextPath}/logout" style="color: #D32F2F;">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                            stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            style="margin-right: 12px;">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path>
                            <polyline points="16 17 21 12 16 7"></polyline>
                            <line x1="21" y1="12" x2="9" y2="12"></line>
                        </svg>
                        Logout
                    </a>
                </li>
            </ul>
        </div>
    </div>
</aside>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var toggle = document.getElementById('userMenuToggle');
        var menu = document.getElementById('userDropdownMenu');
        if (toggle && menu) {
            toggle.addEventListener('click', function(e) {
                e.stopPropagation();
                menu.classList.toggle('active');
            });
            document.addEventListener('click', function(e) {
                if (!menu.contains(e.target) && !toggle.contains(e.target)) {
                    menu.classList.remove('active');
                }
            });
        }
    });
</script>

<!-- Embedded Real-Time AI Chatbot Widget -->
<jsp:include page="/Components/chatbot-widget.jsp" />