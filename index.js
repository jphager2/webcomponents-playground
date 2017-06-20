(function () {
  var init = function() {
    document.addEventListener('click', function(e) {
      var form = e.target.closest('form');

      if (!e.target.matches('paper-button[type=submit]') || !form) {
        return true;
      }

      e.preventDefault();
      form.submit();
      return false;
    });
  };

  if (document.readyState === 'ready' || document.readyState !== 'loading') {
    init();
  } else {
    document.addEventListener('DOMContentLoaded', init);
  }
}());
