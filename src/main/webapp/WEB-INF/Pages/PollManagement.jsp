<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Poll Management - CivicPulse</title>

<!-- Link to Admin CSS-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/Admin-Side.css?v=<%=System.currentTimeMillis()%>">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/CSS/PollManagement.css">

</head>
<body>
	<input type="checkbox" id="sidebarToggle" class="sidebarToggleInput" />

	<!-- SIDEBAR COMPONENT -->
	<jsp:include page="/Components/admin-sidebar.jsp" />

	<div class="mainContent">

		<!-- TOPBAR COMPONENT -->

		<jsp:include page="/Components/admin-topbar.jsp" />

		<main class="dashboardBody">

			<div class="pollPageWrapper">

				<div class="pageHeader">
					<h1 class="pageTitle">Polls Management</h1>
					<form action="${pageContext.request.contextPath}/pollmanagement"
						method="POST">
						<input type="hidden" name="openCreatePoll" value="true">
						<button type="submit" class="button buttonPrimary">+ Create New
							Poll</button>
					</form>
				</div>

				<hr class="divider">

				<div class="pollsStatContainer">
					<!-- Card 1 -->
					<div class="statCardPoll">
						<div class="statIconWrap">
							<div class="statBars barsGreen">
								<div class="bar h50"></div>
								<div class="bar h80"></div>
								<div class="bar h100"></div>
								<div class="bar h60"></div>
							</div>
						</div>
						<div class="statInfo">
							<span class="statLabel">Total Polls</span> <span
								class="statValue">${totalPolls}</span>
						</div>
					</div>

					<!-- Card 2 -->
					<div class="statCardPoll">
						<div class="statIconWrap">
							<div class="statBars barsOrange">
								<div class="bar h60"></div>
								<div class="bar h100"></div>
								<div class="bar h80"></div>
							</div>
						</div>
						<div class="statInfo">
							<span class="statLabel">Active Polls</span> <span
								class="statValue">${activePolls}</span>
						</div>
					</div>

					<!-- Card 3 -->
					<div class="statCardPoll">
						<div class="statIconWrap">
							<div class="statBars barsBlue">
								<div class="bar h70"></div>
								<div class="bar h40"></div>
								<div class="bar h100"></div>
							</div>
						</div>
						<div class="statInfo">
							<span class="statLabel">Total Votes</span> <span
								class="statValue">8</span>
						</div>
					</div>
				</div>

				<hr class="divider">

				<div class="subHeader">
					<span class="pillBadge">Total Polls: ${totalPolls}</span>
				</div>

				<!-- LIST OF POLLS -->
				<div class="pollListContainer">
					<c:forEach var="p" items="${polls}">
						<div class="pollRow">
							<div class="pollIconBox">
								<div class="statBars barsBlue" style="height: 20px; gap: 3px;">
									<div class="bar h60" style="width: 4px;"></div>
									<div class="bar h100" style="width: 4px;"></div>
									<div class="bar h80" style="width: 4px;"></div>
								</div>
							</div>
							<div class="pollInfo">
								<h4>
									<c:out value="${p.question}" />
								</h4>
								<p>Created ${p.createdAt}</p>
							</div>
							<div class="pollActions">
								<form action="${pageContext.request.contextPath}/pollmanagement"
									method="POST">
									<input type="hidden" name="editPollId" value="${p.pollId}">
									<button type="submit" class="button buttonEdit">
										<svg width="14" height="14" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round">
								            <path
												d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
								            <path
												d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
								        </svg>
										Edit
									</button>
								</form>

								<form action="${pageContext.request.contextPath}/pollmanagement"
									method="POST">
									<input type="hidden" name="openDeletePollId"
										value="${p.pollId}"> <input type="hidden"
										name="deleteQuestion" value="<c:out value='${p.question}'/>">
									<button type="submit" class="button buttonDelete">
										<svg width="14" height="14" viewBox="0 0 24 24" fill="none"
											stroke="currentColor" stroke-width="2" stroke-linecap="round"
											stroke-linejoin="round">
								            <polyline points="3 6 5 6 21 6"></polyline>
								            <path
												d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
								        </svg>
										Delete
									</button>
								</form>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</main>
	</div>

	<div class="modalOverlay" id="createPollModal"
		style="${not empty openCreatePoll ? 'display:flex;' : ''}">
		<div class="modalBox">
			<div class="modalHeader">
				<h2 class="modalTitle">Create New Poll</h2>
				<p class="modalSubtitle">Set up a new civic issue poll and
					define choices.</p>
			</div>

			<form action="${pageContext.request.contextPath}/createpoll" method="POST"
				id="createPollForm">
				<div class="modalBody">
					<div class="formGroup">
						<label class="formLabel">Poll Title</label> <input type="text"
							class="formInput" id="createPollTitle" name="title"
							placeholder="e.g., Should we install new bike lanes?">
					</div>

					<div class="formGroup">
						<label class="formLabel">Brief Description</label>
						<textarea class="formInput" id="createPollDesc" name="description"
							placeholder="Provide some context for the citizens..."></textarea>
					</div>

					<div class="formGroup">
						<label class="formLabel">Option 1</label> <input type="text"
							class="formInput" name="option_1" placeholder="e.g., Yes">
					</div>
					<div class="formGroup">
						<label class="formLabel">Option 2</label> <input type="text"
							class="formInput" name="option_2" placeholder="e.g., No">
					</div>
					<c:if test="${not empty errorMessage}">
						<p class="error-message">${errorMessage}</p>
					</c:if>
				</div>
				<div class="modalFooter">
					<a href="${pageContext.request.contextPath}/pollmanagement"
						class="buttonGhost" style="text-decoration: none;">Cancel</a>

					<button type="submit" class="button buttonPrimary">Create Poll</button>
				</div>
			</form>
		</div>
	</div>

	<!-- THE 'DELETE' MODAL OVERLAY-->
	<div class="modalOverlay" id="deletePollModal"
		style="${not empty openDeletePollId ? 'display:flex;' : ''}">
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

			<form action="${pageContext.request.contextPath}/deletepoll" method="POST">
				<input type="hidden" name="pollId" value="${openDeletePollId}">

				<div class="modalBody" style="padding: 24px 28px;">
					<p
						style="color: #CFD3D6; font-size: 14px; margin-top: 0; margin-bottom: 24px; line-height: 1.5;">
						You are about to permanently delete the poll. <strong
							style="color: #ffffff; font-weight: 700;">${deleteQuestion}</strong>.
					</p>

				</div>

				<div class="modalFooter"
					style="padding: 18px 28px; border-top: 1px solid #323639; display: flex; justify-content: flex-end; gap: 14px;">
					<a href="${pageContext.request.contextPath}/pollmanagement"
						class="buttonGhost" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="button buttonDelete">Confirm
						Deletion</button>
				</div>
			</form>
		</div>
	</div>

	<div class="modalOverlay" id="editPollModal"
		style="${not empty editPoll ? 'display:flex;' : ''}">
		<div class="modalBox">
			<div class="modalHeader">
				<h2 class="modalTitle">Edit Poll</h2>
				<p class="modalSubtitle">Modify poll details and update
					available choices.</p>
			</div>
			<form action="${pageContext.request.contextPath}/updatepoll" method="POST"
				id="editPollForm">
				<input type="hidden" name="pollId" value="${editPoll.pollId}">
				<div class="modalBody">
					<div class="formGroup">
						<label class="formLabel">Poll Title</label> <input type="text"
							class="formInput" id="editPollTitle" name="title"
							value="<c:out value='${editPoll.question}'/>">
					</div>
					<div class="formGroup">
						<label class="formLabel">Brief Description</label>
						<textarea class="formInput" id="editPollDesc" name="description"><c:out
								value="${editPoll.description}" /></textarea>
					</div>
					<div class="formGroup">
						<label class="formLabel">Option 1</label> <input type="text"
							class="formInput" id="editOption1" name="option_1"
							value="<c:out value='${editPoll.option1}'/>">
					</div>
					<div class="formGroup">
						<label class="formLabel">Option 2</label> <input type="text"
							class="formInput" id="editOption2" name="option_2"
							value="<c:out value='${editPoll.option2}'/>">
					</div>
				</div>
				<div class="modalFooter">
					<a href="${pageContext.request.contextPath}/pollmanagement"
						class="buttonGhost" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="button buttonPrimary">Update Poll</button>
				</div>
			</form>
		</div>
	</div>

</body>