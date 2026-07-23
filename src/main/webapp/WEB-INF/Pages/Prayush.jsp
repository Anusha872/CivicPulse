<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prayush Shrestha | Portfolio</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
    <link class="portfolioStyle" rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Portfolio.css">
</head>
<body>

    <jsp:include page="/Components/navbar.jsp" />

    <main class="portfolioContainer">
        
        <div class="mainLayout">
        
            <aside class="sidebar">
                <div class="backBtnBox">
                    <a href="${pageContext.request.contextPath}/aboutus" class="backBtn">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <line x1="19" y1="12" x2="5" y2="12"></line>
                            <polyline points="12 19 5 12 12 5"></polyline>
                        </svg>
                        Back to Team
                    </a>
                </div>

                <div class="avatarBox">
                    <img src="${pageContext.request.contextPath}/Images/Prayush.jpeg" alt="Prayush Shrestha" class="avatarImg">
                </div>
                <h1 class="memberName">Prayush Shrestha</h1>
                <div class="memberRole">BSc (Hons) Computing Student</div>
                
                <div class="separator"></div>
                
                <ul class="contactList">
                    <li class="contactItem">
                        <div class="contactIcon">E</div>
                        <div>
                            <div class="contactLabel">Email</div>
                            <div class="contactValue">prayus1823@gmail.com</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">P</div>
                        <div>
                            <div class="contactLabel">Phone</div>
                            <div class="contactValue">+977 9863221148</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">B</div>
                        <div>
                            <div class="contactLabel">Birthday</div>
                            <div class="contactValue">October 12, 2005</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">L</div>
                        <div>
                            <div class="contactLabel">Location</div>
                            <div class="contactValue">Ason, Kathmandu, Nepal</div>
                        </div>
                    </li>
                </ul>
            </aside>

            <!-- Main Content -->
            <div class="contentArea">
            
                <article id="aboutTab" class="articlePage active">
                    <div class="aboutText">
                        <p>I'm Prayush Shrestha, a motivated and curious Computing student at Islington College, Kathmandu. I have a strong interest in technology, programming, and data analysis. I enjoy learning new skills and working with data to find practical solutions to problems. With growing skills in Python, Excel, HTML, CSS, JavaScript, and graphic design, I'm a quick learner and a great team player eager to adapt to new challenges.</p>
                    </div>

                    <h3 class="subTitle" style="margin-bottom: 35px;">What I'm Doing</h3>
                    <div class="serviceGrid">
                        <!-- Python Programming -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="4 17 10 11 4 5"></polyline>
                                    <line x1="12" y1="19" x2="20" y2="19"></line>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Python Programming</h4>
                                <p class="serviceItemText">Writing clean, efficient scripts to automate tasks and process data.</p>
                            </div>
                        </div>
                        
                        <!-- Data Analysis -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="18" y1="20" x2="18" y2="10"></line>
                                    <line x1="12" y1="20" x2="12" y2="4"></line>
                                    <line x1="6" y1="20" x2="6" y2="14"></line>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Data Analysis</h4>
                                <p class="serviceItemText">Analyzing complex datasets and building interactive dashboards in Power BI and Excel.</p>
                            </div>
                        </div>
                        
                        <!-- Frontend Engineering -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                    <line x1="2" y1="20" x2="22" y2="20"></line>
                                    <line x1="12" y1="17" x2="12" y2="20"></line>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Frontend Engineering</h4>
                                <p class="serviceItemText">Developing elegant, fully responsive web layouts with clean structure.</p>
                            </div>
                        </div>
                        
                        <!-- Graphic Design -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 14.7255 3.09032 17.1962 4.85857 19C5.35824 19.5 5.2418 20.318 4.75 20.75C4.2494 21.1895 3.5 21.5 3 22H12Z"></path>
                                    <circle cx="7.5" cy="10.5" r="1.5"></circle>
                                    <circle cx="11.5" cy="7.5" r="1.5"></circle>
                                    <circle cx="16.5" cy="9.5" r="1.5"></circle>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Graphic Design</h4>
                                <p class="serviceItemText">Creating stunning visual graphics and digital assets for layouts and branding.</p>
                            </div>
                        </div>
                    </div>
                </article>

                <!-- Resume Tab -->
                <article id="resumeTab" class="articlePage">
                    <div class="cvDownloadSection">
                        <div class="cvDownloadBox">
                            <div class="cvIconBox">
                                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                    <polyline points="14 2 14 8 20 8"></polyline>
                                    <line x1="16" y1="13" x2="8" y2="13"></line>
                                    <line x1="16" y1="17" x2="8" y2="17"></line>
                                    <polyline points="10 9 9 9 8 9"></polyline>
                                </svg>
                            </div>
                            <div class="cvInfoBox">
                                <h3 class="cvTitle">Prayush's Resume</h3>
                                <p class="cvText">Download the full CV to view complete details of my education and experience.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/assets/Prayush Shrestha.pdf" class="cvDownloadBtn" download>
                                Download CV
                            </a>
                        </div>
                    </div>

                    <div class="timelineSection">
                        <div class="timelineTitleBox">
                            <div class="timelineIcon">E</div>
                            <h3 class="subTitle" style="margin:0;">Education</h3>
                        </div>
                        <ol class="timelineList">
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">BSc (Hons) Computing</h4>
                                <span class="timelineDate">Islington College &middot; In Progress</span>
                                <p class="timelineText">Pursuing an undergraduate degree in computing, developing skills in programming, database design, and statistical data analysis.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Secondary Higher Education</h4>
                                <span class="timelineDate">Uniglobe Secondary School &middot; 2023 - 2024</span>
                                <p class="timelineText">Completed higher secondary education with a major in science and mathematics.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Secondary Higher Education (SEE)</h4>
                                <span class="timelineDate">Kathmandu University High School &middot; Passed 2022</span>
                                <p class="timelineText">Completed lower secondary education, achieving strong academic performance.</p>
                            </li>
                        </ol>
                    </div>
                    
                    <div class="timelineSection">
                        <div class="timelineTitleBox">
                            <div class="timelineIcon">X</div>
                            <h3 class="subTitle" style="margin:0;">Experience</h3>
                        </div>
                        <ol class="timelineList">
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Academic Projects &mdash; Computing Student</h4>
                                <span class="timelineDate">2024 - Present</span>
                                <p class="timelineText">Collaborated on frontend web application development, implementing data structuring and responsive layouts using HTML, CSS, and JavaScript.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Graphic Designer (Academic / Freelance)</h4>
                                <span class="timelineDate">2023 - 2024</span>
                                <p class="timelineText">Created high-quality digital layouts and illustrations. Developed core graphic design assets and UI layouts for student projects.</p>
                            </li>
                        </ol>
                    </div>
                    
                    <!-- Skills Tab -->

                    <h3 class="subTitle">My Skills</h3>
                    <div class="skillsSection">
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">HTML5 &amp; CSS3 &amp; JS</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Python Programming</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Data Analysis (Excel &amp; Power BI)</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Graphic Design &amp; Figma</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
                            </div>
                        </div>
                    </div>
                </article>

            </div>
        </div>
    </main>
</body>
</html>
