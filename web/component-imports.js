(function() {
  var bowerImports = [
    'iron-icon/iron-icon',
    'iron-icons/iron-icons',
    'paper-checkbox/paper-checkbox',
    'paper-button/paper-button',
    'paper-input/paper-input',
    'paper-card/paper-card',
    'iron-form/iron-form',
    'lss-paper-date-picker/lss-paper-date-picker',
    'granite-spinner/granite-spinner',
  ];

  var vendorImports = [
    'paper-snackbar/paper-snackbar',
  ];

  document.addEventListener('WebComponentsReady', function() {
    var link = '';

    bowerImports.forEach(function(file) {
      links += `<link rel="import" href="components/${file}.html">`;
    })

    vendorImports.forEach(function(file) {
      links += `<link rel="import" href="vendor/${file}.html">`;
    })

    document.head.insertAdjacentHTML('beforeend', links);
  });
}());

