<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document Management - CivicPulse</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Admin-Side.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/DocumentManagement.css">
</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />

	<!-- sidebar -->
	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">
		<!-- topbar -->
		<jsp:include page="/Components/admin-topbar.jsp" />

		<div class="dashboardBody">
			<div class="docPageHeader">
				<h1 class="docPageTitle">Document Management</h1>
			</div>

			<!-- stat cards -->
			<div class="statsFlex" style="margin-bottom: 24px;">
				<!-- total -->
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
						<span class="statLabel">Total Documents</span> <span
							class="statValue">${totalDocuments}</span>
					</div>
				</div>
				<!-- approved -->
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
						<span class="statLabel">Approved Documents</span> <span
							class="statValue">${approvedDocuments}</span>
					</div>
				</div>
				<!-- pending -->
				<div class="statCard">
					<div class="statIconWrap">
						<div class="statBars barsBlue">
							<div class="bar h70"></div>
							<div class="bar h50"></div>
							<div class="bar h100"></div>
						</div>
					</div>
					<div class="statInfo">
						<span class="statLabel">Pending Documents</span> <span
							class="statValue">${pendingDocuments}</span>
					</div>
				</div>
			</div>

			<hr class="docDivider">

			<div class="docTwoColumn">
				<!-- pending documents table -->
				<div class="docTableCard">
					<h2 class="docTableTitle">Pending Documents</h2>
					<table class="docTable">
						<thead>
							<tr>
								<th>Citizen</th>
								<th>Type</th>
								<th>Submitted</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="doc" items="${documents}">
								<c:if test="${doc.status == 'Pending'}">
									<tr>
										<td>${doc.fullName}</td>
										<td>${doc.documentType}</td>
										<td>${doc.submittedAt}</td>
										<td class="docActionCell">
											<!-- open approval modal -->
											<form
												action="${pageContext.request.contextPath}/documentlist"
												method="GET" style="display: inline;">
												<input type="hidden" name="openDoc"
													value="${doc.documentId}">
												<button type="submit" class="buttonDocAccept">Accept</button>
											</form>
											<!-- reject and delete -->
											<form
												action="${pageContext.request.contextPath}/documentlist"
												method="GET" style="display: inline;">
												<input type="hidden" name="deleteDoc"
													value="${doc.documentId}">
												<button type="submit" class="buttonDocReject">Reject</button>
											</form>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>

				<!-- verified documents table -->
				<div class="docTableCard">
					<h2 class="docTableTitle">Verified Documents</h2>
					<table class="docTable">
						<thead>
							<tr>
								<th>Citizen</th>
								<th>Type</th>
								<th>Submitted</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="doc" items="${documents}">
								<c:if test="${doc.status == 'Approved'}">
									<tr>
										<td>${doc.fullName}</td>
										<td>${doc.documentType}</td>
										<td>${doc.submittedAt}</td>
										<td class="docActionCell">
											<form action="${pageContext.request.contextPath}/documentlist"
												method="GET">
												<input type="hidden" name="editDoc"
													value="${doc.documentId}">
												<td class="docActionCell">
													<form
														action="${pageContext.request.contextPath}/documentlist"
														method="GET">
														<input type="hidden" name="editDoc"
															value="${doc.documentId}">
														<!-- open delete modal -->
														<button type="submit" class="buttonDocReject">Delete</button>
													</form>
												</td>
											</form>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
				</div>

			</div>

		</div>
	</div>

	<!-- approval modal -->
	<div class="modalOverlay" id="acceptDocModal"
		style="${not empty viewDocument ? 'display:flex;' : ''}">
		<div class="modalBox">
			<div class="modalHeaderSuccess">
				<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round" style="color: #6ee7b7;">
                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                <polyline points="22 4 12 14.01 9 11.01"></polyline>
            </svg>
				<h2>Confirm Approval</h2>
			</div>
			<form action="${pageContext.request.contextPath}/acceptdocument"
				method="POST">
				<input type="hidden" name="documentId"
					value="${viewDocument.documentId}">
				<div class="modalBodyContent">
					<!-- document details -->
					<div class="docFormGroup">
						<label class="docFormLabel">Full Name</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${viewDocument.fullName}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Date of Birth</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${viewDocument.dateOfBirth}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Address</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${viewDocument.address}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Phone</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${viewDocument.phone}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Additional Info</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${viewDocument.additionalInfo}</p>
					</div>
				</div>
				<div class="modalFooterActions">
					<a href="${pageContext.request.contextPath}/documentlist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonModalAccept">Confirm
						Approval</button>
				</div>
			</form>
		</div>
	</div>

	<!-- delete document modal -->
	<div class="modalOverlay" id="editDocModal"
		style="${not empty editDocument ? 'display:flex;' : ''}">
		<div class="modalBox">
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
			<form action="${pageContext.request.contextPath}/deletedocument"
				method="POST">
				<input type="hidden" name="documentId"
					value="${editDocument.documentId}">
				<div class="modalBodyContent">
					<!-- document details -->
					<div class="docFormGroup">
						<label class="docFormLabel">Full Name</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${editDocument.fullName}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Document Type</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${editDocument.documentType}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Address</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${editDocument.address}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Phone</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${editDocument.phone}</p>
					</div>
					<div class="docFormGroup">
						<label class="docFormLabel">Submitted</label>
						<p style="color: #ffffff; font-size: 14px; margin: 0;">${editDocument.submittedAt}</p>
					</div>
				</div>
				<div class="modalFooterActions">
					<a href="${pageContext.request.contextPath}/documentlist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonModalDanger">Confirm
						Deletion</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>
