var DANEBOOK = DANEBOOK || {}

DANEBOOK.ajax = {

  sendPost: function(text) {
    var data = {
      body: text,
    }
    $.post({
      url: "/posts",
      data: data,
      dataType: "json"

    })
  }

}