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
  if ($('[action="documents#generate"]').length > 0) {
    const loadFile = function (url, callback) {
      JSZipUtils.getBinaryContent(url, callback);
    };

    loadFile("/assets/template.docx", function (error, content) {
      if (error) throw e;

      const data = {};
      const doc = new Docxgen(content);

      $.get('/documents/1/document-data', function (response) {
        $.extend(data, response);

        doc.setData(data);

        doc.render();

        const out = doc.getZip().generate({type: "blob"});

        saveAs(out, "output.docx");
      });
    });
  }
});
