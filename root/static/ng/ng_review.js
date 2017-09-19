angular.module('datareview', [])
  .controller('Purpose', [function() {
    var self = this;
    self.text = 'Data from JavaScript';

    self.changeMsg = function() {
	self.text = 'Message changed';
    };
  }
]);
