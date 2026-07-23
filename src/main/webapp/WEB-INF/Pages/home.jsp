<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=1440">
<title>CivicPulse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/home.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/leftbar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/navbar.css">
</head>

<body>
	<jsp:include page="/Components/leftbar.jsp" />

	<div class="mainContent">
		<jsp:include page="/Components/navbar.jsp" />
		<div class="dashboardArea">

			<!-- ===== Available Services ===== -->
			<div class="servicesSection">
				<h2 class="sectionTitle">Available Services</h2>
				<br>
				<div class="servicesList">
					<div class="serviceItem"
						onclick="window.location.href='${pageContext.request.contextPath}/documents'">
						<div class="serviceIconBox">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
                                <rect x="3" y="4" width="18" height="16"
									rx="2" />
                                <circle cx="9" cy="10" r="2" />
                                <path
									d="M14 9h4M14 13h4M5 17c0-2 2-3 4-3s4 1 4 3" />
                            </svg>
						</div>
						<span class="serviceLabel">National ID</span>
					</div>
					<div class="serviceItem"
						onclick="window.location.href='${pageContext.request.contextPath}/documents'">
						<div class="serviceIconBox">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
                                <path
									d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2" />
                                <circle cx="7" cy="17" r="2" />
                                <circle cx="17" cy="17" r="2" />
                            </svg>
						</div>
						<span class="serviceLabel">Driving License</span>
					</div>
					<div class="serviceItem"
						onclick="window.location.href='${pageContext.request.contextPath}/documents'">
						<div class="serviceIconBox">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
                                <rect x="3" y="4" width="18" height="16"
									rx="2" />
                                <circle cx="12" cy="10" r="2.5" />
                                <path
									d="M6 18c0-2 2.5-3.5 6-3.5s6 1.5 6 3.5" />
                            </svg>
						</div>
						<span class="serviceLabel">Voter Card</span>
					</div>
					<div class="serviceItem"
						onclick="window.location.href='${pageContext.request.contextPath}/documents'">
						<div class="serviceIconBox">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
                                <rect x="2" y="5" width="20" height="14"
									rx="2" />
                                <line x1="2" y1="10" x2="22" y2="10" />
                                <rect x="5" y="14" width="4" height="2"
									rx="0.5" />
                            </svg>
						</div>
						<span class="serviceLabel">PAN</span>
					</div>
					<div class="serviceItem"
						onclick="window.location.href='${pageContext.request.contextPath}/documents'">
						<div class="serviceIconBox">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
                                <path
									d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
                                <path
									d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
                            </svg>
						</div>
						<span class="serviceLabel">Bluebook</span>
					</div>
					<div class="serviceItem"
						onclick="window.location.href='${pageContext.request.contextPath}/documents'">
						<div class="serviceIconBox">
							<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2.5" stroke-linecap="round"
								stroke-linejoin="round">
                                <circle cx="12" cy="12" r="1" />
                                <circle cx="19" cy="12" r="1" />
                                <circle cx="5" cy="12" r="1" />
                            </svg>
						</div>
						<span class="serviceLabel">Other Services</span>
					</div>
				</div>
			</div>

			<!-- ===== My Issues + Pending Permit Bookings (side-by-side) ===== -->
			<div class="activityContainer">

				<!-- My Issues (reported issues with status) -->
				<div class="activitySection issuesSection">
					<div class="sectionHeader">
						<h2 class="sectionTitle">My Issues</h2>
						<a href="${pageContext.request.contextPath}/report"
							class="viewAllLink">View all &rarr;</a>
					</div>
					<div class="issuesList">
						<c:choose>
							<c:when test="${not empty myReports}">
								<c:forEach var="report" items="${myReports}">
									<c:set var="statusClass" value="badgePending" />
									<c:if
										test="${report.status eq 'Resolved' or report.status eq 'Approved'}">
										<c:set var="statusClass" value="badgeApproved" />
									</c:if>
									<c:if test="${report.status eq 'Rejected'}">
										<c:set var="statusClass" value="badgeRejected" />
									</c:if>
									<c:if
										test="${report.status eq 'in_progress' or report.status eq 'Under review' or report.status eq 'Under Review'}">
										<c:set var="statusClass" value="badgeUnderReview" />
									</c:if>
									<div class="issueCard"
										onclick="window.location.href='${pageContext.request.contextPath}/report'">
										<div class="issueLeft">
											<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
												stroke="currentColor" stroke-width="2"
												stroke-linecap="round" stroke-linejoin="round"
												class="issueIcon">
                                                <path
													d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" />
                                                <line x1="12" y1="9"
													x2="12" y2="13" />
                                                <line x1="12" y1="17"
													x2="12.01" y2="17" />
                                            </svg>
											<div class="issueInfo">
												<span class="issueTitle">${report.title}</span>
												<c:if test="${not empty report.location}">
													<span class="issueLocation">${report.location}</span>
												</c:if>
											</div>
										</div>
										<span class="statusBadge ${statusClass}">${report.status}</span>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="emptyState">
									<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="1.5"
										stroke-linecap="round" stroke-linejoin="round">
                                        <path
											d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" />
                                        <line x1="12" y1="9" x2="12"
											y2="13" />
                                        <line x1="12" y1="17" x2="12.01"
											y2="17" />
                                    </svg>
									<p>No issues reported yet.</p>
									<a href="${pageContext.request.contextPath}/report">Report
										an issue &rarr;</a>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

				<!-- Pending Permit Bookings — iterate all pending permit bookings -->
				<div class="activitySection finesSection">
					<div class="sectionHeader">
						<h2 class="sectionTitle">Pending Permit Bookings</h2>
						<a href="${pageContext.request.contextPath}/payments"
							class="viewAllLink">View all &rarr;</a>
					</div>
					<div class="finesList">
						<c:choose>
							<c:when test="${not empty pendingFines}">
								<c:forEach var="fine" items="${pendingFines}">
									<div class="fineCard">
										<div class="fineInfo">
											<div class="fineTitle">${fine.violationType}</div>
											<div class="fineDesc">
												${fine.violationDate}

												<c:if test="${not empty fine.reason}">
        &nbsp;&middot;&nbsp;${fine.reason}
    </c:if>
											</div>
											<span class="fineStatusBadge">Unpaid</span>
										</div>
										<div class="fineAction">
											<div class="fineAmount">
												Rs.&nbsp;
												<fmt:formatNumber value="${fine.fineAmount}" pattern="#,##0" />
											</div>
											<form action="${pageContext.request.contextPath}/payments"
												method="GET">
												<button type="submit" class="payFineButton">Pay
													fine</button>
											</form>
										</div>
									</div>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<div class="emptyState">
									<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="1.5"
										stroke-linecap="round" stroke-linejoin="round">
                                        <path
											d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
                                        <polyline
											points="22 4 12 14.01 9 11.01" />
                                    </svg>
									<p>No pending permit bookings &mdash; you&rsquo;re all clear!</p>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>

			</div>
			<!-- end activityContainer -->

			<!-- ===== Bottom Cards: Poll + Contact Us ===== -->
			<div class="bottomCards">

				<!-- Community Poll — single featured poll -->
				<c:choose>
					<c:when test="${not empty featuredPoll}">
						<div class="pollCard"
							onclick="window.location.href='${pageContext.request.contextPath}/polls'"
							style="cursor: pointer;">
							<div class="cardHeader">
								<div class="pollIconWrap">
									<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="2.2"
										stroke-linecap="round" stroke-linejoin="round">
                                        <line x1="18" y1="20" x2="18"
											y2="10" />
                                        <line x1="12" y1="20" x2="12"
											y2="4" />
                                        <line x1="6" y1="20" x2="6"
											y2="14" />
                                    </svg>
								</div>
								<h3 class="cardTitle">Community Poll</h3>
							</div>
							<p class="pollQuestion">${featuredPoll.question}</p>
							<div class="pollOptions">
								<div class="pollOption">
									<span class="pollOptionText">${featuredPoll.option1}</span>
									<!-- SVG Radio (unchecked) -->
									<svg class="radioSvg" width="22" height="22"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round">
										<circle cx="12" cy="12" r="10" />
									</svg>
								</div>
								<div class="pollOption">
									<span class="pollOptionText">${featuredPoll.option2}</span>
									<svg class="radioSvg" width="22" height="22"
										viewBox="0 0 24 24" fill="none" stroke="currentColor"
										stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round">
										<circle cx="12" cy="12" r="10" />
									</svg>
								</div>
							</div>
						</div>
					</c:when>
					<c:otherwise>
						<div class="pollCard">
							<div class="cardHeader">
								<div class="pollIconWrap">
									<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
										stroke="currentColor" stroke-width="2.2"
										stroke-linecap="round" stroke-linejoin="round">
                                        <line x1="18" y1="20" x2="18"
											y2="10" />
                                        <line x1="12" y1="20" x2="12"
											y2="4" />
                                        <line x1="6" y1="20" x2="6"
											y2="14" />
                                    </svg>
								</div>
								<h3 class="cardTitle">Community Poll</h3>
							</div>
							<p class="pollQuestion">No active polls right now. Check back
								soon!</p>
						</div>
					</c:otherwise>
				</c:choose>

				<!-- Contact Us Card (formerly Report a Problem) -->
				<div class="reportCard">
					<div class="reportIconBox">
						<svg width="32" height="32" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
                            <path
								d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 
								19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 
								2h3a2 2 0 0 1 2 1.72c.127.96.362 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.338 1.85.573 2.81.7A2 2 0 0 1 22 16.92z" />
                        </svg>
					</div>
					<h3 class="reportTitle">Need help? Contact Us</h3>
					<p class="reportDesc">Have a question, concern, or feedback?
						Our support team is here to assist you. Reach out anytime.</p>
					<a href="${pageContext.request.contextPath}/contact"
						class="reportButton"
						style="text-decoration: none; display: inline-flex;">Contact
						Us</a>
				</div>

			</div>
		</div>
	</div>
</body>
</html>