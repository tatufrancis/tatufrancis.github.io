/*
 *
 *  jQuery ResponsiveNavigation by Gary Hepting
 *  
 *  Open source under the MIT License. 
 *
 *  Copyright © 2013 Gary Hepting. All rights reserved.
 *
*/


(function() {
  var ResponsiveNavigation, delayNavigationClose, responsiveNavigationIndex;

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

}).call(this);
