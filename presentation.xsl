<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:variable name="head">
  <head><link rel="stylesheet" type="text/css" href="present.css"></link></head>  
</xsl:variable>

<xsl:variable name="author">
  <p>
    <b>Author: </b><xsl:value-of select="//author/degree"/><xsl:text>&#xA0;</xsl:text>
    <xsl:value-of select="//author/name"/><xsl:text>&#xA0;</xsl:text>
    <xsl:value-of select="//author/surname"/>    
  </p>
</xsl:variable>

<xsl:template name="headings">
    <xsl:param name="hElement">h1</xsl:param>
    <xsl:element name="{$hElement}">
      <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="/"> 
   <xsl:result-document method="html" href="presentation.html">
        <html>
          <xsl:copy-of select="$head" />
          <body>
            <xsl:apply-templates select="presentation/info"/>
          </body>
        </html>
    </xsl:result-document>

  <!-- Contents -->
    <xsl:result-document method="html" href="contents.html">
      <html>
          <xsl:copy-of select="$head" />
          <body>
            <div id="wrapper">
              <h1>Contents</h1>
              <table>             
              <xsl:for-each select="presentation/slide">  
                <tr> 
                  <td><xsl:value-of select="position()"/></td>
                  <td><a href="slide_{position()}.html"><xsl:value-of select="heading"/>  </a></td>
                </tr>
                </xsl:for-each>
                </table>
                <div id="footer" >
                  <a href="slide_1.html" class="right">Next</a>
                  <a href="presentation.html" class="right">Prew</a>
                </div>     
              </div>
          </body>
        </html>
      </xsl:result-document>
      <xsl:for-each select="presentation">
        <xsl:apply-templates select="slide"/>
      </xsl:for-each>
</xsl:template>

 <!-- Create first slide -->
<xsl:template match="presentation/info"> 
  <div id="wrapper">
    <div id="intro" align="center">
      <xsl:apply-templates select="title"/> 
      <div>
        <xsl:copy-of select="$author"/> 
        <xsl:apply-templates select="organisation"/>
        <xsl:apply-templates select="date"/>
      </div>
    </div>
    <div id="footer">
      <footer>
      <a href="contents.html" class="right">Next</a>
    </footer>
    </div>
  </div>
</xsl:template>

<xsl:template match="slide"> 
  <xsl:result-document method="html" href="slide_{position()}.html">
  <html>
    <xsl:copy-of select="$head" />
      <body>
        <div id="wrapper">
          
            <xsl:apply-templates select="heading"/>        
            <xsl:apply-templates select="content"/>  
         
          <div id ="footer">              
            <footer>
              <p>Page: <xsl:value-of select="position()"/></p>
              
              <xsl:if test="position() &lt; last()"> <!-- Vloz tlacidlo next, ak nie je posledny-->
                <a href="slide_{position()+1}.html" class="right">Next</a>
              </xsl:if>
              <xsl:if test="position() &gt; 1"> <!-- Vloz tlacidlo prew, ak nie je prvy-->
                <a href="slide_{position()-1}.html" class="right">Prew</a>
              </xsl:if>
               <xsl:if test="position() = 1">
                <a href="contents.html" class="right">Prew</a>
               </xsl:if>
               <a href="contents.html" class="right">Contents</a>
            </footer>
          </div>  
        </div> 
      </body>
  </html>
</xsl:result-document>
</xsl:template>

<xsl:template match="heading">
  <div id="header">
     <xsl:call-template name="headings">
      <xsl:with-param name="hElement">h2</xsl:with-param>
    </xsl:call-template>
</div>
</xsl:template>

<xsl:template match="image">
  <img>
    <xsl:attribute name="src">
        <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:attribute name="align">
        <xsl:value-of select="@align"/>
    </xsl:attribute>
  </img>
</xsl:template>

<xsl:template match="organisation">
  <p>
    <b>Organisation: </b>
    <xsl:value-of select="orgtitle"/>,
    <br/>
    <xsl:value-of select="orgsubtitle"/>   
  </p>
</xsl:template>

<xsl:template match="title">
   <xsl:call-template name="headings">
      <xsl:with-param name="hElement">h1</xsl:with-param>
    </xsl:call-template>
</xsl:template>

<xsl:template match="list">
    <xsl:choose>
    <xsl:when test="@style='number'">
      <ol>
        <xsl:for-each select=".">
          <xsl:apply-templates select="item"/>
        </xsl:for-each>
      </ol>
    </xsl:when>
    <xsl:otherwise>
      <ul>
        <xsl:for-each select=".">
          <xsl:apply-templates select="item"/>
        </xsl:for-each>
      </ul>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="item">
  <li><xsl:value-of select="."/></li>
</xsl:template>

<xsl:template match="content">
  <div id="content">
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="para">  
  <p>
    <xsl:attribute name="style">
        color:<xsl:value-of select="@color"/>
    </xsl:attribute>
    <xsl:apply-templates/>
  </p>
</xsl:template>

<xsl:template match="date">  
  <p>
    Date: <xsl:value-of select="."/>
  </p>
</xsl:template>

<xsl:template match="ref">
  <a>
    <xsl:attribute name="href">
        <xsl:value-of select="."/>
    </xsl:attribute>
    <xsl:value-of select="."/>
  </a>
</xsl:template>

</xsl:stylesheet>



