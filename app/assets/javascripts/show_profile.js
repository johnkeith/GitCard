function buildLanguagesDoughnut(){
  var langsCanvas = $("#languages-doughnut")[0].getContext("2d");
  var langsData = [
    {
        value: 300,
        color:"#F7464A",
        highlight: "#FF5A5E",
        label: "Red"
    },
    {
        value: 50,
        color: "#46BFBD",
        highlight: "#5AD3D1",
        label: "Green"
    },
    {
        value: 100,
        color: "#FDB45C",
        highlight: "#FFC870",
        label: "Yellow"
    }
  ];
  var langsOptions = {};
  var languagesDoughnut = new Chart(langsCanvas).Doughnut(langsData, langsOptions);
}
