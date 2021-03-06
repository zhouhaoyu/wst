﻿<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
  <xsl:output method="html" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Homework 8</title>
        <link href="/stylesheets/Global.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="/stylesheets/prettify.css" type="text/css" />
        <script src="http://libs.baidu.com/jquery/1.9.0/jquery.js" type="text/javascript"></script>
        <script src="/javascripts/AutoFloat.js" type="text/javascript"></script>
        <script src="/javascripts/prettify/prettify.js" type="text/javascript"></script>
        <script type="text/javascript">
          <![CDATA[
          function ShowSrc(src) {
            $("#dlgViewSrc").fadeIn().find("pre").replaceWith($("<pre class=\"prettyprint roundbound\"></pre>").text(src));
            prettyPrint();
          }
          function ViewOnlineSrc(url) {
            $.get(url, function (src) {
              ShowSrc(src);
            }, "text");
          }
          $(document).ready(function () {
            $(".mask").click(function (e) {
              if ($(this).is(e.target))
                $(this).fadeOut();
            });
          })
          ]]>
        </script>
      </head>
      <body>
        <div id="dlgViewSrc" class="mask">
          <div class="inner">
            <h3 style="margin-top: 0">View Source</h3>
            <hr />
            <pre class="prettyprint roundbound">
            </pre>
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
            Homework 8 by 周昊宇
          </p>
          <p class="subtitle">
            <small>
              -- For <em>Web Software &amp; Technology</em> Course
            </small>
          </p>
        </div>
        <!-- 正文 -->
        <div class="content wrapfloat">
          <div class="divide-2of3 padding">
            <p>
              Please note that though this page looks like a raw HTML page, it is an XML transformed by browser with an XSLT. 
              <span class="slashout">By the way, the schema used in this XML is auto-generated by the powerful Visual Studio ®. Hooary!</span>
            </p>
            <xsl:for-each select="recipes/recipe">
              <h2>
                <b>Recipe:&#032;</b>
                <xsl:value-of select="name"></xsl:value-of>
              </h2>
              <h3>Ingredients</h3>
              <table class="mytable" style="font-size: 14px">
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Amount</th>
                </tr>
                <xsl:for-each select="ingredients/ingredient">
                  <tr>
                    <td>
                      <xsl:value-of select="name"></xsl:value-of>
                    </td>
                    <td>
                      <xsl:value-of select="@type"></xsl:value-of>
                    </td>
                    <td>
                      <xsl:value-of select="amount"></xsl:value-of>&#160;
                      <xsl:value-of select="amount/@unit"></xsl:value-of>
                    </td>
                  </tr>
                </xsl:for-each>
              </table>
              <h3>Steps</h3>
              <ul>
                <xsl:for-each select="steps/step">
                  <li>
                    <p>
                      <b>What will be used in this step:&#032;</b>
                      <xsl:for-each select="cookers/cooker">
                        <xsl:value-of select="."></xsl:value-of>&#160;
                      </xsl:for-each>
                    </p>
                    <p>
                      <b>Step detail:&#032;</b>
                      <xsl:value-of select="action"></xsl:value-of>
                    </p>
                  </li>
                </xsl:for-each>
              </ul>
            </xsl:for-each>
          </div>
          <!-- 目录 -->
          <div class="divide-1of3 lmargin padding contents">
            <p>
              <b>Sources</b>:
            </p>
            <ol>
              <li>
                <a href="javascript:;" onclick="ViewOnlineSrc('index.xml')">
                  <b>XML</b> View the source of this XML
                </a>
              </li>
              <li>
                <a href="javascript:;" onclick="ViewOnlineSrc('index.xsd')">
                  <b>XSD</b> View the source of <em>Schema</em> used in this XML
                </a>
              </li>
              <li>
                <a href="javascript:;" onclick="ViewOnlineSrc('index.xslt')">
                  <b>XSLT</b> View the source of <em>XSL Transformation</em> used in this XML
                </a>
              </li>
            </ol>
          </div>
        </div>
        <div id="footer">
          <hr />
          <div style="color: #777; text-align: center">All rights reserved 2014 Zhou Haoyu, Peking University.</div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
