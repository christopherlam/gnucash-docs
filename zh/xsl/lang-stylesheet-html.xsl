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
<xsl:import href="../../xsl/general-customization.xsl"/>


<xsl:template match="imagedata[@autoscale-screenshot='1']">
  <xsl:variable name="postprocess">
    <fragment>
      <imagedata>
        <xsl:copy-of select="@*"/>
        <xsl:if test="@contentwidth">
          <xsl:attribute name="contentwidth">
            <xsl:variable name="bestwidth"><xsl:value-of select="number(substring-before(@contentwidth, 'in'))*0.8" /></xsl:variable>
            <xsl:value-of select="concat(string($bestwidth),'in')" />
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
