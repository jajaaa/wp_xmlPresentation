<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- <xsl:variable name="logo">
  
</xsl:variable>
<xsl:copy-of select="$logo" /> -->

<xsl:variable name="head">
<head><link rel="stylesheet" type="text/css" href="present.css"></link></head>  
</xsl:variable>

<xsl:variable name="author">
  <p>
    <b>Author: </b><xsl:value-of select="author/name"/> <xsl:value-of select="author/surname"/>    
  </p>
</xsl:variable>

<xsl:variable name="organisation">
  <p>
    <b>Organisation: </b>
    <xsl:value-of select="title"/>,
    <br/>
    <xsl:value-of select="subtitle"/>   
    <xsl:value-of select="image"/>
  </p>
  
</xsl:variable>

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
                  <td><a href="slide_{position()}.html"><xsl:value-of select="title"/>  </a></td>
                </tr>
                </xsl:for-each>
                </table>
                <div id="footer" >
                  <a href="slide_1.html">Next</a>
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
        <xsl:copy-of select="$organisation"/>
      </div>
    </div>
    <div id="footer">
      <footer>
      <a href="contents.html">Next</a>
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
          <div id="header">
            <xsl:apply-templates select="$author"/>  
          </div>
          <div id="content">
            <xsl:apply-templates select="title"/>  
            <xsl:apply-templates select="content"/>  
          </div>
          <div id ="footer">              
            <footer>
              <p>Page: <xsl:value-of select="position()"/></p>
              <a href="contents.html" class="right">Contents</a>
              <xsl:if test="position() &lt; last()"> <!-- Vloz tlacidlo next, ak nie je posledny-->
                <a href="slide_{position()+1}.html" class="right">Next</a>
              </xsl:if>
              <xsl:if test="position() &gt; 1"> <!-- Vloz tlacidlo prew, ak nie je prvy-->
                <a href="slide_{position()-1}.html" class="right">Prew</a>
              </xsl:if>
            </footer>
          </div>  
        </div> 
      </body>
  </html>
</xsl:result-document>
</xsl:template>

<xsl:template match="title">
  <h1>
    <xsl:value-of select="."/>    
  </h1>
</xsl:template>

<xsl:template match="content">
  <p>
    CONTENT: <xsl:value-of select="."/>    
  </p>
</xsl:template>

<xsl:template match="image">
  <img>
    <xsl:attribute name="src">
        <xsl:value-of select="."/>
    </xsl:attribute>
  </img>
</xsl:template>
</xsl:stylesheet>

