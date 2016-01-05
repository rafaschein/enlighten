$(document).ready(function() {
  /*
   * Instances Masonry over Card Grid
   */
  var cardGrid = $('.card-grid').masonry({
    itemSelector: '.card',
    columnWidth: '.card',
    percentPosition: true,
    transitionDuration: 0
  });

  /*
   * Parse JSON Standards from Links
   */
  var parse_link_header = function(header) {
    if (header.length === 0) {
      throw new Error("input must not be of zero length");
    }

    // Split parts by comma
    var parts = header.split(',');
    var links = {};

    // Parse each part into a named link
    for(var i=0; i<parts.length; i++) {
      var section = parts[i].split(';');
      if (section.length !== 2) {
        throw new Error("section could not be split on ';'");
      }
      var url = section[0].replace(/<(.*)>/, '$1').trim();
      var name = section[1].replace(/rel="(.*)"/, '$1').trim();
      links[name] = url;
    }

    return links;
  };

  /*
   * Load More Grid Results
   */
  var loadGrid = function(url) {
    // Get More Cards
    $.ajax({
      url: url
    }).done(function(jsonResponse, statusResponse, xhrResponse) {
      // parse all api links
      var links = parse_link_header(xhrResponse.getResponseHeader('Link'));

      // iterate over cards
      $.each(jsonResponse.cards, function(index, card) {
        var template = $('#card-template').html();
        var html = Mustache.render(template, card);

        // Append to Grid
        $(cardGrid).append(html);
        $(cardGrid).masonry('reloadItems');
        $(cardGrid).masonry('layout', html);
      });

      // Check Pager
      if (links.hasOwnProperty('next')) {
        // Show Pager
        $('.card-grid-pager a').attr('href', links.next);
        $('.card-grid-pager').show();
      } else {
        // Hide Pager
        $('.card-grid-pager').hide();
      }
    });
  };

  // Start
  loadGrid('/cards.json');

  // Bind Pager
  $('.card-grid-pager a').on('click', function(e) {
    // Stop Propagation
    e.preventDefault();
    e.stopPropagation();

    // URL
    var url = $(this).attr('href');

    // Load
    if (url) {
      loadGrid(url);
    }
  });
});
