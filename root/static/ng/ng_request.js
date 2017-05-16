angular.module('datarequest', [])
  .controller('MainCtrl', [function() {
	var self = this;
	  self.change = function() {
	  self.firstName = 'Robert';
	  self.lastName = 'Robot'; 
	  self.pathology = true;
	  self.pathologyDetails = 'Electrolytes and Blood tests';
	  self.diagnosis = true;
	  self.diagnosisDetails = 'ACS and Acute Coronary Syndrome';
	  self.radiology = true;
	  self.radiologyDetails = 'CT Scans';
	  self.pharmacy = true;
	  self.pharmacyDetails = 'Anti-viral and anti-coagulants';
	  self.episode = true;
	  self.episodeDetails = 'All admissions for Cardiology';
	  self.theatre = true;
	  self.theatreDetails = 'Cardiology admissions dates';
	  self.cardiology = true;
	  self.cardiologyDetails = 'Echocardiography and Angiogram data';
	  self.chemotherapy = true;
	  self.chemotherapyDetails = 'Chemotherapy treatments';
	  self.other = true;
	  self.otherDetails = 'Outstanding PPI claims';
	};
	self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
	};
  }]);
//cardiology_details => $parameters->cardiologyDetails,
//chemotherapy_details => $parameters->chemotherapyDetails,
//diagnosis_details => $parameters->diagnosisDetails,
//episode_details => $parameters->episodeDetails,
//other_details => $parameters->otherDetails,
//pathology_details => $parameters->otherDetails,
//pharmacy_details => $parameters->pharmacyDetails,
//radiology_details => $parameters->radiologyDetails,
//theatre_details => $parameters->theatreDetails,
