<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicPulse - Polls</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Polls.css">
</head>
<body>

    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent">
        <jsp:include page="/Components/navbar.jsp" />

        <section class="pollsContainer">
            <div class="pollsList">

                <c:choose>
                    <c:when test="${empty polls}">
                        <p class="noPolls">No active polls at the moment.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="poll" items="${polls}">
                            <article class="pollCard">

                                <div class="pollContent">
                                    <h2 class="pollTitle">${poll.question}</h2>
                                    <p class="pollDescription">${poll.description}</p>

                                    <c:if test="${poll.totalVotes > 0}">
                                        <div class="voteBar">
                                            <div class="voteBarFill" style="width: ${poll.option1Count * 100 / poll.totalVotes}%"></div>
                                        </div>
                                        <div class="voteCounts">
                                            <span>${poll.option1} — ${poll.option1Count} votes</span>
                                            <span>${poll.option2} — ${poll.option2Count} votes</span>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="pollActions">
                                    <c:choose>
                                        <c:when test="${poll.hasVoted}">
                                            <p class="votedLabel">
                                                You voted:
                                                <strong>
                                                    <c:if test="${poll.userVote == 'option1'}">${poll.option1}</c:if>
                                                    <c:if test="${poll.userVote == 'option2'}">${poll.option2}</c:if>
                                                </strong>
                                            </p>
                                            <form action="${pageContext.request.contextPath}/polls" method="POST">
                                                <input type="hidden" name="poll_id" value="${poll.pollId}">
                                                <input type="hidden" name="action"  value="unvote">
                                                <button type="submit" class="pollBtn btnUnvote">Unvote</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/polls" method="POST">
                                                <input type="hidden" name="poll_id"      value="${poll.pollId}">
                                                <input type="hidden" name="action"       value="vote">
                                                <input type="hidden" name="voted_option" value="option1">
                                                <button type="submit" class="pollBtn btnYes">${poll.option1}</button>
                                            </form>
                                            <form action="${pageContext.request.contextPath}/polls" method="POST">
                                                <input type="hidden" name="poll_id"      value="${poll.pollId}">
                                                <input type="hidden" name="action"       value="vote">
                                                <input type="hidden" name="voted_option" value="option2">
                                                <button type="submit" class="pollBtn btnNo">${poll.option2}</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </article>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>

            </div>
        </section>
    </main>
</body>
</html>