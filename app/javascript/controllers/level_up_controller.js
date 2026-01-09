import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "dialog"];

  connect() {
    this._onKeydown = this._onKeydown.bind(this);
  }

  toggle(event) {
    if (event) event.preventDefault();
    const modal = this.modalTarget;
    modal.classList.toggle("hidden");

    if (!modal.classList.contains("hidden")) {
      document.addEventListener("keydown", this._onKeydown);
      document.documentElement.classList.add("overflow-hidden");
      const firstInput = modal.querySelector("input, select, textarea, button");
      if (firstInput) firstInput.focus();
    } else {
      document.removeEventListener("keydown", this._onKeydown);
      document.documentElement.classList.remove("overflow-hidden");
    }
  }

  close() {
    const modal = this.modalTarget;
    if (modal && !modal.classList.contains("hidden")) {
      modal.classList.add("hidden");
      document.removeEventListener("keydown", this._onKeydown);
      document.documentElement.classList.remove("overflow-hidden");
    }
  }

  stop(event) {
    event.stopPropagation();
  }

  _onKeydown(e) {
    if (e.key === "Escape") {
      this.close();
    }
  }
}
