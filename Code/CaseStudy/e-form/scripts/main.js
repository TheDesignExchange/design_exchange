require.config({
	baseUrl: 'scripts/modules',
	paths : {
	 "jquery" : "http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min",
	 "bootstrap" : "bootstrap.min",
	 // "stellar" : "jquery.stellar.min",
	 "waypoints" : "waypoints.min",
	 "easing" : "jquery.easing.1.3",
	 "csvread" : "csvread",
	 "basic" : "basic",
	 "gui": "gui",
	 "casestudy": "casestudy"
	}, 
	shim:{
		"basic" : ["jquery"],
		"casestudy" : ["jquery", "basic"],
		"bootstrap" : ["jquery"],
		"waypoints": ["jquery"],
		"easing": ["jquery"],
		// "stellar": ["stellar"],
		"gui" : ["jquery", "basic"]
	}
});

define(['jquery', 'bootstrap', 'easing', 'waypoints', 'basic', 'casestudy', 'gui', 'csvread'], function($, b, c, d, e, f, g) {
	$(function(){
	  var id = parseInt(getURLParameters('cs'));
	  for(var i in info)
	    casestudies.push(new CaseStudy(i, info[i], Object.size(info)))
	  
	  activeStudy = casestudies[id-1];
	  gui = new GUI(activeStudy);
	  
	});
});