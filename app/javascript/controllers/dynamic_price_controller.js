const startDate = document.getElementById("range_start");
const endDate = document.getElementById("range_end");

const dynamicPrice = () => {
  let dateDiffInMilliseconds = new Date(endDate.value) - new Date(startDate.value);
  let nbrOfNights = dateDiffInMilliseconds / 86400000;
};

dynamicPrice();

[startDate, endDate].forEach(date => {
  date.addEventListener("change", (event) => {
    dynamicPrice();
  });
})

const totalNights = document.getElementById("total-days")

// [...]

const dynamicPriceCalculator = () => {
  // [...]
  // je n'affiche le nombre de nuit que si les deux dates sont sélectionnées
  if(startDate.value && endDate.value) {
    totalDays.innerText = nbrOfDays
  }
};
