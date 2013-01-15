$(document).ready(function(){
	var wHeight = $(window).outerHeight() - $('#footer-wrap').outerHeight() - $('#head-wrap').outerHeight() - $('#mainnav-wrap').outerHeight() - $('#notice-details').outerHeight();
	
	var top = $('#tab-wrap').offset().top - parseFloat($('#tab-wrap').css('marginTop').replace(/auto/, 0));
	
	$('#details').scroll(function (event) {
		
		// what the y position of the scroll is
		var y = $(this).scrollTop();
		
		if (y >= top) {
		  
		  $('#tab-wrap').addClass('fixed');
		} else {
		  
		  $('#tab-wrap').removeClass('fixed');
		}
	});
	
	$('#instances').height(wHeight);
	$('#details').height(wHeight);
	$('.blank-slate-wrap').height(wHeight);
	
	$('a[rel=tooltip]').hover(function(){
		$(this).tooltip('show');
	}, function() {
		$(this).tooltip('hide');
	})
	
	$('#main-tab a').click(function (e) {
	  e.preventDefault();
	  $(this).tab('show');
	})
	
	$('.volume-img').click(function(){
		$('.volume-snapshot').slideToggle();
	})
	
});