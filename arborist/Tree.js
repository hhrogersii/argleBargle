//JavaScript Arborist - hhrogersii.com
/*global document: false, $: false */
var Tree = ( function ( ) 
{
	'use strict';
	
	var initialNode = 0,
		listTag = 'dl',
		itemTag = 'dd',
		treeClass = 'tree';
	
	function show ( item, list ) 
	{
		if ( typeof list === 'undefined' )
		{
			list = item.getElementsByTagName( listTag )[0];
		}
		if ( typeof list !== 'undefined' )
		{
			list.style.display = 'block';
		}
		item.style.backgroundImage = 'url(minusm.gif)';
		item.style.color = '#036';
	}
	
	function hide ( item, list ) 
	{
		if ( typeof list === 'undefined' )
		{
			list = item.getElementsByTagName( listTag )[0];
		}
		if ( typeof list !== 'undefined' )
		{
			list.style.display = 'none';
		}
		item.style.backgroundImage = 'url(plusm.gif)';
		//item.style.color = '#999';
	}
	
	return {
		
		init: function ( iTag, iClass, iNode )
		{
			listTag = iTag;
			if ( listTag.toUpperCase() !== 'DL' )
			{
				itemTag = 'li';
			}
			
			treeClass = iClass;

			initialNode = iNode;
			if ( typeof iNode !== 'undefined' )
			{
				this.expand( iNode );
			}
		},
		
		select: function ( item )
		{
			var list = item.getElementsByTagName( listTag )[0];
		
			if ( typeof list !== 'undefined' )
			{
				if ( list.style.display !== 'block' )
				{
					show( item, list );
				}
				else
				{
					if ( item.id.indexOf( itemTag + '_0_' + treeClass ) === 0 )
					{
						this.renew( list.id.substring( 5 ) );
					}
					else
					{
						hide( item, list );
					}
				}
			}
		},
		
		expand: function ( id )
		{
			var nodeVal = id.split( '_' )[1],
				item = document.getElementById( id );

			if ( parseInt( nodeVal, 10 ) !== 0 && nodeVal !== '' )
			{
				while ( item && item.tagName !== 'DIV' )
				{
					if ( item.tagName === listTag.toUpperCase() )
					{
						item.style.display = 'block';
					}
					else
					if ( item.tagName === itemTag.toUpperCase() )
					{
						item.style.backgroundImage = 'url(minusm.gif)';
						item.style.color = '#036';
					}
			
					item = item.parentNode;
				}
			}
		},
		
		renew: function ( id )
		{
			var list = document.getElementById( listTag + '_0_' + treeClass ),
				items = document.getElementsByTagName( itemTag.toUpperCase() ),
				i = 0;

			for ( i; i<items.length; i+=1 )
			{
				hide( items[i] );
			}
			
			if ( typeof id !== 'undefined' )
			{
				initialNode = id;
			}
			
			this.expand( initialNode );
		},
		
		expandAll: function ( )
		{
			var list = document.getElementById( listTag + '_0_' + treeClass ),
				items = document.getElementsByTagName( itemTag.toUpperCase() ),
				i = 0;

			for ( i; i<items.length; i+=1 )
			{
				show( items[i] );
			}
		},
		
		collapseAll: function ( )
		{
			var list = document.getElementById( listTag + '_0_' + treeClass ),
				items = document.getElementsByTagName( itemTag.toUpperCase() ),
				i = 0;

			for ( i; i<items.length; i+=1 )
			{
				hide( items[i] );
			}
		}
	};
}());

// callback from info iframe: parent.$('#info').css('visibility','visible');
function resizeIframe ()
{
	$('#info').height( Math.max( $('#tree').height() - 4, $('#wa').height() ) );
}

// $(window).load(main);
function main ()
{
	'use strict';
	
	Tree.init( 'dl', 'tree', 'dl_21645_tree' );
	$('.tree').click( 
		function(event){ 
			Tree.select( event.target ); 
			resizeIframe(); 
		} 
	);
	
	resizeIframe();
	
	$('.wa-link').click( 
		function(){ 
			$('#wa').show();
			$('#info').css('visibility','hidden');
		} 
	);
	
	$('#expandAll').click( function(){ Tree.expandAll(); } );
	$('#collapseAll').click( function(){ Tree.collapseAll(); $('#wa').hide(); } );
	$('#resetAll').click( function(){ Tree.renew(); } );
}
