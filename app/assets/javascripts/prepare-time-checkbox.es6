$(() => {
  // block with inputs for entering time for labs and lectures
  const fields = $('.labs-and-lectures-time-inputs');
  const callback = () => fields.slideToggle();
  const checkbox = $('input[type=checkbox]');
  if (checkbox.is(':checked')) callback();

  checkbox.change(callback);
});
