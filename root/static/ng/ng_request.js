angular.module('datarequest', [])
  .controller('MainCtrl', [function() {
	var self = this;
	  self.change = function() {
	  self.firstName = 'Robert';
	  self.lastName = 'Robot'; 
	  self.cardiologyDetails = 'Angiograms and Echocardiography. Details for vessels diseased';
	  self.chemotherapyDetails = '';
	  self.pathology = true;
	  self.pathologyDetails = 'Electrolytes and Blood tests';
	  self.diagnosisDetails = 'ACS and Acute Coronary Syndrome';
	  self.episodeDetails = 'All admissions for Cardiology';
	  self.theatreDetails = 'Cardiology admissions dates';
	};
	self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
	};
  }]);
	cardiology_details => $parameters->cardiologyDetails,
	chemotherapy_details => $parameters->chemotherapyDetails,
	diagnosis_details => $parameters->diagnosisDetails,
	episode_details => $parameters->episodeDetails,
	other_details => $parameters->otherDetails,
	pathology_details => $parameters->otherDetails,
	pharmacy_details => $parameters->pharmacyDetails,
	radiology_details => $parameters->radiologyDetails,
	theatre_details => $parameters->theatreDetails,
