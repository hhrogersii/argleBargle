<cffunction name="PageInfo" returntype="struct" output="false">
<cfscript>
	return {
		  ttl = "Flexigrid-S"
		, dsc = "&hellip;extensions to the jQuery table plugin."
		, lay = "Lab"
	};
</cfscript>
</cffunction>

<cffunction name="PageHeader" access="public" output="true" returntype="void">
	<link type="text/css" rel="stylesheet" href="flexigrid.css" />
</cffunction>

<cffunction name="PageContent" returntype="void" output="true">
    <article>

        <header>
        	<div style="float:right">
				<a href="https://github.com/hhrogersii/argleBargle/tree/master/flexigrid-s/"><img id="octodex" src="/img/octodex.png" width="24" height="24" alt="Git'er Done" /></a> &larr;
				<a href="#request.url.base#">Flexigrid-S</a> &larr; 
				<a href="#request.url.root#/lab/">&gt;arg&iexcl;eBarg!e</a> &larr; 
				<a href="#request.url.root#/">hhROGERSii</a>
        	</div>
        	<h2>#request.Page.getTitle()#</h2>
        	<p>#request.Page.getDescription()#</p>
        </header>

		<section>
			
			<div class="section" style="position:relative">
				<h3>Flexigrid-S</h3>
				<table class="flex-vam"></table>
				<div class="small">Art data courtesy of <a href="http://www.vam.ac.uk/api/">Victoria &amp; Albert Museum</a> ReST interface.</div>
			</div>

		</section>

   		<footer>
			<p>
				<a href="https://github.com/hhrogersii/argleBargle/tree/master/flexigrid-s/"><img id="octodex" src="/img/octodex.png" width="24" height="24" alt="Git'er Done" /></a> &larr;
				<a href="#request.url.base#">Flexigrid-S</a> &larr; 
				<a href="#request.url.root#/lab/">&gt;arg&iexcl;eBarg!e</a> &larr; 
				<a href="#request.url.root#/">hhROGERSii</a>
			</p>
		</footer>

    </article>
</cffunction>

<cffunction name="PageFooter" access="public" returntype="void">
	<script src="flexigrid.js"></script>
	<script src="/js/jquery.xml2json.js"></script>
	<script src="fg-vam.js"></script>
</cffunction>
