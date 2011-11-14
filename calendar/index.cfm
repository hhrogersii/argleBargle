<cffunction name="PageInfo" returntype="struct" output="false">
<cfscript>
	return {
		  ttl = "Pop-up Calendar"
		, dsc = "a simple pop-up calendar for fast date finding."
		, lay = "Lab"
	};
</cfscript>
</cffunction>

<cffunction name="PageHeader" access="public" output="true" returntype="void">
	<link type="text/css" rel="stylesheet" href="Calendar.css"/>
	<link type="text/css" rel="stylesheet" href="/js/jquery-ui-1.8.16.custom/css/smoothness/jquery-ui-1.8.16.custom.css"/>
</cffunction>

<cffunction name="PageContent" returntype="void" output="true">
	<cfsilent>	
		<!--- <cfset var Tree = CreateObject( "Component", "Tree" )> --->
		<cffile action="read" file="#ExpandPath('/lab/calendar/Calendar.js')#" variable="request.js">
		<cffile action="read" file="#ExpandPath('/lab/calendar/Calendar.cfm')#" variable="request.cf">
		<cffile action="read" file="#ExpandPath('/lab/calendar/Calendar.css')#" variable="request.css">
		<cffile action="read" file="#ExpandPath('/lab/calendar/multical.cfm')#" variable="request.ct">
		<cffile action="read" file="#ExpandPath('/js/CGI.js')#" variable="request.cgi">
	</cfsilent>
    <article>

        <header>
        	<h2>#request.Page.getTitle()#</h2>
        	<p>#request.Page.getDescription()#</p>
        </header>

		<section>
			<div class="section" style="position:relative;height:200px">

<form method="get">
	<i>Date:</i>
	<input type="text" name="date" id="date_field" size="20" value="#DateFormat(Now(),'m/d/yyyy')#" class="inputtext" /> &nbsp;
	<a href="##" id="link_cal_date_field" class="link_cal">Calendar</a>
</form>

<iframe src="" name="calendarFrame" id="calendarFrame" width="172" height="172" frameborder="0" style="visibility:hidden;position:absolute;border:1px solid black;"></iframe>

			</div>

			<div id="tabs" class="section">
				<ul>
					<li><a href="##tabs-1">Javascript</a></li>
					<li><a href="##tabs-2">ColdFusion</a></li>
					<li><a href="##tabs-3">CSS</a></li>
					<li><a href="##tabs-4">CustomTag</a></li>
					<li><a href="##tabs-5">CGI</a></li>
				</ul>
				<div id="tabs-1">
<pre class="brush: js; ruler:false; toolbar:true;">#request.js#</pre>
				</div>
				<div id="tabs-2">
<pre class="brush: html; ruler:false; toolbar:true;">#HTMLEditFormat( request.cf )#</pre>
				</div>
				<div id="tabs-3">
<pre class="brush: css; ruler:false; toolbar:true;">#HTMLEditFormat( request.css )#</pre>
				</div>
				<div id="tabs-4">
<pre class="brush: coldfusion; ruler:false; toolbar:true;">#HTMLEditFormat( request.ct )#</pre>
				</div>
				<div id="tabs-5">
<pre class="brush: js; ruler:false; toolbar:true;">#HTMLEditFormat( request.cgi )#</pre>
				</div>
			</div>

		</section>

   		<footer>
			<p>
				<a href="https://github.com/hhrogersii/argleBargle/tree/master/calendar"><img src="/img/octodex.png" width="24" height="24" alt="Git'er Done" class="githubicon" /></a> &larr; 
				<a href="#request.url.base#">Calendar</a> &larr; 
				<a href="#request.url.root#lab/">arg!eBarg!e</a> &larr; 
				<a href="#request.url.root#">hhROGERSii</a>
			</p>
		</footer>

    </article>
</cffunction>

<cffunction name="PageFooter" access="public" returntype="void">
	<script src="Calendar.js"></script>
	<script src="/js/jquery-ui-1.8.16.custom/js/jquery-ui-1.8.16.custom.min.js"></script>
	<script>
		$('#tabs').tabs();
		$('#dialog_link, ul#icons li').hover(
			function(){
				$(this).addClass('ui-state-hover');
			}, 
			function(){
				$(this).removeClass('ui-state-hover');
			}
		);
	</script>
</cffunction>
