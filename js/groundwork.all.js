(function() {
  var ResponsiveNavigation, ResponsiveTable, ResponsiveText, TruncateLines, delayNavigationClose, delayedAdjustTables, delayedAdjustText, delayedAdjustTruncation, equalizeColumns, responsiveNavigationIndex, responsiveTableIndex, responsiveTextIndex, truncateIndex;

  $(function() {
    return $('body').on('click', '.checklist li', function() {
      if ($(this).attr('data-checked') === "true") {
        return $(this).attr('data-checked', "false");
      } else {
        return $(this).attr('data-checked', "true");
      }
    });
  });

  $(function() {
    return $('body').on('click', '.dismissible', function() {
      var _this = this;
      $(this).addClass('dismiss animated');
      return setTimeout(function() {
        return $(_this).hide(250, function() {
          return $(this).remove();
        });
      }, 1000);
    });
  });

  $(window).on('load resize', function() {
    return equalizeColumns();
  });

  equalizeColumns = function() {
    return $('.row.equalize').each(function() {
      var $row, collapsed, tallest;
      $row = $(this);
      tallest = 0;
      collapsed = false;
      $row.children().each(function(i) {
        var $this;
        $this = $(this);
        $this.css('minHeight', '1px');
        collapsed = $this.outerWidth() === $row.outerWidth();
        if (!collapsed) {
          if (!$this.hasClass('equal')) {
            $this.addClass('equal');
          }
          if ($this.outerHeight() > tallest) {
            tallest = $this.outerHeight();
          }
        }
      });
      if (!collapsed) {
        return $row.children().css('min-height', tallest);
      }
    });
  };

  $(function() {
    var $body;
    $body = $('body');
    $body.on('click', ['.error input', '.error textarea', '.invalid input', '.invalid textarea', 'input.error', 'textarea.error ', 'input.invalid', 'textarea.invalid '].join(','), function() {
      return $(this).focus().select();
    });
    $('.select select').each(function() {
      var $this;
      $this = $(this);
      if ($this.children('option').first().val() === '' && $this.children('option').first().attr('selected')) {
        $this.addClass('unselected');
      } else {
        $this.removeClass('unselected');
      }
    });
    $body.on('change', '.select select', function() {
      var $this;
      $this = $(this);
      if ($this.children('option').first().val() === '' && $this.children('option').first().attr('selected')) {
        $this.addClass('unselected');
      } else {
        $this.removeClass('unselected');
      }
    });
  });

  $(function() {
    var $body;
    $body = $('body');
    $body.on('dropdown', function(e) {
      var $target;
      $target = $(e.target);
      $('.dropdown').not($target).removeClass('on');
      $target[$target.hasClass('on') ? 'removeClass' : 'addClass']('on');
    });
    $body.on('click', '.dropdown', function(e) {
      var $target;
      $target = $(e.currentTarget);
      if (!$target.is('a')) {
        e.stopPropagation();
      }
      if (!$target.hasClass('focused')) {
        $target.trigger('dropdown');
      } else {
        $target.removeClass('focused');
      }
    });
    $body.on('click', function() {
      var $dropdown;
      $dropdown = $('.dropdown.on');
      if ($dropdown.length) {
        $dropdown.removeClass('on');
      }
    });
    $body.on('focus', '.dropdown', function(e) {
      var $target;
      $target = $(e.currentTarget);
      if (!$(e.target).is('a')) {
        if ($target.hasClass('dropdown')) {
          $target.addClass('focused').trigger('dropdown');
        }
      } else {
        e.stopPropagation();
      }
    });
    return $body.on('focusout', '.dropdown li:last-child a', function(e) {
      return $('.dropdown.on').removeClass('on');
    });
  });

  /*
   *
   *  jQuery ResponsiveNavigation by Gary Hepting
   *  
   *  Open source under the MIT License. 
   *
   *  Copyright © 2013 Gary Hepting. All rights reserved.
   *
  */


  responsiveNavigationIndex = 0;

  delayNavigationClose = [];

  ResponsiveNavigation = (function() {
    function ResponsiveNavigation(el) {
      this.index = responsiveNavigationIndex++;
      this.el = $(el);
      this.init();
    }

    ResponsiveNavigation.prototype.init = function() {
      this.defaultLabel();
      this.setupMarkers();
      this.hamburgerHelper();
      this.touchBindings();
      if (!Modernizr.touch) {
        return this.mouseBindings();
      }
    };

    ResponsiveNavigation.prototype.defaultLabel = function() {
      if (this.el.attr('title') === void 0) {
        return this.el.attr('title', 'Menu');
      }
    };

    ResponsiveNavigation.prototype.setupMarkers = function() {
      return this.el.find('li').each(function() {
        if ($(this).find('ul').length) {
          return $(this).addClass('menu');
        }
      });
    };

    ResponsiveNavigation.prototype.hamburgerHelper = function() {
      return this.el.prepend('<button><i class="icon-list-ul" /></button>');
    };

    ResponsiveNavigation.prototype.mouseBindings = function() {
      $('body').on('mouseenter', 'li.menu', function() {
        if (!$(this).parents('.nav').find('button').is(':visible')) {
          clearTimeout(delayNavigationClose[this.index]);
          $(this).siblings().children('ul').removeClass('open');
          return $(this).children('ul').addClass('open');
        }
      });
      return $('body').on('mouseleave', 'li.menu, ul.open', function() {
        var _this = this;
        if (!$(this).parents('.nav').find('button').is(':visible')) {
          return delayNavigationClose[this.index] = setTimeout(function() {
            return $(_this).find('ul').removeClass('open');
          }, 500);
        }
      });
    };

    ResponsiveNavigation.prototype.touchBindings = function() {
      return $('body').on('click', 'li.menu > a', function(e) {
        $(this).closest('.menu').children('ul').toggleClass('open');
        $(this).closest('.menu').toggleClass('on');
        if (!$(this).closest('.menu').hasClass('on')) {
          $(this).closest('.menu').find('.menu').removeClass('on');
          $(this).closest('.menu').find('ul').removeClass('open');
        }
        return e.preventDefault();
      });
    };

    return ResponsiveNavigation;

  })();

  $(function() {
    var responsiveNavigationElements;
    responsiveNavigationElements = [];
    $('.nav').each(function() {
      return responsiveNavigationElements.push(new ResponsiveNavigation(this));
    });
    return $('body').on('click', '.nav button', function(e) {
      var list;
      list = $(this).siblings('ul');
      list.toggleClass('open');
      if (!list.hasClass('on')) {
        list.find('.menu').removeClass('on');
        list.find('ul').removeClass('open');
      }
      return e.preventDefault();
    });
  });

  $(function() {
    var convertToAccordion, restoreTabStructure, transformTabs;
    $('.tabs').each(function() {
      var activeTab, tabs;
      activeTab = $(this).find('> ul li.active');
      if (activeTab.length) {
        tabs = activeTab.parents('.tabs');
        return tabs.find(activeTab.attr('aria-controls')).addClass('active');
      } else {
        $(this).find('> ul li').first().addClass('active');
        return $(this).find('> div').first().addClass('active');
      }
    });
    $('body').on('click', '.tabs > ul li', function(e) {
      var tab, tabs;
      tab = $(this).addClass('active');
      tabs = tab.parents('.tabs');
      tab.siblings('li').removeClass('active');
      tabs.find('> div, > ul > div').hide();
      tabs.find(tab.attr('aria-controls')).show();
      return e.preventDefault();
    });
    transformTabs = function() {
      var viewport;
      viewport = $(window).width();
      if (viewport <= 480) {
        restoreTabStructure('.tabs.accordion.mobile');
        return convertToAccordion('.tabs:not(.accordion):not(.mobile)');
      } else if (viewport < 768) {
        restoreTabStructure('.tabs.accordion.mobile, .tabs.accordion.small-tablet');
        return convertToAccordion('.tabs:not(.accordion):not(.mobile):not(.small-tablet)');
      } else if (viewport <= 1024) {
        restoreTabStructure('.tabs.accordion.mobile, .tabs.accordion.small-tablet, .tabs.accordion.ipad');
        return convertToAccordion('.tabs:not(.accordion):not(.mobile):not(.small-tablet):not(.ipad)');
      } else if (viewport > 1024) {
        return restoreTabStructure('.tabs.accordion');
      }
    };
    convertToAccordion = function(tabTypes) {
      tabTypes = $(tabTypes);
      return tabTypes.each(function() {
        var tabs;
        tabs = $(this);
        tabs.addClass('accordion');
        return tabs.find('> div').each(function() {
          var tabpanel;
          tabpanel = $(this).clone();
          tabs.find('li[aria-controls="#' + tabpanel.attr('id') + '"]').after(tabpanel);
          return $(this).remove();
        });
      });
    };
    restoreTabStructure = function(tabTypes) {
      return $(tabTypes).each(function() {
        var tabs;
        tabs = $(this);
        tabs.removeClass('accordion');
        return tabs.find('> ul > div').each(function() {
          var tabpanel;
          tabpanel = $(this).clone();
          tabs.append(tabpanel);
          return $(this).remove();
        });
      });
    };
    $(window).resize(function() {
      clearTimeout(window.delayedAdjustTabs);
      return window.delayedAdjustTabs = setTimeout(function() {
        return transformTabs();
      }, 50);
    });
    return $(window).load(function() {
      return transformTabs();
    });
  });

  /*
   *
   *  jQuery ResponsiveTables by Gary Hepting - https://github.com/ghepting/jquery-responsive-tables
   *  
   *  Open source under the MIT License. 
   *
   *  Copyright © 2013 Gary Hepting. All rights reserved.
   *
  */


  delayedAdjustTables = [];

  responsiveTableIndex = 0;

  ResponsiveTable = (function() {
    function ResponsiveTable(el) {
      this.index = responsiveTableIndex++;
      this.el = el;
      this.compression = $(this.el).data('compression') || 5;
      this.minFontSize = $(this.el).data('min') || 10;
      this.maxFontSize = $(this.el).data('max') || Number.POSITIVE_INFINITY;
      this.width = $(this.el).data('width') || "100%";
      this.height = $(this.el).data('height') || "auto";
      this.adjustParents = $(this.el).data('adjust-parents') || true;
      this.styled = $(this.el).data('styled') || true;
      this.columns = $('tbody tr', $(this.el)).first().find('th, td').length;
      this.rows = $('tbody tr', $(this.el)).length;
      this.init();
    }

    ResponsiveTable.prototype.init = function() {
      this.setupTable();
      this.adjustOnLoad();
      return this.adjustOnResize();
    };

    ResponsiveTable.prototype.fontSize = function() {
      var compressed;
      if (this.height === "auto") {
        compressed = $('tbody td', $(this.el)).first().width() / this.compression;
      } else {
        compressed = $(this.el).height() / this.rows / this.compression;
      }
      return Math.min(this.maxFontSize, Math.max(compressed, this.minFontSize));
    };

    ResponsiveTable.prototype.setupTable = function() {
      $(this.el).css('width', this.width);
      if (this.height !== "auto") {
        $(this.el).css('height', this.height);
      }
      $("th, td", $(this.el)).css('width', (100 / this.columns) + "%");
      if (this.styled) {
        $(this.el).addClass("responsiveTable");
      }
      if (this.height !== "auto") {
        $("th, td", $(this.el)).css('height', (100 / this.rows) + "%");
        if (this.adjustParents) {
          $(this.el).parents().each(function() {
            return $(this).css('height', '100%');
          });
        }
      }
      return $(this.el).css('font-size', this.fontSize());
    };

    ResponsiveTable.prototype.resizeTable = function() {
      return $(this.el).css('font-size', this.minFontSize).css('font-size', this.fontSize());
    };

    ResponsiveTable.prototype.adjustOnLoad = function() {
      var _this = this;
      return $(window).on('load', function() {
        return _this.resizeTable();
      });
    };

    ResponsiveTable.prototype.adjustOnResize = function() {
      var _this = this;
      return $(window).on('resize', function() {
        clearTimeout(delayedAdjustTables[_this.index]);
        return delayedAdjustTables[_this.index] = setTimeout(function() {
          return _this.resizeTable();
        }, 20);
      });
    };

    return ResponsiveTable;

  })();

  (function($) {
    var responsiveTableElements;
    responsiveTableElements = [];
    return $.fn.responsiveTables = function(options) {
      return this.each(function() {
        return responsiveTableElements.push(new ResponsiveTable(this));
      });
    };
  })(jQuery);

  $(document).ready(function() {
    return $("table.responsive").responsiveTables();
  });

  /*
   *
   *  jQuery ResponsiveText by Gary Hepting - https://github.com/ghepting/jquery-responsive-text
   *  
   *  Open source under the MIT License. 
   *
   *  Copyright © 2013 Gary Hepting. All rights reserved.
   *
  */


  delayedAdjustText = [];

  responsiveTextIndex = 0;

  ResponsiveText = (function() {
    function ResponsiveText(el) {
      this.index = responsiveTextIndex++;
      this.el = el;
      this.compression = $(this.el).data('compression') || 10;
      this.minFontSize = $(this.el).data('min') || Number.NEGATIVE_INFINITY;
      this.maxFontSize = $(this.el).data('max') || Number.POSITIVE_INFINITY;
      this.scrollable = $(this.el).data('scrollable') || false;
      this.scrollSpeed = $(this.el).data('scrollspeed') || 650;
      this.scrollReset = $(this.el).data('scrollreset') || 200;
      this.init();
    }

    ResponsiveText.prototype.init = function() {
      $(this.el).wrapInner('<span class="responsiveText-wrapper" />');
      this.adjustOnLoad();
      this.adjustOnResize();
      if (this.scrollable) {
        return this.scrollOnHover();
      }
    };

    ResponsiveText.prototype.resizeText = function() {
      return $(this.el).css("font-size", Math.floor(Math.max(Math.min($(this.el).width() / this.compression, this.maxFontSize), this.minFontSize)));
    };

    ResponsiveText.prototype.adjustOnLoad = function() {
      var _this = this;
      return $(window).on('load', function() {
        return _this.resizeText();
      });
    };

    ResponsiveText.prototype.adjustOnResize = function() {
      var _this = this;
      return $(window).on('resize', function() {
        clearTimeout(delayedAdjustText[_this.index]);
        return delayedAdjustText[_this.index] = setTimeout(function() {
          return _this.resizeText();
        }, 20);
      });
    };

    ResponsiveText.prototype.scrollOnHover = function() {
      var _this = this;
      $(this.el).css({
        'overflow': 'hidden',
        'text-overflow': 'ellipsis',
        'white-space': 'nowrap'
      });
      return $(this.el).hover(function() {
        _this.difference = _this.el.scrollWidth - $(_this.el).width();
        if (_this.difference > _this.scrollSpeed) {
          _this.scrollSpeed = _this.difference;
        }
        if (_this.difference > 0) {
          $(_this.el).css('cursor', 'e-resize');
          return $(_this.el).stop().animate({
            "text-indent": -_this.difference
          }, _this.scrollSpeed, function() {
            return $(_this.el).css('cursor', 'text');
          });
        }
      }, function() {
        return $(_this.el).stop().animate({
          "text-indent": 0
        }, _this.scrollReset);
      });
    };

    return ResponsiveText;

  })();

  (function($) {
    var responsiveTextElements;
    responsiveTextElements = [];
    return $.fn.responsiveText = function(options) {
      return this.each(function() {
        return responsiveTextElements.push(new ResponsiveText(this));
      });
    };
  })(jQuery);

  $(document).ready(function() {
    return $(".responsive").not('table').responsiveText();
  });

  /*
   *
   *  jQuery truncateLines by Gary Hepting - https://github.com/ghepting/jquery-truncate-lines
   *  
   *  Open source under the MIT License. 
   *
   *  Copyright © 2013 Gary Hepting. All rights reserved.
   *
  */


  delayedAdjustTruncation = [];

  truncateIndex = 0;

  TruncateLines = (function() {
    function TruncateLines(el) {
      this.el = el;
      this.index = truncateIndex++;
      this.text = $(this.el).text();
      $(this.el).attr('data-text', this.text);
      this.words = this.text.trim().split(" ");
      this.lines = parseInt($(this.el).attr('data-truncate'));
      this.truncate();
      this.adjustOnResize();
    }

    TruncateLines.prototype.truncate = function() {
      this.measure();
      return this.setContent();
    };

    TruncateLines.prototype.reset = function() {
      return $(this.el).text(this.text).css('max-height', 'none').attr('data-truncated', 'false');
    };

    TruncateLines.prototype.measure = function() {
      var i;
      this.reset();
      $(this.el).html(".");
      this.singleLineHeight = $(this.el).outerHeight();
      i = 1;
      while (i++ < this.lines) {
        $(this.el).append("<br>.");
      }
      return this.maxLinesHeight = $(this.el).outerHeight();
    };

    TruncateLines.prototype.empty = function() {
      return $(this.el).html("");
    };

    TruncateLines.prototype.setContent = function() {
      var truncated;
      this.reset();
      truncated = false;
      this.addWords(this.words.length);
      if (this.tooBig()) {
        this.addNumberWordsThatFit();
        $(this.el).css('max-height', this.maxLinesHeight + 'px');
        return $(this.el).attr('data-truncated', true);
      }
    };

    TruncateLines.prototype.addNumberWordsThatFit = function() {
      var can, cant, mid;
      cant = this.words.length;
      can = 0;
      mid = Math.floor(this.words.length / 2);
      while (can + 1 !== cant) {
        this.addWords(can + mid);
        if (this.tooBig()) {
          cant = can + mid;
        } else {
          can = can + mid;
        }
        mid = Math.floor(mid / 2) || 1;
      }
      this.addWords(can);
      return $(this.el).html(this.trimTrailingPunctuation($(this.el).html()));
    };

    TruncateLines.prototype.addWords = function(num) {
      return $(this.el).html(this.words.slice(0, num).join(" "));
    };

    TruncateLines.prototype.tooBig = function() {
      return $(this.el).outerHeight() > this.maxLinesHeight;
    };

    TruncateLines.prototype.adjustOnResize = function() {
      var _this = this;
      return $(window).on('resize', function() {
        clearTimeout(delayedAdjustTruncation[_this.index]);
        return delayedAdjustTruncation[_this.index] = setTimeout(function() {
          return _this.truncate();
        }, 20);
      });
    };

    TruncateLines.prototype.trimTrailingPunctuation = function(str) {
      return str.replace(/(,$)|(\.$)|(\:$)|(\;$)|(\?$)|(\!$)/g, "");
    };

    return TruncateLines;

  })();

  (function($) {
    var truncateInitialized, truncatedLineElements;
    truncateInitialized = false;
    truncatedLineElements = [];
    return $.fn.truncateLines = function() {
      if (!truncateInitialized) {
        $('head').append('<style type="text/css"> [data-truncated="true"] { overflow: hidden; } [data-truncated="true"]:after { content: "..."; position: absolute; } </style>');
      }
      return this.each(function() {
        return truncatedLineElements.push(new TruncateLines(this));
      });
    };
  })(jQuery);

  $(window).load(function() {
    return $("[data-truncate]").truncateLines();
  });

}).call(this);
