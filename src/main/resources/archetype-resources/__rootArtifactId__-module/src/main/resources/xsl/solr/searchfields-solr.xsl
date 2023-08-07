<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:import href="xslImport:solr-document-3:solr/searchfields-solr.xsl" />

  <xsl:template match="mycoreobject">
    <xsl:apply-imports />

    <field name="${rootArtifactId}.hasFiles">
      <xsl:value-of select="count(structure/derobjects/derobject)&gt;0" />
    </field>
    <field name="${rootArtifactId}.title">
      <xsl:value-of select="metadata/def.title/title" />
    </field>
  </xsl:template>

</xsl:stylesheet>