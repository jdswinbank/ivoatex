<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
	xmlns="http://www.w3.org/1999/xhtml"
	version="1.0">

  <!-- The parameter docbase is the location where the final document
       will be served from.  This will always have the following value
       in final versions, but draft versions may appear for a while at
       a different location, and this can be parameterised when this
       stylesheet is invoked. -->
  <xsl:param name='docbase'>http://www.ivoa.net/documents/</xsl:param>

  <xsl:param name="CSS_HREF" select="''"/>

  <xsl:output method="xml" encoding="utf-8"/>

  <xsl:template match="*">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|text()"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="@*">
    <xsl:copy/>
  </xsl:template>

  <xsl:template match="head">
    <xsl:copy>
      <xsl:element name="link">
        <xsl:attribute name="rel">stylesheet</xsl:attribute>
        <xsl:attribute name="type">text/css</xsl:attribute>
        <xsl:attribute name="href">
          <xsl:value-of select="$CSS_HREF"/>
        </xsl:attribute>
      </xsl:element>
      <xsl:call-template name="selectDoctypeStyle"/>

			<style type="text/css"><![CDATA[
				div#versionstatement, div#dateline {
					color: #005A9C;
					font-size: 150%;
				}

				p.parsep {
					overflow: hidden;
					height: 0pt;
					margin-top:0.5ex;
					margin-bottom:0.5ex;
				}

				div.admonition {
					width: 30em;
					position: relative;
					float: right;
					background-color: #dddddd;
					font-size: 80%;
					margin: 1ex;
					padding: 3pt;
					overflow: auto;
				}
				
				p.admonition-type {
					background-color: #444444;
					color: #ffffff;
					margin-top: 0px;
					padding-left: 5pt;
					padding-top: 5pt;
					padding-bottom: 5pt;
					font-weight: bold;
				}

				a.tth_citation, a.tth_citeref {
					color: #002A5C;
					text-decoration: none;
				}
			]]></style>

      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

	<xsl:template match="div[@id='titlepage']">
    <xsl:copy>
      <table cellspacing="0" cellpadding="0" width="450">
      <tr>
        <td><a href="http://www.ivoa.net/"><img height="169" alt="IVOA" src="http://www.ivoa.net/icons/IVOA_wb_300.jpg" width="300" border="0"/></a></td>
        <td>
        <div style="padding: 3.6pt 7.2pt;">
        <p><b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);"><span>&#xa0;</span>I</span></i></b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);">nternational</span></i></p>
        <p><b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);"><span>&#xa0;&#xa0;&#xa0;</span>V</span></i></b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);">irtual</span></i></p>
        <p><b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);"><span>&#xa0;</span><span>&#xa0;&#xa0;</span>O</span></i></b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);">bservatory</span></i></p>
        <p><b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);">A</span></i></b><i><span style="font-size: 14pt; color: rgb(0, 90, 156);">lliance</span></i><i>
        </i></p>
        </div>
        <i></i></td>
      </tr>
      </table>
      <br/>
    </xsl:copy>
		
		<h1><xsl:value-of select="h1[@align='center']"/></h1>
		<div id="versionstatement">
			Version <xsl:value-of select="span[@id='version']"/>
		</div>
		<div id="dateline">
			<xsl:apply-templates select="span[@id='doctype']" mode="humanreadable"/>
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="span[@id='docdate']"/>
		</div>
		<dl id="docmeta">

			<dt>Working Group</dt>
			<xsl:copy-of select="dd[@id='ivoagroup']"/>

			<dt>This Version</dt>
			<dd>
				<xsl:call-template name="currentlink"/>
			</dd>

			<dt>Latest Version</dt>
			<dd>
				<xsl:call-template name="latestlink"/>
			</dd>

			<dt>Previous Versions</dt>
			<dd>
				<ul class="previousversions">
					<xsl:apply-templates select="li[@class='previousversion']"/>
				</ul>
			</dd>

			<dt>Author(s)</dt>
			<dd>
				<ul class="authors">
					<xsl:apply-templates select="li[@class='author']"/>
				</ul>
			</dd>
			
			<dt>Editor</dt>
			<xsl:copy-of select="dd[@id='editor']"/>
		</dl>
	</xsl:template>

  <xsl:template match="a/@name">
    <xsl:if test="not(starts-with(., 'CITE'))">
      <xsl:copy/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="a/@href">
    <xsl:if test="not(starts-with(., '#CITE'))">
      <xsl:copy/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="style[./@type='text/css']">
  </xsl:template>

  <xsl:template match="dd/div[./@class='p']">
  </xsl:template>

  <xsl:template match="span[@id='doctype']" mode="humanreadable">
  	<xsl:variable name="doctype" select="."/>
    <xsl:choose>
       <xsl:when test="$doctype='WD'">
           <xsl:text>IVOA Working Draft </xsl:text>
       </xsl:when>
       <xsl:when test="$doctype='PR'">
           <xsl:text>IVOA Proposed Recommendation </xsl:text>
       </xsl:when>
       <xsl:when test="$doctype='REC'">
           <xsl:text>IVOA Recommendation </xsl:text>
       </xsl:when>
       <xsl:when test="$doctype='NOTE'">
           <xsl:text>IVOA Note </xsl:text>
       </xsl:when>
       <xsl:otherwise>
           <xsl:message terminate='yes'>doctype must be one of
               WD, PR, REC, NOTE</xsl:message>
       </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="div[@id='statusOfThisDocument']">
  	<xsl:variable name="doctype" select="."/>
      <p id="statusdecl"><em>
          <xsl:choose>
              <xsl:when test="$doctype='NOTE'">
                  This is an IVOA Note expressing suggestions from and
                  opinions of the authors. It is intended to share best
                  practices, possible approaches, or other perspectives on
                  interoperability with the Virtual Observatory. It should
                  not be referenced or otherwise interpreted as a standard
                  specification.
              </xsl:when>
              <xsl:when test="$doctype='WD'">
                  This is an IVOA Working Draft for review by IVOA members
                  and other interested parties.  It is a draft document and
                  may be updated, replaced, or obsoleted by other documents
                  at any time. It is inappropriate to use IVOA Working Drafts
                  as reference materials or to cite them as other than "work
                  in progress".
              </xsl:when>
              <xsl:when test="$doctype='PR'">
                  This is an IVOA Proposed Recommendation made available for
                  public review. It is appropriate to reference this document
                  only as a recommended standard that is under review and
                  which may be changed before it is accepted as a full
                  Recommendation.
              </xsl:when>
              <xsl:when test="$doctype='REC'">
                  This document has been reviewed by IVOA Members and other
                  interested parties, and has been endorsed by the IVOA
                  Executive Committee as an IVOA Recommendation. It is a
                  stable document and may be used as reference material or
                  cited as a normative reference from another document.
                  IVOA's role in making the Recommendation is to draw
                  attention to the specification and to promote its
                  widespread deployment. This enhances the functionality and
                  interoperability inside the Astronomical Community.
              </xsl:when>
              <xsl:otherwise>
                  <xsl:message terminate='yes'>doctype must be one of
                      WD, PR, REC, NOTE</xsl:message>
              </xsl:otherwise>
          </xsl:choose>
      </em></p>
  </xsl:template>

	<xsl:template name="selectDoctypeStyle">
  	<xsl:variable name="doctype" select="//span[@id='doctype']"/>
    <link rel="stylesheet" type="text/css">
      <xsl:attribute name="href">
        <xsl:choose>
         <xsl:when test="$doctype='WD'"
            >http://www.ivoa.net/misc/ivoa_wd.css</xsl:when>
         <xsl:when test="$doctype='PR'"
            >http://www.ivoa.net/misc/ivoa_pr.css</xsl:when>
         <xsl:when test="$doctype='REC'"
            >http://www.ivoa.net/misc/ivoa_rec.css</xsl:when>
         <xsl:when test="$doctype='NOTE'"
            >http://www.ivoa.net/misc/ivoa_note.css</xsl:when>
       </xsl:choose>
     </xsl:attribute>
   	</link>
  </xsl:template>

  <!-- Make a link to the current version on the ivoa doc server.
       The format of the URI here is as mandated by the IVOA
       Document Standards Standard Document (ahem). -->
  <xsl:template name="currentlink">
		<xsl:variable name="docdate" select="span[@id='docdate']"/>
    <xsl:variable name="currenturl">
      <xsl:value-of select="$docbase"/>
      <xsl:value-of select="//span[@id='docname']"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="concat(
      	substring($docdate, 1, 4),
      	substring($docdate, 6, 2),
      	substring($docdate, 9, 2))"/>
    </xsl:variable>
    <xsl:element name="a">
      <xsl:attribute name="class">currentlink</xsl:attribute>
      <xsl:attribute name="href">
        <xsl:value-of select="$currenturl"/>
      </xsl:attribute>
      <xsl:value-of select="$currenturl"/>
     </xsl:element>
  </xsl:template>

  <!-- Make a link to the LATEST version on the ivoa doc server.
       This is a URL without a version, which will redirect, on the
       doc server, to the versioned URL. -->
  <xsl:template name="latestlink">
    <xsl:variable name="currenturl">
	    <xsl:value-of select="$docbase"/>
      <xsl:value-of select="//span[@id='docname']"/>
    </xsl:variable>
    <xsl:element name="a">
       <xsl:attribute name="class">latestlink</xsl:attribute>
       <xsl:attribute name="href">
          <xsl:value-of select="$currenturl"/>
       </xsl:attribute>
       <xsl:value-of select="$currenturl"/>
    </xsl:element>
  </xsl:template>

	<!-- tth has given up detecting Ps in TeX source and hacks in
	     div class="p" elements as paragraph separators.  These
	     are potentially very confusing to browsers.  We hence 
	     replace them with hopefully less confusing constructs -->
	<xsl:template match="div[@class='p']">
		<p class="parsep"><span> </span></p>
	</xsl:template>

	<xsl:template match="body">
		<xsl:apply-templates/>
	</xsl:template>

</xsl:stylesheet>