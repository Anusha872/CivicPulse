<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/feed.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/profile.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
</head>
<body>
    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent">
        <jsp:include page="/Components/navbar.jsp" />

        <section class="contentArea">
            <div class="feedCenter profileWrapper">
                
                <!-- PROFILE HEADER -->
                <header class="profileHeader">
                    <section class="profileAvatarLarge">
                        <div class="avatarCircle">
                            <c:choose>
                                <c:when test="${not empty user.image}">
                                    <img src="${pageContext.request.contextPath}/getimage?name=${user.userName}" alt="Profile Photo" style="width:100%; height:100%; object-fit:cover;">
                                </c:when>
                                <c:otherwise>
                                    <svg width="70" height="70" viewBox="0 0 24 24" fill="none" stroke="white" stroke-width="1" stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                        <circle cx="12" cy="7" r="4"/>
                                    </svg>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </section>

                    <section class="profileInfoSection">
                        <h2 class="username">${user != null ? user.userName : 'Guest'}</h2>
                        <div class="profileBio">
                            <span class="fullName">${user != null ? user.firstName : 'Guest'} ${user != null ? user.lastName : 'Name'}</span>
                        </div>
                        <div class="profileActionRow">
                            <a href="${pageContext.request.contextPath}/editprofile" class="edit-btn">Edit Profile</a>
                        </div>
                    </section>
                </header>

                <!-- TABS -->
                <nav class="profileTabs">
                    <button class="tab active" onclick="switchTab(event, 'postsTab')">POSTS</button>
                    <button class="tab" onclick="switchTab(event, 'savedTab')">SAVED</button>
                </nav>

                <!-- POSTS TAB -->
                <section id="postsTab" class="tab-content active-content">
                    <c:choose>
                        <c:when test="${empty myPosts}">
                            <div class="emptyState">
                                <span class="icon-circle"><span class="plus-icon"></span></span>
                                <h2 class="emptyTitle">Share posts</h2>
                                <p>Your posts will appear here.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="post" items="${myPosts}">
                                <article class="post">
                                    <header class="postHeader">
                                        <div class="postHeaderLeft">
                                            <!-- AVATAR -->
                                            <div class="postAvatar" style="${empty post.userImage ? 'background-color:#E86A33;color:#fff;font-weight:700;font-size:13px;' : 'background-color:transparent;'}">
                                                <c:choose>
                                                    <c:when test="${not empty post.userImage}">
                                                        <img src="${pageContext.request.contextPath}/getimage?name=${post.userName}" alt="${post.userName}" style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${fn:toUpperCase(fn:substring(post.userName, 0, 1))}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="postAuthorInfo">
                                                <div style="display:flex; align-items:center; gap:6px;">
                                                    <span class="postAuthor">${post.userName}</span>
                                                    <span class="postTime">${post.postTime}</span>
                                                </div>
                                                <span class="postTypeBadge">${post.postType}</span>
                                            </div>
                                        </div>
                                    </header>

                                    <div class="postTextContent">
                                        <p class="postBody">${post.content}</p>
                                        <c:if test="${not empty post.postImage}">
                                            <img src="${pageContext.request.contextPath}/getimage?name=${post.postImage}" alt="post image" style="max-width:100%; border-radius:8px; margin-top:10px; border:1px solid #E2E8F0;">
                                        </c:if>
                                    </div>

                                    <footer class="postActions">
                                        <div class="voteGroup">
                                            <!-- UPVOTE -->
                                            <form method="post" action="${pageContext.request.contextPath}/feed">
                                                <input type="hidden" name="action" value="vote">
                                                <input type="hidden" name="postId" value="${post.postId}">
                                                <input type="hidden" name="voteType" value="up">
                                                <button type="submit" class="voteBtn ${post.userVote == 'up' ? 'voteActive' : ''}">
                                                    <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="margin-right:4px;">
                                                        <line x1="12" y1="19" x2="12" y2="5"/>
                                                        <polyline points="5 12 12 5 19 12"/>
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
                                                        <line x1="12" y1="5" x2="12" y2="19"/>
                                                        <polyline points="19 12 12 19 5 12"/>
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
                        </c:otherwise>
                    </c:choose>
                </section>

                <!-- SAVED TAB -->
                <section id="savedTab" class="tab-content">
                    <c:choose>
                        <c:when test="${empty savedPosts}">
                            <div class="emptyState">
                                <span class="icon-circle"><span class="large-bookmark-icon"></span></span>
                                <h2 class="emptyTitle">Save for later</h2>
                                <p>Items you save will appear here.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="post" items="${savedPosts}">
                                <article class="post">
                                    <header class="postHeader">
                                        <div class="postHeaderLeft">
                                            <div class="postAvatar" style="${empty post.userImage ? 'background-color:#E86A33;color:#fff;font-weight:700;font-size:13px;' : 'background-color:transparent;'}">
                                                <c:choose>
                                                    <c:when test="${not empty post.userImage}">
                                                        <img src="${pageContext.request.contextPath}/getimage?name=${post.userName}" alt="${post.userName}" style="width:100%; height:100%; object-fit:cover; border-radius:50%;">
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${fn:toUpperCase(fn:substring(post.userName, 0, 1))}
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="postAuthorInfo">
                                                <div style="display:flex; align-items:center; gap:6px;">
                                                    <span class="postAuthor">${post.userName}</span>
                                                    <span class="postTime">${post.postTime}</span>
                                                </div>
                                                <span class="postTypeBadge">${post.postType}</span>
                                            </div>
                                        </div>
                                    </header>

                                    <div class="postTextContent">
                                        <p class="postBody">${post.content}</p>
                                        <c:if test="${not empty post.postImage}">
                                            <img src="${pageContext.request.contextPath}/getimage?name=${post.postImage}" alt="post image" style="max-width:100%; border-radius:8px; margin-top:10px; border:1px solid #E2E8F0;">
                                        </c:if>
                                    </div>

                                    <footer class="postActions">
                                        <div class="voteGroup">
                                            <form method="post" action="${pageContext.request.contextPath}/feed">
                                                <input type="hidden" name="action" value="vote">
                                                <input type="hidden" name="postId" value="${post.postId}">
                                                <input type="hidden" name="voteType" value="up">
                                                <button type="submit" class="voteBtn ${post.userVote == 'up' ? 'voteActive' : ''}">
                                                    ▲ ${post.upCount}
                                                </button>
                                            </form>

                                            <form method="post" action="${pageContext.request.contextPath}/feed">
                                                <input type="hidden" name="action" value="vote">
                                                <input type="hidden" name="postId" value="${post.postId}">
                                                <input type="hidden" name="voteType" value="down">
                                                <button type="submit" class="voteBtn downvoteBtn ${post.userVote == 'down' ? 'voteActive' : ''}">
                                                    ▼ ${post.downCount}
                                                </button>
                                            </form>
                                        </div>

                                        <form method="post" action="${pageContext.request.contextPath}/feed">
                                            <input type="hidden" name="action" value="save">
                                            <input type="hidden" name="postId" value="${post.postId}">
                                            <button type="submit" class="saveBtnPill saveActive">
                                                Saved
                                            </button>
                                        </form>
                                    </footer>
                                </article>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </section>
            </div>
        </section>
    </main>

    <script>
        function switchTab(evt, tabId) {
            document.querySelectorAll(".tab-content").forEach(c => c.classList.remove("active-content"));
            document.querySelectorAll(".tab").forEach(t => t.classList.remove("active"));
            document.getElementById(tabId).classList.add("active-content");
            evt.currentTarget.classList.add("active");
        }
    </script>
</body>
</html>