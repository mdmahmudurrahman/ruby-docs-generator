//= require jquery
//= require lodash
//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets

//= require docxtemplater
//= require jszip-utils
//= require file-saver
//= require jquery-ui

//= require_tree .
//= require_self

$(function () {
  prepareTabs();
  prepareMoveButtons();
  prepareTimeCheckbox();

  if ($('[action="documents#generate"]').length > 0) {
    const loadFile = function (url, callback) {
      JSZipUtils.getBinaryContent(url, callback);
    };

    const template_url = $('.keeper-of-template-path').attr('url');

    loadFile(template_url, function (error, content) {
      if (error) throw e;

      const doc = new Docxgen(content);
      const url = $('.keeper-of-document-path').attr('url');

      console.log(url);

      $.get(url, function (response) {
        doc.setData(response);
        doc.render();

        const out = doc.getZip().generate(
          {type: "blob"}
        );

        saveAs(out, "output.docx");
      });
    });
  }
});

function prepareMoveButtons() {
  const buttons = $('.panel-body-container a.btn-xs');

  // hide the first and the last buttons
  buttons.first().hide();
  buttons.last().hide();

  // make second and penultimate buttons long
  $(buttons.get(1)).css('width', '95px');
  $(buttons.get(-2)).css('width', '95px');
}

function prepareTimeCheckbox() {
  // block with inputs for entering time for labs and lectures
  const fields = $('.labs-and-lectures-time-inputs');

  const callback = function () {
    fields.slideToggle();
  };

  const checkbox = $('input[type=checkbox]');
  if (checkbox.is(':checked')) callback();
  checkbox.change(callback);
}

function prepareTabs() {
  $("#tabs").tabs();
}
