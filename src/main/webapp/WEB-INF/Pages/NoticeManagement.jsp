<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notices - CivicPulse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Admin-Side.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/NoticeManagement.css">
</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />

	<!-- SIDEBAR component -->
	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">
		<!-- TOPBAR component -->
		<jsp:include page="/Components/admin-topbar.jsp" />

		<div class="dashboardBody">

			<!-- PAGE HEADER -->
			<div class="noticePageHeader">
				<h1 class="noticePageTitle">Post A Notice</h1>
				<p class="noticePageSubtitle">Manage and Upload Important Notice</p>
			</div>

			<hr class="noticeDivider">

			<!-- POST A NEW NOTICE FORM -->
			<div class="noticeFormCard">
				<div class="noticeFormHeader">
					<h2 class="noticeFormHeading">Post a New Notice</h2>
				</div>

				<form action="${pageContext.request.contextPath}/noticelist"
					method="POST" class="noticeForm">
					<div class="noticeFormRow">
						<div class="noticeFormGroup">
							<label class="noticeFormLabel" for="noticeTitle">Notice
								Title</label> <input type="text" class="noticeFormInput"
								id="noticeTitle" name="noticeTitle" placeholder="e.g. Meeting">
						</div>
						<div class="noticeFormGroup">
							<label class="noticeFormLabel" for="noticeCategory">Category</label>
							<select class="noticeFormSelect" id="noticeCategory"
								name="noticeCategory">
								<option value="Policy">Policy</option>
								<option value="Event">Event</option>
								<option value="Maintenance">Maintenance</option>
								<option value="Safety">Safety</option>
								<option value="General">General</option>
								<option value="Job">Job</option>
							</select>
						</div>
					</div>

					<div class="noticeFormGroup noticeFormGroupFull">
						<label class="noticeFormLabel" for="noticeDescription">Notice
							Description</label>
						<textarea class="noticeFormTextarea" id="noticeDescription"
							name="noticeDescription" placeholder="Describe the Notice"></textarea>
					</div>

					<c:if test="${not empty errorMessage}">
						<p class="error-message">${errorMessage}</p>
					</c:if>

					<div class="noticeFormActions">
						<button type="submit" class="buttonPostNotice">Post
							Notice</button>
					</div>
				</form>
			</div>

			<!-- NOTICE LIST SECTION -->
			<div class="noticeListContainer">
				<c:forEach var="n" items="${notices}">
					<div class="noticeRow">
						<div class="noticeIconWrap">
							<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
								stroke="#3b82f6" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
			                    <path
									d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
			                    <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
			                </svg>
						</div>
						<div class="noticeInfo">
							<h4>
								<c:out value="${n.noticeTitle}" />
							</h4>
							<p>Posted ${n.createdAt}</p>
						</div>
						<span class="noticeCategoryTag tag${n.noticeCategory}"> <c:out
								value="${n.noticeCategory}" />
						</span>
						<div class="noticeActions">
							<form action="${pageContext.request.contextPath}/noticelist"
								method="POST">
								<input type="hidden" name="editNoticeId" value="${n.noticeId}">
								<button type="submit" class="buttonNoticeEdit">Edit</button>
							</form>
							<form action="${pageContext.request.contextPath}/noticelist"
								method="POST">
								<input type="hidden" name="openDeleteNoticeId"
									value="${n.noticeId}">
								<button type="submit" class="buttonNoticeDelete">Delete</button>
							</form>
						</div>
					</div>
				</c:forEach>
			</div>



		</div>
	</div>

	<!-- DELETE CONFIRMATION MODAL -->
	<div class="modalOverlay" id="deleteNoticeModal"
		style="${not empty deleteNoticeId ? 'display:flex;' : ''}">
		<div class="modalBox"
			style="padding: 0; max-width: 520px; overflow: hidden;">
			<div class="modalHeaderDanger">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round" style="color: #ffbba6;">
                <path
						d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
                <line x1="12" y1="9" x2="12" y2="13"></line>
                <line x1="12" y1="17" x2="12.01" y2="17"></line>
            </svg>
				<h2>Confirm Deletion</h2>
			</div>
			<form action="${pageContext.request.contextPath}/deletenotice"
				method="POST">
				<input type="hidden" name="noticeId" value="${deleteNoticeId}">
				<div class="modalBodyContent">
					<p class="modalDescriptionText">
						You are about to permanently delete the notice <strong
							style="color: #ffffff; font-weight: 700;">${deleteNoticeTitle}</strong>.
						This action cannot be undone.
					</p>
				</div>
				<div class="modalFooterActions">
					<a href="${pageContext.request.contextPath}/noticelist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonNoticeDelete">Delete</button>
				</div>
			</form>
		</div>
	</div>

	<!-- EDIT NOTICE MODAL -->
	<div class="modalOverlay" id="editNoticeModal"
		style="${not empty editNotice ? 'display:flex;' : ''}">
		<div class="modalBox"
			style="padding: 0; max-width: 560px; overflow: hidden;">
			<div class="modalHeaderEdit">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round" style="color: #93c5fd;">
	                <path
						d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
	                <path
						d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
	            </svg>
				<h2>Edit Notice</h2>
			</div>
			<form action="${pageContext.request.contextPath}/updatenotice"
				method="POST">
				<input type="hidden" name="noticeId" value="${editNotice.noticeId}">
				<div class="modalBodyContent">
					<div class="noticeFormGroup">
						<label class="noticeFormLabel">Notice Title</label> <input
							type="text" class="noticeFormInput" name="noticeTitle"
							value="<c:out value='${editNotice.noticeTitle}'/>" required>
					</div>
					<div class="noticeFormGroup">
						<label class="noticeFormLabel">Category</label> <select
							class="noticeFormSelect" name="noticeCategory" required>
							<option value="Policy"
								${editNotice.noticeCategory == 'Policy'      ? 'selected' : ''}>Policy</option>
							<option value="Event"
								${editNotice.noticeCategory == 'Event'       ? 'selected' : ''}>Event</option>
							<option value="Maintenance"
								${editNotice.noticeCategory == 'Maintenance' ? 'selected' : ''}>Maintenance</option>
							<option value="Safety"
								${editNotice.noticeCategory == 'Safety'      ? 'selected' : ''}>Safety</option>
							<option value="General"
								${editNotice.noticeCategory == 'General'     ? 'selected' : ''}>General</option>
						</select>
					</div>
					<div class="noticeFormGroup">
						<label class="noticeFormLabel">Description</label>
						<textarea class="noticeFormTextarea" name="noticeDescription"
							required><c:out
								value="${editNotice.noticeDescription}" /></textarea>
					</div>
				</div>
				<div class="modalFooterActions">
					<a href="${pageContext.request.contextPath}/noticelist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonModalSuccess">Save
						Changes</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
