$(document).ready(function() {

	// Preloader
	$(window).load(function(){
		$('.preloader').fadeOut();
	});

	// Initiat WOW.js
	var wow = new WOW(
	  {
	  	mobile: false
	  }
	);
	wow.init();

	// .intro-section reduce opacity when scrolling down
	$(window).scroll(function(){
		if($(window).width() > 1260) {
			windowScroll = $(window).scrollTop();
			contentOpacity = 1 - (windowScroll / ($('#intro').offset().top+$('#intro').height()));
			$('.intro-section').css('transform','translateY('+Math.floor(windowScroll*0.16)+'px)');
			$('.intro-section').css('-webkit-transform','translateY('+Math.floor(windowScroll*0.16)+'px)');
			$('.intro-section').css('opacity',contentOpacity.toFixed(2));
		}
	});

	// Fixed navigation
	$(window).scroll(function() {
	    if ($(window).scrollTop() > 500) {
	        $('.navbar').addClass('fixednav');
	    } else {
	    	$('.navbar').removeClass('fixednav');
	    }
	});

	// Initiat onepageNav.js
	$('.nav').onePageNav({
		currentClass: 'current',
		'scrollOffset': 500
	});

	// Hide Mobile Nav when clicking item
	$(".nav a, .navbar-header a").click(function(event) {
		$(".navbar-collapse").removeClass("in").addClass("collapse");
	});

	/* Buttons Scroll to Div */
	$('.navbar-brand').click(function () {
		$.scrollTo('.intro', 1000);
	return false;
	});

	$('.scrollto-what').click(function () {
		$.scrollTo('#what', 1000);
	return false;
	});

	$('.scrollto-process, a.mouse').click(function () {
		$.scrollTo('#features', 1000);
	return false;
	});
	$('.scrollto-screenshots, a.mouse').click(function () {
		$.scrollTo('#screenshots', 1000);
	return false;
	});
	$('.scrollto-signupform, a.mouse').click(function () {
		$.scrollTo('#signupform', 1000);
	return false;
	});
	$('.scrollto-contact, a.mouse').click(function () {
		$.scrollTo('#footer', 1000);
	return false;
	});

	// Screenshot carousel
	$(".screens").owlCarousel({
		items: 4,
		navigation:true,
		navigationText: [
			"<i class='fa fa-angle-left btn-slide'></i>",
			"<i class='fa fa-angle-right btn-slide'></i>"
			],
		pagination: false,
		itemsDesktop: [1000, 4],
        itemsDesktopSmall: [990, 3],
        itemsTablet: [600, 1],
        itemsMobile: false
	});

	// Screenshot lightbox
	$('.screens a').nivoLightbox({
	    effect: 'fadeScale'
	});

	// Brief carousel
	$(".small-slider").owlCarousel({
		items: 1,
		navigation: true,
		navigationText: [
			"<i class='fa fa-angle-left btn-slide'></i>",
			"<i class='fa fa-angle-right btn-slide'></i>"
			],
		pagination: false,
		itemsDesktop: [1000, 1],
        itemsDesktopSmall: [900, 1],
        itemsTablet: [600, 1],
        itemsMobile: false
	})

	// Testimonial carousel
	$(".testimonials").owlCarousel({
		autoPlay: 8000,
		autoHeight : true,
		singleItem: true,
		navigation: false,
		itemsDesktop: [1000, 1],
        itemsDesktopSmall: [900, 1],
        itemsTablet: [600, 1],
        itemsMobile: false
	});
	// Product carousel
	$(".products").owlCarousel({
		autoPlay: 8000,
		autoHeight : true,
		singleItem: true,
		navigation: false,
		itemsDesktop: [1000, 1],
        itemsDesktopSmall: [900, 1],
        itemsTablet: [600, 1],
        itemsMobile: false
	});

	// Initiat fitVids.js
	$(".video-item").fitVids();

	// Bootstrap Tab navigation
	$('.tabs a').click(function (e) {
		e.preventDefault()
		$(this).tab('show')
	});

	// Testimonial carousel
	$(".customer-slider").owlCarousel({
		autoPlay: 8000,
		items: 5,
		pagination: false,
		itemsDesktop: [1000, 1],
        itemsDesktopSmall: [900, 1],
        itemsTablet: [600, 1],
        itemsMobile: false
	});
	// Form
	
    $("#submit_btn").click(function() { 
    		$('#error').empty();
        var proceed = true;
        //simple validation at client's end
        //loop through each field and we simply change border color to red for invalid fields       
        $("#contact_form input[required=true], #contact_form textarea[required=true], #contact_form select[required=true]").each(function(){
            $(this).css('border-color',''); 
            if(!$.trim($(this).val())){ //if this field is empty 
                $(this).css('border','1px solid'); //change border color to red   
                $(this).css('border-color','red'); //change border color to red   
                proceed = false; //set do not proceed flag
            }
            //check invalid email
            var email_reg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/; 
            if($(this).attr("type")=="email" && !email_reg.test($.trim($(this).val()))){
                $(this).css('border','1px solid'); //change border color to red   
				$(this).css('border-color','red'); //change border color to red   
				var theDiv = document.getElementById("error");
				var content = document.createTextNode("Not a valid email address, sorry. ");
				theDiv.appendChild(content);
		        proceed = false; //set do not proceed flag              
            }   
        });
		var theDiv = document.getElementById("error");
		var content = document.createTextNode("Please complete the fields highlighted in red. ");
		theDiv.appendChild(content);

        if(proceed) //everything looks good! proceed...
        {
			    		$('#error').empty();

            //get input field values data to be sent to server
            post_data = {
                'user_name'     : $('input[name=name]').val(), 
                'user_email'    : $('input[name=email]').val(), 
                'launchdate'  	: $('input[name=launchdate]').val(), 
                'package'  		: $('select[name=package]').val(), 
                'business'       : $('input[name=business]').val(), 
            };
            
            //Ajax post data to server
            $.post('contact_me.php', post_data, function(response){  
                if(response.type == 'error'){ //load json data from server and output message     
                    output = '<div class="error">'+response.text+'</div>';
                }else{
                    output = '<div class="success">'+response.text+'</div>';
                    //reset values in all input fields
                    $("#contact_form  input[required=true], #contact_form textarea[required=true]").val(''); 
                    $("#contact_form #contact_body").slideUp(); //hide form after success
                }
                $("#contact_form #contact_results").hide().html(output).slideDown();
            }, 'json');
        }
    });
    
    //reset previously set border colors and hide all message on .keyup()
    $("#contact_form  input[required=true], #contact_form textarea[required=true]").keyup(function() { 
        $(this).css('border-color',''); 
        $("#result").slideUp();
    });
	
	$(function () {
            $('#datetimepicker11').datetimepicker({
                daysOfWeekDisabled: [0,6],
				format: 'DD/MM/YYYY'
            });
        });
 
});