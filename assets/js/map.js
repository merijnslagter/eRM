import L from "leaflet"
import { Socket } from "phoenix"

let socket = new Socket("/socket", { params: { token: window.userToken } })
//let socket = new Socket("/socket")

let mapContainer = document.querySelector("#mapid")
let myMap = null
let map;

socket.connect()


if (mapContainer) {
    map = L.map('mapid').fitWorld();
    console.log(map)
    

    //map = L.map('mapid').setView([51.505, -0.09], 18);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        
        id: 'mapbox.streets',
        //maxZoom: 15,
        minZoom: 3,
        accessToken: 'pk.eyJ1IjoidGllcnJhbGlicmUiLCJhIjoiY2preHo4bDM0MGN2djN2cjBzOHN3bTR1bCJ9.TunGBy7jq9N_X6hFM7WRcQ'
    }).addTo(map);


    let channel = socket.channel("map:lobby", {})
    channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on("eis:list", payload => {
        console.log("eis:list:payload")
        console.log(payload)
        payload.data.map(ei => {
                if (ei.lat != null || ei.long != null){
                    const lat = parseFloat(ei.lat)
                    const long = parseFloat(ei.long)
                    const marker = L.marker([lat, long], {ei_id: ei.id}).addTo(map)
                    marker.bindPopup("<b>"+ ei.description+"</b>. " ).on('click', markerOnClick)
                    
                    //centerLeafletMapOnMarker(map, marker)
                }
            }) 
        
    })

    function centerLeafletMapOnMarker(map, marker) {
        var latLngs = [ marker.getLatLng() ];
        var markerBounds = L.latLngBounds(latLngs);
        map.fitBounds(markerBounds);
      }

    function markerOnClick(e)
    {
        console.log(e.target.options.ei_id)
        channel.push("ei:selected", {ei_id: e.target.options.ei_id})
    }

    channel.on("ei:selected", payload => {
        console.log("ei:selected")
        console.log(payload)
        let liveDiv = $("#live-div")
        if(liveDiv){
            console.log(liveDiv)
            liveDiv.empty()
            liveDiv.append(payload.html)
        }else {
            console.log("no liveDiv")
        }
    })
}


export default map
