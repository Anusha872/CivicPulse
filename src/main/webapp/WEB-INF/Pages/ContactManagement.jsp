<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Messages - CivicPulse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Admin-Side.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/NewsManagement.css">
</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />

	<!-- SIDEBAR component -->
	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">

		<!-- TOPBAR component -->
		<jsp:include page="/Components/admin-topbar.jsp" />

		<main class="dashboardBody">

			<!-- PAGE HEADER -->
			<div class="newsPageHeader">
				<div>
					<h1 class="newsPageTitle">Contact Messages</h1>
				</div>
				<span class="newsPillBadge">Total: ${contactList.size()}</span>
			</div>

			<hr class="newsDivider">

			<!-- MESSAGES LIST -->
			<div class="panel">
				<c:choose>
					<c:when test="${empty contactList}">
						<p style="color: #94a3b8; text-align: center; padding: 32px 0;">No
							contact messages yet.</p>
					</c:when>
					<c:otherwise>
						<c:forEach var="c" items="${contactList}">
							<div class="newsRow">
								<div class="newsIconWrap">
									<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
										stroke="#3b82f6" stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round">
										<path
											d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path>
										<polyline points="22,6 12,13 2,6"></polyline>
									</svg>
								</div>
								<div class="newsInfo">
									<h4>
										<c:out value="${c.subject}" />
									</h4>
									<div class="newsMetaRow">
										<span class="newsCategoryBadge normal"><c:out
												value="${c.fullName}" /></span>
										<p>
											<c:out value="${c.email}" />
										</p>
										<p>${c.createdAt}</p>
									</div>
									<p style="color: #cbd5e1; font-size: 0.85rem; margin-top: 6px;">
										<c:out value="${c.message}" />
									</p>
								</div>
								<div class="newsActions">
									<form
										action="${pageContext.request.contextPath}/contactmessage"
										method="POST">
										<input type="hidden" name="contactId" value="${c.contactId}">
										<button type="submit" class="buttonNewsDelete">Done</button>
									</form>
								</div>
							</div>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</div>

		</main>
	</div>

</body>
</html>