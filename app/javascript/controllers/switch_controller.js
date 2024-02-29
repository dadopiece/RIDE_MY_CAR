import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tabs", "cards", "map"]

  handleClick(event) {
    if (event.params.toggabletarget === "list") {
      this.showCards()
    } else {
      this.showMap()
    }
  }

  showCards() {
    this.mapTarget.classList.add("d-none")
    this.cardsTarget.classList.remove("d-none")
    this.tabsTarget.children[0].classList.add("btn-primary")
    this.tabsTarget.children[0].classList.remove("btn-outline-primary")
    this.tabsTarget.children[1].classList.add("btn-outline-primary")
    this.tabsTarget.children[1].classList.remove("btn-primary")
  }


  showMap() {
    this.mapTarget.classList.remove("d-none")
    this.cardsTarget.classList.add("d-none")
    this.tabsTarget.children[0].classList.remove("btn-primary")
    this.tabsTarget.children[0].classList.add("btn-outline-primary")
    this.tabsTarget.children[1].classList.remove("btn-outline-primary")
    this.tabsTarget.children[1].classList.add("btn-primary")
  }
}
