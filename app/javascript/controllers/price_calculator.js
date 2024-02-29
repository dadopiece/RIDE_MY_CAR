document.addEventListener('turbolinks:load', function() {
  const startDateInput = document.querySelector('#booking_start_date');
  const endDateInput = document.querySelector('#booking_end_date');
  const priceDisplay = document.querySelector('#calculated-price');
  // Assurez-vous de convertir la valeur récupérée en float
  const pricePerDay = parseFloat(document.querySelector('#car-price-per-day').textContent.trim());

  function calculatePrice() {
    const startDate = new Date(startDateInput.value);
    const endDate = new Date(endDateInput.value);
    const timeDiff = endDate - startDate;
    // Assurez-vous d'arrondir à l'entier le plus proche pour éviter les prix fractionnés de jours
    const days = Math.round(timeDiff / (1000 * 3600 * 24)) + 1; // +1 pour inclure le jour de début

    const totalPrice = days * pricePerDay;

    if (!isNaN(totalPrice) && totalPrice > 0) {
      priceDisplay.innerHTML = `<strong>Prix Total : </strong>${totalPrice.toFixed(2)}€`;
    } else {
      priceDisplay.innerHTML = 'Veuillez sélectionner des dates valides.';
    }
  }

  if (startDateInput && endDateInput) {
    startDateInput.addEventListener('change', calculatePrice);
    endDateInput.addEventListener('change', calculatePrice);
  }
});
