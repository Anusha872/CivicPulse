<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CivicPulse</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/report.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/leftbar.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/CSS/navbar.css">
</head>

<body>

    <jsp:include page="/Components/leftbar.jsp" />

    <main class="mainContent">

        <jsp:include page="/Components/navbar.jsp" />

        <div class="formWrapper">

            <c:if test="${not empty errorMessage}">
                <div class="alertError">
                    ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="alertSuccess">
                    ${successMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/report"
                  method="POST"
                  enctype="multipart/form-data"
                  class="reportForm">

                <!-- TITLE -->
                <fieldset class="formGroup">

                    <label for="issueTitle">
                        Title
                    </label>

                    <input type="text"
                           id="issueTitle"
                           name="title"
                           placeholder="What is your Issue?">

                </fieldset>

                <!-- CATEGORY -->
                <fieldset class="formGroup">

                    <legend>Category</legend>

                    <div class="categoryGrid">

                        <label class="categoryOption">

                            <input type="radio"
                                   name="category"
                                   value="roads">

                            <span class="categoryBtn">
                                Roads & Footpaths
                            </span>

                        </label>

                        <label class="categoryOption">

                            <input type="radio"
                                   name="category"
                                   value="streetlights">

                            <span class="categoryBtn">
                                Streetlights
                            </span>

                        </label>

                        <label class="categoryOption">

                            <input type="radio"
                                   name="category"
                                   value="waste">

                            <span class="categoryBtn">
                                Waste & Garbage
                            </span>

                        </label>

                        <label class="categoryOption">

                            <input type="radio"
                                   name="category"
                                   value="parks">

                            <span class="categoryBtn">
                                Parks & Trees
                            </span>

                        </label>

                        <label class="categoryOption">

                            <input type="radio"
                                   name="category"
                                   value="water">

                            <span class="categoryBtn">
                                Water & Drainage
                            </span>

                        </label>

                        <label class="categoryOption">

                            <input type="radio"
                                   name="category"
                                   value="safety">

                            <span class="categoryBtn">
                                Safety & Other
                            </span>

                        </label>

                    </div>

                </fieldset>

                <!-- LOCATION -->
                <fieldset class="formGroup">

                    <label for="issueLocation">
                        Location
                    </label>

                    <input type="text"
                           id="issueLocation"
                           name="location"
                           placeholder="Location">

                </fieldset>

                <!-- DESCRIPTION -->
                <fieldset class="formGroup">

                    <label for="issueDescription">
                        Description
                    </label>

                    <textarea id="issueDescription"
                              name="description"
                              rows="4"
                              placeholder="Describe the issue"></textarea>

                </fieldset>

                <!-- IMAGE -->
                <fieldset class="formGroup">

                    <legend>Attach Photo (Optional)</legend>

                    <input type="file"
                           id="issuePhoto"
                           name="photo"
                           accept="image/*"
                           class="fileInput"
                           onchange="previewFile()">

                    <label for="issuePhoto"
                           class="fileUploadLabel">

                        <img id="previewImage"
                             src=""
                             style="display:none;
                                    width:220px;
                                    border-radius:10px;
                                    margin-bottom:10px;">

                        <span class="uploadIcon"
                              id="uploadIcon">

                            <svg width="32"
                                 height="32"
                                 viewBox="0 0 24 24"
                                 fill="none"
                                 stroke="currentColor"
                                 stroke-width="2"
                                 stroke-linecap="round"
                                 stroke-linejoin="round">

                                <rect x="3"
                                      y="3"
                                      width="18"
                                      height="18"
                                      rx="2"
                                      ry="2"></rect>

                                <circle cx="8.5"
                                        cy="8.5"
                                        r="1.5"></circle>

                                <polyline points="21 15 16 10 5 21"></polyline>

                            </svg>

                        </span>

                        <span class="uploadText"
                              id="uploadText">

                            Click to upload a photo

                        </span>

                    </label>

                </fieldset>

                <!-- BUTTON -->
                <button type="submit"
                        class="btnPrimary">

                    Submit report

                </button>

            </form>

        </div>

    </main>

    <script>

        function previewFile() {

            const fileInput =
                    document.getElementById("issuePhoto");

            const previewImage =
                    document.getElementById("previewImage");

            const uploadText =
                    document.getElementById("uploadText");

            const uploadIcon =
                    document.getElementById("uploadIcon");

            const file = fileInput.files[0];

            if (file) {

                const reader = new FileReader();

                reader.onload = function (e) {

                    previewImage.src = e.target.result;

                    previewImage.style.display = "block";

                    uploadIcon.style.display = "none";

                    uploadText.textContent = file.name;
                };

                reader.readAsDataURL(file);
            }
        }

    </script>

</body>

</html>