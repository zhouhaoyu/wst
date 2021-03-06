<%@ page language="java" import="java.util.*, java.sql.*, java.io.FileInputStream" %>
<%!
    String readFile(String absPath) {
        try {
            Scanner s = new Scanner(new FileInputStream(absPath), "UTF-8");
            StringBuilder sb = new StringBuilder();
            for (String line = s.nextLine(); s.hasNextLine(); line = s.nextLine())
                sb.append(line).append('\n');
            return sb.toString().replace("<", "&lt;").replace(">", "&gt;");
        } catch (Exception ex) {
            return "ERROR" + ex.getMessage();
        }
    }
%>
<%@ include file="conn.jsp" %>
<%
    Map<String, String[]> parameters = request.getParameterMap();
    String[] names = parameters.get("name");
    String name;
    if (names != null) {
        name = names[0];
        int score = Integer.parseInt(parameters.get("score")[0]);
        String scoree = parameters.get("e")[0];
        if (scoree.equals(Double.toString(new Random(score).nextDouble()))) {
            PreparedStatement stmt = con.prepareStatement("INSERT INTO scores VALUES (?, ?)");
            stmt.setString(1, name);
            stmt.setInt(2, score);
            stmt.execute();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Homework 7</title>
    <link href="/stylesheets/Global.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/stylesheets/prettify.css" type="text/css" />
    <style>
        .divide-2of3 {
            margin: 0;
        }
        .divide-1of3 {
            margin: 0;
        }
        
        .widthfixed {
            width: 100%;
        }

        .applet {
            padding: 5px;
            box-shadow: gray 0 0 5px;
        }
    </style>
    <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js" type="text/javascript"></script>
    <script src="/javascripts/AutoFloat.js" type="text/javascript"></script>
    <script src="/javascripts/FormValidation.js" type="text/javascript"></script>
    <script src="/javascripts/prettify/prettify.js" type="text/javascript"></script>
    <script type="text/javascript">
        var graphicApplet, pingpongApplet;

        function ShowSrc(id) {
            $("#dlgViewSrc").fadeIn().find("pre").hide().eq(id).show();
        }
        
        function ChangeGAppletStyle() {
            var shape, color;
            $("#dGraphicAppletParameters input[type=radio]").each(function () {
                if (this.name == 'shape' && this.checked)
                    shape = this.value;
                if (this.name == 'color' && this.checked)
                    color = this.value;
            })
            graphicApplet.drawShape(shape, color);
        }

        function SubmitScore() {
            var name = prompt('Please tell me your name', '');
            if (!name || name == '')
                return false;
            try {
                $("#iScore").val(pingpongApplet.getLScore());
                $("#iScoreEncrypted").val(pingpongApplet.getScoreEncrypted());
                $("#iName").val(name);
            } catch (ex) {
                return false;
            }
            return true;
        }
        
        function Repaint() {
            graphicApplet.repaint();
            pingpongApplet.repaint();
        }

        $(document).ready(function () {
            prettyPrint();
            graphicApplet = document.getElementById('graphicApplet');
            pingpongApplet = document.getElementById('pingpongApplet');
            $(".mask").click(function (e) {
                if ($(this).is(e.target))
                    $(this).fadeOut();
            });
        });
    </script>
</head>
<body>
    <div id="dlgViewSrc" class="mask">
        <div class="inner">
            <h3 style="margin-top: 0">View Source</h3>
            <hr />
            <pre class="prettyprint roundbound"><%=readFile(application.getRealPath("./SimpleGraphicApplet.java"))%></pre>
            <pre class="prettyprint roundbound"><%=readFile(application.getRealPath("./PingPongApplet.java"))%></pre>
            <pre class="prettyprint roundbound"><%=readFile(application.getRealPath("./homework7/index.jsp"))%></pre>
        </div>
    </div>
    <!-- 页面顶端浮动导航栏 -->
    <div id="navigation-bar">
        <a href="http://162.105.146.183/b2evolution/blogs/index.php/zhouhy" id="btnGotoBlog"></a>
        <span class="splitter"></span>
        <a href="/">HOME</a>
        <span class="splitter"></span>
        <a href="http://net.pku.edu.cn/~zt/wst/">HOME OF WST</a>
        <span class="rfloat">Created by 周昊宇 / 1200012823</span>
    </div>
    <!-- 页首 -->
    <div id="banner">
        <p class="title">
            Homework 7 by 周昊宇
        </p>
        <p class="subtitle">
            <small>-- For <em>Web Software &amp; Technology</em> Course</small>
        </p>
    </div>
    <!-- 正文 -->
    <div class="content wrapfloat">
        <div class="divide-2of3 padding">
            <!-- 作业检查项 -->
            <a id="homework1"></a>
            <h2><b>Requirement #1</b> Load sample on different browsers</h2>
            <p>
                <h3>Chrome</h3>
                <img class="widthfixed" src="/images/chrome_applet.png" alt="chrome" />
            </p>
            <p>
                <h3>Firefox</h3>
                <img class="widthfixed" src="/images/firefox_applet.png" alt="firefox" />
            </p>
            <p>
                <h3>IE</h3>
                <img class="widthfixed" src="/images/ie_applet.png" alt="ie" />
            </p>
            <a id="homework23"></a>
            <h2><b>Requirement #2 &amp; #3</b> Draw three shapes with parameters</h2>
            <div class="wrapfloat">
                <div class="divide-2of3" id="dGraphicAppletParameters">
                    <a href="javascript:;" onclick="ShowSrc(0)">View Source</a>
                    <p>Choose shape for the <b>3rd</b> one:</p>
                    <p class="wrapfloat">
                        <label class="rad" for="radShape0"><input type="radio" id="radShape0" onchange="ChangeGAppletStyle()" name="shape" value="0" /> None</label>
                        <label class="rad" for="radShape1"><input type="radio" id="radShape1" onchange="ChangeGAppletStyle()" name="shape" value="1" /> Round Rectangle</label>
                        <label class="rad" for="radShape2"><input type="radio" id="radShape2" onchange="ChangeGAppletStyle()" name="shape" value="2" checked /> Oval</label>
                    </p>
                    <p>Choose filling color for the <b>3rd</b> one:</p>
                    <p class="wrapfloat">
                        <label class="rad" for="radColor0"><input type="radio" id="radColor0" onchange="ChangeGAppletStyle()" name="color" value="0" /> None</label>
                        <label class="rad" for="radColor1"><input type="radio" id="radColor1" onchange="ChangeGAppletStyle()" name="color" value="1" checked /> Blue</label>
                        <label class="rad" for="radColor2"><input type="radio" id="radColor2" onchange="ChangeGAppletStyle()" name="color" value="2" /> Orange</label>
                    </p>
                </div>
                <object type="application/x-java-applet" width="200" height="200" id="graphicApplet" class="applet divide-1of3">
                    <param name="code" value="SimpleGraphicApplet.class" />
                    <param name="permissions" value="sandbox" />
                    <param name="additionalShapeType" value="2" />
                    <param name="additionalShapeColor" value="1" />
                </object>
            </div>
            <a id="homework4"></a>
            <h2><b>Requirement #4</b> Differences between AWT and Swing graphics</h2>
            <p>AWT and Swing are both standard GUI toolkit in Java. AWT stands for Abstract Windows Toolkit which is the original GUI toolkit of Java which is supplied with all versions of Java on all platforms and is also stable.</p>
            <p>However, AWT is too basic that its components cannot satisfy popular needs. What's more, AWT relies heavily on components provided by host, which may cause different behaviors on different platforms. Therefore, Swing come to rescue.</p>
            <p>Swing is built based on AWT but implemented many more components. It uses few heavyweight (provided by host) components and more lightweight (simulated with pure Java code) components, thus Swing achieved a minimum dependence on host systems.</p>
            <p>Compared to AWT, Swing uses MVC design, has programmable skins, and provided complete support for disabled people. However, Swing is not thread-safe, which needs to be noticed. Though Swing is one of the standard GUI toolkit in Java, it may rely heavily on recent features of Java language, therefore is not so stable as AWT.</p>
            <a id="homework5"></a>
            <h2><b>Requirement #5</b> A ping-pong game</h2>
            <div class="wrapfloat">
                <div class="lfloat">
                    <div class="wrapfloat">
                        <a href="javascript:;" onclick="ShowSrc(1)">View Source</a><br />
                        <b>Control</b>: mouse.<br />
                        <b>Goal</b>: win 3 times more than your opponent.<br />
                        <b>Score</b>: how many times you winned.
                        <form action="#" method="post" onsubmit="return SubmitScore()">
                            <input type="hidden" id="iScore" name="score" />
                            <input type="hidden" id="iScoreEncrypted" name="e" />
                            <input type="hidden" id="iName" name="name" />
                            <button class="btn" type="submit">Submit your score!</button>
                        </form>
                    </div>
                    <h3>High Scores</h3>
                    <table class="mytable">
                        <tr><th>Name</th><th>Score</th></tr>
                        <%
                            try {
                                    Statement sql;
                                    ResultSet rs;
                                sql = con.createStatement();
                                rs = sql.executeQuery("SELECT * FROM scores ORDER BY score DESC");
                                while (rs.next()) {
                                    out.print("<tr>");
                                    out.print("<td>" + rs.getString(1) + "</td>");
                                    out.print("<td>" + rs.getString(2) + "</td>");
                                    out.print("</tr>");
                                }
                                con.close();
                            } catch(SQLException e){ out.print(e); }
                        %>
                    </table>
                </div>
                <object type="application/x-java-applet" width="300" height="200" id="pingpongApplet" class="applet rfloat">
                    <param name="code" value="PingPongApplet.class" />
                    <param name="permissions" value="sandbox" />
                </object>
            </div>
            <a id="homeworka"></a>
            <h2><b>Additional</b> Servlet powered scoreboard</h2>
            <p>
              <a href="javascript:;" onclick="ShowSrc(2)">View Source</a><br />
                The scoreboard feature above is implemented by a Java servlet.<br />
                I installed a mysql-connector for my tomcat and access the DB through servlet,  
                therefore you can submit your score and save it to DB. 
                Then when you open this page, the servlet fetches all the scores from DB.
            </p>
        </div>
        <!-- 目录 -->
        <div class="divide-1of3 lmargin padding contents">
            <p>Contents:</p>
            <ol>
                <li><a href="#homework1"><b>Requirement #1</b> Load sample on different browsers</a></li>
                <li><a href="#homework23"><b>Requirement #2 &amp; #3</b> Draw three shapes with parameters</a></li>
                <li><a href="#homework4"><b>Requirement #4</b> Differences between AWT and Swing graphics</a></li>
                <li><a href="#homework5"><b>Requirement #5</b> A ping-pong game</a></li>
                <li><a href="#homeworka"><b>Additional</b> Servlet powered scoreboard</a></li>
            </ol>
            <a class="btn" onclick="Repaint()">Click here if applets won't auto repaint</a>
        </div>
    </div>
    <div id="footer">
        <hr />
        <div style="color: #777; text-align: center">All rights reserved 2014 Zhou Haoyu, Peking University.</div>
    </div>
</body>
</html>
