$(function() {
  const $sidebar = $(".sidebar")

  $sidebar.find(".dropdown").click(function(event) {
    event.preventDefault()
    $sidebar.addClass("open")
  })

  $sidebar.find(".close, .sidebar-overlay").click(function(event) {
    event.preventDefault()
    $sidebar.removeClass("open")
  })

  $sidebar.find(".toggle-item").click(function(event) {
    event.preventDefault()
    const data = $(event.target).attr("data-toggle")
    $('.toggle[data-id!="' + data + '"]').hide("fast")
    $('.toggle[data-id="' + data + '"]').toggle("fast")
  })
})
