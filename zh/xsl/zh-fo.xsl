<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:ng="http://docbook.org/docbook-ng"
                xmlns:db="http://docbook.org/ns/docbook"
                xmlns:math="http://exslt.org/math"
                exclude-result-prefixes="db ng exsl"
                version='1.0'>

<!-- Importing the base stylesheet. -->
<xsl:import href="../../xsl/general-fo-customization.xsl"/>

<xsl:attribute-set name="normal.para.spacing">
  <xsl:attribute name="space-before.optimum">.5em</xsl:attribute>
  <xsl:attribute name="space-before.minimum">.3em</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="para.properties" use-attribute-sets="normal.para.spacing">
  <xsl:attribute name="text-indent">2.em</xsl:attribute>
  <xsl:attribute name="linefeed-treatment">treat-as-zero-width-space</xsl:attribute>
  <xsl:attribute name="white-space-collapse">true</xsl:attribute>
</xsl:attribute-set>

<xsl:param name="line-height">1.5</xsl:param>

<xsl:param name="menuchoice.menu.separator">→</xsl:param>


<xsl:template match="guimenu|guisubmenu|guimenuitem|guilabel">
  <xsl:call-template name="inline.italicseq">
    <xsl:with-param name="content">&#x3014;<xsl:value-of select="." />&#x3015;</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="accountname">
  <xsl:call-template name="inline.italicseq">
    <xsl:with-param name="content">&#8220;<xsl:value-of select="." />&#8221;</xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="keycap">
  <xsl:choose>
    <xsl:when test="@function and normalize-space(.) = ''">
      <xsl:call-template name="inline.monoseq">
        <xsl:with-param name="content">
          <xsl:text>&#x3008;</xsl:text>
          <xsl:call-template name="gentext.template">
            <xsl:with-param name="context" select="'keycap'"/>
            <xsl:with-param name="name" select="@function"/>
          </xsl:call-template>
          <xsl:text>&#x3009;</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      &#x3008;<xsl:call-template name="inline.monoseq"/>&#x3009;
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="filename">
  "<xsl:apply-imports />"
</xsl:template>

<xsl:template match="//listitem/para[1]">
  <xsl:call-template name="block.object">
    <xsl:with-param name="content"><xsl:apply-templates/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="emohasis">
  <xsl:choose>
    <xsl:when test="@role = ''">
      <xsl:call-template name="inline.boldseq"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-imports />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="imagedata[@autoscale-screenshot='1']">
  <xsl:variable name="postprocess">
    <fragment>
      <imagedata>
        <xsl:copy-of select="@*"/>
        <xsl:if test="@contentwidth">
          <xsl:attribute name="contentwidth">
            <xsl:variable name="bestwidth"><xsl:value-of select="number(substring-before(@contentwidth, 'in'))*0.7" /></xsl:variable>
            <xsl:choose>
              <xsl:when test="$bestwidth > 5.8"><xsl:value-of select="'5.8in'" /></xsl:when>
              <xsl:otherwise><xsl:value-of select="concat(string($bestwidth),'in')" /></xsl:otherwise>
            </xsl:choose>
          </xsl:attribute>
        </xsl:if>
      </imagedata>
    </fragment>
  </xsl:variable>
  <xsl:apply-templates select="exsl:node-set($postprocess)/*[1]"/>
</xsl:template>

<xsl:template match="fragment">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="fragment/imagedata">
  <xsl:apply-imports />
</xsl:template>

</xsl:stylesheet>
