<cfset var Tree = CreateObject( "Component", "Tree" )>

<!doctype html>
<html>

<head>
	<meta charset="utf-8" />
	<title>&gt;arg!eBarg!e: JavaScript Arborist</title>
	<meta name="description" content="&hellip;methods for managing tree structures." />
	<meta name="author" content="Henry Harper Rogers II" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<!--[if lt IE 9]>
		<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->
	<!-- Adding "maximum-scale=1" fixes the Mobile Safari auto-zoom bug: http://filamentgroup.com/examples/iosScaleBug/ -->
	<link rel="stylesheet" type="text/css" href="Tree.css" />
</head>

<body lang="en">

	<div id="header-container" class="wrapper lab">
    	<header>
			<h1>&gt;arg!eBarg!e:</h1>
			<span>&hellip;such as an argument, often a worthless, but energetic, conversation or comment.</span>
		</header>
	</div>

	<div id="main" class="wrapper lab" role="main">
    <article>

        <header>
        	<h2>JavaScript Arborist</h2>
        	<p>&hellip;methods for managing tree structures.</p>
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
<cfoutput>#Tree.OutputNode( Tree.GetPineTrees(), 0 )#</cfoutput>
					</dl>
				</div>

				<div id="wa">
<iframe name="wa-details" id="info" height="200" width="500" src="#" style="float:right;height:100%"></iframe>
				</div>

				<hr style="clear:left">
				<span>Hierarchy and species details retrieved via <a href="http://tolweb.org/">Tree of Life Web Project</a> ReST interface.</span>

			</div>
		</section>

   		<footer>
			<p>
				<a href="https://hhrogersii@github.com/hhrogersii/js-namespaces.git">0.9</a> &larr; <cfoutput>
	 			<a href="http://hhrogersii.com/lab/arborist/">Arborist</a> &larr; 
				<a href="http://hhrogersii.com/lab/">arg!eBarg!e</a> &larr; 
				<a href="http://hhrogersii.com/">hhROGERSii</a></cfoutput>
			</p>
		</footer>

    </article>

	</div>

	<div id="footer-container" class="wrapper lab">
		<footer>
			<p>All code authored by hhrogersii is available for use with or without attribution under the <a href="http://www.opensource.org/licenses/mit-license.php">MIT license</a>.
			<br />See disclaimers provided by the authors of code included in this site for the terms and conditions of the use of their work.</p>
		</footer>
	</div>

	<!--Thank you jQuery -->
	<script src="http://code.jquery.com/jquery-latest.js"></script>
	<script>!window.jQuery && document.write(unescape('%3Cscript src="/js/libs/jquery-1.5.1.min.js"%3E%3C/script%3E'))</script>
	<script type="text/javascript" src="Tree.js"></script>
	<script>$(window).load(main);</script>
	
</body>

</html>
