$(document).on('ready', setup);

function setup () {

  // Image upload
  $('#faux_upload').click(function() {
    $('#upload').click();
  });

  $('#upload').on('change', function (event) {
    var data = new FormData();
    $.each(event.target.files, function(i, file) {
      data.append('file-'+i, file);
    });
    console.log('sending to ' + event.target.parentNode.action)
    $.ajax({
      url: event.target.parentNode.action,
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      type: 'POST',
      success: function(data){
        alert(data);
      }
    });
  });

  // Replace default titles on click
  $('input[name=title]').on('focus', function (event) { var input = event.target; if (input.value == input.dataset['default'])  { input.value = "";                       } });
  $('input[name=title]').on('blur',  function (event) { var input = event.target; if (input.value == '')                        { input.value = input.dataset['default']; } });

  // Preview markdown in preview panel
  var converter = new Markdown.Converter();
  var preview_title   = $('#admin .preview .title')[0];
  var preview_content = $('#admin .preview .content')[0];
  $('#admin .editor input[name=title]').on('keyup', function (event) {
    preview_title.innerHTML = event.target.value;
  });
  $('#admin .editor textarea').on('keyup', function (event) {
    preview_content.innerHTML = converter.makeHtml(event.target.value);
  });
  preview_title.innerHTML = $('#admin .editor input[name=title]')[0].value;
  preview_content.innerHTML = converter.makeHtml($('#admin .editor textarea')[0].value);

  // Save form on Cmd+S
  $(window).on('keydown', function(event) { 
    if (!(event.which == 83 && event.metaKey) && 
        !(event.which == 19))
      return true;
    $('#admin .editor form').submit();
    return false; 
  });

}