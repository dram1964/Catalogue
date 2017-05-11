angular.module('register', [])
  .controller('MainCtrl', ['$http', '$location', function($http, $location) {
	var self = this;
	self.change = function() {
	  self.username = 'changed';
	  self.password = 'password'; 
	};
	self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
	  self.uri = 'http://localhost:3000/registration/ng_new_submitted/' + self.username;
	  return $http.post( self.uri).then(function(response) {
			self.data = response.data;}, 
		function(errResponse) {
			console.error('error while posting data')});
	};
	self.data = foo;
  }]);
