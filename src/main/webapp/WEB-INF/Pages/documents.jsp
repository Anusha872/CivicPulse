<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>CivicPulse</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/leftbar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/navbar.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/documents.css">
</head>

<body>

	<jsp:include page="/Components/leftbar.jsp" />

	<main class="mainContent">
		<jsp:include page="/Components/navbar.jsp" />

		<section class="documentTitleSection">

			<div class="docPageHeader">
				<h1 class="docPageTitle"></h1>

				<form method="post" action="${pageContext.request.contextPath}/documents">
					<input type="hidden" name="openApply" value="true">
					<button type="submit" class="docApplyBtn">
						<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2.5" stroke-linecap="round"
							stroke-linejoin="round">
							<line x1="12" y1="5" x2="12" y2="19" />
							<line x1="5" y1="12" x2="19" y2="12" />
						</svg>
						New Application
					</button>
				</form>
			</div>

			<c:if test="${param.success == 'applied'}">
				<div class="docBanner docBannerSuccess">
					<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
						stroke="currentColor" stroke-width="2" stroke-linecap="round"
						stroke-linejoin="round">
						<path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
						<polyline points="22 4 12 14.01 9 11.01" />
					</svg>
					Application submitted successfully.
				</div>
			</c:if>

			<div class="documentsGrid">

				<article class="documentItem">
					<div class="documentIcon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
							<rect x="3" y="4" width="18" height="16" rx="2" />
							<circle cx="9" cy="10" r="2" />
							<line x1="14" y1="9" x2="18" y2="9" />
							<line x1="14" y1="13" x2="18" y2="13" />
							<path d="M6 16c0-1.1.9-2 2-2h2c1.1 0 2 .9 2 2" />
						</svg>
					</div>
					<h3 class="documentTitle">National Identity Card</h3>
					<form action="${pageContext.request.contextPath}/documents" method="GET" style="width:100%; margin-top:auto;">
						<input type="hidden" name="docType" value="National Identity Card">
						<button type="submit" class="documentViewDetailsBtn">View Details</button>
					</form>
				</article>

				<article class="documentItem">
					<div class="documentIcon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
							<circle cx="12" cy="12" r="10" />
							<path d="M2 12h20M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z" />
						</svg>
					</div>
					<h3 class="documentTitle">Passport</h3>
					<form action="${pageContext.request.contextPath}/documents" method="GET" style="width:100%; margin-top:auto;">
						<input type="hidden" name="docType" value="Passport">
						<button type="submit" class="documentViewDetailsBtn">View Details</button>
					</form>
				</article>

				<article class="documentItem">
					<div class="documentIcon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
							<rect x="3" y="4" width="18" height="16" rx="2" />
							<circle cx="15" cy="10" r="2" />
							<path d="M7 8h4M7 12h4m-4 4h10" />
						</svg>
					</div>
					<h3 class="documentTitle">Citizenship</h3>
					<form action="${pageContext.request.contextPath}/documents" method="GET" style="width:100%; margin-top:auto;">
						<input type="hidden" name="docType" value="Citizenship">
						<button type="submit" class="documentViewDetailsBtn">View Details</button>
					</form>
				</article>

				<article class="documentItem">
					<div class="documentIcon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
							<path d="M7 10h10l1 4H6l1-4z" />
							<path d="M21 14v5a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-5" />
							<circle cx="7" cy="17" r="2" />
							<circle cx="17" cy="17" r="2" />
						</svg>
					</div>
					<h3 class="documentTitle">Driving License</h3>
					<form action="${pageContext.request.contextPath}/documents" method="GET" style="width:100%; margin-top:auto;">
						<input type="hidden" name="docType" value="Driving License">
						<button type="submit" class="documentViewDetailsBtn">View Details</button>
					</form>
				</article>

				<article class="documentItem">
					<div class="documentIcon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
							<path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2" />
							<rect x="8" y="2" width="8" height="4" rx="1" />
							<path d="M9 14l2 2 4-4" />
						</svg>
					</div>
					<h3 class="documentTitle">Voters ID</h3>
					<form action="${pageContext.request.contextPath}/documents" method="GET" style="width:100%; margin-top:auto;">
						<input type="hidden" name="docType" value="Voters ID">
						<button type="submit" class="documentViewDetailsBtn">View Details</button>
					</form>
				</article>

				<article class="documentItem">
					<div class="documentIcon">
						<svg width="28" height="28" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="1.8" stroke-linecap="round"
							stroke-linejoin="round">
							<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
							<polyline points="14 2 14 8 20 8" />
							<line x1="16" y1="13" x2="8" y2="13" />
							<line x1="16" y1="17" x2="8" y2="17" />
							<line x1="10" y1="9" x2="8" y2="9" />
						</svg>
					</div>
					<h3 class="documentTitle">Bluebook</h3>
					<form action="${pageContext.request.contextPath}/documents" method="GET" style="width:100%; margin-top:auto;">
						<input type="hidden" name="docType" value="Bluebook">
						<button type="submit" class="documentViewDetailsBtn">View Details</button>
					</form>
				</article>

			</div>

			<div class="myApplicationsSection">
				<h2 class="myAppTitle">My Applications</h2>

				<c:choose>
					<c:when test="${empty myDocuments}">
						<div class="emptyApplications">
							<svg width="44" height="44" viewBox="0 0 24 24" fill="none"
								stroke="#d1d5db" stroke-width="1.5" stroke-linecap="round"
								stroke-linejoin="round">
								<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
								<polyline points="14 2 14 8 20 8" />
							</svg>
							<p>No document applications yet.</p>
						</div>
					</c:when>
					<c:otherwise>
						<div class="appList">
							<div class="appListRow appListHeader">
								<span>Document Type</span>
								<span>Full Name</span>
								<span>Submitted</span>
								<span>Status</span>
								<span style="text-align:center;">Details</span>
							</div>

							<c:forEach var="doc" items="${myDocuments}">
								<article class="appListRow">
									<span class="appDocType">
										<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
											stroke="#E86A33" stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round">
											<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
											<polyline points="14 2 14 8 20 8" />
										</svg>
										<strong>${doc.documentType}</strong>
									</span>
									<span>${doc.fullName}</span>
									<span>${doc.submittedAt}</span>
									<span>
										<c:choose>
											<c:when test="${doc.status == 'Approved'}">
												<span class="appBadge appBadgeApproved">Approved</span>
											</c:when>
											<c:when test="${doc.status == 'Rejected'}">
												<span class="appBadge appBadgeRejected">Rejected</span>
											</c:when>
											<c:otherwise>
												<span class="appBadge appBadgePending">Pending</span>
											</c:otherwise>
										</c:choose>
									</span>
									<span class="appActionCell">
										<form method="post" action="${pageContext.request.contextPath}/documents">
											<input type="hidden" name="openViewDoc" value="${doc.documentId}">
											<button type="submit" class="documentViewDetailsBtn">View</button>
										</form>
									</span>
								</article>
							</c:forEach>
						</div>
					</c:otherwise>
				</c:choose>
			</div>

		</section>
	</main>

	<c:if test="${not empty openApply}">
		<div class="docModalOverlay" style="display:flex;">
			<div class="docModalBox">
				<div class="docModalHeader">
					<div class="docModalHeaderIcon">
						<svg width="20" height="20" viewBox="0 0 24 24" fill="none"
							stroke="#E86A33" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
							<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
							<polyline points="14 2 14 8 20 8" />
							<line x1="12" y1="18" x2="12" y2="12" />
							<line x1="9" y1="15" x2="15" y2="15" />
						</svg>
					</div>
					<h2>New Document Application</h2>
					<a href="${pageContext.request.contextPath}/documents" class="docModalClose">
						<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
							<line x1="18" y1="6" x2="6" y2="18" />
							<line x1="6" y1="6" x2="18" y2="18" />
						</svg>
					</a>
				</div>

				<form action="${pageContext.request.contextPath}/documents" method="POST" novalidate>

					<c:if test="${not empty error}">
						<div class="docModalError">
							<svg width="16" height="16" viewBox="0 0 24 24" fill="none"
								stroke="currentColor" stroke-width="2" stroke-linecap="round"
								stroke-linejoin="round">
								<circle cx="12" cy="12" r="10" />
								<line x1="12" y1="8" x2="12" y2="12" />
								<line x1="12" y1="16" x2="12.01" y2="16" />
							</svg>
							<span>${error}</span>
						</div>
					</c:if>

					<div class="docModalBody">

						<div class="docFormGroup">
							<label class="docFormLabel">
								Document Type <span class="required">*</span>
							</label>
							<div class="docSelectWrapper">
								<select name="applyDocType"
									class="docFormSelect ${not empty error && (empty param.applyDocType || fn:contains(error, 'document type')) ? 'inputError' : ''}">
									<option value="">Select a document type</option>
									<option value="National Identity Card" ${param.applyDocType == 'National Identity Card' ? 'selected' : ''}>National Identity Card</option>
									<option value="Passport" ${param.applyDocType == 'Passport' ? 'selected' : ''}>Passport</option>
									<option value="Citizenship" ${param.applyDocType == 'Citizenship' ? 'selected' : ''}>Citizenship</option>
									<option value="Driving License" ${param.applyDocType == 'Driving License' ? 'selected' : ''}>Driving License</option>
									<option value="Voters ID" ${param.applyDocType == 'Voters ID' ? 'selected' : ''}>Voters ID</option>
									<option value="Bluebook" ${param.applyDocType == 'Bluebook' ? 'selected' : ''}>Bluebook</option>
								</select>
								<svg class="docSelectArrow" width="14" height="14" viewBox="0 0 24 24" fill="none"
									stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
									<polyline points="6 9 12 15 18 9" />
								</svg>
							</div>
							<c:if test="${not empty error && (empty param.applyDocType || fn:contains(error, 'document type'))}">
								<span class="fieldError">Please select a document type.</span>
							</c:if>
						</div>

						<div class="docFormRow">
							<div class="docFormGroup">
								<label class="docFormLabel">
									Full Name <span class="required">*</span>
								</label>
								<input type="text"
									name="fullName"
									class="docFormInput ${not empty error && (empty param.fullName || fn:contains(error, 'Full name')) ? 'inputError' : ''}"
									placeholder="As on official records"
									value="${param.fullName}">
								<c:if test="${not empty error && empty param.fullName}">
									<span class="fieldError">Full name is required.</span>
								</c:if>
								<c:if test="${not empty error && fn:contains(error, 'Full name')}">
									<span class="fieldError">Full name must contain letters only.</span>
								</c:if>
							</div>

							<div class="docFormGroup">
								<label class="docFormLabel">
									Date of Birth <span class="required">*</span>
								</label>
								<input type="date"
									name="dateOfBirth"
									class="docFormInput ${not empty error && empty param.dateOfBirth ? 'inputError' : ''}"
									value="${param.dateOfBirth}">
								<c:if test="${not empty error && empty param.dateOfBirth}">
									<span class="fieldError">Date of birth is required.</span>
								</c:if>
							</div>
						</div>

						<div class="docFormGroup">
							<label class="docFormLabel">
								Address <span class="required">*</span>
							</label>
							<input type="text"
								name="address"
								class="docFormInput ${not empty error && empty param.address ? 'inputError' : ''}"
								placeholder="Current residential address"
								value="${param.address}">
							<c:if test="${not empty error && empty param.address}">
								<span class="fieldError">Address is required.</span>
							</c:if>
						</div>

						<div class="docFormGroup">
							<label class="docFormLabel">
								Phone Number <span class="required">*</span>
							</label>
							<input type="tel"
								name="phone"
								class="docFormInput ${not empty error && (empty param.phone || fn:contains(error, 'Phone number')) ? 'inputError' : ''}"
								placeholder="98XXXXXXXX"
								value="${param.phone}">
							<c:if test="${not empty error && empty param.phone}">
								<span class="fieldError">Phone number is required.</span>
							</c:if>
							<c:if test="${not empty error && fn:contains(error, 'Phone number') && not empty param.phone}">
								<span class="fieldError">Phone number must be 10 digits.</span>
							</c:if>
						</div>

						<div class="docFormGroup">
							<label class="docFormLabel">Additional Information</label>
							<textarea name="additionalInfo" class="docFormTextarea"
								placeholder="Any supporting notes or special requests...">${param.additionalInfo}</textarea>
						</div>
					</div>

					<div class="docModalFooter">
						<a href="${pageContext.request.contextPath}/documents"
							class="docBtnCancel" style="text-decoration:none;">Cancel</a>
						<button type="submit" class="docBtnSubmit">Submit Application</button>
					</div>
				</form>
			</div>
		</div>
	</c:if>

	<c:if test="${not empty viewDocument or (not empty param.docType)}">
		<div class="docModalOverlay" style="display:flex;">
			<div class="docModalBox docModalBoxView">
				<div class="docModalHeader">
					<div class="docModalHeaderIcon">
						<svg width="20" height="20" viewBox="0 0 24 24" fill="none"
							stroke="#E86A33" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
							<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
							<polyline points="14 2 14 8 20 8" />
							<line x1="16" y1="13" x2="8" y2="13" />
							<line x1="16" y1="17" x2="8" y2="17" />
							<line x1="10" y1="9" x2="8" y2="9" />
						</svg>
					</div>
					<h2>Application Details</h2>
					<a href="${pageContext.request.contextPath}/documents" class="docModalClose">
						<svg width="18" height="18" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
							<line x1="18" y1="6" x2="6" y2="18" />
							<line x1="6" y1="6" x2="18" y2="18" />
						</svg>
					</a>
				</div>

				<c:choose>
					<c:when test="${not empty viewDocument}">
						<div class="docViewStatusRow">
							<c:choose>
								<c:when test="${viewDocument.status == 'Approved'}">
									<span class="appBadge appBadgeApproved appBadgeLg">Approved</span>
								</c:when>
								<c:when test="${viewDocument.status == 'Rejected'}">
									<span class="appBadge appBadgeRejected appBadgeLg">Rejected</span>
								</c:when>
								<c:otherwise>
									<span class="appBadge appBadgePending appBadgeLg">Pending Review</span>
								</c:otherwise>
							</c:choose>
						</div>

						<div class="docViewBody">
							<div class="docDetailRow">
								<span class="docDetailLabel">Document Type</span>
								<span class="docDetailValue docDetailHighlight">${viewDocument.documentType}</span>
							</div>
							<div class="docDetailRow">
								<span class="docDetailLabel">Full Name</span>
								<span class="docDetailValue">${viewDocument.fullName}</span>
							</div>
							<div class="docDetailRow">
								<span class="docDetailLabel">Date of Birth</span>
								<span class="docDetailValue">${viewDocument.dateOfBirth}</span>
							</div>
							<div class="docDetailRow">
								<span class="docDetailLabel">Address</span>
								<span class="docDetailValue">${viewDocument.address}</span>
							</div>
							<div class="docDetailRow">
								<span class="docDetailLabel">Phone</span>
								<span class="docDetailValue">${viewDocument.phone}</span>
							</div>
							<c:if test="${not empty viewDocument.additionalInfo}">
								<div class="docDetailRow">
									<span class="docDetailLabel">Additional Info</span>
									<span class="docDetailValue">${viewDocument.additionalInfo}</span>
								</div>
							</c:if>
							<div class="docDetailRow">
								<span class="docDetailLabel">Submitted At</span>
								<span class="docDetailValue">${viewDocument.submittedAt}</span>
							</div>
						</div>

						<div class="docModalFooter">
							<a href="${pageContext.request.contextPath}/documents"
								class="docBtnCancel" style="text-decoration:none;">Close</a>
						</div>
					</c:when>
					<c:otherwise>
						<div class="docNoAppBody">
							<svg width="44" height="44" viewBox="0 0 24 24" fill="none"
								stroke="#d1d5db" stroke-width="1.5" stroke-linecap="round"
								stroke-linejoin="round">
								<path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z" />
								<polyline points="14 2 14 8 20 8" />
							</svg>
							<p>No application found for <strong>${param.docType}</strong>.</p>
							<span>Use New Application to apply.</span>
						</div>
						<div class="docModalFooter">
							<a href="${pageContext.request.contextPath}/documents"
								class="docBtnCancel" style="text-decoration:none;">Close</a>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</c:if>

</body>
</html>