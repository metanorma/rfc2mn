<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0"

    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:str="http://exslt.org/strings"
    xmlns:exsl="http://exslt.org/common"
    xmlns:l="urn:local"
    exclude-result-prefixes="xsl date str exsl l">

    <xsl:output method="text" encoding="utf-8" />
    <xsl:strip-space elements="*" />
    <xsl:preserve-space elements="t li reference" />

    <!-- if value = final, cref are omitted -->
    <xsl:param name="draft">nonfinal</xsl:param>

    <xsl:include href="common.xslt" />
        
    <xsl:variable name="areas">
        <xsl:call-template name="commafy">
            <xsl:with-param name="nodes" select="/rfc/front/area" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="workgroups">
        <xsl:call-template name="commafy">
            <xsl:with-param name="nodes" select="/rfc/front/workgroup" />
        </xsl:call-template>
    </xsl:variable>
    
    <xsl:variable name="keywords">
        <xsl:call-template name="commafy">
            <xsl:with-param name="nodes" select="/rfc/front/keyword" />
        </xsl:call-template>
    </xsl:variable>
    <!--    
    <xsl:template name="dateconvert">
        <xsl:param name="day" />
        <xsl:param name="month" />
        <xsl:param name="year" />
-->
        <!-- now print them out. Pad with 0 where necessary. -->
<!--
        <xsl:value-of select="$year" />
<xsl:choose>
  <xsl:when test="$month = 'January'">
   <xsl:value-of select="'-01'"/>
  </xsl:when>
  <xsl:when test="$month = 'February'">
   <xsl:value-of select="'-02'"/>
  </xsl:when>
  <xsl:when test="$month = 'March'">
   <xsl:value-of select="'-03'"/>
  </xsl:when>
  <xsl:when test="$month = 'April'">
   <xsl:value-of select="'-04'"/>
  </xsl:when>
  <xsl:when test="$month = 'May'">
   <xsl:value-of select="'-05'"/>
  </xsl:when>
  <xsl:when test="$month = 'June'">
   <xsl:value-of select="'-06'"/>
  </xsl:when>
  <xsl:when test="$month = 'July'">
   <xsl:value-of select="'-07'"/>
  </xsl:when>
  <xsl:when test="$month = 'August'">
   <xsl:value-of select="'-08'"/>
  </xsl:when>
  <xsl:when test="$month = 'September'">
   <xsl:value-of select="'-09'"/>
  </xsl:when>
  <xsl:when test="$month = 'October'">
   <xsl:value-of select="'-10'"/>
  </xsl:when>
  <xsl:when test="$month = 'November'">
   <xsl:value-of select="'-11'"/>
  </xsl:when>
  <xsl:when test="$month = 'December'">
   <xsl:value-of select="'-12'"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="'-01'"/>
  </xsl:otherwise>
 </xsl:choose>        
        <xsl:value-of select="'-'" />
        <xsl:choose>
        <xsl:when test="string-length($day) = 0">
            <xsl:value-of select="'01'" />
        </xsl:when>
        <xsl:when test="string-length($day) = 1">
            <xsl:value-of select="'0'" />
            <xsl:value-of select="$day" />
        </xsl:when>
        <xsl:otherwise>
        <xsl:value-of select="$day" />
        </xsl:otherwise>
        </xsl:choose>
        <xsl:value-of select="'T00:00:00Z'"/>
        </xsl:template>
-->

	<xsl:variable name="listprefix" />
	<xsl:template name="author">
	
	<!-- TODO: each needs wrapping with xsl:if to not include line if no metadata -->
	<xsl:param name="auth"/>

[[author]]
initials = "<xsl:value-of select="($auth)/@initials"/>"
surname = "<xsl:value-of select="($auth)/@surname"/>"
fullname = "<xsl:value-of select="($auth)/@fullname"/>"
role = "<xsl:value-of select="($auth)/@role"/>"
organization = "<xsl:value-of select="($auth)/organization"/>"
[author.address]
street = "<xsl:value-of select="($auth)/address/postal/street"/>"
city = "<xsl:value-of select="($auth)/address/postal/city"/>"
region = "<xsl:value-of select="($auth)/address/postal/region"/>"
code = "<xsl:value-of select="($auth)/address/postal/code"/>"
country = "<xsl:value-of select="($auth)/address/postal/country"/>"
phone = "<xsl:value-of select="($auth)/address/phone"/>"
facsimile = "<xsl:value-of select="($auth)/address/facsimile"/>"
email = "<xsl:value-of select="($auth)/address/email"/>"
uri = "<xsl:value-of select="($auth)/address/uri"/>"
</xsl:template>

    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="rfc">
%%%
title = "<xsl:value-of select="normalize-space(front/title)"/>"
abbrev = "<xsl:value-of select="title/@abbrev"/>"
category = "<xsl:value-of select="@category"/>"
docName = "<xsl:value-of select="@docName"/>"
updates = [<xsl:value-of select="@updates"/>]
obsoletes = [<xsl:value-of select="@obsoletes"/>]
ipr = "<xsl:value-of select="@ipr"/>"
area =  <xsl:value-of select="$areas"/>
workgroup = <xsl:value-of select="$workgroups"/>
keyword =  [<xsl:value-of select="$keywords"/>]
date = <xsl:call-template name="dateconvert">
        <xsl:with-param name="day" select="front/date/@day"/>
        <xsl:with-param name="month" select="front/date/@month"/>
        <xsl:with-param name="year" select="front/date/@year"/>
    </xsl:call-template>

        <xsl:apply-templates />
    </xsl:template>


    <xsl:template match="author">
[[author]]
initials = "<xsl:value-of select="@initials"/>"
surname = "<xsl:value-of select="@surname"/>"
fullname = "<xsl:value-of select="@fullname"/>"
role = "<xsl:value-of select="@role"/>"
organization = "<xsl:value-of select="organization"/>"
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="address">
[author.address]
street = "<xsl:value-of select="street"/>"
city = "<xsl:value-of select="city"/>"
region = "<xsl:value-of select="region"/>"
code = "<xsl:value-of select="code"/>"
country = "<xsl:value-of select="country"/>"
phone = "<xsl:value-of select="phone"/>"
facsimile = "<xsl:value-of select="facsimile"/>"
email = "<xsl:value-of select="email"/>"
uri = "<xsl:value-of select="uri"/>"
        <xsl:apply-templates />
    </xsl:template>

    <!-- already handled by the pull templates, so discard -->
    <xsl:template match="title" /> 
    <xsl:template match="organization" />
    <xsl:template match="street" />
    <xsl:template match="city" />
    <xsl:template match="region" />
    <xsl:template match="code" />
    <xsl:template match="country" />
    <xsl:template match="phone" />
    <xsl:template match="facsimile" />
    <xsl:template match="email" />
    <xsl:template match="uri" />
    
    <xsl:template match="area" />
    <xsl:template match="workgroup" />
    <xsl:template match="keyword" />


    <xsl:template match="front">
        <xsl:apply-templates select="author"/>
        <xsl:text>&#xa;%%%&#xa;</xsl:text>
        <xsl:apply-templates select="*[not(local-name()='author')]" />
    </xsl:template>
    

    <xsl:template match="abstract">
        <xsl:text>&#xa;.# Abstract</xsl:text>
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="note">
        <xsl:text>&#xa;.# </xsl:text>
        <xsl:value-of select="@title"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="middle">
        <xsl:text>&#xa;{mainmatter}&#xa;</xsl:text>
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="section">
        <xsl:text>&#xa;</xsl:text>
        
        <xsl:value-of select="str:padding(count(ancestor-or-self::section), '#')" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="@title | name"/>
        <xsl:apply-templates select="@anchor" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="@anchor" >
        <xsl:text> {#</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>}&#xa;</xsl:text>
    </xsl:template>
    
    <!-- TODO handle name other V3 parent elements -->
    <xsl:template match="name" /> <!-- already did name when we did section so discard -->

    <xsl:template match="//xref"> (#<xsl:value-of select="./@target"/>)</xsl:template>
    <!-- Not bothering with differentiation between format attribute values -->

    <xsl:template match="list">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="t">
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="ol">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="ul">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="dl">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="dt">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="dd">
        <xsl:text>&#xa;: </xsl:text>
        <xsl:apply-templates />
        <xsl:text>&#xa;&#xa;</xsl:text>
    </xsl:template>

    <xsl:template match="li">

        <xsl:call-template name="make-list-item">
            <xsl:with-param name="indent-level" select="count(ancestor::ol | ancestor::ul)" />
            <!-- counter-style fails through to default counter style when parent::ul -->
            <xsl:with-param name="counter-style" select="parent::ol/@style" />
            <xsl:with-param name="item-number" select="count(preceding-sibling::li) + 1" />
        </xsl:call-template>
        
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="t[parent::list]">

        <xsl:choose>
          <xsl:when test="parent::list/@style='hanging'">
        <xsl:value-of select="@hangText"/>
        <xsl:text>&#xa;: </xsl:text>
        <xsl:apply-templates />
        <xsl:text>&#xa;&#xa;</xsl:text>
      </xsl:when>

          <xsl:otherwise>
        <xsl:call-template name="make-list-item">
            <xsl:with-param name="indent-level" select="count(ancestor::list)" />
            <xsl:with-param name="counter-style" select="parent::list/@style" />
            <xsl:with-param name="item-number" select="count(preceding-sibling::t) + 1" />
        </xsl:call-template>
        
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    </xsl:template>
    
    <xsl:template match="eref">
        <xsl:text>[</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>](</xsl:text>
        <xsl:value-of select="@target" />
        <xsl:text>)</xsl:text>
    </xsl:template>
 
    <xsl:template match="spanx | em | spanx[@size='emph'] | 
                         spanx[@size='strong'] | spanx[@size='verb']">
        <xsl:text>*</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>*</xsl:text>
    </xsl:template>
    
    <xsl:template match="strong">
        <xsl:text>**</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>**</xsl:text>
    </xsl:template>
    
    <xsl:template match="tt">
        <xsl:text>`</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>`</xsl:text>
    </xsl:template>
    
    <!-- This is how it's handled in standard markdown, not Github-flavored markdown -->
    <xsl:template match="br">
        <xsl:text>  &#xa;</xsl:text> <!-- Two spaces followed by newline -->
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="sub">
        <xsl:text>~</xsl:text>
        <xsl:apply-templates />
        <xsl:text>~</xsl:text>
    </xsl:template>
    
    <xsl:template match="sup">
        <xsl:text>^</xsl:text>
        <xsl:apply-templates />
        <xsl:text>^</xsl:text>
    </xsl:template>
    
    <xsl:template match="blockquote">
        <xsl:text>&#xa;</xsl:text>
        <xsl:variable name="text"> <!-- process all the child nodes into text so we can -->
            <xsl:apply-templates /><!-- postprocess them and add block quote markdown -->
        </xsl:variable>
        
        <xsl:for-each select="str:split($text, '&#xa;')">
            <xsl:text>&gt; </xsl:text>
            <xsl:value-of select="." />
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    

    <xsl:template match="vspace">
        <xsl:text>&#xa;</xsl:text>
        <xsl:if test="@blankLines">
            <xsl:call-template name="blankLines">
                <xsl:with-param name="n" select="@blankLines - 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!-- override rule: <link> nodes get special treatment -->
    <xsl:template match="description//link">
        <a href="#{@ref}">
            <xsl:apply-templates />
        </a>
    </xsl:template>


    <xsl:template match="back">
        <xsl:apply-templates />

        <xsl:text>&#xa;{backmatter}&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="references">
        <xsl:text># </xsl:text>
        <xsl:choose>
            <xsl:when test="@title">
                <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>References</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="reference">
        <xsl:text>&#xa;&lt;reference</xsl:text>
        <xsl:for-each select="@*"><xsl:text> </xsl:text><xsl:value-of select="name()"/>="<xsl:value-of select="."/>"</xsl:for-each>&gt;
        <xsl:apply-templates/>
        <xsl:text>&lt;/reference&gt;&#xa;</xsl:text>
    </xsl:template>
    <xsl:template match="reference//node()">&#xa;&lt;<xsl:value-of select="name()"/><xsl:for-each select="@*"><xsl:text> </xsl:text><xsl:value-of select="name()"/>="<xsl:value-of select="."/>"</xsl:for-each>&gt;<xsl:apply-templates/>&lt;/<xsl:value-of select="name()"/>&gt;&#xa;</xsl:template>

    <xsl:template match="reference//text()"><xsl:copy-of select="." /></xsl:template>

    <xsl:template match="cref">
        <xsl:apply-templates select="@anchor" />
            <xsl:choose>
                <xsl:when test="$draft='final'">
                </xsl:when>
                <xsl:otherwise>
&lt;!-- <xsl:value-of select="@source"/> -- <xsl:value-of select="normalize-space(.)" /> --&gt;
                </xsl:otherwise>
             </xsl:choose>
    </xsl:template>

    <xsl:template match="figure">
        <xsl:apply-templates select="@anchor" />
        <xsl:apply-templates />
        <xsl:choose>
            <xsl:when test="@title !=''">
                <xsl:text>Figure: </xsl:text>
                <xsl:value-of select="@title"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:when>
            <xsl:when test="@suppress-title = 'true'">
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Figure: </xsl:text>
                <xsl:number format="1" level="any" count="figure"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="preamble">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="artwork">
        <xsl:apply-templates match="@type" />
        <xsl:choose>
            <xsl:when test="@src != ''">
                <xsl:apply-templates match="@src" />
            </xsl:when>
            <xsl:otherwise>
              <!--<xsl:apply-templates />-->
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>F&gt; ~~~~&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="@src">
        <xsl:text>{{</xsl:text>
        <xsl:value-of select="."/>
        <xsl:text>}}</xsl:text>
    </xsl:template>
    
    <xsl:template match="@type">
        <xsl:text>F&gt; ~~~ </xsl:text>
        <xsl:value-of select="." />
    </xsl:template>
    
    <xsl:template match="artwork//text()">
        <xsl:for-each select="str:split(., '&#xa;')">
            <xsl:text>F&gt; </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="postamble">
        <xsl:apply-templates />
    </xsl:template>
    
    
    <xsl:template match="texttable">
        <xsl:text>&#xa;</xsl:text>
        <xsl:variable name="colcount" select="count(ttcol)"/>
        <xsl:apply-templates select="@anchor" />
        <xsl:apply-templates select="preamble"/>

        <xsl:text>&#xa;</xsl:text>
        
        <xsl:for-each select="ttcol">
            <xsl:call-template name="tableheader">
                <xsl:with-param name="lastnode" select="position()=last()"/>
            </xsl:call-template>
        </xsl:for-each>

        <xsl:for-each select="ttcol">
            <xsl:call-template name="separator">
                <xsl:with-param name="lastnode" select="position()=last()"/>
            </xsl:call-template>
        </xsl:for-each>
    
        <xsl:for-each select="c">
            <xsl:call-template name="table-c">
                <xsl:with-param name="colcount" select="$colcount"/>
            </xsl:call-template>
        </xsl:for-each>

        <xsl:apply-templates select="postamble"/>
        <xsl:choose>
            <xsl:when test="@title and string-length(@title)!=0">
Table: <xsl:value-of select="@title"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:when>
            <xsl:when test="@suppress-title = 'true'">
            </xsl:when>
            <xsl:otherwise>
Table: <xsl:number format="1" level="any" count="texttable"/>
                <xsl:text>&#xa;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
    <xsl:template match="ttcol" name="tableheader">
        <xsl:param name="lastnode"/>
        <xsl:value-of select="."/> 
        <xsl:choose>
            <xsl:when test="not($lastnode)"> | </xsl:when>
            <xsl:otherwise><xsl:text>&#xA;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
    <xsl:template match="ttcol" name="separator">
        <xsl:param name="lastnode"/>
        <xsl:choose>
            <xsl:when test="@align = 'left'">:---</xsl:when>
            <xsl:when test="@align = 'center'">:--:</xsl:when>
            <xsl:when test="@align = 'right'">---:</xsl:when>
            <xsl:otherwise>----</xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="not($lastnode)">|</xsl:when>
            <xsl:otherwise><xsl:text>&#xA;</xsl:text></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
  
    <xsl:template match="c" name="table-c">
        <xsl:param name="colcount"/>
        <xsl:apply-templates />
        <xsl:choose>
            <xsl:when test="position() mod $colcount = 0">
                <xsl:text>&#xA;</xsl:text>
            </xsl:when>
            <xsl:when test="position()=last()"> </xsl:when>
            <xsl:otherwise> | </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <!-- V3 tables -->
    <xsl:template match="table">
        <xsl:if test="@title != ''">
            <xsl:text>&#xa;{# </xsl:text>
            <xsl:value-of select="@title" />
            <xsl:text> }&#xa;</xsl:text>
        </xsl:if>
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="tr[th]">
        <xsl:apply-templates select="th" mode="labels"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates select="th" mode="alignment"/>
        <xsl:text></xsl:text>
    </xsl:template>
    
    <xsl:template match="tr[td]">
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="th" mode="labels">
        <xsl:apply-templates />
        <xsl:if test="position() != last()">
            <xsl:text> | </xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="th" mode="alignment">
        <xsl:text>---</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="th[@align='left']" mode="alignment">
        <xsl:text>:--</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="th[@align='center']" mode="alignment">
        <xsl:text>:-:</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="th[@align='right']" mode="alignment">
        <xsl:text>--:</xsl:text>
        <xsl:if test="position() != last()">
            <xsl:text>|</xsl:text>
        </xsl:if>
    </xsl:template>

    <xsl:template match="td">
        <xsl:apply-templates />
        <xsl:if test="position() != last()">
            <xsl:text> | </xsl:text>
        </xsl:if>

    </xsl:template>
    


</xsl:stylesheet>
