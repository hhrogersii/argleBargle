$(document).ready( 
	function(){
		$('.flex-painters').flexigrid(
			{
				sortname: 'label',
				sortorder: 'asc',
				usepager: true,
				usesort: true,
				title: 'Famous Painters (1700-present)',
				dataType: 'json',
				rp: 15,
				rpOptions: [10,15,25,40],
				showTableToggleBtn: true,
				width: 'auto',
				height: 'auto',
				searchitems: [],
				colModel:
				[
					{ display: 'Id', name: 'id', width: 20, sortable: true, filterable: false, isdefault: false, align: 'center', type: 'numeric' },
					{ display: 'School', name: 'school', width: 125, sortable: true, filterable: true, isdefault: true, align: 'left', type: 'string' },
					{ display: 'Artist', name: 'artist', width: 150, sortable: true, filterable: true, isdefault: true, align: 'left', type: 'string' },
					{ display: 'Dates', name: 'dates', width: 75, sortable: true, filterable: true, isdefault: false, align: 'left', type: 'date' },
					{ display: 'Description', name: 'description', width: 450, sortable: true, filterable: true, isdefault: false, align: 'left', type: 'string' }
				],
				preProcess: function (data)
				{
					if (this.onChangePage)
					{
						return this.onChangePage(data, this.newp, this.rp);
					}
					else
					{
						return data;
					}
				},
				onChangeSort: function (ds, cn, so)
				{
					var st = 'string',
						ci = 0;
					$.each(
						this.colModel, 
						function (i, v)
						{
							if (v.name === cn)
							{
								st = v.type;
								ci = i;
								return false;
							}
						}
					);
					var sortData = function (a, b)
						{
							var x = (so === 'asc') ? a.cell[ci] : b.cell[ci],
								y = (so === 'asc') ? b.cell[ci] : a.cell[ci];
							if (st === 'numeric')
							{
								return (x - y);
							}
							else if (st === 'date')
							{
								x = x.split('/');
								y = y.split('/');
								return (x[2] === y[2]) ? ( (x[0] === y[0]) ? (x[1] - y[1]) : (x[0] - y[0]) ) : (x[2] - y[2]);
							}
							else
							{
								//x = $(x).text().toUpperCase();
								//y = $(y).text().toUpperCase();
	
								x = x.replace(/<\/?[^>]+>/gi, '').toUpperCase();
								y = y.replace(/<\/?[^>]+>/gi, '').toUpperCase();
	
								return ( (x < y) ? -1 : ( (x > y) ? 1 : 0) );
							}
						};
					ds.rows.sort(sortData);
					return ds;
				},
				onDoSearch: function (ds, qy, cn)
				{
					//filter results based on query
					//http://net.tutsplus.com/tutorials/javascript-ajax/using-jquery-to-manipulate-and-filter-data/
					var q = $.trim(qy); //trim white space
					
					if (q.length)
					{
						q = q.replace(/ /gi, '|'); 		//add OR for regex query
						var   rs = new RegExp(q, 'i')	//regular expression for searching for query
							, rh = /<\/?[^>]+>/g		//regular expresssion for removing html tags
							, si = this.searchitems 	//an array of columns that are filterable
							, is = 0 					//index of search item
							, ci = {} 					//column item 
							, ic = 0					//index of column (of column model not search items)
							, d = {
								page: ds.page,
								total: 0,
								rows: []
							};
						if (cn === '')
						{
							$(ds.rows).each(
								function (i, v)
								{
									var ci = {};
									for ( is in si )
									{
										ci = si[is];
										if (v.cell[ci.index].replace(rh, '').search(rs) !== -1)
										{
											d.rows.push(this);
											break;
										}
									}
								}
							);
						}
						else
						{
							if ( isNaN(cn) )
							{
								for ( is in si )
								{
									ci = si[is];
									if ( ci.name = cn )
									{
										ic = ci.index;
										break;
									}
								}
								
							}
							$(ds.rows).each(
								function (i, v)
								{
									if ( v.cell[ic].replace(rh, '').search(rs) !== -1 )
									{
										d.rows.push(this);
									}
								}
							);
							
						}
						d.total = d.rows.length;
						return d;
					}
					else
					{
						return ds;
					}
				},
				onChangePage: function (ds, pn, rpp)
				{
					var	r = ds.rows,
						b = (pn - 1) * rpp,
						e = (b + rpp > ds.rows.length) ? ds.rows.length : b + rpp,
						d = {
							page: pn,
							total: 0,
							rows: []
						},
						i=0;
					for (i = b; i < e; i+=1)
					{
						d.rows.push(r[i]);
					}
					d.total = ds.total;
					return d;
				}
			}
		);
	}
);
