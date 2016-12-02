$(() => {
  const buttons = $('.panel-body-container a.btn-xs');

  // hide the first and the last buttons
  buttons.first().hide();
  buttons.last().hide();

  // make second and penultimate buttons long
  $(buttons.get(1)).css('width', '95px');
  $(buttons.get(-2)).css('width', '95px');
});
