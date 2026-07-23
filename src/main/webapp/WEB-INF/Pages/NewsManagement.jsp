<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>News Management - CivicPulse</title>
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
		<%
		request.setAttribute("pageTitle", "Admin Dashboard");
		%>
		<jsp:include page="/Components/admin-topbar.jsp" />

		<div class="dashboardBody">

			<!-- PAGE HEADER -->
			<div class="newsPageHeader">
				<div>
					<h1 class="newsPageTitle">News Management</h1>
				</div>
				<form action="${pageContext.request.contextPath}/newslist"
					method="POST">
					<input type="hidden" name="openCreateNews" value="true">
					<button type="submit" class="buttonCreateNews">+ Create
						News</button>
				</form>
			</div>

			<hr class="newsDivider">

			<!-- NEWS PREVIEW CARDS -->
			<div class="newsPreviewGrid">
				<c:if test="${not empty newsList[0]}">
					<div class="newsPreviewCard">
						<c:choose>
							<c:when test="${not empty newsList[0].newsImage}">
								<img class="newsPreviewImage"
									src="${pageContext.request.contextPath}/newsimage/${newsList[0].newsImage}"
									alt="News Image">
							</c:when>
							<c:otherwise>
								<div class="newsPreviewImage previewBlue"></div>
							</c:otherwise>
						</c:choose>
						<div class="newsPreviewBody">
							<h3 class="newsPreviewTitle">
								<c:out value="${newsList[0].newsTitle}" />
							</h3>
							<p class="newsPreviewSnippet">
								<c:out value="${newsList[0].newsDescription}" />
							</p>
							<span class="newsPreviewTime">${newsList[0].postedAt}</span>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty newsList[1]}">
					<div class="newsPreviewCard">
						<c:choose>
							<c:when test="${not empty newsList[1].newsImage}">
								<img class="newsPreviewImage"
									src="${pageContext.request.contextPath}/newsimage/${newsList[1].newsImage}"
									alt="News Image">
							</c:when>
							<c:otherwise>
								<div class="newsPreviewImage previewYellow"></div>
							</c:otherwise>
						</c:choose>
						<div class="newsPreviewBody">
							<h3 class="newsPreviewTitle">
								<c:out value="${newsList[1].newsTitle}" />
							</h3>
							<p class="newsPreviewSnippet">
								<c:out value="${newsList[1].newsDescription}" />
							</p>
							<span class="newsPreviewTime">${newsList[1].postedAt}</span>
						</div>
					</div>
				</c:if>
				<c:if test="${not empty newsList[2]}">
					<div class="newsPreviewCard">
						<c:choose>
							<c:when test="${not empty newsList[2].newsImage}">
								<img class="newsPreviewImage"
									src="${pageContext.request.contextPath}/newsimage/${newsList[2].newsImage}"
									alt="News Image">
							</c:when>
							<c:otherwise>
								<div class="newsPreviewImage previewPink"></div>
							</c:otherwise>
						</c:choose>
						<div class="newsPreviewBody">
							<h3 class="newsPreviewTitle">
								<c:out value="${newsList[2].newsTitle}" />
							</h3>
							<p class="newsPreviewSnippet">
								<c:out value="${newsList[2].newsDescription}" />
							</p>
							<span class="newsPreviewTime">${newsList[2].postedAt}</span>
						</div>
					</div>
				</c:if>
			</div>
		</div>
		<!-- NEWS LIST SECTION -->
		<div class="newsListHeader">
			<h2 class="newsListTitle">News Application</h2>
			<span class="newsPillBadge">Total: ${totalNews} </span>
		</div>
		<div class="newsListContainer">
			<c:forEach var="n" items="${newsList}">
				<div class="newsRow">
					<div class="newsIconWrap">
						<svg width="22" height="22" viewBox="0 0 24 24" fill="none"
							stroke="#3b82f6" stroke-width="2" stroke-linecap="round"
							stroke-linejoin="round">
                    <path
								d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                    <polyline points="14 2 14 8 20 8"></polyline>
                    <line x1="16" y1="13" x2="8" y2="13"></line>
                    <line x1="16" y1="17" x2="8" y2="17"></line>
                    <polyline points="10 9 9 9 8 9"></polyline>
                </svg>
					</div>
					<div class="newsInfo">
						<h4>
							<c:out value="${n.newsTitle}" />
						</h4>
						<div class="newsMetaRow">
							<c:choose>
								<c:when test="${n.newsCategory == 'featured'}">
									<span class="newsCategoryBadge featured">Featured</span>
								</c:when>
								<c:otherwise>
									<span class="newsCategoryBadge normal">Normal</span>
								</c:otherwise>
							</c:choose>
							<p>${n.postedAt}</p>
						</div>
					</div>
					<div class="newsActions">
						<form action="${pageContext.request.contextPath}/newslist"
							method="POST">
							<input type="hidden" name="editNewsId" value="${n.newsId}">
							<button type="submit" class="buttonNewsEdit">Edit</button>
						</form>
						<form action="${pageContext.request.contextPath}/deletenews"
							method="POST">
							<input type="hidden" name="newsId" value="${n.newsId}">
							<button type="submit" class="buttonNewsDelete">Delete</button>
						</form>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	</div>

	<!-- CREATE NEWS MODAL -->
	<div class="modalOverlay" id="createNewsModal"
		style="${not empty openCreateNews ? 'display:flex;' : ''}">

		<div class="modalBox"
			style="padding: 0; max-width: 560px; overflow: hidden;">

			<div class="modalHeaderCreate">
				<h2>Create News</h2>
				<p class="modalSubtitle">Write and publish a new news article.</p>
			</div>

			<form action="${pageContext.request.contextPath}/createnews"
				method="POST" enctype="multipart/form-data">

				<div class="modalBodyContent">

					<div class="newsFormGroup">

						<label class="newsFormLabel">Title</label> <input type="text"
							class="newsFormInput" name="newsTitle"
							placeholder="e.g. Ward Committee Approves..." required>
					</div>

					<div class="newsFormGroup">

						<label class="newsFormLabel">Image</label> <input type="file"
							class="newsFormInput" name="newsImage" accept="image/*">
					</div>

					<div class="newsFormGroup">

						<label class="newsFormLabel">Category</label> <select
							class="newsFormInput" name="newsCategory" required>

							<option value="normal">Normal</option>

							<option value="featured">Featured</option>

						</select>
					</div>

					<div class="newsFormGroup">

						<label class="newsFormLabel">Content</label>
						<textarea class="newsFormTextarea" name="newsContent"
							placeholder="Write your news article here..." required></textarea>
					</div>

					<c:if test="${not empty errorMessage}">
						<p class="error-message">${errorMessage}</p>
					</c:if>

				</div>

				<div class="modalFooterActions">

					<a href="${pageContext.request.contextPath}/newslist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>

					<button type="submit" class="buttonPostNews">Post News</button>
				</div>
			</form>
		</div>
	</div>

	<!-- EDIT NEWS MODAL -->
	<div class="modalOverlay" id="editNewsModal"
		style="${not empty editNews ? 'display:flex;' : ''}">

		<div class="modalBox"
			style="padding: 0; max-width: 560px; overflow: hidden;">

			<div class="modalHeaderEdit">

				<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
					stroke="currentColor" stroke-width="2" stroke-linecap="round"
					stroke-linejoin="round" style="color: #93c5fd;">
			        
			        <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
			        
			        <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
			    </svg>

				<h2>Edit News</h2>


			</div>

			<form action="${pageContext.request.contextPath}/updatenews"
				method="POST" enctype="multipart/form-data">

				<input type="hidden" name="newsId" value="${editNews.newsId}">

				<div class="modalBodyContent">

					<div class="newsFormGroup">

						<label class="newsFormLabel">Title</label> <input type="text"
							class="newsFormInput" name="newsTitle"
							value="<c:out value='${editNews.newsTitle}'/>" required>

					</div>
					<div class="newsFormGroup">
						
						<label class="newsFormLabel">Image</label>
						
						<c:if test="${not empty editNews.newsImage}">
							<img
								src="${pageContext.request.contextPath}/newsimage/${editNews.newsImage}"
								alt="Current Image"
								style="width: 100%; max-height: 160px; object-fit: cover; border-radius: 8px; margin-bottom: 8px;">
							<p
								style="font-size: 0.75rem; color: #94a3b8; margin-bottom: 6px;">
								Upload a new image to replace the current one, or leave blank to
								keep it.</p>
						</c:if>
						
						<input type="file" class="newsFormInput" name="newsImage"
							accept="image/*">
					</div>

					<div class="newsFormGroup">

						<label class="newsFormLabel">Category</label> <select
							class="newsFormInput" name="newsCategory" required>

							<option value="normal"
								${editNews.newsCategory == 'normal' ? 'selected' : ''}>Normal</option>

							<option value="featured"
								${editNews.newsCategory == 'featured' ? 'selected' : ''}>Featured</option>

						</select>
					</div>

					<div class="newsFormGroup">

						<label class="newsFormLabel">Content</label>

						<textarea class="newsFormTextarea" name="newsContent" required><c:out
								value="${editNews.newsDescription}" /></textarea>
					</div>
				</div>
				<div class="modalFooterActions">

					<a href="${pageContext.request.contextPath}/newslist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonModalSuccess">Save
						Changes</button>
				</div>
			</form>
		</div>
	</div>

	<!-- DELETE NEWS MODAL -->
	<div class="modalOverlay" id="deleteNewsModal"
		style="${not empty openDeleteNewsId ? 'display:flex;' : ''}">

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

			<form action="${pageContext.request.contextPath}/deletenews"
				method="POST">

				<input type="hidden" name="newsId" value="${openDeleteNewsId}">

				<div class="modalBodyContent">

					<p class="modalDescriptionText">

						You are about to permanently delete <strong
							style="color: #ffffff; font-weight: 700;">${deleteNewsTitle}</strong>.
						This action cannot be undone.
					</p>

					<div class="newsFormGroup">

						<label class="newsFormLabel">Reason for Deletion</label>

						<textarea class="newsFormTextarea" name="deleteReason"
							placeholder="Provide a reason for deleting this news..."
							style="min-height: 90px;" required>
						</textarea>

					</div>

				</div>

				<div class="modalFooterActions">

					<a href="${pageContext.request.contextPath}/newslist"
						class="buttonModalCancel" style="text-decoration: none;">Cancel</a>
					<button type="submit" class="buttonModalDanger">Confirm
						Delete</button>
				</div>
			</form>
		</div>
	</div>

</body>
</html>