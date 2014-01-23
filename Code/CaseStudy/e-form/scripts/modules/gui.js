
var colors = ['btn-success', 'btn-info', 'btn-warning', 'btn-primary'];
var gui;

function GUI(cs){
  this.characterization = $('#btn-char');
  this.user = {
    "title" : $('textarea[name="title"'),
    "description" : $('textarea[name="description"')
  }

  this.system = {
    "title" : $('p[name="title"'),
    "description" : $('p[name="description"'),
    "methods" : $('ul[name="methods"')
  }
  // ADD DYNAMIC ELEMENTS 
  this.pagination(cs.id, cs.n);
  for(var type in options.characterization)
    this.addCharacterization(type, options.characterization[type]);
  this.loadCaseStudy(cs);
  this.addHandlers();
}

GUI.prototype.refresh = function(cs){
  this.loadCaseStudy(cs);
}

GUI.prototype.loadCaseStudy = function(cs){
  this.addMetaData(cs);
  for(var prop in cs.characterization)
    $($('td[name="' + prop + '"]').parent().children()[1]).html(cs.characterization[prop]);
  for(var i in cs.methods)
    this.addMethod(cs.methods[i]);
}


GUI.prototype.addMetaData = function(cs){
  this.system.title.html(cs.title);
  this.user.title.val(cs.title);
  this.user.description.val(cs.description);
  this.system.description.html(cs.description);
  for(var i in cs.methods){
    this.system.methods.append($("<li>"+ cs.methods[i] +"</li>"))
  }
}

GUI.prototype.addMethod = function(method){
   var row = '<div class="row"><div class="col-sl-1"><div class="input-group"><span class="input-group-addon"><input type="checkbox"></span><input type="text" class="form-control" value="'+ method+'"></div><!-- /input-group --></div><!-- /.col-lg-6 --></div><br>';
    $('#methods').append(row);

    var adddetails = '<button type="button" class="btn btn-default navbar-btn">Add Details</button>'; 
    $('#adddetails').append(adddetails);
}




GUI.prototype.pagination = function(active, n){
    n += 2; // for traversing large n

    var paginationContainer = $('.pagination');
    for(var i = 0; i < n; i ++){
       var li = $('<li></li>');
      var page = $('<a></a>');
      if(i == 0)
        page.attr('href', "").html('&laquo;');
      else if(i == n - 1)
        page.attr('href', "").html('&raquo;');
      else
        page.attr('href', "index.html?cs=" + i).html(i);

      if(i == active){
        page.html(i + '<span class="sr-only">(current)</span>');
        li.addClass('active');
      }
      
      paginationContainer.append(li.append(page));
    }
  }
  GUI.prototype.addCharacterization = function(type, values){
    var name = type.split('-');
    for(var i in name) name[i] = name[i].capitalize();
    name = name.join(" ")
    var n = $('.btn-group').length;
    var character = $('<div class="grid_6 omega btn-group">  <button type="button" class="btn '+ colors[n] + ' dropdown-toggle" data-toggle="dropdown">'+ name +' <span class="caret"></span>  </button>  <ul name='+ type  +' class="dropdown-menu" role="menu"></ul></div>');
    var menu =  character.children('.dropdown-menu');
    for(var i in values){
      var li = $("<li><a>" + values[i] + "</a></li>");
      menu.append(li);
    }

    this.characterization.append(character);
  };
GUI.prototype.addHandlers = function(){
  $("#adddetails").click(function(){
      var id = $(this).attr('name');
      if ($(this).hasClass("remove")){
        //SHOW SUB
        $(this).html("Add Details").removeClass("remove");
        $("#sub").show();
        $("#submethod-text").html(id);
      }else{
        //HIDE SUB
        $(this).html("Remove Details").addClass("remove");
        $("#sub").hide();
      }
    });

    $("#Hdetail1").click(function(){
      $("#sub").show();
    });

  // ENABLE CLICK FUNCTIONALITY ON PAGINATION
  $('a').click(function(){ window.location = $(this).attr('href');});
  $('li>a').unbind();
   $('.dropdown-menu li').click(function(){
      var prop = $(this).parent().attr('name');
      var value = $(this).children().html();
      console.log(prop, value);
      activeStudy.characterization[prop] = value;
      gui.refresh(activeStudy);
    });
   this.user.title.bind('input propertychange', function() {
      var value = $(this).val();
      activeStudy.title = value;
      gui.refresh(activeStudy);
   });
    this.user.description.bind('input propertychange', function() {
      var value = $(this).val();
      activeStudy.description = value;
      gui.refresh(activeStudy);
   });
}
