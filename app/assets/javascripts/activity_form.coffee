$ ->
  $('.activity-form').submit ->
    $this = $(this)
    url = $this.attr('action')
    postData = $this.serialize()
    textInput = $this.find('input[name=\'post[body]\']')

    $.post url, postData, (data) ->
      textInput.val ''

      $('#activities').load document.URL + ' #activities'
      return

    false
  return
