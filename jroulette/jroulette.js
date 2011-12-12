/*jslint browser: true, undef: false, sloppy: true, vars: true, white: true, forin: false, nomen: false, maxerr: 100, indent: 4 */
/*globals document,$,jQuery*/
/* 
 * jRoulette v0.1
 * Designed and written by hhrogersii
 * Licensed under MIT

 * Inspired by jBond Slider 0.9
 * Andrew Marcus & Love Media, 2010
 * Licensed under MIT
 */

(function ($) {

	'use strict';

	$.fn.extend(
		{
			jRoulette: function ( opt )
			{
				jQuery.extend(
					jQuery.easing
				  , {
						roul_ease: function ( x, t, b, c, d )
						{
							x = x;
							return ( t === d ) ? b+c : c*(-Math.pow(2,-10*t/d)+1)+b;
						}
					}
				);

				var dflts = {
								scroll:		3
							  , bounce:		4
							  , veloce:		5
							  , neutra:		6	// Rest area width in px
							  , mspeed:		7	// Max speed
			
							  , wrapSelector:	'.roul-wrap'
							  , boxySelector:	'.roul-boxy'
							  , sldsSelector:	'.roul-slds'
							  , bumpSelector:	'.roul-bump'
							  , pageSelector:	'.roul-page'
							  , easingMargin:	 'swing' //'roul_ease'
			
							  , slideClickCallback: function ( i, d )
								{
									i = d;
								}
							}
				 		  , option = {};

				if ( !opt )
				{
					opt = dflts;
				}
				else
				{
					for ( option in dflts )
					{
						if ( dflts.hasOwnProperty(option) && opt[option] === undefined )
						{
							opt[option] = dflts[option];
						}
					}
				}

				//private
				function getLeft ( f )
				{
					return parseInt( f.css('left'), 10 );
				}
				function setLeft ( f, d )
				{
					f.css( 'left', ( getLeft(f) + d ) );
				}

				function wrapIndex ( v, l )
				{
					return ( v + l ) % l;
				}

				function manual ( i )
				{
					clearInterval( i );
				}

				//public
				return this.each(

					function ()
					{
						var roul = $(this)
						  , wrap = roul.children( opt.wrapSelector )
						  , boxy = wrap.children( opt.boxySelector )
						  , slds = boxy.children( opt.sldsSelector )
						  , scnt = slds.length
						  , frst = slds.first()
						  , bump = roul.children( opt.bumpSelector+'-left,' +opt.bumpSelector+'-right' )
						  , page = $( opt.pageSelector ).find('li')
						  , sdim = frst.width()
						  , adim = scnt * sdim
						  , touch = 0, delta = 0, veloc = 0, crrnt = 0, dirct = 0, autos = 0
						;

						function animate ( target, fn )
						{
							var callback = ( !fn ) ? jQuery.noop : fn
							  , time = parseFloat( (opt.scroll).toString() + 's' ) * 1000;

							page.removeClass('hover');

							frst.animate(
								{
									'left': target
								}
							  , {
									duration:	time
								  , easing:		opt.easingMargin
								  , complete:	callback
								  , step:		function ( now )
									{
										slds.css(
											'left'
										  , function ( index )
											{
												return ( (index * sdim) + now ) % adim;
											}
										);
									}
								}
							);

							page.eq( ( scnt - crrnt ) % scnt ).addClass('hover');
						}

						function change ( e, c, d )
						{
							manual( autos );

							slds.stop( true );
							e.preventDefault();
							e.stopPropagation();

							crrnt = c;
							dirct = d;
						}

						function select ( e, p )
						{
							if ( scnt-p === crrnt )
							{
								return false;
							}

							var cur = crrnt;
							var tar = scnt - p;

							var dis = cur - tar;
							var abs = Math.abs( dis );
							var opp = scnt - abs;
							var dir = abs / dis;

							//var shift = Math.min( abs , (scnt-abs) ) * abs / dis;	
							var shf = (
										( tar < cur )
									? ( ( abs < opp ) ?  1 : -1 ) 
									: ( ( abs < opp ) ? -1 :  1 ) 
								);

							if ( shf !== dir )
							{
								setLeft( frst, ( adim * -dir ) );
							}

							change( 
								e
							  , tar
							  , dir
							);
							
							animate( tar * sdim );
						}

						function browse ( e, d )
						{
							if ( ( d > 0 && crrnt === scnt-1 ) || ( d < 0 && crrnt === 0 ) )
							{
								setLeft( frst, ( adim * -d ) );
							}

							change( 
								e
							  , wrapIndex( ( crrnt + d ), scnt )
							  , d
							);

							animate( crrnt * sdim );
						}

						function automatic()
						{
							autos = window.setInterval(
								function () 
								{
									if ( crrnt === 0 )
									{
										setLeft( frst, adim );
									}
									slds.stop( true );
									crrnt = wrapIndex( ( crrnt + -1 ), scnt );
									dirct = -1;
									animate( crrnt * sdim );
								}
							  , 4000
							);
						}

						function back ()
						{
							crrnt = wrapIndex( ( -Math.round( getLeft( frst ) / sdim ) ), scnt );

							var shift = wrapIndex( ( -crrnt ), scnt ) * sdim;

							if ( shift === 0 && getLeft( frst ) > 2400 )
							{
								setLeft( frst, ( adim * dirct ) );
							}

							animate( shift );
						}

						function end ()
						{
							touch = 0;

							if ( Math.abs(veloc) > opt.veloce )
							{
								animate( getLeft( frst ) + Math.floor( Math.sqrt( Math.abs(veloc) * opt.bounce ) ) * veloc, back );
							}
							else
							{
								back();
							}

							slds.unbind( 'mousemove move' );
							$(document).unbind( 'mouseup end' );

							return false;
						}

						function move ( x )
						{
							veloc = x - touch - delta;
							delta = x - touch;
							dirct = Math.abs(veloc)/veloc;

							slds.css(
								'left'
							  , function ( index )
								{
									return wrapIndex( (index * sdim) + delta, adim );
								}
							);

							return false;
						}

						function begin ( e )
						{
							if ( e.button === 2 )
							{
								return false;
							}
							var me = ( e.originalEvent && e.originalEvent.touches ) ? e.originalEvent.touches[0] : e;

							slds.stop();
							e.preventDefault();
							e.stopPropagation();

							manual( autos );

							delta = 0;
							veloc = 0;
							touch = me.pageX - getLeft( frst );

							slds.on(
								'mousemove move'
							  , function (me)
								{
									move(me.pageX);
								}
							);

							$(document).on(
								'mouseup end'
							  , function ()
								{
									end();
								}
							);

							return false;
						}

						roul.find('a').click(
							function ()
							{
								if ( delta !== 0 )
								{
									return false;
								}
							}
						);

						/* Setting zero position */
						wrap.css(
							'left'
						  , (     (    (   Math.ceil(  (scnt+1) / 2 ) - 1  )   *  -sdim    )    ).toString() + 'px'
						);

						boxy.children( opt.sldsSelector ).click(
							function ()
							{
								opt.slideClickCallback( slds.index(this), delta );
							}
						);

						slds.on(
							'mousedown begin'
						  , function (e)
							{
								begin(e);
							}
						);

						bump.on(
							{
								click: function(e)
								{
									if ( touch === 0 )
									{
										browse( e, ( $(this).attr('class').indexOf('right')>0 ? -1 : 1 ) );
									}
								}
							  , mouseenter: function()
								{
									if ( touch === 0 )
									{
										$(this).addClass('hover');
									}
								}
							  , mouseleave: function()
								{
									$(this).removeClass('hover');
 								}
							} 
						);

						page.on(
							{
								click: function (e)
								{
									select( e, $(this).index() );
								}
							  , mouseenter: function()
								{
									$(this).addClass('hover');
								}
							  , mouseleave: function()
								{
									$(this).removeClass('hover');
								}
							}
						);

						automatic();
					}
				);//end public
			}//end roul
		}//end map
	);//end extend
}( jQuery ) );