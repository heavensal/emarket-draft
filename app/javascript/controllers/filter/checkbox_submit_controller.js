import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filter--checkbox-submit"
export default class extends Controller {
  static targets = ["checkbox", "label", "form"];

  connect() {
    console.log("connected");
    this.checkboxTargets.forEach(checkbox => {
      this.updateLabel(checkbox);
    });
  }

    // Applique les styles dynamiques au label en fonction de l'état de la checkbox
    updateLabel(checkbox) {
      const label = checkbox.nextElementSibling;
      if (checkbox.checked) {
        label.classList.remove("bg-gray-600");
        label.classList.add("bg-orange-600");
      } else {
        label.classList.remove("bg-orange-600");
        label.classList.add("bg-gray-600");
      }
    }

  filterCategory() {

    // Soumet le formulaire
    this.formTarget.requestSubmit();
  }
}
