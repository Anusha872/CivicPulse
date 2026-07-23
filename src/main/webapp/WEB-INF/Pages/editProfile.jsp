<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CivicPulse - Edit Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/leftbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>

    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent editProfileMain">
        <jsp:include page="/Components/navbar.jsp" />

        <div class="editProfileContainer">

            <a href="${pageContext.request.contextPath}/profile"
               class="back-link">&#8592; Back to Profile</a>

            <div class="editProfileCard">

                <div class="cardHeader">
                    <h2>Edit Profile</h2>
                    <p class="subtitle">Update your personal information</p>
                </div>

                <!-- SUCCESS / ERROR -->
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <form action="${pageContext.request.contextPath}/editprofile"
                      method="post"
                      enctype="multipart/form-data">

                    <!-- PROFILE PHOTO -->
                    <div class="preview-container">
                        <c:choose>
                            <c:when test="${not empty user.image}">
                                <img id="imagePreview"
                                     src="${pageContext.request.contextPath}/getimage?name=${user.userName}"
                                     alt="Profile Photo"
                                     style="display:block;">
                            </c:when>
                            <c:otherwise>
                                <div class="preview-placeholder" id="placeholderIcon">
                                    <svg width="40" height="40" viewBox="0 0 24 24" fill="none"
                                         stroke="#262626" stroke-width="1.5"
                                         stroke-linecap="round" stroke-linejoin="round">
                                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                                        <circle cx="12" cy="7" r="4"/>
                                    </svg>
                                </div>
                                <img id="imagePreview" src="#" alt="Preview"
                                     style="display:none; width:100%; height:100%; object-fit:cover;">
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="file-input-wrapper">
                        <label for="profileImage" class="custom-file-upload">
                            <i class="fas fa-camera"></i> Change Photo
                        </label>
                        <input type="file" id="profileImage" name="profileImage"
                               accept="image/*"
                               onchange="previewFile()"
                               style="display:none;">
                    </div>

                    <!-- FIELDS — pre-filled from session -->
                    
                    
                    <div class="input-group">
                        <label>USERNAME</label>
                        <input type="text"
                               value="${user.userName}"
                               class="formControl"
                               disabled>
                        <span class="hint-text">Username cannot be changed.</span>
                    </div>
                    
                    <div class="input-group">
                        <label>FIRST NAME</label>
                        <input type="text" name="first_name"
                               value="${user.firstName}" class="formControl">
                    </div>

                    <div class="input-group">
                        <label>LAST NAME</label>
                        <input type="text" name="last_name"
                               value="${user.lastName}" class="formControl">
                    </div>

                    <div class="input-group">
                        <label>EMAIL</label>
                        <input type="email" name="email"
                               value="${user.email}" class="formControl">
                    </div>

                    <div class="input-group">
                        <label>PHONE NUMBER</label>
                        <input type="text" name="number"
                               value="${user.number}" class="formControl">
                    </div>

                    <div class="btn-container">
                        <button type="submit" class="btn-submit">
                            Save Changes
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </main>

    <script>
        function previewFile() {
            const preview     = document.getElementById('imagePreview');
            const placeholder = document.getElementById('placeholderIcon');
            const file        = document.querySelector('input[name=profileImage]').files[0];
            const reader      = new FileReader();

            reader.onloadend = function () {
                preview.src          = reader.result;
                preview.style.display = 'block';
                if (placeholder) placeholder.style.display = 'none';
            };

            if (file) reader.readAsDataURL(file);
        }
    </script>

</body>
</html>