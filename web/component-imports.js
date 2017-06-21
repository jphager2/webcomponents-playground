(function() {
  var imports = [
    'iron-icon/iron-icon',
    'iron-icons/iron-icons',
    'paper-checkbox/paper-checkbox',
    'paper-button/paper-button',
    'paper-input/paper-input',
    'paper-card/paper-card',
    'iron-form/iron-form',
    'paper-snackbar/paper-snackbar',
  ];

  document.addEventListener('WebComponentsReady', function() {
    imports.forEach(function(file) {
      var link = `<link rel="import" href="components/${file}.html">`;
      document.head.insertAdjacentHTML('beforeend', link);
    })
  });
}());

