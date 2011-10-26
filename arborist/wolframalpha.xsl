<?xml version="1.0" encoding="UTF-8"?><!-- DWXMLSource="../Untitled-2.xml" --><!DOCTYPE xsl:stylesheet  [
	<!ENTITY nbsp   "&#160;">
	<!ENTITY copy   "&#169;">
	<!ENTITY reg    "&#174;">
	<!ENTITY trade  "&#8482;">
	<!ENTITY mdash  "&#8212;">
	<!ENTITY ldquo  "&#8220;">
	<!ENTITY rdquo  "&#8221;"> 
	<!ENTITY pound  "&#163;">
	<!ENTITY yen    "&#165;">
	<!ENTITY euro   "&#8364;">
]>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"/>
<xsl:template match="/">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>WolframAlpha</title>
<link href="wa-calculate.css" rel="stylesheet" type="text/css" />
</head>
<body>
<h1><xsl:value-of select="queryresult/@datatypes"/></h1>
<xsl:if test="queryresult/warningsmarkup !=''">
<p><span  class="warning"><xsl:value-of select="queryresult/warningsmarkup" disable-output-escaping="yes"/></span></p>
</xsl:if>
<p>	
	<xsl:for-each select="queryresult/pod">
		<xsl:value-of select="markup" disable-output-escaping="yes"/>
	</xsl:for-each>
</p>
<script type="text/javascript">parent.$('#info').css('visibility','visible');</script>
<!--[if lte IE 8]>
<link rel='stylesheet' type='text/css' media='screen' href='http://www4b.wolframalpha.com/Calculate/css/ie.css' />
<![endif]-->
<!--[if lte IE 6]>
<style type="text/css">
body {behavior: url(http://www4b.wolframalpha.com/Calculate/javascript/csshover.htc);}
</style>
<![endif]-->
</body>
</html>

</xsl:template>
</xsl:stylesheet>