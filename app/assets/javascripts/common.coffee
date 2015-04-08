$ ->
  do ->
    appendOptions = ($select, results) ->
      option = $('<option>')
      $select.append(option)
      $.each results, ->
        option = $('<option>')
        option.val(this.id)
        option.text(this.name)
        $select.append(option)

    replaceChildrenOptions = ->
      childrenPath = $(@).find('option:selected').data().childrenPath
      $selectChildren = $(@).closest('form').find('.select-children')
      if childrenPath?
        $.ajax
          url: childrenPath
          dataType: "json"
          success: (results) ->
            $selectChildren.empty()
            appendOptions($selectChildren, results)
          error: (XMLHttpRequest, textStatus, errorThrown) ->
            console.error("Error occurred in replaceChildrenOptions")
            console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
            console.log("textStatus: #{textStatus}")
            console.log("errorThrown: #{errorThrown}")
      else
        $selectChildren.empty()

    $('.select-parent').on
      'change': replaceChildrenOptions