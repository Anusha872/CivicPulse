<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rikesh Adhikari | Portfolio</title>
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
                    <img src="${pageContext.request.contextPath}/Images/Rikesh.png" alt="Rikesh Adhikari" class="avatarImg">
                </div>
                <h1 class="memberName">Rikesh Adhikari</h1>
                <div class="memberRole">BSc (Hons) Computing Student</div>
                
                <div class="separator"></div>
                
                <ul class="contactList">
                    <li class="contactItem">
                        <div class="contactIcon">E</div>
                        <div>
                            <div class="contactLabel">Email</div>
                            <div class="contactValue">rikeshadhik@gmail.com</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">P</div>
                        <div>
                            <div class="contactLabel">Phone</div>
                            <div class="contactValue">+977 9841959546</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">B</div>
                        <div>
                            <div class="contactLabel">Birthday</div>
                            <div class="contactValue">July 01, 2005</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">L</div>
                        <div>
                            <div class="contactLabel">Location</div>
                            <div class="contactValue">Kathmandu, Nepal</div>
                        </div>
                    </li>
                </ul>
            </aside>

            <!-- Main Content -->
            <div class="contentArea">

                <article id="aboutTab" class="articlePage active">
                    <div class="aboutText">
                        <p>I'm Rikesh Adhikari, a BSc (Hons) Computing student at Islington College, Kathmandu. I have hands-on project experience in web and desktop development using JavaScript, Java, and HTML/CSS. I am an AWS-certified Cloud Practitioner, and I'm eager to apply my technical and infrastructure skills in a practical development role.</p>
                    </div>

                    <h3 class="subTitle" style="margin-bottom: 35px;">What I'm Doing</h3>
                    <div class="serviceGrid">
                        <!-- Cloud Architecture -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M18 10h-1.26A8 8 0 1 0 9 20h9a5 5 0 0 0 0-10z"></path>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Cloud Architecture</h4>
                                <p class="serviceItemText">Designing and deploying scalable, reliable cloud infrastructure using AWS solutions.</p>
                            </div>
                        </div>
                        
                        <!-- Full-Stack Web Apps -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="16 18 22 12 16 6"></polyline>
                                    <polyline points="8 6 2 12 8 18"></polyline>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Full-Stack Web Apps</h4>
                                <p class="serviceItemText">Developing feature-rich, high-performance web applications with optimized frontends.</p>
                            </div>
                        </div>
                        
                        <!-- Database Architecture -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <ellipse cx="12" cy="5" rx="9" ry="3"></ellipse>
                                    <path d="M21 12c0 1.66-4 3-9 3s-9-1.34-9-3"></path>
                                    <path d="M3 5v14c0 1.66 4 3 9 3s9-1.34 9-3V5"></path>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Database Architecture</h4>
                                <p class="serviceItemText">Designing, optimizing, and managing robust relational database structures.</p>
                            </div>
                        </div>
                        
                        <!-- Systems Development -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Systems Development</h4>
                                <p class="serviceItemText">Creating secure desktop systems with role-based access and admin dashboard analytics.</p>
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
                                <h3 class="cvTitle">Rikesh's Resume</h3>
                                <p class="cvText">Download the full CV to view complete details of my education and experience.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/assets/Rikesh Adhikari.pdf" class="cvDownloadBtn" download>
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
                                <span class="timelineDate">Islington College &middot; Expected 2027</span>
                                <p class="timelineText">Currently pursuing an undergraduate degree in computing, focusing on software development, cloud systems, and machine learning models.</p>
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
                                <h4 class="timelineItemTitle">Developer &mdash; Homeo Management System</h4>
                                <span class="timelineDate">2025</span>
                                <p class="timelineText">Developed an Airbnb-style hotel and flat booking application. Integrated user review systems and optimized front-end performance for smooth, professional animations.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Developer &mdash; Gym Membership Management System</h4>
                                <span class="timelineDate">2025</span>
                                <p class="timelineText">Built a Java desktop application with GUI for membership registration, payment handling, and role-based access control.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Developer &mdash; Travelo (Travel Planning Website)</h4>
                                <span class="timelineDate">2024 - Ongoing</span>
                                <p class="timelineText">Designed and developed an interactive travel planning platform with a responsive layout and booking system.</p>
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
                                <span class="skillName">Figma &amp; UI/UX</span>
                                <span class="skillPercent">95%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 95%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Java &amp; Python</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">MySQL &amp; Databases</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                    </div>
                </article>

            </div>
        </div>
    </main>
</body>
</html>
