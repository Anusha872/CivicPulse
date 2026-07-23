<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard - CivicPulse</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/Admin-Side.css">
</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />
	<!-- SIDEBAR component -->
	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">

		<jsp:include page="/Components/admin-topbar.jsp" />

		<!-- DASHBOARD BODY -->
		<main class="dashboardBody">

			<div class="report-bar" style="display: flex; gap: 10px;">
				<a href="<%=request.getContextPath()%>/generatereport"
					class="download"> Download </a> <a
					href="<%=request.getContextPath()%>/contactmessage"
					class="download">Contact Messages</a>

			</div>

			<!-- STAT CARDS -->
			<div class="statsFlex">
				<div class="statCard">
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
						<span class="statLabel">Total citizens</span> <span
							class="statValue">${totalCitizens}</span> <span
							class="statTrend green">▲ Wow </span>
					</div>
				</div>
				<div class="statCard">
					<div class="statIconWrap">
						<div class="statBars barsOrange">
							<div class="bar h50"></div>
							<div class="bar h80"></div>
							<div class="bar h100"></div>
							<div class="bar h60"></div>
						</div>
					</div>
					<div class="statInfo">
						<span class="statLabel">Open civic issues</span> <span
							class="statValue">${openIssues}</span> <span
							class="statTrend orange">Needs attention</span>
					</div>
				</div>
				<div class="statCard">
					<div class="statIconWrap">
						<div class="statBars barsBlue">
							<div class="bar h70"></div>
							<div class="bar h50"></div>
							<div class="bar h100"></div>
						</div>
					</div>
					<div class="statInfo">
						<span class="statLabel">Documents pending</span> <span
							class="statValue">${pendingDocuments}</span> <span
							class="statTrend orange">Awaiting review</span>
					</div>
				</div>
				<div class="statCard">
					<div class="statIconWrap">
						<div class="statBars barsYellow">
							<div class="bar h100"></div>
							<div class="bar h80"></div>
						</div>
					</div>
					<div class="statInfo">
						<span class="statLabel">Active polls</span> <span
							class="statValue">${activePolls}</span> <span
							class="statTrend orange">On track</span>
					</div>
				</div>
			</div>
			<!-- MAIN GRID -->
			<div class="dashboardFlex">
				<!-- LEFT COLUMN -->
				<div class="leftCol">
					<div class="panel">
						<div class="panelHeader">
							<span class="panelTitle">Recent civic issues</span> <a
								href="<%=request.getContextPath()%>/reportissue"
								class="viewAllLink">View all</a>
						</div>
						<table class="dataTable">
							<thead>
								<tr>
									<th>Citizen</th>
									<th>Category</th>
									<th>Submitted</th>
									<th>Status</th>
								</tr>
							</thead>
							<c:forEach var="r" items="${recentIssues}">
								<tr class="${r.status != 'resolved' && r.status != 'in_progress' ? 'pending-row' : ''}">
									<td class="primaryText">${r.firstName} ${r.lastName}</td>
									<td class="secondaryText">${r.category}</td>
									<td class="secondaryText">${r.createdAt}</td>
									<td><c:choose>
											<c:when test="${r.status == 'resolved'}">
												<span class="badge badgeResolved">Resolved</span>
											</c:when>
											<c:when test="${r.status == 'in_progress'}">
												<span class="badge badgeProgress">In Progress</span>
											</c:when>
											<c:otherwise>
												<span class="badge badgePending">Pending</span>
											</c:otherwise>
										</c:choose></td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="panel">
						<div class="panelHeader">
							<span class="panelTitle">News </span> <a
								href="<%=request.getContextPath()%>/newslist"
								class="viewAllLink">View all</a>
						</div>
						<table class="dataTable">
							<thead>
								<tr>
									<th>Title</th>
									<th>Type</th>
									<th>Date</th>
									<th>Status</th>
								</tr>
							</thead>
							<c:forEach var="n" items="${recentNews}">
								<tr>
									<td class="primaryText">${n.newsTitle}</td>
									<td><span class="typeBadge">${n.newsCategory}</span></td>
									<td class="secondaryText">${n.postedAt}</td>
									<td><span class="badge badgePublished">Published</span></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</div>

				<!-- RIGHT COLUMN -->
				<div class="rightCol">
					<div class="panel">
						<div class="panelHeader">
							<span class="panelTitle">Active polls</span> <a
								href="<%=request.getContextPath()%>/pollmanagement"
								class="viewAllLink">View all</a>
						</div>
						<c:forEach var="p" items="${recentPolls}" end="2">
							<c:if test="${p.status == 'Active'}">
								<div class="pollItem">
									<div class="pollIconBox">
										<div class="statBars barsBlue" style="height: 16px; gap: 2px;">
											<div class="bar h60" style="width: 3px;"></div>
											<div class="bar h100" style="width: 3px;"></div>
											<div class="bar h80" style="width: 3px;"></div>
										</div>
									</div>
									<div class="pollDetails">
										<h4>${p.question}</h4>
										<p class="pollMeta">${p.status}</p>
									</div>
								</div>
							</c:if>
						</c:forEach>
					</div>
					<div class="panel">
						<div class="panelHeader">
							<span class="panelTitle">Document vault</span> <a
								href="<%=request.getContextPath()%>/documentlist"class="viewAllLink">View all</a>
						</div>
						<div class="statRow">
							<span class="statRowLabel">Total documents</span><span
								class="statRowValue">${totalDocuments}</span>
						</div>
						<div class="statRow">
							<span class="statRowLabel">Pending verification</span><span
								class="statRowValue valueOrange">${pendingDocuments}</span>
						</div>
					</div>
					<div class="panel">
						<div class="panelHeader">
							<span class="panelTitle">Recent Notices</span> <a
								href="<%=request.getContextPath()%>/noticelist"
								class="viewAllLink">View all</a>
						</div>
						<div class="statRow">
							<span class="primaryText">Total Notices</span><span
								class="statRowValue">${totalNotices}</span>
						</div>
						<c:forEach var="n" items="${recentNotices}" end="2">
							<div class="statRow">
								<span class="statRowLabel">${n.noticeTitle}</span> <span
									class="statRowLabel">${n.noticeCategory}</span>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
</html>