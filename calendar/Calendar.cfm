<cfsilent><cfsetting showdebugoutput="No">
<cfscript>
	if ( IsDefined("url.date") AND Compare(url.date,"") AND IsDate(url.date) )
	{
		request.Date = DateFormat(url.date,"m-d-yyyy");
	}
	param type='string' name='request.Date' default=DateFormat(Now(),"m-d-yyyy");

	if ( IsDefined("url.field") )
	{
		request.Field = url.field;
	}
	param type='string' name='request.Field' default='date_field';
	
	param type='string' name='request.Width' default='18';
</cfscript>
</cfsilent>

<!doctype html>
<html>

<head>
	<meta charset="utf-8" />
	<title>&gt;arg!eBarg!e: Pop-up Calendar</title>
	<meta name="description" content="&hellip;a multi-modal date selector." />
	<meta name="author" content="Henry Harper Rogers II" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<!-- Adding "maximum-scale=1" fixes the Mobile Safari auto-zoom bug: http://filamentgroup.com/examples/iosScaleBug/ -->
	<link rel="stylesheet" href="Calendar.css" type="text/css">
</head>

<body class="calendar">

<cfif IsDate(request.Date)>

	<cfmodule 
		template="multical.cfm" 
		path="."
		date="#request.Date#"
		field="#request.Field#"
		delim="/">

	<!--Thank you jQuery -->
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>!window.jQuery && document.write(unescape('%3Cscript src="/js/libs/jquery-1.5.1.min.js"%3E%3C/script%3E'))</script>
	<script src="/js/CGI.js"></script>
	<script src="Calendar.js"></script>
	<script>
		CGI.init();
		calendar('<cfoutput>#request.Field#</cfoutput>');
		parent.dspCalendar(true);
	</script>
	
<cfelseif IsDefined("url.date") AND Compare(url.date,"")>

	<p style="padding:4px 4px 4px 4px;">Text entered is not a date.<br />
	<a href="#" onclick="parent.calendar.style.visibility='hidden';return false;">Close Window</a></p>
	
</cfif>

</body>

</html>
