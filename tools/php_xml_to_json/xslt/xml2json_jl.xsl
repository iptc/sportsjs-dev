<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xts="http://www.xmlteam.com"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:iptc="http://iptc.org/std/nar/2006-10-01/"  
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/"
     exclude-result-prefixes="xs xts iptc sportsml"
    version="1.0">
    
    
    <xsl:output method="xml" indent="yes"/>
    
    
    <xsl:template match="/">
        <xsl:apply-templates select="//iptc:sports-content" />
    </xsl:template>
    
    
    <xsl:template match="iptc:sports-content">
        <sportsContent>
            <xsl:apply-templates select="*" />
        </sportsContent>
    </xsl:template>
    
    
    
    <!-- pass all elements through -->
    <xsl:template match="*">
        <xsl:choose>
            <xsl:when test="name() = 'sports-title'">
                <sportsTitle>
                    <name>
                        <full><xsl:value-of select="."/></full>
                    </name>
                </sportsTitle>
            </xsl:when>
            <xsl:when test="name() = 'name' and not(@*)" >
                <name>
                  <full><xsl:value-of select="."/></full>
                </name>
            </xsl:when>
            <xsl:when test="name() = 'name' and @*">
                <name>
                    <xsl:apply-templates select="@* | node()"/>
                </name>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="elementName"><xsl:call-template name="words-to-camel-case" ><xsl:with-param name="arg" select="name()"></xsl:with-param></xsl:call-template></xsl:variable>
                <xsl:element name="{$elementName}">
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <!-- convert all attributes to elements -->
    <xsl:template match="@*">
        <xsl:choose>
            <xsl:when test="name() = 'part'">
                <part>
                <xsl:variable name="elementName" select="substring-after(.,':')"></xsl:variable>
                <xsl:element name="{$elementName}">
                    <xsl:variable name="attributeValue" select="."/>
                    <xsl:value-of select=".."/>
                </xsl:element>
                </part>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="elementName"><xsl:call-template name="words-to-camel-case" ><xsl:with-param name="arg" select="name()"/></xsl:call-template></xsl:variable>
                <xsl:element name="{$elementName}">
                    <xsl:value-of select="."/>
                </xsl:element>        
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    <!-- pass all content through -->
    <xsl:template match="text()">
        <xsl:choose>
            <xsl:when test="following-sibling::node()">
                <xsl:if test="normalize-space()">
                    <xsl:element name="_text">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:if>                
            </xsl:when>
            <xsl:when test="preceding-sibling::node()">
                <xsl:if test="normalize-space()">
                    <xsl:element name="_fart">
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:if>                
            </xsl:when>
            <xsl:otherwise>
                <!--<xsl:value-of select="."/>-->
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:template>
    
    
    
    <xsl:template name="words-to-camel-case">
        <xsl:param name="arg"/>
        
        <xsl:if test="string-length($arg) &gt; 0">
            <xsl:variable name="org" select="concat($arg,'-')"/>
            
            <xsl:variable name="first" select="substring-before($org,'-')"/>
            
            <xsl:if test="string-length($first) &gt; 0">
               <xsl:call-template name="capitalize-first"><xsl:with-param name="arg" select="$first"/></xsl:call-template>
            </xsl:if>
            
            <xsl:if test="contains($org,'-')">
                <xsl:call-template name="words-to-camel-case"><xsl:with-param name="arg" select="substring-after($arg,'-')"/></xsl:call-template>
            </xsl:if>
            
        </xsl:if>
        
    </xsl:template>
    
    
    <!-- Make sure first letter is capitalized -->    
    <xsl:template name="capitalize-first">
        <xsl:param name="arg"/>
        
        <xsl:choose>
            <xsl:when test="string-length($arg) &gt; 0">
                <xsl:value-of select="concat(translate(substring($arg,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVXYZ'),substring($arg,2))"/>
            </xsl:when>
        </xsl:choose>
        
    </xsl:template>
    
</xsl:stylesheet>