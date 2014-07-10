function buildLanguagesDoughnut(data){
  var languages = $.parseJSON(data)
  var langsCanvas = $("#languages-doughnut")[0].getContext("2d");
  var langsData = [];
  var legendTemplate = "<ul class=\"languages-doughnut-legend-item\">";
  var randomColors = randomColor({
    count: Object.keys(languages).length,
    luminosity: "dark"
  });

  each_index = 0
  $.each(languages, function(language, percent){
    langsData.push({
      value: percent, 
      color: randomColors[each_index], 
      highlight: randomColors[each_index], 
      label: language
    });
    legendTemplate += ("<li style=\"color:" + randomColors[each_index] + ";\">" +
      language + ": " + percent + "%</li>")
    each_index ++;
  });

  var langsOptions = {
    responsive: true,
    legendTemplate: legendTemplate + "</ul>"
  };
  var languagesDoughnut = new Chart(langsCanvas).Doughnut(langsData, langsOptions);
  $("#languages-doughnut-legend").append(languagesDoughnut.generateLegend());
}
