$(document).ready( 
	function(){
		$('.flex-vam').flexigrid(
			{
				sortname: 'label',
				sortorder: 'asc',
				usepager: true,
				dataType: 'json',
				rp: 10,
				rpOptions: [10, 15, 25, 40],
				showTableToggleBtn: true,
				width: 'auto',
				query: 'circus horse',
				height: 'auto',
				url: 'http://www.vam.ac.uk/api/json/museumobject/',
				title: 'Art Collections in the Victoria and Albert Museum',
				searchitems: [],
				colModel:
				[
					{ display: 'Id', name: 'primary_image_id', width: 75, sortable: true, filterable: false, isdefault: false, align: 'left', type: 'numeric' },
					{ display: 'Year', name: 'year_start', width: 40, sortable: true, filterable: true, isdefault: true, align: 'left', type: 'numeric' },
					{ display: 'Artist', name: 'artist', width: 200, sortable: true, filterable: true, isdefault: false, align: 'left', type: 'string' },
					{ display: 'Place', name: 'place', width: 100, sortable: true, filterable: true, isdefault: false, align: 'left', type: 'string' },
					{ display: 'Title', name: 'title', width: 400, sortable: true, filterable: true, isdefault: false, align: 'left', type: 'string' }
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
				executeAjax: function () {
					
				},
				parseData: function (data)
				{
					var ds = {
							page: data.meta.page,
							total: data.meta.result_count, //data.records.length
							rows: []
						};
					var cm = this.colModel;
					$.each(
						data.records,
						function (i, v)
						{
							var row = {};
							var f = v.fields;
							row.id = f.primary_image_id;
							row.cell = [];
							
							$.each(
								cm, 
								function (i, v)
								{
									row.cell.push(f[v.name]);
								}
							);
							ds.rows.push(row);
						}
					);
					return ds;
				}
			}
		); 
	}
);
