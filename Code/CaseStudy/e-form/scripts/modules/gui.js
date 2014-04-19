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
    var header = GUI.dom('p').html(el.name).addClass('label').addClass('full-label');
    var container = GUI.dom("div").addClass('multiple row');//.append(header);
    
    for(var i in el.options){
      var option = el.options[i];
      var label = GUI.label(option.name, option['sqlName']);
      var value = GUI.dom("span");
      if(option.val) value.html(option.val);
     
      var input = GUI.dom('input').attr('name', option['sqlName'])    
                                  .attr('value', option['val']);     
     
      var n = GUI.node(label, value, input);
      container.append(n);
    }
    container.children(".row:first").children(".half").prepend(header);
    this.form.append(container);
  }, 
  textArea: function(el){
    var label = GUI.label(el.name, el.name, true);
    var value = GUI.dom("p").attr('name', el['sqlName']).html(el.options[0]['val']);
    var a = [label, value];
    var value2 = GUI.dom('textarea').attr('rows', 4).attr('name', el['sqlName']).html(el.options[0]['val']);
    var b = [label.clone(), value2];
    var input = GUI.column(a, b);
    this.form.append(input);
  },
  webInput : function(el){
    var label = GUI.label(el.name, el.name, true);
    var value = GUI.dom("a").attr({
                              name : el['sqlName'],
                              target: "blank",
                              href: el.options[0]['val'] 
                            }).html('Link');
   
    var value2 = GUI.dom('input').attr('name', el['sqlName']).val(el.options[0]['val']);
   
    var input = GUI.node(label, value, value2);
    this.form.append(input);
  },
  checkbox : function(el){
    console.log(el);
  },
  checkboxConfirm : function(el){
    // console.log(el);
  },
  fileUpload : function(el){
    console.log(el);
    var label = GUI.label(el.name, el.name, true);
    var input = GUI.dom("input").attr({
                type: "file", 
                name: el.name,
                id: el.name
              });
    var brk = GUI.dom('br');
    var submit = GUI.dom("input").attr({
                type: "submit", 
                name: el.name + "submit",
                id: el.name + "submit", 
                value: "Submit"
              });
    var fileContainer = GUI.dom('div').addClass('files').append([input, brk, submit]);
    var n = GUI.node(label, "", fileContainer );
    this.form.append(n);
  },
  time : function(el){
    var header = GUI.label(el.name, el.name, true);
    var container = GUI.dom("div").addClass('multiple row');//.append(header);
    
    for(var i in el.options){
      var option = el.options[i];
      var label = GUI.label(option.name, option['sqlName']).addClass('time');
      var value = GUI.dom("span").addClass('time');
      if(option.val) value.html(option.val);
     
      var input = GUI.dom('input').attr('name', option['sqlName'])    
                                  .attr('value', option['val'])
                                  .addClass('time');     
     
      var n = GUI.node(label, value, input, true);
      container.append(n);
    }
    container.children(".row:first").children(".half").prepend(header);
    this.form.append(container);
    // console.log(el);
  },
  checkbox : function(el){},
  dropDown : function(el){
    var header = GUI.label(el.name, el.name, true);
    var container = GUI.dom("div").addClass('multiple row');
     for(var i in el.options){
      var option = el.options[i];
      var label = GUI.label(option.name, option['sqlName']);
      var value = GUI.dom("span");
      if(option.val) value.html(option.val);
      

      var n = GUI.node(label, value, "");
      container.append(n);
    }   
    container.children(".row:first").children(".half").prepend(header); 
    this.form.append(container);
    console.log(el);
  }
}


GUI.node = function(label, valA, valB, invert){
  if(invert)
    return GUI.column([valA, label], [valB, label.clone()]);
  else
    return GUI.column([label, valA], [label.clone(), valB]);
}
GUI.dom = function(tag){ return $("<" + tag + "></" + tag + ">");}
GUI.label = function(label, sqlName, isFull){
  var a = GUI.dom("p").attr("name", sqlName).addClass('label').html(label);
  return isFull ? a.addClass('full-label') : a;
}
/* Separates a and b into a column */
GUI.column = function(l, r){
  var row = GUI.dom('div').addClass('row');
  var left = GUI.dom('div').addClass('half system').append(l);
  var right = GUI.dom('div').addClass('half omega user').append(r);
  var brk = GUI.dom('br').addClass('clearfix');
  return row.append([left, right, brk]);
}

  
GUI.dd = function(type, values){

  list = GUI.dom("ul").addClass('name', type);
  
  var lis = $.map(values, function(el, i){
    return GUI.dom('li').append(GUI.dom('a').html(el)).attr('name', el);
  });

  return list.append(lis);
}
