<cfsilent>

	<!--- List of images to include in slideshow --->
	<cfset lstImage =
		"blue-fish.jpg
		,coral-reef.jpg
		,sea-turtle.jpg">
	<!--- path to output slideshow html file --->
	<cfset pthFile = "/lab/slideshow/">
	<!--- stand-alone slideshow file name --->
	<cfset sasName = pthFile & "SAS_tinyfader.html">
	<!--- path to images --->
	<cfset pthImage = pthFile & "tinyfader/photos/">
	<cfset imgWidth = "500">
	<cfset imgHeight = "300">
	<!--- left and right navigation images --->
	<cffile action="readbinary" variable="left" file="#ExpandPath('/lab/slideshow/tinyfader/images/left.gif')#">
	<cffile action="readbinary" variable="right" file="#ExpandPath('/lab/slideshow/tinyfader/images/right.gif')#">

</cfsilent>
<cfsavecontent variable="sas">
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>TinyFader Standalone Slideshow Demo</title>
<!-- Tiny Fader CSS -->
<style type="text/css">
	* {margin:0; padding:0}
	body {font:12px Verdana,Arial; color:#555; background-color:#222}
	p {line-height:1.4; margin-bottom:12px}
	#wrapper {width:<cfoutput>#(imgWidth+78)#</cfoutput>px; margin:10px auto}
	.sliderbutton {float:left; width:32px; padding-top:96px}
	.sliderbutton img {cursor:pointer}
	.sliderbutton img:hover {background:#666}
	#slideshow {float:left; width:<cfoutput>#imgWidth#</cfoutput>px; height:<cfoutput>#imgHeight#</cfoutput>px; border:2px solid #fff; background:#fff}
	#slides {position:relative; width:<cfoutput>#imgWidth#</cfoutput>px; height:<cfoutput>#imgHeight#</cfoutput>px; list-style:none; overflow:auto}
	#slides li {width:<cfoutput>#imgWidth#</cfoutput>px; height:<cfoutput>#imgHeight#</cfoutput>px}
	.pagination {float:left; list-style:none; height:25px; margin:15px 0 0 32px}
	.pagination li {float:left; cursor:pointer; padding:5px 8px; background:#666; border:1px solid #999; margin:0 4px 0 0; text-align:center; color:#222}
	.pagination li:hover {background:#777; border:1px solid #bbb; color:#000}
	li.current {border:1px solid #ccc; background:#888}
	li#content {width:<cfoutput>#(imgWidth-36)#</cfoutput>px; height:<cfoutput>#(imgHeight-30)#</cfoutput>px; padding:15px 18px 15px 18px; background:#fff}
	#content h1 {font:22px Georgia,Verdana; margin-bottom:15px; color:#036}
</style>
<!-- TinyFader JavaScript -->
<script type="text/javascript">
	var TINY={};function T$(i){return document.getElementById(i)}function T$$(e,p){return p.getElementsByTagName(e)}TINY.fader=function(){function fade(n,p){this.n=n;this.init(p)}fade.prototype.init=function(p){var s=T$(p.id),u=this.u=T$$('li',s),l=u.length,i=this.l=this.c=this.z=0;if(p.navid&&p.activeclass){this.g=T$$('li',T$(p.navid));this.s=p.activeclass}s.style.overflow='hidden';this.a=p.auto||0;this.p=p.resume||0;for(i;i<l;i++){if(u[i].parentNode==s){u[i].style.position='absolute';this.l++;u[i].o=p.visible?100:0;u[i].style.opacity=u[i].o/100;u[i].style.filter='alpha(opacity='+u[i].o+')'}}this.pos(p.position||0,this.a?1:0,p.visible)},fade.prototype.auto=function(){this.u.ai=setInterval(new Function(this.n+'.move(1,1)'),this.a*1000)},fade.prototype.move=function(d,a){var n=this.c+d,i=d==1?n==this.l?0:n:n<0?this.l-1:n;this.pos(i,a)},fade.prototype.pos=function(i,a,v){var p=this.u[i];this.z++;p.style.zIndex=this.z;clearInterval(p.si);clearInterval(this.u.ai);this.u.ai=0;this.c=i;if(p.o>=100&&!v){p.o=0;p.style.opacity=0;p.style.filter='alpha(opacity=0)'}if(this.g){for(var x=0;x<this.l;x++){this.g[x].className=x==i?this.s:''}}p.si=setInterval(new Function(this.n+'.fade('+i+','+a+')'),20)},fade.prototype.fade=function(i,a){var p=this.u[i];if(p.o>=100){clearInterval(p.si);if((a||(this.a&&this.p))&&!this.u.ai){this.auto()}}else{p.o+=5;p.style.opacity=p.o/100;p.style.filter='alpha(opacity='+p.o+')'}};return{fade:fade}}();
</script>
</head>
<body>
<div id="wrapper">
	<div>
		<!--- left navigation icon --->
		<div class="sliderbutton"><img src="data:image/gif;base64,<cfoutput>#BinaryEncode(left,'Base64')#</cfoutput>" width="32" height="24" alt="Previous" onclick="slideshow.move(-1)" /></div>
		<div id="slideshow">
			<ul id="slides">
				<li id="content">
					<h1>TinyFader - Simple JavaScript Slideshow</h1>
					<p>This super lightweight (1.3 KB) fading JavaScript slideshow script can easily be customized to integrate with any website through CSS. You can add any content to it, not just images, and it gracefully degrades without JavaScript support. The script supports automatic rotation with the option to auto-resume and an active class on a navigation list if applicable.</p>
					<p><em>For complete details visit <a href="http://www.leigeber.com/">leigeber.com</a>.</em></p>
				</li>
<!--- loop through images list and encode into Base64 --->
<cfloop list="#lstImage#" index="iMage">
<cffile action="readbinary" variable="slide" file="#ExpandPath(pthImage&Trim(iMage))#">
<cfoutput><li><img src="data:image/jpg;base64,#BinaryEncode(slide,'Base64')#"></li></cfoutput>
</cfloop>
			</ul>
		</div>
		<!--- right navigation icon --->
		<div class="sliderbutton"><img src="data:image/gif;base64,<cfoutput>#BinaryEncode(right,'Base64')#</cfoutput>" width="32" height="24" alt="Next" onclick="slideshow.move(1)" /></div>
	</div>
	<ul id="pagination" class="pagination">
<cfloop from="0" to="#ListLen(lstImage)#" index="i">
<cfoutput><li onclick="slideshow.pos(#i#)">#(i+1)#</li></cfoutput>
</cfloop>
	</ul>
</div>
<!--- TinyFader init --->
<script type="text/javascript">
	var slideshow=new TINY.fader.fade('slideshow',{
		id:'slides',
		auto:5,
		resume:false,
		navid:'pagination',
		activeclass:'current',
		visible:true,
		position:0
	});
</script>
</body>
</html>
</cfsavecontent>
<cffile action="write" file="#ExpandPath(sasName)#" output="#sas#">
<cfoutput>#sas#</cfoutput>