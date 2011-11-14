<cffunction name="PageInfo" returntype="struct" output="false">
<cfscript>
	return {
		  ttl = "JavaScript Arborist"
		, dsc = "&hellip;methods for managing tree structures."
		, lay = "Lab"
	};
</cfscript>
</cffunction>

<cffunction name="PageHeader" access="public" output="true" returntype="void">
	<link type="text/css" rel="stylesheet" href="Tree.css"/>
	<link type="text/css" rel="stylesheet" href="/js/jquery-ui-1.8.16.custom/css/smoothness/jquery-ui-1.8.16.custom.css"/>
</cffunction>

<cffunction name="PageContent" returntype="void" output="true">
	<cfsilent>	
		<cfset var Tree = CreateObject( "Component", "Tree" )>
		<cffile action="read" file="#ExpandPath('/lab/arborist/tree.js')#" variable="request.js">
		<cffile action="read" file="#ExpandPath('/lab/arborist/tree.cfm')#" variable="request.cf">
		<cffile action="read" file="#ExpandPath('/lab/arborist/tree.cfc')#" variable="request.cfc">
		<cffile action="read" file="#ExpandPath('/lab/arborist/tree.css')#" variable="request.css">
		<cffile action="read" file="#ExpandPath('/lab/arborist/wa.cfm')#" variable="request.rest">
		<cffile action="read" file="#ExpandPath('/lab/arborist/wolframalpha.xsl')#" variable="request.xsl">
	</cfsilent>
    <article>

        <header>
        	<h2>#request.Page.getTitle()#</h2>
        	<p>#request.Page.getDescription()#</p>
        </header>

		<section>
			<div class="section" style="position:relative">

				<h3>Pine Tree Classification</h3>

				<div id="tree">
					<div id="menu">
						<span id="expandAll" class="menu">Expand All</span> 
						<span id="collapseAll" class="menu">Collapse All</span> 
						<span id="resetAll" class="menu">Reset</span>
					</div>
					<dl id="dl_0_tree" class="tree">
#Tree.OutputNode(Tree.GetPineTrees(),0)#
					</dl>
				</div>

				<div id="wa">
<iframe name="wa-details" id="info" height="200" width="500" src="##" style="float:right;height:100%"></iframe>
				</div>

				<hr style="clear:left">
				<span>Hierarchy and species details retrieved via <a href="http://tolweb.org/">Tree of Life Web Project</a> ReST interface.</span>

			</div>

			<div id="tabs" class="section">
				<ul>
					<li><a href="##tabs-1">Javascript</a></li>
					<li><a href="##tabs-2">ColdFusion</a></li>
					<li><a href="##tabs-3">Component</a></li>
					<li><a href="##tabs-4">CSS</a></li>
					<li><a href="##tabs-5">ReST</a></li>
					<li><a href="##tabs-6">XSL</a></li>
				</ul>
				<div id="tabs-1">
<pre class="brush: js; ruler:false; toolbar:true;">#request.js#</pre>
				</div>
				<div id="tabs-2">
<pre class="brush: html; ruler:false; toolbar:true;">#HTMLEditFormat( request.cf )#</pre>
				</div>
				<div id="tabs-3">
<pre class="brush: coldfusion; ruler:false; toolbar:true;">#HTMLEditFormat( request.cfc )#</pre>
				</div>
				<div id="tabs-4">
<pre class="brush: css; ruler:false; toolbar:true;">#HTMLEditFormat( request.css )#</pre>
				</div>
				<div id="tabs-5">
<pre class="brush: coldfusion; ruler:false; toolbar:true;">#HTMLEditFormat( request.rest )#</pre>
				</div>
				<div id="tabs-6">
<pre class="brush: xml; ruler:false; toolbar:true;">#HTMLEditFormat( request.xsl )#</pre>
				</div>
			</div>

		</section>

   		<footer>
			<p>
				<a href="https://github.com/hhrogersii/argleBargle/tree/master/arborist"><img id="octodex" src="/img/octodex.png" width="24" height="24" alt="Git'er Done" /></a> &larr;
				<a href="#request.url.base#">Arborist</a> &larr; 
				<a href="#request.url.root#lab/">arg!eBarg!e</a> &larr; 
				<a href="#request.url.root#">hhROGERSii</a>
			</p>
		</footer>

    </article>
</cffunction>

<cffunction name="PageFooter" access="public" returntype="void">
	<script src="Tree.js"></script>
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
