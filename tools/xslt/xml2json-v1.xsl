<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xts="http://www.xmlteam.com"  
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:iptc="http://iptc.org/std/nar/2006-10-01/"  
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/"
     exclude-result-prefixes="xs xts iptc sportsml" version="1.0">
    <!-- Use this if your system only support xslt 1 -->
    
    
    <xsl:output method="xml" indent="yes"/> <!-- We are not producing json but a flatter xml, prepared for json-conversion -->
    
    
    <xsl:template match="/">
        <xsl:apply-templates select="//iptc:sports-content" /> <!-- Start with sports-content  -->
    </xsl:template>
    
    
    <xsl:template match="iptc:sports-content">
        <sportsContent>
            <xsl:apply-templates select="*" />  <!-- Apply templates in sports-content -->
        </sportsContent>
    </xsl:template>
    
    
    
    <!-- pass all elements through -->
    <xsl:template match="*">
        <xsl:choose>
            <xsl:when test="name() = 'sports-title'">  <!-- If the element is called sports-title -->
                <sportsTitle>
                    <name>
                        <full><xsl:value-of select="."/></full>
                    </name>
                </sportsTitle>
            </xsl:when>
            <xsl:when test="name() = 'name' and not(@*)" > <!-- If the element is called name and it has no attributes -->
                <name>
                  <full><xsl:value-of select="."/></full> <!-- Use construction name/full with content -->
                </name>
            </xsl:when>
            <xsl:when test="name() = 'name' and @*"> <!-- If the element is called name and it has attributes -->
                <name>
                    <xsl:apply-templates select="@* | node()"/> <!-- Use name and process all content of this element -->
                </name>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="elementName"><xsl:call-template name="convertName" ><xsl:with-param name="arg" select="name()"/></xsl:call-template></xsl:variable> <!-- Call template to get a new element name -->
                <xsl:element name="{$elementName}"> <!-- Create a new element with the name from the variable above -->
                    <xsl:apply-templates select="@* | node()"/> <!-- Process all content of this element -->
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
                <xsl:variable name="elementName"><xsl:call-template name="convertName" ><xsl:with-param name="arg" select="name()"/></xsl:call-template></xsl:variable>
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
    

    <!-- Template to convert names to camelCase with lowercase first -->
    <xsl:template name="convertName">
        <xsl:param name="arg"/>
        
        <xsl:variable name="step1"> <!-- Start by calling the template to convert to camelcase -->
            <xsl:call-template name="words-to-camel-case"><xsl:with-param name="arg" select="$arg"/></xsl:call-template>
        </xsl:variable>
        
        <xsl:call-template name="lowercase-first"><xsl:with-param name="arg" select="$step1"/></xsl:call-template>
    </xsl:template>
    
    
    <!-- Template to convert to camel case -->
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
    
    
    <!-- Make sure first letter is lowercase. This is called once to make first letter in the combined CamelCaseWord starting lowerCase -->    
    <xsl:template name="lowercase-first">
        <xsl:param name="arg"/>
        
        <xsl:choose>
            <xsl:when test="string-length($arg) &gt; 0">
                <xsl:value-of select="concat(translate(substring($arg,1,1),'ABCDEFGHIJKLMNOPQRSTUVXYZ','abcdefghijklmnopqrstuvwxyz'),substring($arg,2))"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- Make sure first letter is capitalized. This is called for each word in a multi-word element name. -->    
    <xsl:template name="capitalize-first">
        <xsl:param name="arg"/>
        
        <xsl:choose>
            <xsl:when test="string-length($arg) &gt; 0">
                <xsl:value-of select="concat(translate(substring($arg,1,1),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVXYZ'),substring($arg,2))"/>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>