<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CivicPulse</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/login.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/register.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>

    <body>
        <div class="LoginBox">
            <div class="loginQuote">
                <div class="loginText">
                    <h1 class="loginHeader">
                        Join,<br>
                        <span class="loginHeader2">Participate,</span> and<br>
                        Grow Your<br>
                        Community
                    </h1>
                </div>
            </div>

            <div class="loginPanel">
                <a href="${pageContext.request.contextPath}/login" class="backLink">&lt; Back</a>

                <div class="loginForm">
                    <h2>Create new account</h2>

                    <%-- Single error message shown at top --%>
                    <c:if test="${not empty error}">
                        <div class="errorMessage">${error}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post" enctype="multipart/form-data">

                        <%-- Photo --%>
                        <div class="photo-container">
                            <div class="preview-container" id="placeholderIcon">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                    <circle cx="12" cy="7" r="4"></circle>
                                </svg>
                            </div>
                            <img id="imagePreview" src="#" alt="Preview" style="display:none;">
                            <div class="file-input-wrapper">
                                <label for="profileImage" class="custom-file-upload">
                                    <i class="fas fa-camera"></i> Change Photo
                                </label>
                                <input type="file" id="profileImage" name="profileImage"
                                       accept="image/*" onchange="previewFile()" style="display:none;">
                            </div>
                        </div>

                        <%-- Name row --%>
                        <div class="formRow">
                            <div class="formGroup">
                                <div class="formLabel"><label for="first_name">FIRST NAME</label></div>
                                <input type="text" id="first_name" name="first_name" class="formControl" value="${first_name}">
                            </div>
                            <div class="formGroup">
                                <div class="formLabel"><label for="last_name">LAST NAME</label></div>
                                <input type="text" id="last_name" name="last_name" class="formControl" value="${last_name}">
                            </div>
                        </div>

                        <%-- Username --%>
                        <div class="formGroup">
                            <div class="formLabel"><label for="username">USERNAME</label></div>
                            <input type="text" id="username" name="username" class="formControl" value="${username}">
                        </div>

                        <%-- DOB + Gender --%>
                        <div class="formRow">
                            <div class="formGroup">
                                <div class="formLabel"><label for="dob">DATE OF BIRTH</label></div>
                                <input type="date" id="dob" name="dob" class="formControl" value="${dob}">
                            </div>
                            <div class="formGroup">
                                <div class="formLabel"><label for="gender">GENDER</label></div>
                                <select id="gender" name="gender" class="formControl">
                                    <option value="" disabled ${empty gender ? 'selected' : ''}></option>
                                    <option value="Male" ${gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${gender == 'Female' ? 'selected' : ''}>Female</option>
                                </select>
                            </div>
                        </div>

                        <%-- Email + Number --%>
                        <div class="formRow">
                            <div class="formGroup">
                                <div class="formLabel"><label for="email">EMAIL</label></div>
                                <input type="email" id="email" name="email" class="formControl" value="${email}">
                            </div>
                            <div class="formGroup">
                                <div class="formLabel"><label for="number">NUMBER</label></div>
                                <input type="text" id="number" name="number" class="formControl" value="${number}">
                            </div>
                        </div>

                        <%-- Password --%>
                        <div class="formGroup">
                            <div class="formLabel"><label for="password">CREATE PASSWORD</label></div>
                            <input type="password" id="password" name="password" class="formControl">
                        </div>

                        <button type="submit" class="loginButton loginBtnPrimary registerSubmitButton">CREATE ACCOUNT</button>

                    </form>
                </div>
            </div>
        </div>

        <script>
            function previewFile() {
                const preview     = document.getElementById('imagePreview');
                const placeholder = document.getElementById('placeholderIcon');
                const file        = document.querySelector('input[name=profileImage]').files[0];
                const reader      = new FileReader();
                reader.onloadend = function () {
                    preview.src               = reader.result;
                    preview.style.display     = 'block';
                    placeholder.style.display = 'none';
                };
                if (file) reader.readAsDataURL(file);
            }
        </script>
    </body>
</html>