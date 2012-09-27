
var opts = {
    lines: 9,
    length: 7,
    width: 4,
    radius: 10,
    corners: 1,
    rotate: 0,
    color: '#000',
    speed: 1,
    trail: 35,
    shadow: false,
    hwaccel: true,
    className: 'spinner',
    zIndex: 2e9,
    top: 'auto',
    left: 'auto'
};

$.fn.spin = function() {
    
    this.each(function() {
        var $this = $(this), data = $this.data();
        if (data.spinner) {
            data.spinner.stop();
            delete data.spinner;
        }
        data.spinner = new Spinner($.extend({color: $this.css('color')}, opts)).spin(this);
    });

    return this;
  
};
