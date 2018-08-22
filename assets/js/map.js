import L from "leaflet"

let mapContainer= document.querySelector("#mapid")
let myMap = null
let map;


if(mapContainer) {
    map = L.map('mapid').fitWorld();
    console.log(map)

    //map = L.map('mapid').setView([51.505, -0.09], 13);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox.streets',
    accessToken: 'pk.eyJ1IjoidGllcnJhbGlicmUiLCJhIjoiY2preHo4bDM0MGN2djN2cjBzOHN3bTR1bCJ9.TunGBy7jq9N_X6hFM7WRcQ'
    }).addTo(map);
}


export default map
