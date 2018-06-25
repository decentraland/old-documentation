jQuery(function() {
  var states = {
    normal: 0,
    bottom: 1,
    top: 2
  };
  var latestState = states.normal;
  var $sidebar = $(".sidebar"),
    $content = $(".wrapper"),
    $tutorial = $(".main-container"),
    $header = $("header"),
    $postTopBar = $(".tutorial .title-search-wrapper");
  $postTopBarPosition = $postTopBar.offset();
  console.log($postTopBarPosition);
  offset = $content.offset().top + 60;

  var setActiveSidebarLink = throttle(function setActiveSidebarLink() {
    var $closest = getClosestHeader();
    if (!$closest.hasClass("active")) {
      $(".sidebar .current-post-list a").removeClass("active");
      $closest.addClass("active");
    }
  }, 100);

  var found = true;

  var $el;

  var href = $sidebar
    .find(".current-post-list a")
    .first()
    .attr("href");

  if (href !== undefined) {
    $(window).on("scroll", function() {
      setSidebar();
    });
  }

  function setSidebar() {
    var headerHeight = 48; // header of the whole page, with logo
    var offset = headerHeight;
    // $header.toggleClass("overflow", window.scrollY > headerHeight);

    var bottom = $tutorial.offset().top + $tutorial.outerHeight() - $sidebar.outerHeight() - offset;

    if (window.scrollY > bottom) {
      if (latestState !== states.bottom) {
        // sticky at the bottom
        $sidebar.css("position", "absolute").css("top", $tutorial.outerHeight() - $sidebar.outerHeight());
        latestState = states.bottom;
      }
    } else if (window.scrollY > $tutorial.offset().top - offset) {
      if (latestState !== states.top) {
        // sticky at the top
        $sidebar.css("position", "fixed").css("top", offset);
        latestState = states.top;
      }
    } else {
      if (latestState !== states.normal) {
        // normal no sticky
        $sidebar.css("position", "absolute").css("top", 0);
        latestState = states.normal;
      }
    }
  }

    $('.toggle-item').click(function(ev) {
        ev.preventDefault();
        var data = $(ev.target).attr('data-toggle')
        $('.toggle[data-id!="' + data + '"]').hide('fast')
        $('.toggle[data-id="' + data + '"]').toggle('fast')
    })
});

function getClosestHeader() {
  var $links = $(".internal-href"),
    top = window.scrollY,
    $last = $links.first(),
    $content = $(".tutorial-content");

  // console.log(top);

  if (top < 300) {
    return $last;
  }

  if (top + window.innerHeight >= $content.offset().top + $content.height()) {
    return $links.last();
  }

  for (var i = 0; i < $links.length; i++) {
    var $link = $links.eq(i),
      href = $link.attr("href");

    if (href !== undefined && href.charAt(0) === "#" && href.length > 1) {
      var $anchor = $(href);

      if ($anchor.length > 0) {
        var offset = $anchor.offset();

        if (top < offset.top - window.innerHeight / 2) {
          return $last;
        }

        $last = $link;
      }
    }
  }
  return $last;
}

function throttle(callback, limit) {
  var wait = false;
  return function() {
    if (!wait) {
      callback.apply(null, arguments);
      wait = true;
      setTimeout(function() {
        wait = false;
      }, limit);
    }
  };
}
