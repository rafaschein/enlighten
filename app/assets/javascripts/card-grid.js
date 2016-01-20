$(document).ready(function() {
  /*
   * Instances Masonry over Card Grid
   */
  var cardGrid = $('.card-grid').masonry({
    itemSelector: '.card-grid__card',
    columnWidth: '.card-grid__card',
    percentPosition: true,
    transitionDuration: 0,
    isResizable: true
  });

  /*
   * Parse JSON Standards from Links
   */
  var parse_link_header = function(header) {
    if (header === null) {
      return {};
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
   * Parse Card
   */
  var parseCard = function(card) {
    var template = $('#card-template').html();
    return Mustache.render(template, card);
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
      $.each(jsonResponse, function(index, card) {
        var html = parseCard(card);

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

      // Bind Statistics
      bindStatistics();

      // Bind Cards
      bindCards();
    });
  };

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

  // Bind Statistics
  var bindStatistics = function() {
    $('.card-grid__card__container__statistic a').off();
    $('.card-grid__card__container__statistic a').on('click', function(e) {
      // Stop Propagation
      e.preventDefault();
      e.stopPropagation();

      // card
      var card = $(this).parents('.card-grid__card');

      // statisticUrl
      var statisticUrl = $(this).attr('href');

      // Put
      $.ajax({
        url: statisticUrl,
        method: 'PUT'
      }).complete(function(jsonResponse, statusResponse, xhrResponse) {
        $(card).trigger('reload');
      });
    });
  };

  // Bind Cards
  var bindCards = function() {
    $('.card-grid__card').off();
    $('.card-grid__card').on('reload', function(e) {
      var card = $(this);
      var cardUrl = card.attr('href');

      $.ajax({
        url : cardUrl
      }).complete(function(xhrResponse, statusResponse) {
        var html = parseCard(xhrResponse.responseJSON);
        card.replaceWith(html);

        $(cardGrid).masonry('reloadItems');
        $(cardGrid).masonry('layout', html);

        // Bind Statistics
        bindStatistics();

        // Bind Cards
        bindCards();
      });
    });
  };

  // Start
  loadGrid(cardGrid.attr('href'));
});
