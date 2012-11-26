$(document).on('ready', setup);

function setup () {



  $('input[type=text]').on('focus', function (event) {
    var input = event.target;
    if (!input.defaultValue || input.value == input.defaultValue) {
      input.defaultValue = input.value;
      input.value = "";
    }
    $(input).addClass('focus');
  });

  $('input[type=text]').on('blur', function (event) {
    var input = event.target;
    if (input.value == '') {
      input.value = input.defaultValue;
      $(input).removeClass('focus');
    }
  });

  var converter = new Markdown.Converter();
  var preview_title   = $('#admin .preview .title')[0];
  var preview_content = $('#admin .preview .content')[0];
  $('#admin .editor input[name=title]').on('keyup', function (event) {
    preview_title.innerHTML = event.target.value;
  });
  $('#admin .editor textarea').on('keyup', function (event) {
    preview_content.innerHTML = converter.makeHtml(event.target.value);
  });

  /*
  $(window).bind('keydown.ctrl_s keydown.meta_s', function(event) {
    event.preventDefault();
    console.log("Sacing!")
    // Do something here
  }, false);*/
}