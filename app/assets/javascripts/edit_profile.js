$(function(){
  $(".repo-visibility-toggle").change(function(){
    $(this).parents('form:first').submit();
  });
});
