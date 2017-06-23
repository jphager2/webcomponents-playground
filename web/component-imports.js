(function() {
  var imports = [
    'iron-icon/iron-icon',
    'iron-icons/iron-icons',
    'paper-checkbox/paper-checkbox',
    'paper-button/paper-button',
    'paper-input/paper-input',
    'paper-card/paper-card',
    'iron-form/iron-form',
    'lss-paper-date-picker/lss-paper-date-picker',
    'granite-spinner/granite-spinner',
    'paper-snackbar/paper-snackbar',
  ];

  document.addEventListener('WebComponentsReady', function() {
    var links = '';

    imports.forEach(function(file) {
      links += `<link rel="import" href="bower_components/${file}.html">`;
    })

    document.head.insertAdjacentHTML('beforeend', links);
  });
}());

