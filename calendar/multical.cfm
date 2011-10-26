<cfif thisTag.ExecutionMode EQ "start">
<cfsilent>
<!--- 
NAME: <CF_MultiCal>
 --->
<cfsetting showdebugoutput="No">
<cfscript>
	param type='string' name='date' default=DateFormat(Now(),'m-d-yyyy'); //default for date being viewed
	param type='string' name='field' default='date'; //default for target form date element name
	param type='string' name='delim' default='/'; //default for target form date element name
	param type='string' name='path' default='img'; //
	
	imgURL = Replace(attributes.path,"/",application.sysBang);
	imgPath = ExpandPath(attributes.path);
	
	vDelim = attributes.delim;
	
	viewDate = ParseDateTime(attributes.date);
	viewMonth = Month(viewDate);
	viewDay = Day(viewDate);
	viewYear = Year(viewDate);
	viewDaysInMonth = DaysInMonth(CreateDate(viewYear,viewMonth,1));
	
	thisDay = 2 - DayOfWeek(CreateDate(viewYear,viewMonth,1));
	
	fmtDate = "m-d-yyyy";
</cfscript>

<cfif DirectoryExists(imgPath)>
	<cfif NOT FileExists("#imgPath#\exit.gif")>
		<cfset imgExit = "R0lGODlhDAAMAKL/ABIUGMDAwHuKpYyevWl3jnuLpSMoLwAAACH5BAEAAAEALAAAAAAMAAwAAAMyGFXRvkEYQ1wgU8hDG+bCZXDE13kjAJDWtR5A1RJvPKfrKZJmtZ0mzUSGMggGmlbkmAAAOwkAOw==">
		<cffile action="WRITE" file="#imgPath#\exit.gif" output="#toBinary(imgExit)#" addnewline="No">
	</cfif>
	<cfif NOT FileExists("#imgPath#\reset.gif")>
		<cfset imgReset = "R0lGODlhDAAMAKL/ABIUGHuKpVhjdsDAwGl3jiMoLwAAAAAAACH5BAEAAAMALAAAAAAMAAwAAAM1OBMEDiSoQYol9S4r5MpMIRTERJFAEZZKUDhsxVLwJCtN6p3Re9sikkvYGqlOlwxpwnhAPAkAOwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACwAAAAADgAOAAAGc0CPULj5fDrD4ePBuHAuFxBBshQ+HBzH8iGpcBgP4SQQAG+vgLCHUGGUz4+LQxiYMN9bh0UI2rrNDwkXfFsRbgtLDYMedQ8QChAMGQZXe2sVA2cHAghyYgEOdlsUDmlWDhoYBUtdX2pLTU9RU1VJHkVHtkEAOw==">
		<cffile action="WRITE" file="#imgPath#\reset.gif" output="#toBinary(imgReset)#" addnewline="No">
	</cfif>
</cfif>

</cfsilent>
<cfoutput>
<table id="miniCal" border="0" cellpadding="0" cellspacing="1">

	<tr align="center">
		<td class="titleCell" id="date_#DateFormat(Now(),fmtDate)#" title="now"><img src="#imgURL#/reset.gif" width="12" height="12" border="0" alt="Now" title="Go to today."></td>
		<td colspan="7" class="titleCell" nowrap>#DateFormat(viewDate,"mmm - yyyy")#</td>
		<td class="titleCell" onclick="parent.dspCalendar(false);" title="exit"><img src="#imgURL#/exit.gif" width="12" height="12" border="0" alt="Exit" title="Close window."></td>
	</tr>
	
	<tr align="center" class="week">
		<td class="goCell" id="date_#DateFormat(DateAdd('m',-1,viewDate),fmtDate)#" title="previous month">&laquo;</td>
		<td>S</td>
		<td>M</td>
		<td>T</td>
		<td>W</td>
		<td>T</td>
		<td>F</td>
		<td>S</td>
		<td class="goCell" id="date_#DateFormat(DateAdd('m',1,viewDate),fmtDate)#" title="next month">&raquo;</td>
	</tr>
	
	<cfloop from="1" to="6" index="iMonth">
	<tr align="center">
		<cfset navClass = "navCell" & RepeatString( 'Sel',(iMonth IS viewMonth)+0)>
		<td class="#navClass#" id="date_#iMonth#-#viewDay#-#viewYear#" title="#MonthAsString(iMonth)#">#Left(MonthAsString(iMonth),1)#</td>
		<cfloop from="1" to="7" index="weekDay">
			<cfif thisDay GT 0 AND thisDay LTE viewDaysInMonth>

				<cfif thisDay EQ viewDay>
					<cfset thisClass = "selDay">
				<cfelseif viewDate EQ Now()>
					<cfset thisClass = "toDay">
				<cfelseif weekDay % 6 IS 1>
					<cfset thisClass = "weekEnd">
				<cfelse>
					<cfset thisClass = "weekDay">
				</cfif>

		<td class="dateCell #thisClass#" id="date_#viewMonth##vDelim##thisDay##vDelim##viewYear#">#thisDay#</td>
			<cfelse>
		<td class="noDay">&nbsp;</td>
			</cfif>
			<cfset thisDay += 1>
		</cfloop>
		<cfset iMonth = 13 - iMonth>
		<cfset navClass = "navCell" & RepeatString( 'Sel',NumberFormat(iMonth IS viewMonth))>
		<td class="#navClass#" id="date_#iMonth#-#viewDay#-#viewYear#" title="#MonthAsString(iMonth)#">#Left(MonthAsString(iMonth),1)#</td>
	</tr>
	</cfloop>
	
	<tr align="center">
	<cfset viewDate = DateAdd('yyyy',-1,viewDate)>
		<td class="goCell"  id="date_#DateFormat(viewDate,fmtDate)#" title="previous year">&laquo;</td>
	<cfset viewDate = DateAdd('yyyy',-2,viewDate)>
		<td class="navCell" id="date_#DateFormat(viewDate,fmtDate)#" title="#Year(viewDate)#">#DateFormat(viewDate,"yy")#</td>
	<cfset viewDate = DateAdd('yyyy',1,viewDate)>
		<td class="navCell" id="date_#DateFormat(viewDate,fmtDate)#" title="#Year(viewDate)#">#DateFormat(viewDate,"yy")#</td>
	<cfset viewDate = DateAdd('yyyy',1,viewDate)>
		<td class="navCell" id="date_#DateFormat(viewDate,fmtDate)#" title="#Year(viewDate)#">#DateFormat(viewDate,"yy")#</td>
	<cfset viewDate = DateAdd('yyyy',1,viewDate)>
		<td class="navCellSel" id="date_#DateFormat(viewDate,"yy")#" title="#Year(viewDate)#">#DateFormat(viewDate,'yy')#</td>
	<cfset viewDate = DateAdd('yyyy',1,viewDate)>
		<td class="navCell" id="date_#DateFormat(viewDate,fmtDate)#" title="#Year(viewDate)#">#DateFormat(viewDate,"yy")#</td>
	<cfset viewDate = DateAdd('yyyy',1,viewDate)>
		<td class="navCell" id="date_#DateFormat(viewDate,fmtDate)#" title="#Year(viewDate)#">#DateFormat(viewDate,"yy")#</td>
	<cfset viewDate = DateAdd('yyyy',1,viewDate)>
		<td class="navCell" id="date_#DateFormat(viewDate,fmtDate)#" title="#Year(viewDate)#">#DateFormat(viewDate,"yy")#</td>
	<cfset viewDate = DateAdd('yyyy',-2,viewDate)>
		<td class="goCell"  id="date_#DateFormat(viewDate,fmtDate)#" title="next year">&raquo;</td>
	</tr>
	
</table>
</cfoutput>
</cfif>