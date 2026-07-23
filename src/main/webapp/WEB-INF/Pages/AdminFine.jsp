<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fine Management</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/AdminFine.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Admin-Side.css">
f
</head>
<body>

	<jsp:include page="/Components/admin-sidebar.jsp" />
	<jsp:include page="/Components/admin-topbar.jsp" />

	<div class="main">

		<div class="header">
			<h1>Traffic Fine Management</h1>
			<p style="padding-left: 5px;">Issue and manage space permits for
				citizens.</p>
			<hr>
		</div>

		<div class="issue-stats">
			<div class="stat">
				<p>Total Venue Permits Approved</p>
				<h2>${totalFines}</h2>
			</div>
			<div class="stat">
				<p>Unpaid Facility Fees</p>
				<h2 class="unpaid">${unpaidFines}</h2>
			</div>
			<div class="stat">
				<p>Paid Facility Fees</p>
				<h2 class="paid">${paidFines}</h2>
			</div>
		</div>

		<section class="card">
			<div class="card-header">
				<h3>Issue new fine</h3>
			</div>
			<form action="${pageContext.request.contextPath}/issuefine"
				method="POST">
				<input type="hidden" name="issueFine" value="true">
				<div class="side">
					<div>
						<label>Citizen</label> <select class="form-design" name="userId">
							<option value="">Select citizen...</option>
							<c:forEach var="u" items="${users}">
								<option value="${u.userId}">
									<c:out value="${u.firstName} ${u.lastName}" /></option>
							</c:forEach>
						</select>
					</div>
					<div>
						<label>Violation type</label> <select class="form-design"
							name="violationType">
							<option value="">Select violation type</option>
							<option>Speeding</option>
							<option>No helmet</option>
							<option>No seatbelt</option>
							<option>Wrong parking</option>
							<option>No license</option>
							<option>Other</option>
						</select>
					</div>
				</div>
				<div class="side">
					<div>
						<label>Fine amount (NPR)</label> <input type="number"
							class="form-design" name="fineAmount" placeholder="e.g. 500">
					</div>
					<div>
						<label>Date of violation</label> <input type="date"
							class="form-design" name="violationDate">
					</div>
				</div>
				<label>Reason / notes</label>
				<textarea class="form-design" name="reason"
					placeholder="Describe the violation in detail..."></textarea>
				<c:if test="${not empty errorMessage}">
					<p class="error-message">${errorMessage}</p>
				</c:if>
				<button type="submit" class="form-button">Issue fine</button>
			</form>

		</section>

		<section class="manage-listings">
			<div class="list-head">
				<h3>Unpaid Facility Fees</h3>
			</div>
			<div class="divider"></div>

			<c:forEach var="f" items="${fines}">
				<c:if test="${f.status == 'Unpaid'}">
					<div class="list-card">
						<div class="list-info">
							<h4>
								<c:out value="${f.firstName} ${f.lastName}" />
								<span class="status-unpaid">Unpaid</span>
							</h4>
							<div class="listing-meta">
								<span><c:out value="${f.violationType}" /></span> <span><c:out
										value="${f.violationDate}" /></span> <span class="amount">NPR
									<c:out value="${f.fineAmount}" />
								</span>
							</div>
						</div>
						<div class="list-actions">
							<form action="${pageContext.request.contextPath}/issuefine"
								method="POST" style="display: inline;">
								<input type="hidden" name="markPaidId" value="${f.fineId}">
								<button type="submit" class="mark">Mark paid</button>
							</form>
							<form action="${pageContext.request.contextPath}/issuefine"
								method="POST" style="display: inline;">
								<input type="hidden" name="deleteFineId" value="${f.fineId}">
								<button type="submit" class="delete">Delete</button>
							</form>
						</div>
					</div>
				</c:if>
			</c:forEach>

		</section>

		<section class="manage-listings">
			<div class="list-head">
				<h3>Paid Facility Fees</h3>
			</div>
			<div class="divider"></div>

			<c:forEach var="f" items="${fines}">
				<c:if test="${f.status == 'Paid'}">
					<div class="list-card">
						<div class="list-info">
							<h4>
								<c:out value="${f.firstName} ${f.lastName}" />
								<span class="status-paid">Paid</span>
							</h4>
							<div class="listing-meta">
								<span><c:out value="${f.violationType}" /></span> <span><c:out
										value="${f.violationDate}" /></span> <span class="amount">NPR
									<c:out value="${f.fineAmount}" />
								</span>
							</div>
						</div>
						<div class="list-actions">
							<form action="${pageContext.request.contextPath}/issuefine"
								method="POST" style="display: inline;">
								<input type="hidden" name="deleteFineId" value="${f.fineId}">
								<button type="submit" class="delete">Delete</button>
							</form>
						</div>
					</div>
				</c:if>
			</c:forEach>

		</section>

	</div>
</body>
</html>