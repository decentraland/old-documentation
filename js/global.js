---
layout: null
---

function indexData(data) {
  var index = lunr(function() {
    this.field('id')
    this.field('title', { boost: 10 })
    this.field('categories')
    this.field('url')
    this.field('content')
  })

  for (var key in data) {
    index.add(data[key])
  }

  window.index = index
  window.data = data
}

if (!document.location.pathname.match('/search')) {
  $.getJSON('{{ site.baseurl }}/data.json?{{ site.time | date: "%s%N" }}', function(data) {
    indexData(data)
  })
}

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

$(function() {
  // HEADER ==>

  const $header = $('header')
  const $headerSearch = $('.header_search')

  function openDropdown() {
    closeSearchResults()
    closeSidebar()
    $header.find('.dropdown-trigger').addClass('open')
    $header.find('.dropdown-content').addClass('open')
    $header.find('.dropdown-overlay').addClass('open')
  }

  function closeDropdown() {
    $header.find('.dropdown-trigger').removeClass('open')
    $header.find('.dropdown-content').removeClass('open')
    $header.find('.dropdown-overlay').removeClass('open')
  }

  function openSearchResults() {
    $headerSearch.addClass('open')
    $headerSearch.find('.search-results').empty()
    $header.find('.search-overlay').addClass('open')
  }

  function closeSearchResults() {
    $headerSearch.removeClass('open')
    $header.find('.search-overlay').removeClass('open')
  }

  $header.find('.dropdown-trigger').click(function(event) {
    event.preventDefault()
    $(this).hasClass('open') ? closeDropdown() : openDropdown()
  })

  $header.find('.dropdown-overlay').click(function(event) {
    event.preventDefault()
    closeDropdown()
  })

  $header.find('.search-overlay').click(function(event) {
    event.preventDefault()
    closeSearchResults()
  })

  const $searchInput = $headerSearch.find('input[type="text"]')

  $header.find('.close').click(function(event) {
    event.preventDefault()
    closeSearchResults()
    $searchInput.val('')
  })

  $searchInput.on('focus click', function() {
    closeSidebar()
    closeDropdown()
    showSearchResults()
  })

  function showSearchResults() {
    const userInput = $searchInput.val().toLowerCase()

    if (userInput.length === 0) {
      closeSearchResults()
      return
    }

    openSearchResults()

    const items = window.index
      .search(userInput)
      .map(function (index) { return window.data[index.ref] })

    const limit = 4
    const results = items.slice(0, limit)
    const $list = $headerSearch.find('.search-results')

    for (var i = 0; i < results.length; i++) {
      var result = results[i]
      var category = result.categories.split(',')[0]

      if (category === 'Decentraland') {
        category = 'general'
      }

      $list.append(
        '<li>' +
          '<a href="' + result.url + '">' +
            '<div class="icon">' +
              '<img src="{{ site.baseurl }}/images/sets/' + category + '.svg" />' +
            '</div>' +
            '<div>' +
              '<span class="title">' + result.title + '</span>' +
              '<span class="description">' + getPreview(userInput, result.content, 120) + '</span>' +
            '</div>' +
          '</a>' +
        '</li>'
      )
    }

    if (items.length > limit) {
      $list.append(
        '<li class="more-results">' +
          '<a href="{{ site.baseurl }}/search/?q=' + userInput + '">See more results</a>' +
        '</li>'
      )
    }

    if (results.length === 0) {
      $list.append(
        '<li class="no-results">' +
          '<div class="image">' +
            '{% include search-big.svg %}' +
          '</div>' +
          '<strong>Sorry, we couldn\'t find any matches</strong>' +
          '<span>Try searching for a different keyword</span>' +
        '</li>'
      )
    }

    $list.find('li:not(.no-results)')
      .mouseenter(function() {
        $list.find('li.selected').removeClass('selected')
        $(this).addClass('selected')
      })
      .mouseleave(function() {
        $(this).removeClass('selected')
      })
  }

  $searchInput.keydown(function(event) {
    const $list = $headerSearch.find('.search-results')
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

      case 'Escape':
        closeSearchResults()
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
    $headerSearch.addClass('fetching')

    $.getJSON('{{ site.baseurl }}/data.json?{{ site.time | date: "%s%N" }}', function(data) {
      fetching = false
      $headerSearch.removeClass('fetching')

      indexData(data)
      showSearchResults()
    })
  })

  // SIDEBAR ==>

  const $sidebar = $('.sidebar')
  const $sidebarDropdown = $sidebar.find('.dropdown')

  function closeSidebar() {
    $sidebar.removeClass('open')
  }

  $sidebarDropdown.click(function(event) {
    event.preventDefault()
    $sidebar.addClass('open')
    $('body').addClass('modal-open')
  })

  $sidebar.find('.close').click(function(event) {
    event.preventDefault()
    closeSidebar()
    $('body').removeClass('modal-open')
  })

  $sidebar.find('.toggle-item').click(function(event) {
    event.preventDefault()
    const data = $(event.target).attr('data-toggle')
    $('.toggle[data-id!="' + data + '"]').hide('fast')
    $('.toggle[data-id="' + data + '"]').toggle('fast')
  })

  window.addEventListener('scroll', function () {
    const threshold = $header.height() + $header.offset().top
    $sidebarDropdown.toggleClass('sticky', window.scrollY > threshold)
  }, { passive: true })

  // HEADINGS ==>

  const headings = document.querySelectorAll('h2[id]')

  for (var i = 0; i < headings.length; i++) {
    const anchorLink = document.createElement('a')
    anchorLink.innerText = '#'
    anchorLink.href = '#' + headings[i].id
    anchorLink.classList.add('header-link')

    headings[i].appendChild(anchorLink)
  }

  $('a[href*=\\#]').not('.no-smooth').on('click', function() {
    const $el = $(this.hash)
    if ($el.length > 0) {
      $('html,body').animate({ scrollTop: $el.offset().top - 30 }, 500)
    }
  })

  // FEEDBACK ==>

  const $feedback = $('.feedback')
  const $textarea = $feedback.find('.textarea')
  const $input = $textarea.find('textarea')
  const $mirror = $textarea.find('.mirror')
  const $send = $feedback.find('.send')

  let articleWasUseful

  function sendingFeedback(value) {
    articleWasUseful = value

    resetFeedback()

    $feedback
      .removeClass('yes no')
      .addClass('sending ' + value)

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

  function sendFeedback(withFeedback) {
    const payload = {
      useful: articleWasUseful,
      feedback: withFeedback ? $input.val().trim() : null
    }

    {% if jekyll.environment == 'production' and site.segment_write_key != '' %}
      analytics.track('Article Feedback', payload)
    {% else %}
      console.log(payload)
    {% endif %}

    $send.prop({ disabled: true })
    $input.blur()
    $feedback
      .removeClass('sending')
      .addClass('sent')
  }

  $send.click(function() {
    sendFeedback(true)
  })

  $feedback.find('.skip').click(function() {
    sendFeedback(false)
  })

  $textarea.on('click', function() {
    if (window.zoomDisable) {
      window.zoomDisable()
    }
    $input.focus()
  })

  $input.on('keydown keyup', function(event) {
    const value = event.target.value;
    $send.prop({ disabled: value.trim().length === 0 })
    $mirror.text(value)
  })

  $input.on('keydown', function(event) {
    switch (event.key) {
      case 'Enter':
        if (!$send.attr('disabled')) {
          sendFeedback(true)
        } else {
          event.preventDefault()
        }
        break
    }
  })

  // SCROLLABLE TABLES ==>
  $('.tutorial-main table').wrap('<div class="scrollable"></div>')

  /*/ TOPBAR ==>
  $('.top .close').click(function() {
    Cookies.set('topbar', true, { expires: 30 })
    $('.top').removeClass('visible')
  })

  if (!Cookies.get('topbar')) {
    $('.top').addClass('visible')
  }

  /* */

  // Fetch CLI release notes
  const cliDiv = document.getElementById('cli-releases')

  if(cliDiv) {
    fetch('https://api.github.com/repos/decentraland/cli/releases')
    .then(response => {
      return response.json()
    })
    .then(data => {
      const converter = new showdown.Converter()
      const releases = data
        .filter(release => !release.prerelease)
        .map(release => ({
          version: release.tag_name,
          notes: converter.makeHtml(release.body.indexOf('Credits') !== -1
            ? release.body.substring(0, release.body.indexOf('Credits'))
            : release.body)
        }))
        .filter(release => release.notes && release.notes.trim() !== '')
      const text = releases.map(({ version, notes }) => `<h2>${version}<h2><div>${notes}</div>`)
      console.log(text)
      document.getElementById('cli-releases').innerHTML = releases.map(({ version, notes }) => `<h1>${version}:</h1><div>${notes}</div>`).join('')
    })
  }
})

$(function() {
  const aside = document.querySelector('aside.sidebar')
  aside.addEventListener('click', function (event) {
    let current = event.target;
    while(current && current.tagName !== 'ASIDE') {
      if (current.tagName === 'LI') {
        if (current.className.indexOf('toggle') >= 0) {
          const ul = current.querySelector('ul');
          const height = Array.from(ul.children, function (el) { return el.offsetHeight })
            .reduce(function (total, current) { return total + current }, 0)
          ul.style.height = String(height) + 'px'

          if (current.className.indexOf('open') >= 0) {
            setTimeout(function () {
              ul.style.height = '0px'
              current.className = current.className.replace(' open', '')
            }, 0)

            setTimeout(function () {
              ul.style.height = ''
            }, 300)

          } else {
            current.className += ' open'
            setTimeout(function () {
              ul.style.height = ''
            }, 300)
          }
        }

        return
      }

      current = current.parentElement;
    }
  })

  let current = aside.querySelector('a.active');
  while(current && current.tagName !== 'ASIDE') {
    if (current.tagName === 'LI' && current.className.indexOf('active') === -1) {
      current.className += ' active open'
    }

    current = current.parentElement;
  }
})