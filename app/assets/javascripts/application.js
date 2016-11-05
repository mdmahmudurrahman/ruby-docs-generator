//= require jquery
//= require jquery3
//= require jquery_ujs
//= require bootstrap-sprockets

//= require docxtemplater
//= require jszip-utils
//= require file-saver

//= require_tree .
//= require_self

$(function () {
  const container = $('.panel-body-container');
  var buttons = container.find('a.btn-xs');

  buttons.first().hide();
  buttons.last().hide();

  $(buttons.get(1)).css('width', '95px');
  $(buttons.get(-2)).css('width', '95px');

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
