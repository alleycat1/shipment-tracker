import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["list", "all", "in_transit", "in_preparation", "delivered", "problematic"];

  connect() {
    console.log('Hello, Stimulus!');

  }

  update(event) {
    const category = event.currentTarget.dataset.shipment;
    const targetsArray = [this.allTarget, this.in_transitTarget, this.in_preparationTarget, this.deliveredTarget, this.problematicTarget];
    targetsArray.map((element)=>element.classList.remove("active-color"));
    event.currentTarget.classList.add("active-color");
    const url = `/shipments?query=${category}`
    fetch(url, { headers: { "Accept": "text/plain" } })
    .then(response => response.text())
    .then((data) => {
      this.listTarget.innerHTML = data;
    })

  }
}
