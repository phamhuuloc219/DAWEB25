
// ================ || HEADER MENU && FOOTER || ==================//
//======================================================//
function fixedMenu() {
  if ($(".wrapHeader").length) {
    var windowScrollTop = $(window).scrollTop();
    var heightHeader = 15;

    if ($(window).width() <= 575) heightHeader = 1;

    if (windowScrollTop > heightHeader) $("body").addClass("fixedMenu");
    else $("body").removeClass("fixedMenu");
  }
}
$(".wrapBtnCtrMenuHeader .btnCtrMenu").on("click", function (e) {
  $("body").toggleClass("showMenu wrapHidden");
  e.preventDefault();

  if ($(".showContact").length) {
    $("body").removeClass("showContact wrapHidden");
  }
});
$(".wrapperBTNclose ").on("click", function (e) {
  $("body").removeClass("showMenu wrapHidden");
  e.preventDefault();

  if ($(".showContact").length) {
    $("body").removeClass("showContact wrapHidden");
  }
});
$(".wrapperBtncloseMobile").on("click", function (e) {
  $("body").removeClass("showMenu wrapHidden");

  if ($(".showContact").length) {
    $("body").removeClass("showContact wrapHidden");
  }

  e.preventDefault();
});

$(".wrapCloseMenuHeaderMobile").on("click", function (e) {
  $("body").removeClass("showMenu wrapHidden");
  e.preventDefault();
});

$(document).on("click", ".itemMenuHeader.menuSub", function (e) {
  if ($(this).hasClass("activeMenu")) {
    $(this).find(".wrapMenuHeader").slideUp();

    $(this).removeClass("activeMenu");
  } else {
    if ($(".itemMenuHeader.menuSub.activeMenu")) {
      $(".itemMenuHeader.menuSub").find(".wrapMenuHeader").slideUp();
      $(".itemMenuHeader.menuSub").removeClass("activeMenu");
    }

    $(this).find(".wrapMenuHeader").toggle()

    $(this).toggleClass("activeMenu");
  }

  // e.preventDefault();
});

$(document).on("click", ".itemMenuHeader.menuSub", function (e) {
  e.stopPropagation();
});

$(document).on("click", ".Rootmenu .itemMenuHeader.menuSub", function () {
  if ($('.menuSetting').hasClass('showSub')) {
    $('.menuSetting .show-menu').toggle();
    $('.menuSetting').removeClass('showSub')
  }
});

$('body, html').on('click', function (e) {
  var target = $(e.target);
  if (
    e.type == "focusin" ||
    target.closest(this.element).length ||
    target.closest(this.container).length ||
    target.closest('.wrapMenuMainHeader').length
  ) return;

  if ($(".itemMenuHeader.menuSub.activeMenu")) {
    $(".itemMenuHeader.menuSub").find(".wrapMenuHeader").slideUp();
    $(".itemMenuHeader.menuSub").removeClass("activeMenu");
  }
});

$('body, html').on('click', function (e) {
  var target = $(e.target);
  if (
    e.type == "focusin" ||
    target.closest(this.element).length ||
    target.closest(this.container).length ||
    target.closest('.wrapMenuMainHeader').length ||
    target.closest('.menuSetting').length
  ) return;

  if ($('.menuSetting').hasClass('showSub')) {
    // $('.menuSetting .show-menu').slideUp();
    $('.menuSetting').removeClass('showSub')
  }
});

// ================ || KIỂM TRA NẾU SỐ LƯỢNG MENU QUÁ NHIỀU THÌ THÊM DROPDOWN || ==================//
//======================================================//
function responeMenuHeader() {
  if ($(window).width() > 1220) {
    var navbarNav = $('.headerTop .wrapperContentTop');

    var maxNavbarWidth = navbarNav.width() - $('.wrapLogoHeader').width() - $('.wrapperRight').width() - 90;

    console.log($('.wrapLogoHeader').width());

    var topLevelItemMenuHeaders = $('.listMenuHeader.Rootmenu > .itemMenuHeader')

    var totalWidth = 0;

    topLevelItemMenuHeaders.each(function () {
      totalWidth += $(this).outerWidth(true) + 15;

      if (totalWidth > maxNavbarWidth) {
        $(this).appendTo('.show-menu');
      }

      if (totalWidth > maxNavbarWidth) {
        $('.btn-show-more').removeClass('hidden');
      } else {
        $('.btn-show-more').addClass('hidden');
      }

    })

    $('.btn-show-more').on('click', function () {
      if ($(".itemMenuHeader.menuSub.activeMenu")) {
        $(".itemMenuHeader.menuSub").find(".wrapMenuHeader").slideUp();
        $(".itemMenuHeader.menuSub").removeClass("activeMenu");
      }

      if ($('.menuSetting').hasClass('showSub')) {
        $('.menuSetting .show-menu').addClass('hidden');
        $('.menuSetting').removeClass('showSub')

      } else {
        // $('.menuSetting .show-menu').slideDown();
        $('.menuSetting').addClass('showSub')
        $('.menuSetting .show-menu').removeClass('hidden');
      }
    });

    $('.btn-close').on('click', function () {
      $('.listMenuHeader.Rootmenu').find('.itemMenuHeader').each(function () {
        if ($(this).offset().left > maxNavbarWidth) {
          $(this).addClass('hidden');
        }
      });
      $('.btn-show-more').removeClass('hidden');
      $(this).addClass('hidden');
    });
  }
}

function actionSetFooter() {
  if ($('body[data-style="google"]').outerHeight() > $(window).height()) $('.footer').removeClass('fixFooter');
  else $('body[data-style="google"] .footer').addClass('fixFooter');
}

function setFooter(typeCall) {
  if ($('.footer').length) {
    if ($('.footer').hasClass('fixFooter')) {
      $('.footer').removeClass('fixFooter');
    }
    if (typeCall == 'resize') {
      setTimeout(function () {
        actionSetFooter();
      });
    } else {
      actionSetFooter();
    }
  }
}


$(document).ready(function () {
  function adjustMainContentHeight() {
    if ($('.main-content')) {
      var headerHeight = $('.wrapHeader').outerHeight();
      var footerHeight = $('.footer').outerHeight();
      var totalHeight = headerHeight + footerHeight;
      var newHeight = 'calc(100vh - ' + totalHeight + 'px - 30px)';
      $('.main-content').css('min-height', newHeight);
    }

  }
  $(window).on('load resize', adjustMainContentHeight);
  function adjustCardHeight() {
    if ($('.card-h')) {
      var headerHeight = $('.wrapHeader').outerHeight();
      var footerHeight = $('.footer').outerHeight();
      var totalHeight = headerHeight + footerHeight;
      var newHeight = 'calc(100vh - ' + totalHeight + 'px - 80px)';
      $('.card-h').css('min-height', newHeight);
    }
  }
  $(window).on('load resize', adjustCardHeight);
});

// ================ || END HEADER MENU && FOOTER || ==================//
//======================================================//


// ===================== || fIXED COLUMN TABLE || ===================//
//=====================================================================//
var prevColumnsWidth = {}; // Mảng để lưu trữ tổng chiều rộng của các cột đã được chọn trước đó
$(document).on("click", ".toggle-column", function () {

  var column = $(this).data("column");
  if ($(this).hasClass("active")) {
    $(".datatable td:nth-child(" + column + "), .datatable th:nth-child(" + column + ")").addClass("fixed-column");
    updatePrevColumnsWidth(column); // Cập nhật lại prevColumnsWidth cho cột mới được chọn
    updateWidth(column); // Cập nhật lại chiều rộng của các cột đã được chọn trước đó
    $(this).removeClass("active");
  } else {
    $(".datatable td:nth-child(" + column + "), .datatable th:nth-child(" + column + ")").removeClass("fixed-column");
    delete prevColumnsWidth[column]; // Xóa tổng chiều rộng của cột hiện tại từ mảng
    $(".datatable td:nth-child(" + column + "), .datatable th:nth-child(" + column + ")").css({
      "position": "",
      "background-color": "",
      "z-index": "",
      "left": ""
    });
    updateWidth(column); // Cập nhật lại chiều rộng của các cột đã được chọn trước đó
    $(this).addClass("active");
  }
})

// Hàm cập nhật lại prevColumnsWidth cho cột mới được chọn
function updatePrevColumnsWidth(column) {
  var totalWidth = 0;
  for (var key in prevColumnsWidth) {
    totalWidth += prevColumnsWidth[key];
  }
  prevColumnsWidth[column] = $(".datatable td.fixed-column:nth-child(" + column + ")").outerWidth();
  totalWidth += prevColumnsWidth[column];
  // Cập nhật lại prevColumnsWidth cho các cột đã được chọn trước đó
  for (var key in prevColumnsWidth) {
    if (parseInt(key) < column) {
      prevColumnsWidth[key] = prevColumnsWidth[key] / totalWidth * (totalWidth);
    }
  }
}

// Hàm cập nhật lại chiều rộng của các cột đã được chọn trước đó
function updateWidth(column) {
  var totalWidth = 0;
  for (var key in prevColumnsWidth) {
    totalWidth += prevColumnsWidth[key];
  }
  var left = 0;
  for (var key in prevColumnsWidth) {
    $(".datatable td:nth-child(" + key + "), .datatable th:nth-child(" + key + ")").css("left", left + "px");
    left += prevColumnsWidth[key];
  }
}

$('tbody').on('click', 'tr', function () {
  if ($(this).hasClass("unfocused") || $(this).hasClass("focused")) {
    $(this).removeClass("unfocused");
    $(this).removeClass("focused");
  }
  if (($("table").hasClass("focus-on"))) {
    $(this).toggleClass('selected');
  }
});


$(document).ready(function () {
  // ================ || SETING COLOR FONTS PAGE  || ==================//
  //======================================================//
  var selectedColor = localStorage.getItem('selectedColor');
  if (selectedColor) {
    $('body').attr('data-color', selectedColor);
    $('.setting-color-item').each(function () {
      if ($(this).data('color') === selectedColor) {
        $(this).addClass("active")
      }
    });
  }
  $('.setting-color-item').click(function () {
    var selectedColor = $(this).data('color');
    $('body').attr('data-color', selectedColor);
    localStorage.setItem('selectedColor', selectedColor);
    $('.setting-color-item').removeClass('active');
    $(this).addClass('active');
  });

  var selectedStyle = localStorage.getItem('selectedStyle');
  if (selectedStyle) {
    $('body').attr('data-style', selectedStyle);
    $('.setting-style-item').each(function () {
      if ($(this).data('style') === selectedStyle) {
        $(this).addClass("active")
      }
    });
  }
  $('.setting-style-item').click(function () {
    location.reload();
    var selectedStyle = $(this).data('style');
    $('body').attr('data-style', selectedStyle);
    localStorage.setItem('selectedStyle', selectedStyle);
    $('.setting-style-item').removeClass('active');
    $(this).addClass('active');
  });

  var selectedFont = localStorage.getItem('selectedFont');
  if (selectedFont) {
    $('body').attr('data-font', selectedFont);
    $('.setting-font-item').each(function () {
      if ($(this).data('font') === selectedFont) {
        $(this).addClass("active")
      }
    });
  }
  $('.setting-font-item').click(function () {
    var selectedFont = $(this).data('font');
    $('body').attr('data-font', selectedFont);
    localStorage.setItem('selectedFont', selectedFont);
    $('.setting-font-item').removeClass('active');
    $(this).addClass('active');
  });


  // ================ || MENU TAB VERTICAL || ==================//
  //======================================================//
  let menu = document.querySelector('.menu');
  let toggle = document.querySelector('.toggle');

  if (toggle && menu) {
    toggle.addEventListener('click', () => {
      menu.classList.toggle('active');
    });
  }


  // ================ ||  toggle-password || ==================//
  //======================================================//
  if ($(".showPass")) {
    $(document).ready(function () {
      $(".showPass").click(function () {
        if ($(".myPass").attr("type") == "password") {
          $(".myPass").attr("type", "text");
        } else {
          $(".myPass").attr("type", "password");
        }
      });
      $(".showPass").click(function () {
        $(".showPass i").toggle();
      });
    });
  }

  // ================|| show-loader  || ==================//

  $(".show-loader").on("click", function () {
    $(".loader-content").addClass("show");
    $("body").css("overflow", "hidden");
    setTimeout(function () {
      $(".loader-content").removeClass("show");
      $("body").css("overflow", "auto");
    }, 2000);
  });
  $(".show-loading-page").on("click", function () {
    $(".loading-page-animation").addClass("show");
    $("body").css("overflow", "hidden");
    setTimeout(function () {
      $(".loading-page-animation").removeClass("show");
      $("body").css("overflow", "auto");

    }, 2000);
  });

  // ================|| show-alert  || ==================//
  $('.show-alert').click(function () {
    $('.alert').addClass("show");
    $('.alert').removeClass("hide");
    $('.alert').addClass("showAlert");
    setTimeout(function () {
      $('.alert').removeClass("show");
      $('.alert').addClass("hide");
    }, 2000);
  });
  $('.close-btn').click(function () {
    $('.alert').removeClass("show");
    $('.alert').addClass("hide");
  });

  // ========|| HIỂN THỊ NÚT SORT TABLE || ===========
  $(function () {
    $('table').on('click', '.thTable', function () {
      var th = $(this).closest('th');
      var thClass = th.hasClass('asc') ? 'desc' : 'asc';
      th.siblings().removeClass('asc desc');
      th.removeClass('asc desc').addClass(thClass);
    });
  });

  // =============== || FULLSCREEN PAGE || ==================//
  //======================================================//

  function toggleFullscreen(elem) {
    elem = elem || document.documentElement;
    if (!document.fullscreenElement && !document.mozFullScreenElement &&
      !document.webkitFullscreenElement && !document.msFullscreenElement) {
      if (elem.requestFullscreen) {
        elem.requestFullscreen();
      } else if (elem.msRequestFullscreen) {
        elem.msRequestFullscreen();
      } else if (elem.mozRequestFullScreen) {
        elem.mozRequestFullScreen();
      } else if (elem.webkitRequestFullscreen) {
        elem.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
      }
      $('.wrapHeader, .footer, body').addClass('fullscreen');
      $('#btnFullscreen .text').text('Thu nhỏ');
      $('#btnFullscreen i').removeClass('bx-fullscreen').addClass('bx-exit-fullscreen');
    } else {
      if (document.exitFullscreen) {
        document.exitFullscreen();
      } else if (document.msExitFullscreen) {
        document.msExitFullscreen();
      } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
      } else if (document.webkitExitFullscreen) {
        document.webkitExitFullscreen();
      }
      $('.wrapHeader, .footer, body').removeClass('fullscreen');
      $('#btnFullscreen .text').text('Phóng To');
      $('#btnFullscreen i').removeClass('bx-exit-fullscreen').addClass('bx-fullscreen')
    }
  }

  $('#btnFullscreen').click(function () {
    toggleFullscreen();
  });
});

// Bộ xử lý sự kiện khi nhấn phím ESC để thoát fullscreen
$(document).on('fullscreenchange mozfullscreenchange webkitfullscreenchange msfullscreenchange', function () {
  if (!document.fullscreenElement && !document.mozFullScreenElement &&
    !document.webkitFullscreenElement && !document.msFullscreenElement) {
    $('.wrapHeader, .footer, body').removeClass('fullscreen');
    $('#fullscreenText').text('Phóng To');
    $('#btnFullscreen i').removeClass('bx-exit-fullscreen').addClass('bx-fullscreen');
  }
});



// ================ || Chỉnh full đội cao khung nếu nội dung không nhiều || ==================//
//======================================================//
function setFullHeightBoxMain() {
  if ($('body').length) {
    if ($('body').height() < $(window).height()) $('body').addClass('fullHeightBox');
    else $('body').removeClass('fullHeightBox');
  }
}

function callFullHeightBoxMain(type) {
  $('body').removeClass('fullHeightBox');

  if (type == 'load') setFullHeightBoxMain();
  else {
    setTimeout(function () {
      setFullHeightBoxMain();
    }, 1000);
  }
}

$(window).on("load", function () {
  responeMenuHeader();
  fixedMenu();
  setFooter('');
  callFullHeightBoxMain('load');
  $('body').removeClass('loadingPage');
});

$(window).on("scroll", function () {
  fixedMenu();
});

$(window).on("resize", function () {
  setFooter('resize');
  callFullHeightBoxMain('');
});


// ============ || TOASTR || =========================
// ==================================================================//
$(document).ready(function () {
  if (typeof toastr !== 'undefined') {
    toastr.options = {
      'closeButton': true,
      'debug': false,
      'newestOnTop': false,
      'progressBar': false,
      'positionClass': 'toast-bottom-right',
      'preventDuplicates': false,
      'showDuration': '1000',
      'hideDuration': '1000',
      'timeOut': '5000',
      'extendedTimeOut': '1000',
      'showEasing': 'swing',
      'hideEasing': 'linear',
      'showMethod': 'fadeIn',
      'hideMethod': 'fadeOut',
    }
  }
});

if ($('.success-remove')) {
  $('.success-remove').click(function (event) {
    toastr.success("Đơn hàng đã được xóa thành công", "Thông báo");
  });
}

if ($('.success-toats')) {
  $('.success-toats').click(function (event) {
    toastr.success("Đơn hàng đã được xóa thành công", "Thông báo");
  });
}

if ($('.info-toats')) {
  $('.info-toats').click(function (event) {
    toastr.info("Đơn hàng đã được xóa thành công", "Thông báo")
  });
}

if ($('.error-toats')) {
  $('.error-toats').click(function (event) {
    toastr.error("Đơn hàng đã được xóa thành công", "Thông báo")
  });
}
if ($('.warning-toats')) {

  $('.warning-toats').click(function (event) {
    toastr.warning("Đơn hàng đã được xóa thành công", "Thông báo")
  });
}


$(document).ready(function () {
  // ==========|| Kiểm tra button có 2 trở lên sẽ sử dụng dropdown ||==========================//
  if ($('.action-button')) {
    var buttons = $('.list-btn-action').find('.btn');
    if (buttons.length > 2) {
      $('.dropdown-toggle').show();
      $('.list-action-dropdown').addClass('dropdown-menu');
      $('.list-action-dropdown').removeClass('list-btn-action')

    } else {
      $('.dropdown-toggle').hide();
    }
  }

  // ==========|| sử dụng cho khi xuống mobile sẽ chuyển sang dropdown ||==========================//
  if ($('.action-button-reponesive')) {
    var buttonsReponesive = $('.list-btn-action-reponesive').find('.btn');
    if (buttonsReponesive.length > 4 || $(window).width() < 992) {
      $('.dropdown-toggle-reponesive').show();
      $('.list-action-dropdown-reponesive').addClass('dropdown-menu');
      $('.list-action-dropdown-reponesive').removeClass('list-btn-action-reponesive')
    } else {
      $('.dropdown-toggle-reponesive').hide();
    }
  }

});

// =============|| GALLERY IMAGE MODAL || =========================
if (typeof Fancybox !== 'undefined') {
  Fancybox.bind('[data-fancybox="gallery"]', {
    buttons: [
      "slideShow",
      "thumbs",
      "zoom",
      "fullScreen",
      "share",
      "close"
    ],
    loop: false,
    protect: true
  });
}



// ============ || CHANGE BACKGROUND PAGE || =========================
// ==================================================================//
$(document).ready(function () {
  $('.change-bg').click(function () {
    $('.change-bg').removeClass('active');
    $(this).addClass('active');
    var newBg = $(this).data('bg');
    $('.wrapperBgPage').css('background-image', 'url(' + newBg + ')');
    $('.wrapper-login-form-center').css('background-image', 'url(' + newBg + ')');
    $('.wrapper-login-form-right').css('background-image', 'url(' + newBg + ')');
    localStorage.setItem('bgImage', newBg);
    localStorage.setItem('activeButton', $(this).index());
  });
  var storedBg = localStorage.getItem('bgImage');
  if (storedBg) {
    $('.wrapperBgPage').css('background-image', 'url(' + storedBg + ')');
    $('.wrapper-login-form-center').css('background-image', 'url(' + storedBg + ')');
    $('.wrapper-login-form-right').css('background-image', 'url(' + storedBg + ')');
  }
  var activeButtonIndex = localStorage.getItem('activeButton');
  if (activeButtonIndex !== null) {
    $('.change-bg').eq(activeButtonIndex).addClass('active');
  }
});

$(document).ready(function () {
  if ($('.dropdown-toggle-action')) {
    var $trList = $('.dt-responsive tbody tr');
    if ($trList.length < 6) {
      $('.table-responsive').css('min-height', '400px');
    }
    $('.dropdown-toggle-action').click(function () {
      var $tr = $(this).closest('tr');
      $('.dt-responsive tr').css('z-index', '');
      $tr.css('z-index', 500);
    });
  }
});