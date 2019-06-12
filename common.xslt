<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0"

    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:str="http://exslt.org/strings"
    
    exclude-result-prefixes="xsl str"


>
    
    <xsl:template name="commafy">
        <xsl:param name="nodes" />
        
        <xsl:for-each select="$nodes">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="normalize-space(.)" />
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">, </xsl:if>
        </xsl:for-each>
    </xsl:template>
        
    <xsl:template name="make-counter">
        <xsl:param name="style" />
        <xsl:param name="position" />

        <xsl:choose>
            <xsl:when test="$style = 'letters' or $style = 'a'">
                <xsl:number value="$position" format="a" />
                <xsl:text>)  </xsl:text> <!-- Need double space after alpha counters -->
            </xsl:when>
            <xsl:when test="$style = 'numbers' or $style = '1'">
                <xsl:number value="$position" format="1" />
                <xsl:text>. </xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>* </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="make-list-item">
        <xsl:param name="indent-level" />
        <xsl:param name="counter-style" />
        <xsl:param name="item-number" />
        
        <!-- start of nested list: insert line -->
        <xsl:choose>
          <xsl:when test="$item-number=1">
            <xsl:text>&#xa;</xsl:text>
          </xsl:when>
        </xsl:choose>

        <xsl:value-of select="str:padding(($indent-level - 1) * 4, ' ')" />
        
        <xsl:call-template name="make-counter">
            <xsl:with-param name="style" select="$counter-style" />
            <xsl:with-param name="position" select="$item-number" />
        </xsl:call-template>
        
    </xsl:template>


    <xsl:template name="dateconvert">
        <xsl:param name="day" />
        <xsl:param name="month" />
        <xsl:param name="year" />

        <!-- now print them out. Pad with 0 where necessary. -->
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


    <xsl:template name="blankLines">
        <xsl:param name="n"/>
        <!-- TODO: remove and just call str:padding directly -->
        <!-- NOTE: these are standard markdown compatible, two spaces followed by newline -->
        <xsl:value-of select="str:padding(n, '   &#xa;')" />
    </xsl:template>
    

</xsl:stylesheet>
