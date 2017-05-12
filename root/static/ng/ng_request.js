angular.module('datarequest', [])
  .controller('MainCtrl', [function() {
	var self = this;
	  self.change = function() {
	  self.firstName = 'Robert';
	  self.lastName = 'Robot'; 
	};
	self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
	};
  }]);
