<cffunction name="PageInfo" returntype="struct" output="false">
<cfscript>
	return {
		  ttl = "jRoulette"
		, dsc = "&hellip;a continuous image carousel."
		, lay = "Lab"
	};
</cfscript>
</cffunction>

<cffunction name="PageHeader" access="public" output="true" returntype="void">
	<link type="text/css" rel="stylesheet" href="jroulette.css" />
	<link type="text/css" rel="stylesheet" href="/js/jquery-ui-1.8.16.custom/css/smoothness/jquery-ui-1.8.16.custom.css"/>	
</cffunction>

<cffunction name="PageContent" returntype="void" output="true">
	<cfsilent>	
		<cffile action="read" file="#ExpandPath('/lab/jroulette/jroulette.htm')#" variable="request.htm">
		<cffile action="read" file="#ExpandPath('/lab/jroulette/jroulette.js')#" variable="request.js">
		<cffile action="read" file="#ExpandPath('/lab/jroulette/jroulette.css')#" variable="request.css">
	</cfsilent>
    <article>

        <header>
			<div style="float:right">
				<a href="https://github.com/hhrogersii/argleBargle/tree/master/jroulette/"><img id="octodex" src="/img/octodex.png" width="24" height="24" alt="Git'er Done" /></a> &larr;
				<a href="#request.url.base#">jRoulette</a> &larr; 
				<a href="#request.url.root#/lab/">&gt;arg&iexcl;eBarg!e</a> &larr; 
				<a href="#request.url.root#/">hhROGERSii</a>
			</div>
        	<h2>#request.Page.getTitle()#</h2>
        	<p>#request.Page.getDescription()#</p>
        </header>

		<section>
			<div class="section" style="position:relative">
				<h3>Paul Klee</h3>

<div class="jroulette">
	<div class="roul-touchmargin">
		<div class="roul-bump-left"></div>
		<div class="roul-wrap">
			<div class="roul-boxy">
				<div class="roul-slds" id="slide-0" style="left:0px">
					<img src="klee_1914.jpg" alt="1914" width="300" height="360" />
				</div>
				<div class="roul-slds" id="slide-1" style="left:640px">
					<img src="klee_ancient-sound.jpg" alt="Ancient Sound" width="348" height="360" />
				</div>
				<div class="roul-slds" id="slide-2" style="left:1280px">
					<img src="klee_captive.jpg" alt="Captive" width="321" height="360" />
				</div>	
				<div class="roul-slds" id="slide-3" style="left:1920px">
					<img src="klee_dream-city.jpg" alt="Dream City" width="232" height="360" />
				</div>
				<div class="roul-slds" id="slide-4" style="left:2560px">
					<img src="klee_embrace.jpg" alt="Embrace" width="448" height="360" />
				</div>
				<div class="roul-slds" id="slide-5" style="left:3200px">
					<img src="klee_highway-byways.jpg" alt="Highway Byways" width="285" height="360" />
				</div>
				<div class="roul-slds" id="slide-6" style="left:3840px">
					<img src="klee_park-idols.jpg" alt="Park Idols" width="225" height="360" />
				</div>
				<div class="roul-slds" id="slide-7" style="left:4480px">
					<img src="klee_parnassum.jpg" alt="Parnassum" width="458" height="360" />
				</div>
				<div class="roul-slds" id="slide-8" style="left:4480px">
					<img src="klee_tunisian-gardens.jpg" alt="Tunisian Gardens" width="273" height="360" />
				</div>
				<div class="roul-slds" id="slide-9" style="left:4480px">
					<img src="paul_klee_artist.jpg" alt="Paul Klee the artist" width="485" height="360" />
				</div>
			</div>
		</div>
		<div class="roul-bump-right"></div>
	</div>
	<div class="roul-page">
		<ul>
			<li id="page-0"><a href="##page-0"></a></li>
			<li id="page-1"><a href="##page-1"></a></li>
			<li id="page-2"><a href="##page-2"></a></li>
			<li id="page-3"><a href="##page-3"></a></li>
			<li id="page-4"><a href="##page-4"></a></li>
			<li id="page-5"><a href="##page-5"></a></li>
			<li id="page-6"><a href="##page-6"></a></li>
			<li id="page-7"><a href="##page-7"></a></li>
			<li id="page-8"><a href="##page-8"></a></li>
			<li id="page-9"><a href="##page-9"></a></li>
		</ul>
	</div>
</div>
			</div>

			<div id="tabs" class="section">
				<ul>
					<li><a href="##tabs-1">HTML</a></li>
					<li><a href="##tabs-2">Javascript</a></li>
					<li><a href="##tabs-3">CSS</a></li>
				</ul>
				<div id="tabs-1">
<pre class="brush: html; ruler:false; toolbar:true;">#HTMLEditFormat( request.htm )#</pre>
				</div>
				<div id="tabs-2">
<pre class="brush: js; ruler:false; toolbar:true;">#request.js#</pre>
				</div>
				<div id="tabs-3">
<pre class="brush: css; ruler:false; toolbar:true;">#HTMLEditFormat( request.css )#</pre>
				</div>
			</div>

		</section>

   		<footer>
			<p>
				<a href="https://github.com/hhrogersii/argleBargle/tree/master/jroulette/"><img id="octodex" src="/img/octodex.png" width="24" height="24" alt="Git'er Done" /></a> &larr;
				<a href="#request.url.base#">jRoulette</a> &larr; 
				<a href="#request.url.root#/lab/">&gt;arg&iexcl;eBarg!e</a> &larr; 
				<a href="#request.url.root#/">hhROGERSii</a>
			</p>
		</footer>

    </article>
</cffunction>

<cffunction name="PageFooter" access="public" returntype="void">
	<script src="/js/jquery-ui-1.8.16.custom/js/jquery-ui-1.8.16.custom.min.js"></script>
	<script type="text/javascript" src="/js/jroulette.js"></script>
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
		$(document).ready(
			function(){
				$('.roul-touchmargin').jRoulette(
					{ desktopMode:'touchMargin', mobileMode:'touchMargin' }
				);
			}
		);
	</script>
</cffunction>
