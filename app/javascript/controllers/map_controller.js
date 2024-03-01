// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // Créez un élément div pour chaque marqueur et ajoutez le prix
      const el = document.createElement('div');
      el.className = 'marker';
      el.style.width = '50px'; // La largeur du marqueur
      el.style.height = '50px'; // La hauteur du marqueur
      el.style.backgroundColor = "#FFF"; // La couleur de fond
      el.style.color = "black"; // La couleur du texte
      el.style.display = "flex";
      el.style.justifyContent = "center";
      el.style.alignItems = "center";
      el.style.borderRadius = "50%"; // Pour un marqueur rond
      el.style.border = "3px solid black"; // Bordure du marqueur
      el.innerText = `${marker.price} €`; // Ajoutez le prix ici

      // Utilisez l'élément personnalisé pour le marqueur
      new mapboxgl.Marker(el)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map);
    });
  }
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
