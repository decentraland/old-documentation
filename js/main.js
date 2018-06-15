jQuery(function() {
  var $sidebar = $(".sidebar"),
    $content = $(".wrapper"),
    $tutorial = $(".tutorial-content"),
    $header = $('header'),
    $postTopBar = $(".tutorial .title-search-wrapper");
  $postTopBarPosition = $postTopBar.offset();
  console.log($postTopBarPosition);
  offset = $content.offset().top + 60;

  var found = true;

  var $el;

  var href = $sidebar
    .find(".current-post-list a")
    .first()
    .attr("href");

  if (href !== undefined && href.charAt(0) === "#") {
    setActiveSidebarLink();

    $(window).on("scroll", function() {
      throttle(function() {
        setHeader();
        setActiveSidebarLink();
        setSidebar();
      }, 100)();
    });
  }

  function setHeader() {
    // if (window.scrollY > 200) {
    //   $postTopBar.addClass("sticky");
    // } else {
    //   $postTopBar.removeClass("sticky");
    // }
  }

  function setSidebar() {
    var offset = 121;
    var headerHeight = 96;
    $header.toggleClass('overflow', window.scrollY > headerHeight)

    var bottom = $tutorial.offset().top + $tutorial.outerHeight() - $sidebar.outerHeight() - offset;

    if (window.scrollY > bottom) {
      $sidebar.css("position", "absolute").css("top", $tutorial.outerHeight() - $sidebar.outerHeight());
    } else if (window.scrollY > ($tutorial.offset().top - headerHeight)) {
      $sidebar.css("position", "fixed").css("top", offset);
    } else {
      $sidebar.css("position", "absolute").css("top", 188);
    }
  }

  function setActiveSidebarLink() {
    $(".sidebar .current-post-list a").removeClass("active");
    var $closest = getClosestHeader();
    $closest.addClass("active");
  }
});

function getClosestHeader() {
  var $links = $(".sidebar .current-post-list a"),
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
