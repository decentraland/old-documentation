---
layout: null
---
function getPreview(query, content, previewLength) {
  previewLength = previewLength || content.length * 2

  var parts = query.split(" "),
    match = content.toLowerCase().indexOf(query.toLowerCase()),
    matchLength = query.length,
    preview

  // Find a relevant location in content
  for (var i = 0; i < parts.length; i++) {
    if (match >= 0) {
      break
    }

    match = content.toLowerCase().indexOf(parts[i].toLowerCase())
    matchLength = parts[i].length
  }

  // Create preview
  if (match >= 0) {
    var start = match - previewLength / 2,
      end = start > 0 ? match + matchLength + previewLength / 2 : previewLength

    preview = content.substring(start, end).trim()

    if (start > 0) {
      preview = "..." + preview
    }

    if (end < content.length) {
      preview = preview + "..."
    }

    // Highlight query parts
    preview = preview.replace(
      new RegExp("(" + parts.join("|") + ")", "gi"),
      "<strong>$1</strong>"
    )
  } else {
    // Use start of content if no match found
    preview =
      content.substring(0, previewLength).trim() +
      (content.length > previewLength ? "..." : "")
  }

  return preview
}

function openDropdown() {
  closeSearchResults()
  $("header .dropdown-trigger").addClass("open")
  $("header .dropdown-content").addClass("open")
  $("header .dropdown-overlay").addClass("open")
}

function closeDropdown() {
  $("header .dropdown-trigger").removeClass("open")
  $("header .dropdown-content").removeClass("open")
  $("header .dropdown-overlay").removeClass("open")
}

function openSearchResults() {
  $(".header_search .search-results").empty().addClass("open")
  $("header .search-overlay").addClass("open")
}

function closeSearchResults() {
  $(".header_search .search-results").removeClass("open")
  $("header .search-overlay").removeClass("open")
}

$(function() {
  $("header .dropdown-trigger").on("click", function(event) {
    event.preventDefault()
    $(this).hasClass("open")
      ? closeDropdown()
      : openDropdown()
  })

  $("header .dropdown-overlay").on("click", function(event) {
    event.preventDefault()
    closeDropdown()
  })

  $("header .search-overlay").on("click", function(event) {
    event.preventDefault()
    closeSearchResults()
  })

  $('.header_search input[type="search"]').on("focus", function() {
    closeDropdown()
  })

  let fetching = false

  $('.header_search input[type="search"]').on("input", function() {
    if (!window.data && !fetching) {
      fetching = true

      $.getJSON("{{ site.baseurl }}/data.json", function(data) {
        fetching = false
        window.data = data

        window.index = lunr(function() {
          this.field("id")
          this.field("title", { boost: 10 })
          this.field("categories")
          this.field("url")
          this.field("content")
        })

        for (var key in window.data) {
          window.index.add(window.data[key])
        }
      })
    }

    if (window.data && !fetching) {
      const userInput = $(this)
        .val()
        .toLowerCase()

      if (userInput.length === 0) {
        closeSearchResults()
        return
      }

      const results = window.index
        .search(userInput)
        .map(index => window.data[index.ref])
        .slice(0, 4)

      openSearchResults()

      for (result of results) {
        $(".header_search .search-results").append(
          `<div>
            <a href="${result.url}">${result.title}</a>
            <p>${getPreview(userInput, result.content, 170)}</p>
          </div>`
        )
      }

      console.log(results)
    }
  })
})
