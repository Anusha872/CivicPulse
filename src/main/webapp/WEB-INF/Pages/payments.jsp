<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicPulse</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/payments.css">
</head>
<body>
    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent">
        <jsp:include page="/Components/navbar.jsp" />

        <section class="paymentSection">
            <!-- CARDS -->
            <div class="paymentSummaryRow">
                <div class="summaryCard">
                    <span class="summaryLabel">Total Venue Permits Approved</span>
                    <span class="summaryValue">${unpaid + paid}</span>
                </div>
                <div class="summaryCard summaryCardWarning">
                    <span class="summaryLabel">Unpaid</span>
                    <span class="summaryValue">${unpaid}</span>
                </div>
                <div class="summaryCard summaryCardSuccess">
                    <span class="summaryLabel">Paid</span>
                    <span class="summaryValue">${paid}</span>
                </div>
                <div class="summaryCard summaryCardDanger">
                    <span class="summaryLabel">Total Owed</span>
                    <span class="summaryValue">
                        Rs. <fmt:formatNumber value="${totalOwed}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
            </div>

            <!-- FINES -->
            <section class="paymentListSection">
                <h3>Your Facility Fees</h3>

                <c:choose>
                    <c:when test="${empty fines}">
                        <div class="emptyFines">
                            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#cccccc" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
                                <polyline points="22 4 12 14.01 9 11.01"/>
                            </svg>
                            <p>You have no facility fees on record.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="paymentList">
 
                             <div class="paymentListRow headerRow sevenCols">
                                <span>Fine For</span>
                                <span>Violation Date</span>
                                <span>Amount</span>
                                <span>Status</span>
                                <span>Issued</span>
                                <span style="text-align:center;">Details</span>
                                <span style="text-align:center;">Pay</span>
                            </div>

                            <c:forEach var="fine" items="${fines}">
                                <article class="paymentListRow sevenCols">
                                    <span class="paymentItemTitle">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#E86A33" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                            <rect x="6" y="2" width="12" height="20" rx="2" ry="2"/>
                                            <circle cx="12" cy="7" r="1" fill="#E86A33"/>
                                            <circle cx="12" cy="12" r="1" fill="#E86A33"/>
                                            <circle cx="12" cy="17" r="1" fill="#E86A33"/>
                                        </svg>
                                        <strong>${fine.violationType}</strong>
                                    </span>

                                    <span>${fine.violationDate}</span>

                                    <span>
                                        <strong>
                                            Rs. <fmt:formatNumber value="${fine.fineAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                                        </strong>
                                    </span>

                                    <span>
                                        <c:choose>
                                            <c:when test="${fine.status == 'Paid'}">
                                                <span class="paymentBadgePaid">Paid</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="paymentBadgePending">Unpaid</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>

                                    <span>${fine.issuedAt}</span>

                                    <!-- VIEW DETAILS -->
                                    <span class="actionCell">
                                        <form method="post" action="${pageContext.request.contextPath}/payments">
                                            <input type="hidden" name="openViewFine" value="${fine.fineId}">
                                            <button type="submit" class="paymentDetailsBtn">View Details</button>
                                        </form>
                                    </span>

                                    <!-- PAY NOW — -->
                                    <span class="actionCell">
                                        <c:choose>
                                            <c:when test="${fine.status == 'Unpaid'}">
                                                <form method="post" action="${pageContext.request.contextPath}/payments">
                                                    <input type="hidden" name="openPayFine" value="${fine.fineId}">
                                                    <button type="submit" class="paymentActionBtn">Pay Now</button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color:#cccccc;font-size:13px;">—</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </article>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
        </section>
    </main>

    <!-- VIEW DETAILS -->
    <div class="fineModalOverlay" style="${not empty viewFine ? 'display:flex;' : ''}">
        <div class="fineModalBox">
            <div class="fineModalHeader">
                <h3>Fine Details</h3>
            </div>
            <div class="fineModalBody">
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Violation Type</span>
                    <span class="fineDetailValue">${viewFine.violationType}</span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Violation Date</span>
                    <span class="fineDetailValue">${viewFine.violationDate}</span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Amount</span>
                    <span class="fineDetailValue">
                        Rs. <fmt:formatNumber value="${viewFine.fineAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Status</span>
                    <span class="fineDetailValue">${viewFine.status}</span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Reason</span>
                    <span class="fineDetailValue">${viewFine.reason}</span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Issued At</span>
                    <span class="fineDetailValue">${viewFine.issuedAt}</span>
                </div>
            </div>
            <div class="fineModalFooter">
                <!-- Cancel  -->
                <a href="${pageContext.request.contextPath}/payments" class="paymentDetailsBtn" style="text-decoration:none; padding:8px 18px;">Close</a>
            </div>
        </div>
    </div>

    <!-- PAY-->
    <div class="fineModalOverlay" style="${not empty payFine ? 'display:flex;' : ''}">
        <div class="fineModalBox">
            <div class="fineModalHeader fineModalHeaderWarning">
                <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#E86A33" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                    <circle cx="12" cy="12" r="10"/>
                    <line x1="12" y1="8" x2="12" y2="12"/>
                    <line x1="12" y1="16" x2="12.01" y2="16"/>
                </svg>
                <h3>Confirm Payment</h3>
            </div>
            <div class="fineModalBody">
                <p style="color:#444; font-size:14px; margin:0 0 8px 0;">You are about to pay the following fine:</p>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Violation Type</span>
                    <span class="fineDetailValue">${payFine.violationType}</span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Amount</span>
                    <span class="fineDetailValue" style="color:#ef4444;">
                        Rs. <fmt:formatNumber value="${payFine.fineAmount}" type="number" minFractionDigits="2" maxFractionDigits="2"/>
                    </span>
                </div>
                <div class="fineDetailRow">
                    <span class="fineDetailLabel">Reason</span>
                    <span class="fineDetailValue">${payFine.reason}</span>
                </div>
            </div>
            <div class="fineModalFooter" style="gap:12px;">
                <!-- Cancel-->
                <a href="${pageContext.request.contextPath}/payments" class="paymentDetailsBtn" style="text-decoration:none; padding:8px 18px;">Cancel</a>
                <!-- Confirm-->
                <form method="post" action="${pageContext.request.contextPath}/payments">
                    <input type="hidden" name="confirmPayFineId" value="${payFine.fineId}">
                    <button type="submit" class="paymentActionBtn">Confirm Payment</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>