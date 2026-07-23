<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yogesh Pant | Portfolio</title>
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
                    <img src="${pageContext.request.contextPath}/Images/Yogesh.png" alt="Yogesh Pant" class="avatarImg">
                </div>
                <h1 class="memberName">Yogesh Pant</h1>
                <div class="memberRole">BSc (Hons) Computing Student</div>
                
                <div class="separator"></div>
                
                <ul class="contactList">
                    <li class="contactItem">
                        <div class="contactIcon">E</div>
                        <div>
                            <div class="contactLabel">Email</div>
                            <div class="contactValue">yogeshpant911@gmail.com</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">P</div>
                        <div>
                            <div class="contactLabel">Phone</div>
                            <div class="contactValue">+977 9765228806</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">B</div>
                        <div>
                            <div class="contactLabel">Birthday</div>
                            <div class="contactValue">April 28, 2006</div>
                        </div>
                    </li>
                    <li class="contactItem">
                        <div class="contactIcon">L</div>
                        <div>
                            <div class="contactLabel">Location</div>
                            <div class="contactValue">Tokha, Kathmandu, Nepal</div>
                        </div>
                    </li>
                </ul>
            </aside>

            <!-- Main Content -->
            <div class="contentArea">
            
                <article id="aboutTab" class="articlePage active">
                    <div class="aboutText">
                        <p>I'm Yogesh Pant, a second-year BSc (Hons) Computing student at Islington College, Kathmandu. Certified in Prompt Engineering, AWS Machine Learning, and Digital Marketing, I am passionate about technology and building real things, from full-stack web applications to IoT devices.</p>
                    </div>

                    <h3 class="subTitle">What I'm Doing</h3>
                    <div class="serviceGrid">
                        <!-- AI & Prompt Engineering -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M12 2v2M12 20v2M4.93 4.93l1.41 1.41M17.66 17.66l1.41 1.41M2 12h2M20 12h2M6.34 17.66l-1.41 1.41M19.07 4.93l-1.41 1.41"></path>
                                    <circle cx="12" cy="12" r="4"></circle>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">AI &amp; Prompt Engineering</h4>
                                <p class="serviceItemText">Crafting optimized prompts and leveraging AI solutions to solve computing challenges.</p>
                            </div>
                        </div>
                        
                        <!-- Digital Marketing -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path d="M11 5L6 9H2V15H6L11 19V5Z"></path>
                                    <path d="M15.54 8.46a5 5 0 0 1 0 7.07"></path>
                                    <path d="M19.07 4.93a10 10 0 0 1 0 14.14"></path>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Digital Marketing</h4>
                                <p class="serviceItemText">Designing and executing digital marketing campaigns and student outreach funnels.</p>
                            </div>
                        </div>
                        
                        <!-- Web Development -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <polyline points="16 18 22 12 16 6"></polyline>
                                    <polyline points="8 6 2 12 8 18"></polyline>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Web Development</h4>
                                <p class="serviceItemText">Building interactive, responsive websites using modern frontend technologies.</p>
                            </div>
                        </div>
                        
                        <!-- Data Analytics -->
                        <div class="serviceItem">
                            <div class="serviceIconBox">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#C05A14" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="18" y1="20" x2="18" y2="10"></line>
                                    <line x1="12" y1="20" x2="12" y2="4"></line>
                                    <line x1="6" y1="20" x2="6" y2="14"></line>
                                </svg>
                            </div>
                            <div>
                                <h4 class="serviceItemTitle">Data Analytics</h4>
                                <p class="serviceItemText">Structuring data and generating actionable insights using MySQL, Excel, and Power BI.</p>
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
                                <h3 class="cvTitle">Yogesh's Resume</h3>
                                <p class="cvText">Download the full CV to view complete details of my education and experience.</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/assets/Yogesh Pant.pdf" class="cvDownloadBtn" download>
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
                                <h4 class="timelineItemTitle">Islington College</h4>
                                <span class="timelineDate">2024 - 2027</span>
                                <p class="timelineText">Pursuing BSc(Hons) Computing</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Learning Realm International School</h4>
                                <span class="timelineDate">2022 - 2024</span>
                                <p class="timelineText">Completed Intermediates in Science with a biology major.</p>
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
                                <h4 class="timelineItemTitle">Sales & Outreach (Intern)</h4>
                                <span class="timelineDate">April 2025 - June 2025</span>
                                <p class="timelineText">Engaged with students and parents to promote the Skill Enrichment Programme (SEP).</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Kavya School +2 - Admissions Officer (Intern)</h4>
                                <span class="timelineDate">July 2025 - August 2025</span>
                                <p class="timelineText">Worked with the admissions team to transition SEP graduates.</p>
                            </li>
                            <li class="timelineItem">
                                <h4 class="timelineItemTitle">Islington College - Admissions Officer (Intern)</h4>
                                <span class="timelineDate">August 2025 - April 2026</span>
                                <p class="timelineText">Focused on guiding prospective students toward bachelor's programs.</p>
                            </li>
                        </ol>
                    </div>
                    
                    <!-- Skills Tab -->

                    <h3 class="subTitle">My Skills</h3>
                    <div class="skillsSection">
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Prompt Engineering &amp; AI Optimization</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Java &amp; Python Programming</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">HTML, CSS &amp; JavaScript</span>
                                <span class="skillPercent">90%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 90%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Data Structuring &amp; MySQL</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Digital Marketing &amp; Sales Funnels</span>
                                <span class="skillPercent">85%</span>
                            </div>
                            <div class="skillBarBg">
                                <div class="skillBarFill" style="width: 85%"></div>
                            </div>
                        </div>
                        <div class="skillItem">
                            <div class="skillInfo">
                                <span class="skillName">Power BI &amp; Excel Analysis</span>
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
