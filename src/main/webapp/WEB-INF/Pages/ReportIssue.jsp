<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Issue Management - CivicPulse</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/Admin-Side.css?v=<%=System.currentTimeMillis()%>">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/CSS/ReportIssue.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />

	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">
		<jsp:include page="/Components/admin-topbar.jsp" />

		<div class="dashboardBody">
			<div class="issuePageWrapper">

				<div class="issuePageHeader">
					<h1 class="issuePageTitle">Issue Management</h1>
					<p class="issuePageSubtitle">Manage community raised Issues</p>
				</div>

				<hr class="issueDivider">

				<!-- Stats Row -->
				<div class="issueStatsContainer">
					<div class="issueStatCard">
						<div class="statIconWrap">
							<div class="statBars barsGreen">
								<div class="bar h50"></div>
								<div class="bar h80"></div>
								<div class="bar h100"></div>
								<div class="bar h60"></div>
							</div>
						</div>
						<div class="statInfo"
							style="align-items: flex-start; text-align: left;">
							<span class="statLabel">Total Posts</span> <span
								class="statValue">${totalReports}</span>
						</div>
					</div>
					<div class="issueStatCard">
						<div class="statIconWrap">
							<div class="statBars barsOrange">
								<div class="bar h60"></div>
								<div class="bar h100"></div>
								<div class="bar h80"></div>
							</div>
						</div>
						<div class="statInfo"
							style="align-items: flex-start; text-align: left;">
							<span class="statLabel">Resolved Posts</span> <span
								class="statValue" style="color: #D35400;">${resolvedReports}</span>
							<span class="statTrend green" style="margin-top: 4px;">Excellent</span>
						</div>
					</div>
					<div class="issueStatCard">
						<div class="statIconWrap">
							<div class="statBars barsBlue">
								<div class="bar h70"></div>
								<div class="bar h100"></div>
								<div class="bar h50"></div>
							</div>
						</div>
						<div class="statInfo"
							style="align-items: flex-start; text-align: left;">
							<span class="statLabel">On Progress Posts</span> <span
								class="statValue" style="color: #3b82f6;">${inProgressReports}</span>
							<span class="statTrend orange" style="margin-top: 4px;">InProgress</span>
						</div>
					</div>
					<div class="issueStatCard">
						<div class="statIconWrap">
							<div class="statBars barsYellow">
								<div class="bar h100"></div>
								<div class="bar h60"></div>
							</div>
						</div>
						<div class="statInfo"
							style="align-items: flex-start; text-align: left;">
							<span class="statLabel">Pending Posts</span> <span
								class="statValue" style="color: #D32F2F;">${pendingReports}</span>
							<span class="statTrend orange" style="margin-top: 4px;">Ontrack</span>
						</div>
					</div>
				</div>

				<hr class="issueDivider">

				<h2 class="sectionTitle">Manage Issues</h2>

				<div class="issueList">
					<c:forEach var="r" items="${reports}">
						<div class="issueRow">
							<div class="issueAvatar">
								<svg width="20" height="20" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2" stroke-linecap="round"
									stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10"></circle>
                                    <line x1="12" y1="8" x2="12" y2="12"></line>
                                    <line x1="12" y1="16" x2="12.01"
										y2="16"></line>
                                </svg>
							</div>
							<div class="issueDetails">
								<div class="issueMeta">
									<span class="reporterName">${r.firstName} ${r.lastName}</span>
									<span class="metaDivider">|</span> <span class="issueTitle">${r.title}</span>
								</div>
								<p class="submittedTime">${r.category}•${r.location}</p>
							</div>
							<c:choose>
								<c:when test="${r.status == 'resolved'}">
									<span class="statusBadge completed">Resolved</span>
								</c:when>
								<c:when test="${r.status == 'in_progress'}">
									<span class="statusBadge inProgress">In Progress</span>
								</c:when>
								<c:otherwise>
									<span class="statusBadge pending">Pending</span>
								</c:otherwise>
							</c:choose>
							<form action="<%=request.getContextPath()%>/reportissue"
								method="POST">
								<input type="hidden" name="reviewIssueId" value="${r.reportId}">
								<button type="submit" class="buttonReview">Review</button>
							</form>
						</div>
					</c:forEach>
				</div>

			</div>
		</div>
	</div>

	<!-- MODERATE MODAL -->
	<div class="moderateModalOverlay"
		style="${not empty selectedIssue ? 'display:flex;' : 'display:none;'}">
		<div class="moderateModal" style="max-height: 80vh;">

			<a href="<%=request.getContextPath()%>/reportissue"
				class="modalClose"> <svg width="24" height="24"
					viewBox="0 0 24 24" fill="none" stroke="currentColor"
					stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
					<line x1="18" y1="6" x2="6" y2="18"></line>
					<line x1="6" y1="6" x2="18" y2="18"></line>
				</svg>
			</a>

			<div class="modalHeader">
				<h2>Moderate Issue</h2>
				<p>Apply administrative Actions</p>
			</div>

			<div class="modalBody">

				<div class="formGroup">
					<label class="formLabel">Category</label>
					<div class="categoryReadonly">${selectedIssue.category}</div>
				</div>

				<div class="formGroup">
					<label class="formLabel">Location</label>
					<div class="categoryReadonly">${selectedIssue.location}</div>
				</div>

				<div class="formGroup">
					<label class="formLabel">Attachments</label>
					<c:choose>
						<c:when test="${not empty selectedIssue.reportPhoto}">
							<img
								src="${pageContext.request.contextPath}/getimage?name=${fn:substringBefore(selectedIssue.reportPhoto, '.')}"
								style="max-width: 100%; border-radius: 8px; margin-top: 6px;">
						</c:when>
						<c:otherwise>
							<div class="attachmentStatus none">No attachment found</div>
						</c:otherwise>
					</c:choose>
				</div>

				<div class="formGroup">
					<label class="formLabel">User Description</label>
					<div class="userDescriptionBox">${selectedIssue.description}</div>
				</div>

				<div class="formGroup">
					<label class="formLabel">Current Status</label>
					<div class="statusSelector">

						<form action="<%=request.getContextPath()%>/reportissue"
							method="POST">
							<input type="hidden" name="reviewIssueId"
								value="${selectedIssue.reportId}"> <input type="hidden"
								name="selectedStatus" value="pending">
							<button type="submit"
								class="statusButton ${selectedStatus == 'pending' ? 'active' : ''}">
								<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2">
									<circle cx="12" cy="12" r="10"></circle>
									<line x1="12" y1="8" x2="12" y2="12"></line>
									<line x1="12" y1="16" x2="12.01" y2="16"></line>
								</svg>
								Pending
							</button>
						</form>

						<form action="<%=request.getContextPath()%>/reportissue"
							method="POST">
							<input type="hidden" name="reviewIssueId"
								value="${selectedIssue.reportId}"> <input type="hidden"
								name="selectedStatus" value="in_progress">
							<button type="submit"
								class="statusButton ${selectedStatus == 'in_progress' ? 'active' : ''}">
								<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2">
									<polyline points="22 12 18 12 15 21 9 3 6 12 2 12"></polyline>
								</svg>
								In Progress
							</button>
						</form>

						<form action="<%=request.getContextPath()%>/reportissue"
							method="POST">
							<input type="hidden" name="reviewIssueId"
								value="${selectedIssue.reportId}"> <input type="hidden"
								name="selectedStatus" value="resolved">
							<button type="submit"
								class="statusButton ${selectedStatus == 'resolved' ? 'active' : ''}">
								<svg viewBox="0 0 24 24" fill="none" stroke="currentColor"
									stroke-width="2">
									<polyline points="20 6 9 17 4 12"></polyline>
								</svg>
								Resolved
							</button>
						</form>

					</div>
				</div>

				<div class="formGroup">
					<label class="formLabel">Internal Staff Notes</label>
					<textarea class="staffNotes" name="notes" id="notesField"
						form="moderateForm">${selectedIssue.staffNotes}</textarea>

				</div>

			</div>

			<div
				style="display: flex; justify-content: space-between; align-items: center; padding: 16px 28px; border-top: 1px solid #323639;">

				<form action="<%=request.getContextPath()%>/reportissue"
					method="POST" style="display: inline-flex; margin: 0; flex: none;">
					<input type="hidden" name="openDeleteIssueId"
						value="${selectedIssue.reportId}">
					<button type="submit" class="buttonDeletePost">
						<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2">
                <polyline points="3 6 5 6 21 6"></polyline>
                <path
								d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
            </svg>
						Delete Post
					</button>
				</form>

				<form id="moderateForm"
					action="<%=request.getContextPath()%>/moderateissue" method="POST"
					style="display: flex; padding-left: 150px; gap: 30px; align-items: center; margin: 0;">
					<input type="hidden" name="reportId"
						value="${selectedIssue.reportId}"> <input type="hidden"
						name="status" value="${selectedStatus}">
					<button type="submit" class="buttonSaveChanges">Save
						Changes</button>

				</form>

			</div>
		</div>
	</div>

	<!-- DELETE CONFIRMATION MODAL -->
	<div class="moderateModalOverlay"
		style="${not empty openDeleteIssueId ? 'display:flex;' : 'display:none;'}">
		<div class="dangerModal">

			<div class="dangerModalHeader">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2" style="color: #ffbba6;">
					<path
						d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
					<line x1="12" y1="9" x2="12" y2="13"></line>
					<line x1="12" y1="17" x2="12.01" y2="17"></line>
				</svg>
				<h2>Confirm Deletion</h2>
			</div>

			<form action="<%=request.getContextPath()%>/deleteissue"
				method="POST">
				<input type="hidden" name="reportId" value="${openDeleteIssueId}">
				<div class="dangerModalBody">
					<p>
						You are about to permanently delete the issue: <strong
							style="color: #ffffff;">${deleteIssueTitle}</strong>
					</p>
				</div>
				<div class="dangerModalFooter">
					<a href="<%=request.getContextPath()%>/reportissue"
						class="buttonCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonConfirmDanger">Confirm
						Deletion</button>
				</div>
			</form>

		</div>
	</div>

</body>
</html>

</body>
</html>