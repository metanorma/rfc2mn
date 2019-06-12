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
<!--
:forename_initials: <xsl:value-of select="($auth)/@initials/">
:surname: <xsl:value-of select="($auth)/@surname/">
:fullname: <xsl:value-of select="($auth)/@fullname/">
:role: <xsl:value-of select="($auth)/@role/">
:organization: <xsl:value-of select="($auth)/organization/">
:street: <xsl:value-of select="($auth)/address/postal/street/">
:city: <xsl:value-of select="($auth)/address/postal/city/">
:region: <xsl:value-of select="($auth)/address/postal/region/">
:code: <xsl:value-of select="($auth)/address/postal/code/">
:country: <xsl:value-of select="($auth)/address/postal/country/">
:phone: <xsl:value-of select="($auth)/address/phone/">
:fax: <xsl:value-of select="($auth)/address/facsimile/">
:email: <xsl:value-of select="($auth)/address/email/">
:uri: <xsl:value-of select="($auth)/address/uri/">
-->
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
= <xsl:value-of select="normalize-space(front/title)"/><xsl:text>&#xa;</xsl:text>
<xsl:value-of select="front/author/@fullname"/>
:abbrev: <xsl:value-of select="title/@abbrev"/>
:status: <xsl:value-of select="@category"/>
:name: <xsl:value-of select="@docName"/>
:updates: <xsl:value-of select="@updates"/>
:obsoletes: <xsl:value-of select="@obsoletes"/>
:ipr: <xsl:value-of select="@ipr"/>
:area: <xsl:value-of select="$areas"/>
:workgroup: <xsl:value-of select="$workgroups"/>
:keyword: <xsl:value-of select="$keywords"/>
:revdate: <xsl:call-template name="dateconvert">
        <xsl:with-param name="day" select="front/date/@day"/>
        <xsl:with-param name="month" select="front/date/@month"/>
        <xsl:with-param name="year" select="front/date/@year"/>
    </xsl:call-template>

        <xsl:apply-templates />
    </xsl:template>


    <xsl:template match="author">
:forename_initials: <xsl:value-of select="@initials"/>
:lastname: <xsl:value-of select="@surname"/>
:fullname: <xsl:value-of select="@fullname"/>
:role: <xsl:value-of select="@role"/>
:organization: <xsl:value-of select="organization"/>
        <xsl:apply-templates />
    </xsl:template>
    <xsl:template match="address">
:street: <xsl:value-of select="street"/>
:city: <xsl:value-of select="city"/>
:region: <xsl:value-of select="region"/>
:code: <xsl:value-of select="code"/>
:country: <xsl:value-of select="country"/>
:phone: <xsl:value-of select="phone"/>
:fax: <xsl:value-of select="facsimile"/>
:email: <xsl:value-of select="email"/>
:uri: <xsl:value-of select="uri"/>
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
        <xsl:apply-templates select="*[not(local-name()='author')]" />
    </xsl:template>
    

    <xsl:template match="abstract">
        <xsl:text>[abstract]</xsl:text>
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="note">
        <xsl:text>&#xa;[NOTE]&#xa;.</xsl:text>
        <xsl:value-of select="@title"/>
        <xsl:text>&#xa;===</xsl:text>
        <xsl:apply-templates />
        <xsl:text>&#xa;===&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="middle">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="section">
        <xsl:text>&#xa;</xsl:text>
        
        <xsl:apply-templates select="@anchor" />
        <xsl:text>=</xsl:text><xsl:value-of select="str:padding(count(ancestor-or-self::section), '=')" />
        <xsl:text> </xsl:text>
        <xsl:value-of select="@title | name"/>
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="@anchor" >
        <xsl:text>&#xa;[[</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>]]&#xa;</xsl:text>
    </xsl:template>
    
    <!-- TODO handle name other V3 parent elements -->
    <xsl:template match="name" /> <!-- already did name when we did section so discard -->

    <xsl:template match="//xref">&lt;&lt;<xsl:value-of select="./@target"/>&gt;&gt;</xsl:template>
    <!-- Not bothering with differentiation between format attribute values -->

    <xsl:template match="list">
        <xsl:choose>
          <xsl:when test="@style = 'numbers'"><xsl:text>[arabic]</xsl:text></xsl:when>
          <xsl:when test="@style = 'letters'"><xsl:text>[alpha]</xsl:text></xsl:when>
        </xsl:choose>
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="t">
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="li">

        <xsl:call-template name="make-list-item">
            <xsl:with-param name="indent-level" select="count(ancestor::ol | ancestor::ul)" />
            <xsl:with-param name="item-number" select="count(preceding-sibling::li) + 1" />
            <xsl:with-param name="numbered" select="count(parent::ol)" />
        </xsl:call-template>
        
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="t[parent::list]">

        <xsl:choose>
          <xsl:when test="parent::list/@style='hanging'">
        <xsl:value-of select="@hangText"/>
        <xsl:text>::&#xa;</xsl:text>
        <xsl:apply-templates />
        <xsl:text>&#xa;&#xa;</xsl:text>
      </xsl:when>

          <xsl:otherwise>
        <xsl:call-template name="make-list-item">
            <xsl:with-param name="indent-level" select="count(ancestor::list)" />
            <xsl:with-param name="item-number" select="count(preceding-sibling::t) + 1" />
            <xsl:with-param name="numbered" select="parent::list[@style = 'numbers' or @style = 'letters']" />
        </xsl:call-template>
        
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>

    </xsl:template>
    
    <xsl:template match="eref">
        <xsl:value-of select="@target" />
        <xsl:text>[</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>]</xsl:text>
    </xsl:template>
 
    <xsl:template match="spanx[not(@style)] | spanx[@style='emph']">
        <xsl:text>_</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>_</xsl:text>
    </xsl:template>
    
    <xsl:template match="spanx[@style='strong']">
        <xsl:text>*</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>*</xsl:text>
    </xsl:template>
    
    <xsl:template match="spanx[@style='verb']">
        <xsl:text>`</xsl:text>
        <xsl:value-of select="." />
        <xsl:text>`</xsl:text>
    </xsl:template>
    
    <xsl:template match="vspace">
        <xsl:text> + &#xa;</xsl:text>
        <xsl:if test="@blankLines">
            <xsl:call-template name="blankLines">
                <xsl:with-param name="n" select="@blankLines - 1"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <xsl:template match="back">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="references">
        <xsl:text>&#xa;[bibliography]&#xa;== </xsl:text>
        <xsl:choose>
            <xsl:when test="@title">
                <xsl:value-of select="@title" />
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>References</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="reference">
        <xsl:text>&#xa;* [[[</xsl:text><xsl:value-of select="@anchor"/><xsl:text>]]] </xsl:text>
        <xsl:value-of select="front/title"/>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="reference//node()">&#xa;&lt;<xsl:value-of select="name()"/><xsl:for-each select="@*"><xsl:text> </xsl:text><xsl:value-of select="name()"/>="<xsl:value-of select="."/>"</xsl:for-each>&gt;<xsl:apply-templates/>&lt;/<xsl:value-of select="name()"/>&gt;&#xa;</xsl:template>

    <xsl:template match="reference//text()"><xsl:copy-of select="." /></xsl:template>

    <xsl:template match="cref">
        <xsl:apply-templates select="@anchor" />
            <xsl:choose>
                <xsl:when test="$draft='final'">
                </xsl:when>
                <xsl:otherwise>
<xsl:text>&#xa;////&#xa;</xsl:text>
<xsl:value-of select="@source"/> -- <xsl:value-of select="normalize-space(.)" />
<xsl:text>&#xa;////&#xa;</xsl:text>
                </xsl:otherwise>
             </xsl:choose>
    </xsl:template>

    <xsl:template match="figure">
        <xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates select="@anchor" />
        <xsl:call-template name="artworkheader">
           <xsl:with-param name="align" select="@align | artwork/@align"/>
           <xsl:with-param name="alt" select="@alt | artwork/@alt"/>
           <xsl:with-param name="type" select="@type | artwork/@type"/>
        </xsl:call-template>
	<xsl:if test="@title !=''">
                <xsl:text>. </xsl:text>
                <xsl:value-of select="@title"/>
                <xsl:text>&#xa;</xsl:text>
        </xsl:if>
        <xsl:apply-templates />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>
    
    <xsl:template match="preamble">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template name="artworkheader">
      <xsl:param name="align"/>
      <xsl:param name="alt"/>
      <xsl:param name="type"/>
      <xsl:if test="$alt or $align or $type">
        <xsl:text>[</xsl:text>
        <xsl:if test="$align"><xsl:text>align=</xsl:text><xsl:value-of select="$align"/></xsl:if>
        <xsl:if test="$align and $alt"><xsl:text>,</xsl:text></xsl:if>
        <xsl:if test="$alt"><xsl:text>alt=</xsl:text><xsl:value-of select="$alt"/></xsl:if>
        <xsl:if test="($align or $alt) and $type"><xsl:text>,</xsl:text></xsl:if>
        <xsl:if test="$type"><xsl:text>type=</xsl:text><xsl:value-of select="$type"/></xsl:if>
        <xsl:text>]&#xa;</xsl:text>
      </xsl:if>
    </xsl:template>
    
    <xsl:template match="artwork[not(@src)]">
	<xsl:choose>
            <xsl:when test="@type != ''"><xsl:text>====&#xa;</xsl:text></xsl:when>
	    <xsl:otherwise><xsl:text>....&#xa;</xsl:text></xsl:otherwise>
	</xsl:choose>
        <xsl:for-each select="str:split(., '&#xa;')">
            <xsl:value-of select="."/>
            <xsl:text>&#xa;</xsl:text>
        </xsl:for-each>
	<xsl:choose>
            <xsl:when test="@type != ''"><xsl:text>====&#xa;</xsl:text></xsl:when>
	    <xsl:otherwise><xsl:text>....&#xa;</xsl:text></xsl:otherwise>
	</xsl:choose>
    </xsl:template>

    <xsl:template match="artwork[@src]">
        <xsl:text>&#xa;image::</xsl:text>
	<xsl:value-of select="@src"/>
	<xsl:text>[</xsl:text>
        <xsl:if test="@alt or @width or @height">
	<xsl:value-of select="@alt"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="@width"/>
	<xsl:text>,</xsl:text>
	<xsl:value-of select="@height"/>
   	</xsl:if>
	<xsl:text>]</xsl:text>
    </xsl:template>
    
    <xsl:template match="texttable">
	<xsl:text>&#xa;</xsl:text>
        <xsl:apply-templates select="preamble"/>
	<xsl:text>&#xa;</xsl:text>
        <xsl:variable name="colcount" select="count(ttcol)"/>
        <xsl:apply-templates select="@anchor" />
	<xsl:text>&#xa;[cols="</xsl:text>
        <xsl:for-each select="ttcol">
            <xsl:call-template name="separator">
                <xsl:with-param name="lastnode" select="position()=last()"/>
            </xsl:call-template>
        </xsl:for-each>
 	<xsl:text>"]</xsl:text>

        <xsl:text>&#xa;</xsl:text>
	<xsl:if test="@title and string-length(@title)!=0">
		<xsl:text>. </xsl:text>
		<xsl:value-of select="@title"/>
        </xsl:if>

        <xsl:text>&#xa;|===&#xa;</xsl:text>
        
        <xsl:for-each select="ttcol">
            <xsl:call-template name="tableheader">
                <xsl:with-param name="lastnode" select="position()=last()"/>
            </xsl:call-template>
        </xsl:for-each>

        <xsl:for-each select="c">
            <xsl:call-template name="table-c">
                <xsl:with-param name="colcount" select="$colcount"/>
            </xsl:call-template>
        </xsl:for-each>

        <xsl:text>|===&#xa;&#xa;</xsl:text>
        <xsl:apply-templates select="postamble"/>
	<xsl:text>&#xa;</xsl:text>
    </xsl:template>
  
    <xsl:template match="ttcol" name="tableheader">
        <xsl:param name="lastnode"/>
	<xsl:text>| </xsl:text>
        <xsl:value-of select="."/> 
	<xsl:if test="$lastnode">
		<xsl:text>&#xa;&#xa;</xsl:text>
	</xsl:if>
    </xsl:template>
  
    <xsl:template match="ttcol" name="separator">
        <xsl:param name="lastnode"/>
        <xsl:choose>
            <xsl:when test="@align = 'left'">&lt;</xsl:when>
            <xsl:when test="@align = 'center'">^</xsl:when>
            <xsl:when test="@align = 'right'">&gt;</xsl:when>
            <xsl:otherwise>&lt;</xsl:otherwise>
        </xsl:choose>
            <xsl:if test="not($lastnode)">,</xsl:if>
    </xsl:template>
  
    <xsl:template match="c" name="table-c">
        <xsl:param name="colcount"/>
        <xsl:text>| </xsl:text>
        <xsl:apply-templates />
           <xsl:if test="position() mod $colcount = 0">
                <xsl:text>&#xA;</xsl:text>
            </xsl:if>
    </xsl:template>
    

</xsl:stylesheet>
