angular.module('datareview', [])
  .controller('Purpose', [function() {
    var self = this;

    self.comment = function() {
	self.show = self.show == 1 ? 0 : 1;
    };
  }
]);
