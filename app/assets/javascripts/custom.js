$(document).ready(function(){
	$(".wd_info").click(function(e){
		meldung = $(this).parent().attr('data_meldung');
		meldung = $.parseJSON(meldung);

		var pos = $(this).offset();
		
      	var top = e.pageY - $(document).scrollTop();
      	var left = e.pageX - $(document).scrollLeft();
		
		$(".work_day_info").css({top: top, left: left, "font-size": "10px"});
		$(".wd_info_text").html("<i>"+meldung.day +"</i><br /><i>"+ meldung.note + "</i>");
		$(".work_day_info").fadeTo(500, 0.9);		

	});

	$(".close").click(function(){
		$(".work_day_info").fadeOut(500);
	});


});