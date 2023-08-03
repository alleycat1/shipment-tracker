import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/starshipsssss/cl42fzh30002x14qlx9knq50y"
      // interactive: false
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    this.markers_array = this.markersValue.map((marker) => {
      return [marker.lng, marker.lat]
    })

    this.map.on('load', () => {
      console.log(this.markers_array)
      this.map.addSource('route', {
      'type': 'geojson',
      'data': {
      'type': 'Feature',
      'properties': {},
      'geometry': {
      'type': 'LineString',
      'coordinates': this.markers_array,
      }
      }
      });
      this.map.addLayer({
      'id': 'route',
      'type': 'line',
      'source': 'route',
      'layout': {
      'line-join': 'round',
      'line-cap': 'round'
      },
      'paint': {
      'line-color': '#9198a3',
      'line-width': 1,
      'line-dasharray': [1, 4]
      }
      });
      });
  }

  #addMarkersToMap() {
    let counter = 0
    this.markersValue.forEach((marker) => {
      counter += 1
    })
    console.log(counter)
    this.markersValue.forEach((marker, index) => {
      // const popup = new mapboxgl.Popup().setHTML(marker.info_window)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("a")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${marker.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.backgroundRepeat = "no-repeat"
      customMarker.style.width = "20px"
      customMarker.style.height = "20px"
      if (index == 0 || index == counter - 1) {
        customMarker.style.marginLeft = "7px"
        customMarker.style.paddingBottom = "39px"
      } else if (index == counter - 2) {
        customMarker.style.paddingBottom = "51px"
        customMarker.style.paddingRight = "1px"
      } else {
        customMarker.style.paddingBottom = "39px"
      }

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        // .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
