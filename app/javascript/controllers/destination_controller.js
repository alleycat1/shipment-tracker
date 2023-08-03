import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

export default class extends Controller {
  static values = { apiKey: String }

  static targets = ["destination_location"]

  connect() {
    this.geocoder = new MapboxGeocoder({
      accessToken: this.apiKeyValue,
      types: "country,region,place,postcode,locality,neighborhood,address"
    });
    this.geocoder.addTo(this.element)
    console.log(this.apiKeyValue)

    this.geocoder.on("result", event => this.#setInputValue(event))
    this.geocoder.on("clear", () => this.#clearInputValue())
  }

  #setInputValue(event) {
    console.log(event.result)
    this.destination_locationTarget.value = event.result["place_name"]
  }

  #clearInputValue() {
    this.destination_locationTarget.value = ""
  }
}
