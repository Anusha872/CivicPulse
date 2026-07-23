<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c"  uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/news.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
</head>
<body>

    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent">
        <jsp:include page="/Components/navbar.jsp" />

        <div class="contentArea">
            <div class="dashboardGrid">
                <div class="feedColumn">

                    <!-- FEATURED ARTICLE -->
                    <c:choose>
                        <c:when test="${not empty featured}">
                            <div class="featuredArticle">

                                <c:choose>
                                    <c:when test="${not empty featured.newsImage}">
                                        <div class="featuredImage"
                                             style="background: url('${pageContext.request.contextPath}/newsimage/${featured.newsImage}') center/cover;"
                                                    center/cover;">
                                            <h2 class="featuredTitle">${featured.newsTitle}</h2>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="featuredImage">
                                            <h2 class="featuredTitle">${featured.newsTitle}</h2>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="featuredContent">
                                    <p>${featured.newsDescription}</p>
                                    <div class="featuredMeta">
                                        <span class="featuredAuthor">CivicPulse</span>
                                        <span class="featuredTime">${featured.postedAt}</span>
                                    </div>
                                </div>

                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="featuredArticle">
                                <div class="featuredImage">
                                    <h2 class="featuredTitle">No featured news at the moment.</h2>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- LATEST STORIES -->
                    <div class="sectionHeader">
                        <span class="sectionTitle">LATEST STORIES</span>
                        <div class="sectionDivider"></div>
                    </div>

                    <c:choose>
                        <c:when test="${empty stories}">
                            <div style="text-align:center; padding:40px 0; color:#aaaaaa; font-size:14px;">
                                No stories available yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="storyList">
                                <c:forEach var="news" items="${stories}">
                                    <div class="storyCard">

                                        <!-- IMAGE or placeholder -->
                                        <c:choose>
                                            <c:when test="${not empty news.newsImage}">
												<img src="${pageContext.request.contextPath}/newsimage/${news.newsImage}"
                                                     alt="${news.newsTitle}"
                                                     style="width:100px; height:100px;
                                                            object-fit:cover; border-radius:8px;
                                                            flex-shrink:0;">
                                            </c:when>
                                            <c:otherwise>
                                                <div style="width:100px; height:100px;
                                                            border-radius:8px; flex-shrink:0;
                                                            background:#f0f2f5;
                                                            display:flex; align-items:center;
                                                            justify-content:center;">
                                                    <svg width="28" height="28" viewBox="0 0 24 24"
                                                         fill="none" stroke="#cccccc" stroke-width="1.5"
                                                         stroke-linecap="round" stroke-linejoin="round">
                                                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"/>
                                                        <polyline points="14 2 14 8 20 8"/>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <div class="storyContent">

                                            <!-- BADGE based on category -->
                                            <div class="storyMeta">
                                                <c:choose>
                                                    <c:when test="${news.newsCategory == 'featured'}">
                                                        <span class="storyBadge badgeOfficial"
                                                              style="display:inline-block; width:auto;
                                                                     padding:2px 8px; margin-right:8px;">
                                                            FEATURED
                                                        </span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="storyBadge badgeCommunity"
                                                              style="display:inline-block; width:auto;
                                                                     padding:2px 8px; margin-right:8px;">
                                                            NEWS
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                                ${news.postedAt}
                                            </div>

                                            <h3 class="storyTitle">${news.newsTitle}</h3>

                                            <p class="storyExcerpt">
                                                <c:choose>
                                                    <c:when test="${fn:length(news.newsDescription) > 120}">
                                                        ${fn:substring(news.newsDescription, 0, 120)}...
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${news.newsDescription}
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>

                                            <div class="storyFooter">
                                                <span class="storySource">CivicPulse</span>
                                            </div>

                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:otherwise>
                    </c:choose>

                </div>
            </div>
        </div>
    </main>

</body>
</html>