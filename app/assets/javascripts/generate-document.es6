$(() => {
  if ($('[action="documents#generate"]').length > 0) {
    const loadFile = (url, callback) => JSZipUtils.getBinaryContent(url, callback);
    const template_url = $('.keeper-of-template-path').attr('url');

    loadFile(template_url, (error, content) => {
      if (error) throw e;

      const url = $('.keeper-of-document-path').attr('url');
      const doc = new Docxgen(content);

      $.get(url, (response) => {
        doc.setData(response);
        doc.render();

        const out = doc.getZip().generate({type: "blob"});

        saveAs(out, "output.docx");
      });
    });
  }
});
