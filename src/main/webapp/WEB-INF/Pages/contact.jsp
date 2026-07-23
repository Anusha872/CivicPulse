<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
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
	href="${pageContext.request.contextPath}/CSS/contact.css">
</head>
<body>

	<jsp:include page="/Components/leftbar.jsp" />

	<main class="mainContent">

		<jsp:include page="/Components/navbar.jsp" />

		<section class="contentArea">

			<div class="contactContainer">

				<c:if test="${not empty errorMessage}">
					<div class="alertError">
						<span>${errorMessage}</span>
					</div>
				</c:if>

				<c:if test="${not empty successMessage}">
					<div class="alertSuccess">
						<span>${successMessage}</span>
					</div>
				</c:if>

				<form action="${pageContext.request.contextPath}/contact"
					method="POST" class="contactForm">

					<div class="formGroup">
						<label for="fullName">Full Name</label> <input type="text"
							id="fullName" name="fullName" placeholder="Enter your full name"
							value="${not empty fullName ? fullName : ''}">
					</div>

					<div class="formGroup">
						<label for="email">Email Address</label> <input type="email"
							id="email" name="email" placeholder="Enter your email"
							value="${not empty email ? email : ''}">
					</div>

					<div class="formGroup">
						<label for="subject">Subject</label> <input type="text"
							id="subject" name="subject" placeholder="Enter subject"
							value="${not empty subject ? subject : ''}">
					</div>

					<div class="formGroup">
						<label for="message">Message</label>
						<textarea id="message" name="message"
							placeholder="Type your message...">${not empty message ? message : ''}</textarea>
					</div>

					<button type="submit" class="submitBtn">Send Message</button>

				</form>

				<div class="contactFooter">
					<p>We're here to help. Reach out to us using the form, and
						we'll get back to you as soon as possible.</p>
				</div>

			</div>

		</section>

	</main>

</body>
</html>
