---
layout: null
---
$(function() {
  // HEADER ==>

  function openDropdown() {
    closeSearchResults()
    closeSidebar()
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
    $(".header_search").addClass("open")
    $(".header_search .search-results").empty()
    $("header .search-overlay").addClass("open")
  }

  function closeSearchResults() {
    $(".header_search").removeClass("open")
    $("header .search-overlay").removeClass("open")
  }

  $("header .dropdown-trigger").click(function(event) {
    event.preventDefault()
    $(this).hasClass("open") ? closeDropdown() : openDropdown()
  })

  $("header .dropdown-overlay").click(function(event) {
    event.preventDefault()
    closeDropdown()
  })

  $("header .search-overlay").click(function(event) {
    event.preventDefault()
    closeSearchResults()
  })

  const $searchInput = $('.header_search input[type="search"]')

  $("header .close").click(function(event) {
    event.preventDefault()
    closeSearchResults()
    $searchInput.val('')
  })

  $searchInput.focus(function() {
    closeSidebar()
    closeDropdown()
    showSearchResults()
  })

  function zoomDisable() {
    $('head meta[name=viewport]').remove()
    $('head').prepend('<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0" />')
  }

  function zoomEnable() {
    $('head meta[name=viewport]').remove()
    $('head').prepend('<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=1" />')
  }

  const $inputs = $('.header_search input[type="search"], select, .newsletter input[type="email"]')

  $inputs.on('touchstart', function() {
    zoomDisable()
  })

  $inputs.on('touchend', function() {
    setTimeout(zoomEnable, 500)
  })

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

  function showSearchResults() {
    const userInput = $searchInput.val().toLowerCase()

    if (userInput.length === 0) {
      closeSearchResults()
      return
    }

    openSearchResults()

    const items = window.index
      .search(userInput)
      .map(index => window.data[index.ref])

    const limit = 4
    const results = items.slice(0, limit)
    const $list = $('.header_search .search-results')

    for (result of results) {
      let category = result.categories.split(',')[0]
      if (category === 'Decentraland') {
        category = 'general'
      }

      $list.append(
        `<li>
          <a href="${result.url}">
            <div class="icon">
              <img src="{{ site.baseurl }}/images/sets/${category}.svg" />
            </div>
            <div>
              <span class="title">${result.title}</span>
              <span class="description">${getPreview(userInput, result.content, 120)}</span>
            </div>
          </a>
        </li>`
      )
    }

    if (items.length > limit) {
      $list.append(
        `<li class="more-results">
          <a href="/search/?q=${userInput}">See more results</a>
        </li>`
      )
    }

    $list.find('li')
      .mouseenter(function() {
        $list.find('li.selected').removeClass('selected')
        $(this).addClass('selected')
      })
      .mouseleave(function() {
        $(this).removeClass('selected')
      })
  }

  $searchInput.keydown(function(event) {
    const $list = $('.header_search .search-results')
    const $selected = $list.find('li.selected')

    let $next

    function selectNextItem() {
      event.preventDefault()
      $selected.removeClass('selected')
      $next.addClass('selected')
    }

    switch (event.key) {
      case 'Down': // IE specific value
      case 'ArrowDown':
        $next = $selected.next()
        if ($next.length === 0) {
          $next = $list.find('li:first-child')
        }
        selectNextItem()
        break

      case 'Up': // IE specific value
      case 'ArrowUp':
        $next = $selected.prev()
        if ($next.length === 0) {
          $next = $list.find('li:last-child')
        }
        selectNextItem()
        break

      case 'Enter':
        if ($selected.length > 0) {
          event.preventDefault()
          document.location.href = $selected.find('a').attr('href')
        }
        break
    }
  })

  let fetching = false

  $searchInput.on('input', function() {
    if (fetching) return

    if (window.data) {
      showSearchResults()
      return
    }

    fetching = true

    $.getJSON('{{ site.baseurl }}/data.json', function(data) {
      fetching = false
      window.data = data
      window.index = lunr(function() {
        this.field('id')
        this.field('title', { boost: 10 })
        this.field('categories')
        this.field('url')
        this.field('content')
      })

      for (var key in window.data) {
        window.index.add(window.data[key])
      }

      showSearchResults()
    })
  })

  // SIDEBAR ==>

  const $sidebar = $(".sidebar")

  function closeSidebar() {
    $sidebar.removeClass("open")
  }

  $sidebar.find(".dropdown").click(function(event) {
    event.preventDefault()
    $sidebar.addClass("open")
    $('body').addClass("modal-open")
  })

  $sidebar.find(".close").click(function(event) {
    event.preventDefault()
    closeSidebar()
    $('body').removeClass("modal-open")
  })

  $sidebar.find(".toggle-item").click(function(event) {
    event.preventDefault()
    const data = $(event.target).attr("data-toggle")
    $('.toggle[data-id!="' + data + '"]').hide("fast")
    $('.toggle[data-id="' + data + '"]').toggle("fast")
  })

  // HEADINGS ==>

  const headings = document.querySelectorAll("h2[id]")

  for (var i = 0; i < headings.length; i++) {
    const anchorLink = document.createElement("a")
    anchorLink.innerText = "#"
    anchorLink.href = "#" + headings[i].id
    anchorLink.classList.add("header-link")

    headings[i].appendChild(anchorLink)
  }

  $('a[href*=\\#]').not('.no-smooth').on('click', function() {
    const $el = $(this.hash)
    if ($el.length > 0) {
      $('html,body').animate({ scrollTop: $el.offset().top - 30 }, 500)
    }
  })

  // LANGUAGE ==>

  function dismissLanguageBar() {
    Cookies.set('language', true)
    $('.select-language').removeClass('visible')
  }

  $('select#lang').on('change', function() {
    const value = $(this).val()
    dismissLanguageBar()
    $('select#lang').val(value)
    $('.lang-flag')
      .removeClass('english chinese')
      .addClass(value)
  })

  $('.select-language .dismiss').click(function() {
    dismissLanguageBar()
  })

  if (!Cookies.get('language')) {
    $('.select-language').addClass('visible')
  }

  // FEEDBACK ==>

  const $feedback = $('.feedback')
  const $textarea = $feedback.find('.textarea')
  const $input = $textarea.find('textarea')
  const $mirror = $textarea.find('.mirror')

  function sendingFeedback(value) {
    $feedback.addClass('sending ' + value)
    $textarea.click()
  }

  $feedback.find('.yes').click(function() {
    sendingFeedback('yes')
  })

  $feedback.find('.no').click(function() {
    sendingFeedback('no')
  })

  function resetFeedback() {
    $input.val('')
    $mirror.text('')
  }

  function submitFeedback() {
    // TODO: send to Segment
    return new Promise(() => console.log($input.val()))
  }

  function sendFeedback() {
    $feedback.removeClass('sending').addClass('sent')
    submitFeedback().then(() => resetFeedback())
  }

  function skipFeedback() {
    $feedback.removeClass('sending yes no')
    resetFeedback()
  }

  $feedback.find('.send').click(function() {
    sendFeedback()
  })

  $feedback.find('.skip').click(function() {
    skipFeedback()
  })

  $textarea.on('click', function() {
    $input.focus();
  })

  $input.on('keydown keyup', function(event) {
    switch (event.key) {
      case 'Enter':
        sendFeedback()
        break;
      case 'Escape':
        skipFeedback()
        break;
      default:
        $mirror.text(event.target.value)
    }
  })

})
