import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"; // You need to import this to use new flatpickr()
import rangePlugin from "flatpickrRangePlugin";


export default class extends Controller {
  static targets = [ 'startDateInput', 'endDateInput' ]

  connect() {
    flatpickr(this.startDateInputTarget, {
    "plugins": [new rangePlugin({ input: this.endDateInputTarget})]
    })
  }
}
