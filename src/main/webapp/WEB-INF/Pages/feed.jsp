<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/feed.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
</head>
<body>
    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent">
        <jsp:include page="/Components/navbar.jsp" />

        <section class="contentArea">
            <div class="feedCenter">

                <!-- CREATE POST -->
                <section class="composer">
                    <form method="post" action="${pageContext.request.contextPath}/feed" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="createPost">

                        <div class="composerTop">
                            <!-- LOGGED IN USER AVATAR -->
                            <div class="composerAvatar" style="${empty user.image ? 'background-color:#E86A33;' : 'background-color:transparent;padding:0;'}">
                                <c:choose>
                                    <c:when test="${not empty user.image}">
                                        <img src="${pageContext.request.contextPath}/getimage?name=${user.userName}" alt="${user.userName}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:toUpperCase(fn:substring(user.userName, 0, 1))}
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="composerInputWrapper">
                                <c:if test="${not empty error}">
                                    <span class="composerError">${error}</span>
                                </c:if>
                                <input type="text" name="content" class="composerInput ${not empty error ? 'inputError' : ''}" placeholder="Report a missing item, found keys, or a lost pet..." value="${not empty error ? param.content : ''}">
                            </div>
                        </div>

                        <!-- IMAGE PREVIEW -->
                        <div id="imagePreviewWrapper" style="display:none; margin: 10px 0 0 48px;">
                            <div style="position:relative; display:inline-block;">
                                <img id="postImagePreview" src="#" alt="preview" style="max-height:200px; max-width:100%; border-radius:8px; border:1px solid #E2E8F0;">
                                <button type="button" onclick="clearImage()" style="position:absolute;top:4px;right:4px; background:rgba(0,0,0,0.5);color:#fff; border:none;border-radius:50%; width:22px;height:22px;cursor:pointer; font-size:12px;line-height:1;">✕</button>
                            </div>
                        </div>

                        <div class="composerBottom">
                            <!-- IMAGE UPLOAD BUTTON -->
                            <label for="postImage" class="photoActionBtn" title="Add photo">
                                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="3" width="18" height="18" rx="2" ry="2" />
                                    <circle cx="8.5" cy="8.5" r="1.5" />
                                    <polyline points="21 15 16 10 5 21" />
                                </svg>
                                Photo
                            </label>
                            <input type="file" id="postImage" name="postImage" accept="image/*" style="display:none;" onchange="previewPostImage(this)">

                            <select name="postType" class="postTypeSelect">
                                <option value="general">General</option>
                                <option value="alert">Alert</option>
                                <option value="discussion">Discussion</option>
                            </select>

                            <button type="submit" class="postBtn">Post</button>
                        </div>
                    </form>
                </section>

                <!-- POSTS -->
                <c:forEach var="post" items="${posts}">
                    <article class="post">
                        <!-- HEADER -->
                        <header class="postHeader">
                            <div class="postHeaderLeft">
                                <!-- POST AUTHOR AVATAR -->
                                <div class="postAvatar" style="${empty post.userImage ? 'background-color:#E86A33;color:#fff;font-weight:700;font-size:13px;' : 'background-color:transparent;'}">
                                    <c:choose>
                                        <c:when test="${not empty post.userImage}">
                                            <img src="${pageContext.request.contextPath}/getimage?name=${post.userName}" alt="${post.userName}" style="width:100%;height:100%;object-fit:cover;border-radius:50%;">
                                        </c:when>
                                        <c:otherwise>
                                            ${fn:toUpperCase(fn:substring(post.userName, 0, 1))}
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="postAuthorInfo">
                                    <div style="display:flex;align-items:center;gap:6px;">
                                        <span class="postAuthor">${post.userName}</span>
                                        <span class="postTime">${post.postTime}</span>
                                    </div>
                                    <span class="postTypeBadge">${post.postType}</span>
                                </div>
                            </div>
                        </header>

                        <!-- BODY -->
                        <div class="postTextContent">
                            <p class="postBody">${post.content}</p>

                            <!-- POST IMAGE (if any) -->
                            <c:if test="${not empty post.postImage}">
                                <img src="${pageContext.request.contextPath}/getimage?name=${post.postImage}" alt="post image" style="max-width:100%;border-radius:8px; margin-top:10px;border:1px solid #E2E8F0;">
                            </c:if>
                        </div>

                        <!-- ACTIONS -->
                        <footer class="postActions">
                            <div class="voteGroup">
                                <!-- UPVOTE -->
                                <form method="post" action="${pageContext.request.contextPath}/feed">
                                    <input type="hidden" name="action" value="vote">
                                    <input type="hidden" name="postId" value="${post.postId}">
                                    <input type="hidden" name="voteType" value="up">
                                    <button type="submit" class="voteBtn ${post.userVote == 'up' ? 'voteActive' : ''}">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right:4px;">
                                            <line x1="12" y1="19" x2="12" y2="5" />
                                            <polyline points="5 12 12 5 19 12" />
                                        </svg>
                                        ${post.upCount}
                                    </button>
                                </form>

                                <!-- DOWNVOTE -->
                                <form method="post" action="${pageContext.request.contextPath}/feed">
                                    <input type="hidden" name="action" value="vote">
                                    <input type="hidden" name="postId" value="${post.postId}">
                                    <input type="hidden" name="voteType" value="down">
                                    <button type="submit" class="voteBtn downvoteBtn ${post.userVote == 'down' ? 'voteActive' : ''}">
                                        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right:4px;">
                                            <line x1="12" y1="5" x2="12" y2="19" />
                                            <polyline points="19 12 12 19 5 12" />
                                        </svg>
                                        ${post.downCount}
                                    </button>
                                </form>
                            </div>

                            <!-- SAVE -->
                            <form method="post" action="${pageContext.request.contextPath}/feed">
                                <input type="hidden" name="action" value="save">
                                <input type="hidden" name="postId" value="${post.postId}">
                                <button type="submit" class="saveBtnPill ${post.savedByUser ? 'saveActive' : ''}">
                                    ${post.savedByUser ? 'Saved' : 'Save'}
                                </button>
                            </form>
                        </footer>
                    </article>
                </c:forEach>
            </div>
        </section>
    </main>

    <script>
        function previewPostImage(input) {
            const wrapper = document.getElementById('imagePreviewWrapper');
            const preview = document.getElementById('postImagePreview');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function (e) {
                    preview.src = e.target.result;
                    wrapper.style.display = 'block';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }

        function clearImage() {
            document.getElementById('postImage').value = '';
            document.getElementById('postImagePreview').src = '#';
            document.getElementById('imagePreviewWrapper').style.display = 'none';
        }
    </script>
</body>
</html>