require.config({
	baseUrl: 'scripts/modules',
	paths : {
	 "jquery" : "http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min",
	 "bootstrap" : "bootstrap.min",
	 "jqueryCSV" : "jquery.csv",
	 "basic" : "basic",
	 "gui": "gui",
	 "casestudy": "casestudy"
	}, 
	shim:{
		"basic" : ["jquery"],
		"casestudy" : ["jquery", "basic"],
		"bootstrap" : ["jquery"],
		"jqueryCSV" : ["jquery"],
		"gui" : ["jquery", "basic"]
	}
});

define(['jquery', 'bootstrap', 'basic', 'casestudy', 'gui', 'jqueryCSV'], function($, b, c, d, e, f) {
	$(function(){
	  var id = parseInt(getURLParameters('cs'));
	  for(var i in info)
	    casestudies.push(new CaseStudy(i, info[i], Object.size(info)))
	  
	  var activeStudy = casestudies[id-1];
	  var caseStudyAtrributes = "https://docs.google.com/spreadsheet/pub?key=0AjAwCuCEhsj_dEZuM2ROU3VjUV9sTWs4TWZDTnotTkE&output=csv";
	  
	  $.get(caseStudyAtrributes, function(data){
	  		var form = {};
	  		var obj = $.csv.toObjects(data);

	  		// console.log(obj.length);
	  		var j = 0;
	  		$.each(obj, function(i, el){
	  			var a = el.processName;
	  			if(a in form){
					if(activeStudy[a] == undefined) activeStudy[a] = "";
					form[a].options.push({
						id: j,
						name: el.optionName, 
						explanation: el.explanation, 
						val: activeStudy[a] 
					});
				} else{
					form[a] = { 
						id: j, 
						name: a,
						sqlName: el.sqlName, 
						type: el.processType, 
						options : [{ name: el.optionName, 
							         explanation: el.explanation, 
							         val: activeStudy[el.sqlName]  
							     }]
					};
					j++;
				}
				
	  		});
			
			var orderedForm = [];
			for(var i in form)
				orderedForm[form[i].id] = form[i];
			
			gui = new GUI(activeStudy, orderedForm);
	  });
	});
});