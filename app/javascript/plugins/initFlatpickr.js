import flatpickr from "flatpickr";

const initFlatpickr = () => {
  flatpickr(".datepicker", {
    allowInput: true,
  });
}

export default initFlatpickr;
