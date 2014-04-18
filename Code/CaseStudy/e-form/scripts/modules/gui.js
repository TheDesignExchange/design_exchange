GUI.colors = ['btn-success', 'btn-info', 'btn-warning', 'btn-primary'];

function GUI(cs, data){
  this.form = $('#form2 .container');
  this.data = data;
  this._init();
}

GUI.prototype = {
  _init: function(){
    var that = this;
    $.each(this.data, function(i, el){
        if(typeof el !== 'undefined')
          that[el.type](el);
    });
  },
  textInput: function(el){
      var container = $('<div class="multiple row"><h4>'+ el.name + ':</h4> </div>');
      for(var i in el.options){
        var input = $(GUI.column('<p name="'+ el.options[i]['sqlName'] + '">' + el.options[i].name + ': '+ el.options[i]['val'] +'</p>', 
                                  '<p class="label">'+ el.options[i].name + ':</p><input name="'+ el.options[i]['sqlName'] + '" value="'+ el.options[i]['val'] +'"/>')
                    );
        container.append(input);
      }
      $(this.form).append(container);
  }, 
  textArea: function(el){
    var input =  $(GUI.column('<h4>'+ el.name + ':</h4><p name="'+ el['sqlName'] + '"> '+ el.options[0]['val'] +'</p>', 
                              '<h4>'+ el.name + ':</h4><textarea rows="4" name="'+ el['sqlName'] + '"> '+ el.options[0]['val'] +' </textarea>')
                );
    $(this.form).append(input);
  },
  webInput : function(el){
    var input = $(GUI.column('<h4>'+ el.name + ':</h4><a target="blank" href="'+ el.options[0]['val'] +'" name="'+ el['sqlName'] + '"> Link </a>', 
                              '<h4>'+ el.name + ':</h4><input name="'+ el['sqlName'] + '" value="'+ el.options[0]['val'] +'"/">')
                );
    $(this.form).append(input);
  },
  checkbox : function(el){},
  checkboxConfirm : function(el){},
  fileUpload : function(el){},
  time : function(el){},
  checkbox : function(el){},
  dropDown : function(el){}
}

/* Separates a and b into a column */
GUI.column = function(a, b){
  return '<div class="row"><div class="half system">'+a+'</div><div class="half omega user">'+b+'<br class="clearfix"/></div>';
}
