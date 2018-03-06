<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xts="http://www.xmlteam.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:iptc="http://iptc.org/std/nar/2006-10-01/"
    xmlns:sportsml="http://iptc.org/std/SportsML/2008-04-01/"
    xmlns:functx="http://www.functx.com"
    xpath-default-namespace="http://iptc.org/std/nar/2006-10-01/"
    exclude-result-prefixes="iptc sportsml functx xs xts"
    version="2.0">
    <!-- Use this if your system support xslt 2. -->
    
    
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
            <xsl:when test="name() = 'sports-title'">
                <sportsTitle>
                    <name><full><xsl:value-of select="."/></full></name>
                </sportsTitle>
            </xsl:when>
            <xsl:when test="name() = 'name' and not(@*)" >
                <name><full><xsl:value-of select="."/></full></name>
            </xsl:when>
            <xsl:when test="name() = 'name' and @*">
                <name>
                    <xsl:apply-templates select="@* | node()"/>
                </name>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="elementName" select="functx:words-to-camel-case(replace(name(), '-', ' '))" />
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
                <xsl:variable name="elementName" select="tokenize(., ':')[last()]"/>
                <xsl:element name="{$elementName}">
                    <!--<xsl:apply-templates select="@* | node()"/>-->
                    <xsl:variable name="attributeValue" select="."/>
                    <xsl:value-of select="//name[@part=$attributeValue]"/>
                </xsl:element>
                </part>
            </xsl:when>
            <xsl:otherwise>
                <xsl:variable name="elementName" select="functx:words-to-camel-case(replace(name(), '-', ' '))" />
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


    <xsl:function name="functx:words-to-camel-case" as="xs:string"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="string-join((tokenize($arg,'\s+')[1], 
            for $word in tokenize($arg,'\s+')[position() > 1]
            return functx:capitalize-first($word))
            ,'')
            "/>
    </xsl:function>
    

    <xsl:function name="functx:capitalize-first" as="xs:string?"
        xmlns:functx="http://www.functx.com">
        <xsl:param name="arg" as="xs:string?"/>
        
        <xsl:sequence select="
            concat(upper-case(substring($arg,1,1)),
            substring($arg,2))
            "/>
    </xsl:function>
    
</xsl:stylesheet>