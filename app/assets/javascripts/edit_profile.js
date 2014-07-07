function toggleLoading(){
  console.log("Loading...");
}

$(document).ready(function(){
  $(".repo-visibility-toggle").change(function(){
    $(this).parents('form:first').submit();
  });
  
  $(".repo-visibility")
    .bind("ajax:loading", toggleLoading())
    .bind("ajax:complete", toggleLoading())
    .bind("ajax:success", function(e, data, status, xhr) {
      console.log(data);
    });
});
