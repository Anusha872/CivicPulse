<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<header class="topbar">
	<div class="topbarLeft">
		<label class="hamburgerBtn" for="sidebarToggle"> <svg
				width="22" height="22" viewBox="0 0 24 24" fill="currentColor">
        <path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z" />
    </svg>
		</label> <a href="${pageContext.request.contextPath}/admindashboard"
			class="topbarLogo"> <img
			src="${pageContext.request.contextPath}/Images/CivicPulseLogo.svg"
			alt="CivicPulse Logo" style="width: 140px; height: auto;">
		</a>
		<h1
			style="border-left: 1px solid #323639; padding-left: 24px; margin-left: 48px;">
			Admin Dashboard</h1>
	</div>

	<div class="topbarRight">
		<div class="userInfo"
			onclick="document.getElementById('profileDropdown').classList.toggle('active')">
			<div class="userAvatar"
				style="${empty sessionScope.user.image ? 'background-color: #E86A33;' : 'background-color: transparent; padding: 0;'}">
				<c:choose>
					<c:when test="${not empty sessionScope.user.image}">
						<img
							src="${pageContext.request.contextPath}/getimage?name=${sessionScope.user.userName}"
							alt="${sessionScope.user.userName}"
							style="width: 100%; height: 100%; object-fit: cover; border-radius: 50%;">
					</c:when>
					<c:otherwise>
                        ${fn:toUpperCase(fn:substring(sessionScope.user.userName, 0, 1))}
                    </c:otherwise>
				</c:choose>
			</div>
			<div class="userDetails">
				<span class="userName">${sessionScope.user.userName}</span> <span
					class="userRole">Admin</span>
			</div>
			<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
				stroke="#75787D" stroke-width="2" stroke-linecap="round"
				stroke-linejoin="round" style="margin-left: 4px;">
                <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
		</div>

		<div class="dropdownMenu" id="profileDropdown">
			<button class="dropdownItem"
				onclick="window.location.href='${pageContext.request.contextPath}/logout'"
				style="color: #ef4444;">Logout</button>
		</div>
	</div>
</header>
<script>
	window.addEventListener("click", function(e) {
		if (!e.target.closest(".userInfo")
				&& !e.target.closest(".dropdownMenu")) {
			const dropdown = document.getElementById("profileDropdown");
			if (dropdown && dropdown.classList.contains("active")) {
				dropdown.classList.remove("active");
			}
		}
	});
</script>