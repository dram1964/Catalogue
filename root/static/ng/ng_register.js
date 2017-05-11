angular.module('register', [])
  .controller('MainCtrl', ['$http', '$location', function($http, $location) {
	var self = this;
	self.change = function() {
	  self.email1 = 'bob@example.com';
	  self.email2 = self.email1;
	  self.firstName = 'Robert';
	  self.lastName = 'Robot'; 
	};
	self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
	};
	self.data = foo;
  }]);
