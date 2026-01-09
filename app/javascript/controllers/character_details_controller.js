import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["details", "btn"];

  connect() {
    if (this.hasDetailsTarget) this.detailsTarget.classList.add("hidden");
    if (this.hasBtnTarget) this.btnTarget.textContent = "Mostrar detalhes";
  }

  toggle() {
    if (!this.hasDetailsTarget || !this.hasBtnTarget) return;

    this.detailsTarget.classList.toggle("hidden");
    const visible = !this.detailsTarget.classList.contains("hidden");
    this.btnTarget.textContent = visible
      ? "Esconder detalhes"
      : "Mostrar detalhes";
  }
}
