<cfcomponent displayname="Arborist Methods" output="false" hint="Methods for displaying a nested tree structure based on an XML document.">

<cffunction name="GetPineTrees">
	<cfif NOT IsDefined("SESSION.treeCache.pines") OR SESSION.treeCache.ttl LTE Now()>
		<cfhttp url="http://tolweb.org/onlinecontributors/app?service=external&page=xml/TreeStructureService&node_id=21626"  />
		<cflock name="_pinetrees" timeout="30" type="exclusive">
			<cfset SESSION.treeCache = StructNew()>
			<cfset SESSION.treeCache.ttl = DateAdd("h", 1, Now())>
			<cfset SESSION.treeCache.pines = cfhttp.filecontent>
		</cflock>
	</cfif>
	<cfreturn ConvertXmlToStruct(SESSION.treeCache.pines, StructNew(), 'name')>
</cffunction>

<cfscript>
function OutputNode( data, id )
{
	var i = 0;
	
	if ( StructKeyExists(data,'NODES') )
		WriteOutput( '<dd id="dd_' & data['ID'] & '_tree" class="node">' );
	else
		WriteOutput( '<dd>' );

	if ( StructKeyExists( data, 'NAME' ) )
	{
		if ( Compare(data.Name,"") )
		{ 
			WriteOutput( '<div><a href="wa.cfm?input=' & URLEncodedFormat(data.Name) & '" target="wa-details">' & data.Name & '</a></div>' );
		}
		else
		{
			WriteOutput( '&hellip;' );
		}
	}
	
	if ( StructKeyExists(data,'NODES') AND IsArray(data.Nodes) AND ArrayLen(data.Nodes) )
	{
		WriteOutput( '<dl id="dl_' & data['ID'] & '_tree">' );
		for ( i=1; i LTE ArrayLen(data.Nodes); i++ )
		{
			if ( IsStruct( data.Nodes[i] ) )
			{
				OutputNode( data.Nodes[i], data['ID'] );
			}
		}
		//while ( i++ LT ArrayLen(data.Nodes) );
		WriteOutput( '</dl>' );
	}

	WriteOutput( '</dd>' );
}
</cfscript>

<cffunction name="ConvertXmlToStruct" access="public" returntype="any" output="true"
			hint="Parse raw XML response body into ColdFusion structs and arrays and return it.">
	<cfargument name="xmlNode" type="string" required="true" />
	<cfargument name="str" type="struct" required="true" />
	<!---Setup local variables for recurse: --->
	<cfset var i = 0 />
	<cfset var axml = arguments.xmlNode />
	<cfset var astr = arguments.str />
	<cfset var n = "" />
	<cfset var tmpContainer = "" />

	<cfset axml = XmlSearch(XmlParse(arguments.xmlNode),"/node()")>
	<cfset axml = axml[1] />

	<!--- For each children of context node: --->
	<cfloop from="1" to="#arrayLen(axml.XmlChildren)#" index="i">
		<!--- Read XML node name without namespace: --->
		<cfset n = replace(axml.XmlChildren[i].XmlName, axml.XmlChildren[i].XmlNsPrefix&":", "") />
		<!--- If key with that name exists within output struct ... --->
		<cfif  ListFind("NAME,NODE,NODES",n)>
			<cfif arrayLen(axml.XmlChildren[i].XmlChildren) gt 0>
				<!--- recurse call: get complex item: --->
				<cfset stuff = ConvertXmlToStruct(axml.XmlChildren[i], structNew()) />
				<!--- <cfdump var="#axml.XmlChildren[i].XmlAttributes.Id#"><cfdump var="#stuff#"><cfabort><cfabort> --->
				<cfif IsStruct(stuff)>
					<cfset stuff.ID = axml.XmlChildren[i].XmlAttributes.id>
				</cfif>
			<cfelse>
				<!--- else: assign node value as last element of array: --->
				<cfset stuff = axml.XmlChildren[i].XmlText />
			</cfif>
			<cfif structKeyExists(astr, n)>
				<!--- ... and is not an array... --->
				<cfif not isArray(astr[n])>
					<!--- ... get this item into temp variable, ... --->
					<cfset tmpContainer = astr[n] />
					<!--- ... setup array for this item beacuse we have multiple items with same name, ... --->
					<cfset astr[n] = arrayNew(1) />
					<!--- ... and reassing temp item as a first element of new array: --->
					<cfset astr[n][1] = tmpContainer />
				</cfif>
				<cfset astr[n][arrayLen(astr[n])+1] = stuff />
			<cfelse>
				<cfset astr[n] = stuff />
			</cfif>
		</cfif>
	</cfloop>
	<cfif StructKeyExists(astr,"node")>
		<cfreturn astr.node />
	<cfelse>
		<cfreturn astr />
	</cfif>
</cffunction>

</cfcomponent>