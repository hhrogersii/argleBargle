
// functions for page calling calendar
function main()
{
	$('.link_cal').click( 
		function (e) 
		{
			e.preventDefault();
			e.stopPropagation();

			var fieldId = $(this).attr('id').replace('link_cal_','');
			var field = $('#'+fieldId);
			var calPos = $(this).position();

			var calendar = $('#calendarFrame');
			calendar.attr( 'src', 'Calendar.cfm?field=' + fieldId + '&date=' + field.val() );
			
			calendar.css('left', calPos.left + $(this).width() + 10 );
			calendar.css('top',  calPos.top );
		}
	);
}


function dspCalendar(bln) 
{
	$('#calendarFrame').css( 'visibility', ( (bln) ? 'visible' : 'hidden' ) );
}

var targetField = 'date_field';

// functions for pop-up calendar
function calendar(tf)
{
	if (tf)
	{
		targetField = tf;
	}
	
	$('.navCell,.goCell,.titleCell,.dateCell').hover( 
		function(){
			$(this).addClass('hover');
		},
		function(){
			$(this).removeClass('hover');
		} 
	);
	
	$('.navCell,.goCell,.titleCell').click( 
		function(){
			window.location.href = CGI.script() + '?field=' + targetField + '&date=' + $(this).attr('id').replace('date_','');
		}
	);
	
	$('.dateCell').click( 
		function(){
			//parent.$(targetField).val( $(this).attr('id').replace('date_','') ); 
			parent.document.getElementById(targetField).value = $(this).attr('id').replace('date_',''); 
			parent.dspCalendar(false);
		} 
	);
}