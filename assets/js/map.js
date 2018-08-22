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

    //map = L.map('mapid').setView([51.505, -0.09], 13);

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
        maxZoom: 18,
        id: 'mapbox.streets',
        accessToken: 'pk.eyJ1IjoidGllcnJhbGlicmUiLCJhIjoiY2preHo4bDM0MGN2djN2cjBzOHN3bTR1bCJ9.TunGBy7jq9N_X6hFM7WRcQ'
    }).addTo(map);


    let channel = socket.channel("map:lobby", {})
    channel.join()
        .receive("ok", resp => { console.log("Joined successfully", resp) })
        .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on("eis:list", payload => {
        console.log("signature_ok")
        console.log(data)

        //var marker = L.marker([51.5, -0.09]).addTo(map)
        //let list = document.querySelector("#messages-list")
        //list.append("signature:ok::")
        //list.append(JSON.stringify(payload))
        //list.prop({scrollTop: list.prop("scrollHeight")})
    });
}


export default map
