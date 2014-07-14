// function createColorScheme(languages_percents) {
//   var languages = $.parseJSON(languages_percents);
//   var randomColors = randomColor({
//     count: Object.keys(languages).length,
//     luminosity: "dark"
//   });
//   return randomColors;
// }
function randomFlatUIColor() {
  var flatUIColors = ["#D24D57", "#F22613", "#FF0000", "#D91E18", "#96281B", "#EF4836", "#D64541", "#C0392B", "#CF000F", "#E74C3C", "#DB0A5B", "#FFECDB", "#F64747", "#F1A9A0", "#D2527F", "#E08283", "#F62459", "#E26A6A", "#663399", "#674172", "#AEA8D3", "#913D88", "#9A12B3", "#BF55EC", "#BE90D4", "#8E44AD", "#9B59B6", "#E4F1FE", "#4183D7", "#59ABE3", "#81CFE0", "#52B3D9", "#C5EFF7", "#22A7F0", "#3498DB", "#2C3E50", "#19B5FE", "#336E7B", "#22313F", "#6BB9F0", "#1E8BC3", "#3A539B", "#34495E", "#67809F", "#2574A9", "#1F3A93", "#89C4F4", "#4B77BE", "#5C97BF", "#A2DED0", "#87D37C", "#90C695", "#26A65B", "#03C9A9", "#68C3A3", "#65C6BB", "#1BBC9B", "#1BA39C", "#66CC99", "#36D7B7", "#049372", "#C8F7C5", "#86E2D5", "#2ECC71", "#16a085", "#3FC380", "#019875", "#26C281", "#03A678", "#4DAF7C", "#2ABB9B", "#00B16A", "#1E824C", "#F89406", "#EB9532", "#E87E04", "#F4B350", "#F2784B", "#EB974E", "#F5AB35", "#F4D03F", "#D35400", "#F39C12", "#F9690E", "#F7CA18", "#F9BF3B", "#F27935", "#E67E22"];
  return flatUIColors[Math.floor(Math.random() * flatUIColors.length)]
}

function buildLanguagesDoughnut(data){
  var languages = $.parseJSON(data);
  var langsCanvas = $("#languages-doughnut")[0].getContext("2d");
  var langsData = [];
  var legendTemplate = "<div class=\"row\">";
  // var randomColors = randomColor({
  //   count: Object.keys(languages).length,
  //   luminosity: "bright", 
  //   brightness: "bright"
  // });
  var randomColors = [];
  for (i = 0; i <= Object.keys(languages).length; i++) {
    randomColors.push(randomColor());
  }

  each_index = 0;
  $.each(languages, function(language, percent){
    langsData.push({
      value: percent,
      color: randomColors[each_index],
      highlight: randomColors[each_index],
      label: language
    });
    legendTemplate += ("<div class=\"col-md-6\"><div style=\"border-left:6px solid " + randomColors[each_index] +
      ";color: black;padding:15px;\" class=\"panel\">" + language + ": " + percent + "%</div></div>");
    each_index ++;
  });

  var langsOptions = {
    responsive: true,
    legendTemplate: legendTemplate + "</div>",
    segmentStrokeWidth: 3
  };
  var languagesDoughnut = new Chart(langsCanvas).Doughnut(langsData, langsOptions);
  if( $('#languages-doughnut-legend:empty').length ) {
    $("#languages-doughnut-legend").append(languagesDoughnut.generateLegend());
  }
}

function buildCommitPlot(data) {
  var commitActivity = data;
}

$(function () {
  $("#hidden-wrapper").fadeIn(800, "linear");
  $("a.refresh-profile-btn").on("ajax:beforeSend", function(e, data, textStatus, jqXHR) {
    $(this).find("i").addClass("fa-spin");
    $(".nav-btn").find("i").addClass("fa-spin");
  });
  $("a.refresh-profile-btn").on("ajax:complete", function(e, data, textStatus, jqXHR) {
    console.log("Update successful!");
    $(this).find("i").removeClass("fa-spin");
    $(".nav-btn").find("i").removeClass("fa-spin");
  });


  $body = $('body');
  $trig = $('.trigger');
    $trig.click(function () {
        $('.nav-wrap').toggleClass('open');
        $body.toggleClass('body-left');
        return false;
    });
    $trig.bind('touchstart', function (e) {
      $(this).trigger('click');
      e.preventDefault();
    });
    $body.click(function (event) {
        if (!$(event.target).closest('.nav-wrap').length) {
            $('.nav-wrap').removeClass('open');
            $body.removeClass('body-left');
        }
    });
});
