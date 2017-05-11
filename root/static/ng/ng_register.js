angular.module('register', [])
  .controller('MainCtrl', ['$http', '$location', function($http, $location) {
	var self = this;
	self.change = function() {
	  self.email1 = 'bob@example.com';
	  self.email2 = self.email1;
	  self.firstName = 'Robert';
	 // self.lastName = 'Robot'; 
    	 self.password1 = 'letmein';
    	 self.password2 = 'letmein';
    	 self.jobTitle = 'Data Mining Manager';
    	 self.department = 'PPI Claims Bureau';
    	 self.organisation = 'Sloggum, Bashum and Run';
    	 self.address1 = '31 Mile End Road';
    	 self.address2 = 'Bow';
    	 self.address3 = 'East London';
    	 self.postcode = 'E11 11P';
    	 self.city = 'London';
    	 self.telephone = '08001232343';
    	 self.mobile = '07807554911';
	};
	self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
	};
	self.data = foo;
  }]);
