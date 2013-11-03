// Validates new design method form.
$(function() {
  var valid = true;
  $("#new_design_method").submit(function( event ) {
    if ($("#design_method_name").val() == "") {
      $("span#name").text("Please name your method.").show();
      valid = false;
    }
    if ($("#design_method_overview").val() == "") {
      $("span#overview").text("Your method must have an overview.").show();
      valid = false;
    }
    if (!valid) {
      alert("Mandatory fields were left empty.");
      event.preventDefault();
    }
  })
});