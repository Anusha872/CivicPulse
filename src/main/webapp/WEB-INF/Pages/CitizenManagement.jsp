<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Citizen Management - CivicPulse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Admin-Side.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/CitizenManagement.css">
</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />

	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">

		<jsp:include page="/Components/admin-topbar.jsp" />

		<div class="dashboardBody">
			<div class="twoColumnLayout">

				<!-- LEFT COLUMN: citizen list and search -->
				<div class="leftColumn">

					<div class="pageHeader">
						<h1 class="pageTitle">Citizen Management</h1>
						<p class="pageSubtitle">Manage the Community</p>
					</div>

					<hr class="divider">

					<div class="statsFlex smallStats" style="margin-bottom: 24px;">

						<div class="statCard statCardSmall">
							<div class="statIconWrap">
								<div class="statBars barsGreen">
									<div class="bar h40"></div>
									<div class="bar h60"></div>
									<div class="bar h80"></div>
									<div class="bar h100"></div>
									<div class="bar h60"></div>
								</div>
							</div>
							<div class="statInfo">
								<span class="statLabel">Total citizens</span>
								<span class="statValue">${totalCitizens}</span>
								<span class="statTrend green">▲ Great</span>
							</div>
						</div>

						<div class="statCard statCardSmall">
							<div class="statIconWrap">
								<div class="statBars barsBlue">
									<div class="bar h70"></div>
									<div class="bar h50"></div>
									<div class="bar h100"></div>
								</div>
							</div>
							<div class="statInfo">
								<span class="statLabel">Active Citizens</span>
								<span class="statValue">${activeCount}</span>
								<span class="statTrend blue"
									style="color: #3b82f6; font-size: 11px; margin-top: 4px; font-weight: 600;">Good
									Standing</span>
							</div>
						</div>

						<div class="statCard statCardSmall">
							<div class="statIconWrap">
								<div class="statBars barsOrange">
									<div class="bar h50"></div>
									<div class="bar h80"></div>
									<div class="bar h100"></div>
									<div class="bar h60"></div>
								</div>
							</div>
							<div class="statInfo">
								<span class="statLabel">Suspended</span>
								<span class="statValue">${suspendedCount}</span>
								<span class="statTrend orange">Needs attention</span>
							</div>
						</div>

					</div>

					<div class="citizenList">

						<form action="${pageContext.request.contextPath}/citizenlist"
							method="GET" class="searchForm">
							<input type="text" name="search" class="searchInput"
								placeholder="Search citizens..." value="${searchQuery}" />
							<button type="submit" class="buttonReview">Search</button>
							<c:if test="${not empty searchQuery}">
								<a href="${pageContext.request.contextPath}/citizenlist"
									class="buttonCancel">Clear</a>
							</c:if>
						</form>

						<c:choose>
							<c:when test="${not empty searchQuery}">
								<!-- If search is active show search results -->
								<h2 class="citizenSectionTitle">Search Results</h2>
								<c:forEach var="c" items="${citizens}">
									<div class="citizenCard">
										<div class="citizenInfo">
											<div class="avatarBox">
												<svg width="24" height="24" viewBox="0 0 24 24"
													fill="currentColor">
													<path
														d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
												</svg>
											</div>
											<div class="nameGroup">
												<h3>
													<c:out value="${c.firstName} ${c.lastName}" />
												</h3>
												<p>ID: #${c.userId} &bull; ${c.status}</p>
											</div>
											<span class="roleTag">Resident</span>
										</div>
										<form action="${pageContext.request.contextPath}/citizenlist"
											method="GET">
											<input type="hidden" name="userId" value="${c.userId}">
											<button type="submit" class="buttonReview">Review</button>
										</form>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<!-- Default view: active and inactive citizens list -->
								<h2 class="citizenSectionTitle">Active Citizens</h2>
								<c:forEach var="c" items="${activeCitizen}">
									<div class="citizenCard">
										<div class="citizenInfo">
											<div class="avatarBox">
												<svg width="24" height="24" viewBox="0 0 24 24"
													fill="currentColor">
													<path
														d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
												</svg>
											</div>
											<div class="nameGroup">
												<h3>
													<c:out value="${c.firstName} ${c.lastName}" />
												</h3>
												<p>ID: #${c.userId} &bull; Active</p>
											</div>
											<span class="roleTag">Resident</span>
										</div>
										<form action="${pageContext.request.contextPath}/citizenlist"
											method="GET">
											<input type="hidden" name="userId" value="${c.userId}">
											<button type="submit" class="buttonReview">Review</button>
										</form>
									</div>
								</c:forEach>

								<h2 class="citizenSectionTitle">Inactive Citizens</h2>
								<c:forEach var="c" items="${inactiveCitizen}">
									<div class="citizenCard">
										<div class="citizenInfo">
											<div class="avatarBox">
												<svg width="24" height="24" viewBox="0 0 24 24"
													fill="currentColor">
													<path
														d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
												</svg>
											</div>
											<div class="nameGroup">
												<h3>
													<c:out value="${c.firstName} ${c.lastName}" />
												</h3>
												<p>ID: #${c.userId} &bull; Inactive</p>
											</div>
											<span class="roleTag">Resident</span>
										</div>
										<form action="${pageContext.request.contextPath}/citizenlist"
											method="GET">
											<input type="hidden" name="userId" value="${c.userId}">
											<button type="submit" class="buttonReview">Review</button>
										</form>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<!-- RIGHT COLUMN: selected citizen profile panel -->
				<div class="rightColumn">
					<c:choose>
						<c:when test="${empty selectedCitizen}">
							<!-- No citizen selected: show empty state -->
							<div class="emptyStatePanel">
								<svg width="48" height="48" viewBox="0 0 24 24" fill="none"
									stroke="#323639" stroke-width="2" stroke-linecap="round"
									stroke-linejoin="round" style="margin-bottom: 16px;">
									<circle cx="12" cy="12" r="10"></circle>
									<line x1="12" y1="16" x2="12" y2="12"></line>
									<line x1="12" y1="8" x2="12.01" y2="8"></line>
								</svg>
								<h3 style="color: #ffffff; font-size: 18px; margin-bottom: 8px;">No
									Citizen Selected</h3>
								<p style="color: #75787D; font-size: 14px;">Select a citizen
									from the list to review their details, issues, and facility fees.</p>
							</div>
						</c:when>
						<c:otherwise>
							<!-- Citizen selected: show full profile panel -->
							<div class="profilePanel">

								<div class="profileHeader">
									<div class="profileTitle">Citizen Profile</div>
									<a href="${pageContext.request.contextPath}/citizenlist"
										class="closeProfileButton" title="Close Profile">
										<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round">
											<line x1="18" y1="6" x2="6" y2="18"></line>
											<line x1="6" y1="6" x2="18" y2="18"></line>
										</svg>
									</a>
								</div>

								<div class="profileSummary">
									<div class="largeAvatar">
										<svg width="36" height="36" viewBox="0 0 24 24"
											fill="currentColor">
											<path
												d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z" />
										</svg>
										<span class="statusDot"></span>
									</div>
									<h2 class="profileName">${selectedCitizen.firstName}
										${selectedCitizen.lastName}</h2>
								</div>

								<div class="profileDetails">
									<div class="detailRow">
										<span class="detailLabel">Username :</span>
										<span class="detailValue">${selectedCitizen.userName}</span>
									</div>
									<div class="detailRow">
										<span class="detailLabel">Email :</span>
										<span class="detailValue">${selectedCitizen.email}</span>
									</div>
									<div class="detailRow">
										<span class="detailLabel">Phone :</span>
										<span class="detailValue">${selectedCitizen.number}</span>
									</div>
									<div class="detailRow">
										<span class="detailLabel">Registered :</span>
										<span class="detailValue">${selectedCitizen.registrationDate}</span>
									</div>
								</div>

								<div class="suspendArea">
									<c:choose>
										<c:when test="${selectedCitizen.status == 'Active'}">
											<!-- Citizen is active: show deactivate button -->
											<form action="${pageContext.request.contextPath}/citizenlist"
												method="GET">
												<input type="hidden" name="userId"
													value="${selectedCitizen.userId}">
												<input type="hidden" name="openSuspendId"
													value="${selectedCitizen.userId}">
												<button type="submit" class="buttonSuspend">DeActivate
													User</button>
											</form>
										</c:when>
										<c:otherwise>
											<!-- Citizen is suspended: show activate button -->
											<p style="color: #ef4444; font-size: 13px; margin-bottom: 10px;">This
												citizen is currently suspended.</p>
											<form action="${pageContext.request.contextPath}/unsuspend"
												method="POST">
												<input type="hidden" name="userId"
													value="${selectedCitizen.userId}">
												<button type="submit" class="buttonUnsuspend">Activate
													User</button>
											</form>
										</c:otherwise>
									</c:choose>
								</div>

							</div>
						</c:otherwise>
					</c:choose>
				</div>

			</div>
		</div>
	</div>

	<!-- Suspension confirmation modal -->
	<div class="modalOverlay" id="suspendModal"
		style="${not empty openSuspendId ? 'display:flex;' : ''}">
		<div class="modalBox">
			<div class="modalHeaderRed">
				<svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
					<path
						d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" />
				</svg>
				<h2>Confirm Suspension</h2>
			</div>
			<form action="${pageContext.request.contextPath}/suspend" method="POST">
				<input type="hidden" name="userId" value="${openSuspendId}">
				<div class="modalBody">
					<p class="modalText">
						You are about to suspend the account for <strong>${selectedCitizen.firstName}
							${selectedCitizen.lastName}</strong>. Please give your reason below.
					</p>
					<label class="labelArea">Reason of Suspension</label>
					<textarea class="modalTextarea" name="suspensionReason"
						placeholder="Provide a detailed explanation for this suspension..."
						required></textarea>
				</div>
				<div class="modalFooter">
					<a href="${pageContext.request.contextPath}/citizenlist"
						class="buttonCancel">Cancel</a>
					<button type="submit" class="buttonConfirmRed">Confirm
						Suspension</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>