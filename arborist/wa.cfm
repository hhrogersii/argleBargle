<cfsetting enableCFoutputOnly="Yes">
<cfflush>

<cfparam name="url.input" default="">
<cfparam name="form.input" default="#url.input#">

<cfif Compare(form.input,"")>

	<cfhttp url="http://api.wolframalpha.com/v2/query?input=#URLEncodedFormat(form.input)#&appid=GX7YKA-XH97X4JUAG&format=html">
	<cfset xmlData = cfhttp.filecontent>
	<cfset xslFile = "wolframalpha.xsl">

	<cfoutput>
#XmlTransform(
	xmlData,
	xslFile
)#
	</cfoutput>

</cfif>
