<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Arjan Regmi | Portfolio</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/navbar.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/Portfolio.css">
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
                    <img src="${pageContext.request.contextPath}/Images/Arjan.png" alt="Arjan Regmi" class="avatarImg">
                </div>
                <h1 class="memberName">Arjan Regmi</h1>
                <div class="memberRole">BSc (Hons) Computing Student</div>
                
                <div class="separator"></div>
                
                <ul class="contactList">
                    <li class="contactItem">
                        <div class="contactIcon">E</div>
                        <div>
                            <div class="contactLabel">Email</div>
                            <div class="contactValue">arjanregmi2006@gmail.com</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">P</div>
                        <div>
                            <div class="contactLabel">Phone</div>
                            <div class="contactValue">+977 9813860791</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">B</div>
                        <div>
                            <div class="contactLabel">Birthday</div>
                            <div class="contactValue">May 15, 2006</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">L</div>
                        <div>
                            <div class="contactLabel">Location</div>
                            <div class="contactValue">Shankhamul, Kathmandu, Nepal</div>
                        </div>
                    </li>
                </ul>
            </aside>

            <!-- Main Content -->
            <div class="contentArea">
            
                <article id="aboutTab" class="articlePage active">
                    <div class="aboutText">
                        <p>I'm Arjan Regmi, a creative and driven multimedia creator with hands-on experience in video editing, storytelling, website building, Figma design, presenting, and audience-focused content production. Currently pursuing BSc (Hons) Computing with growing skills in software development, cloud computing, and quality assurance.</p>
                    </div>

                    <h3 class="subTitle" style="margin-bottom: 35px;">What I'm Doing</h3>
                    <div class="serviceGrid">
                        <!-- Video Editing & Multimedia -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polygon points="23 7 16 12 23 17 23 7"></polygon>
                                    <rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Video Editing &amp; Multimedia</h4>
                                <p class="serviceItemText">Producing, editing, and refining highly engaging video content for online platforms.</p>
                            </div>
                        </div>
                        
                        <!-- UI/UX Design -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 19l7-7 3 3-7 7-3-3z"></path>
                                    <path d="M18 13l-1.5-7.5L2 2l3.5 14.5L13 18l5-5z"></path>
                                    <path d="M2 2l7.586 7.586"></path>
                                    <circle cx="11" cy="11" r="2"></circle>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">UI/UX Design</h4>
                                <p class="serviceItemText">Designing beautiful, high-fidelity prototypes and digital layouts using Figma.</p>
                            </div>
                        </div>
                        
                        <!-- Desktop Applications -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="2" y="3" width="20" height="14" rx="2" ry="2"></rect>
                                    <line x1="8" y1="21" x2="16" y2="21"></line>
                                    <line x1="12" y1="17" x2="12" y2="21"></line>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Desktop Applications</h4>
                                <p class="serviceItemText">Developing robust GUI desktop applications using Java Swing and AWT.</p>
                            </div>
                        </div>
                        
                        <!-- Quality Assurance -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"></path>
                                    <rect x="8" y="2" width="8" height="4" rx="1" ry="1"></rect>
                                    <polyline points="9 11 12 14 22 4"></polyline>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Quality Assurance</h4>
                                <p class="serviceItemText">Conducting software testing, validation, and comprehensive bug documentation.</p>
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
                                <h3 class="cvTitle">Arjan's Resume</h3>
                                <p class="cvText">Download the full CV to view complete details of my education and experience.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/assets/Arjan Regmi.pdf" class="cvDownloadBtn" download>
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
                                <p class="timelineText">Gaining deep knowledge in software development, database design, cloud systems, and agile methodologies.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">+2 Science</h4>
                                <span class="timelineDate">Global School of Science &middot; 2021 - 2023</span>
                                <p class="timelineText">Completed high school education with a focus on physics, chemistry, and mathematics.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Secondary Education Examination (SEE)</h4>
                                <span class="timelineDate">Valley View English School &middot; 2021</span>
                                <p class="timelineText">Completed lower secondary education with high academic standing.</p>
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
                                <h4 class="timelineItemTitle">Freelance Video Editor &amp; Web Designer</h4>
                                <span class="timelineDate">2023 - Present</span>
                                <p class="timelineText">Produced, edited, and refined dynamic video content for digital creators. Designed interactive UI prototypes and built modern responsive websites using Figma, HTML, and CSS.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Content Creator</h4>
                                <span class="timelineDate">2022 - Present</span>
                                <p class="timelineText">Produced high-quality educational and vlog content, managed publishing schedules, and tracked audience growth analytics.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Participant &mdash; Beyond Borders</h4>
                                <span class="timelineDate">Canopy Nepal &middot; 2021</span>
                                <p class="timelineText">Successfully participated in an intensive leadership development and intercultural collaboration exchange course.</p>
                            </li>
                        </ol>
                    </div>
                    
                    <!-- Skills Tab -->

                    <h3 class="subTitle">My Skills</h3>
                    <div class="skillsSection">
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Video Editing &amp; Figma</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Website Building</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Git &amp; GitHub</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
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
                    </div>
                </article>

            </div>
        </div>
    </main>
</body>
</html>
