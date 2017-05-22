angular.module('datarequest', [])
  .controller('MainCtrl', [function() {
    var self = this;

    self.change = function() {
	  self.user = {'firstName' : 'Robert', 'lastName' : 'Robot'};
	  self.data = {'pathology' : true, 
		'pathologyDetails' : 'Electrolytes and Blood tests',
		'diagnosis' : true, 
		'diagnosisDetails' : 'ACS and Acute Coronary Syndrome',
		'radiology' : true, 
		'radiologyDetails': 'CT Scans',
		'pharmacy' : true, 
		'pharmacyDetails' : 'Anti-viral and anti-coagulants',
		'episode' : true,
		'episodeDetails' : 'All admissions for Cardiology',
		'theatre' : true,
		'theatreDetails' : 'Cardiology admissions dates',
		'cardiology' : true, 
		'cardiologyDetails' : 'Echocardiography and Angiogram data',
		'chemotherapy' : false, 
		'other' : true, 
		'otherDetails' : 'Outstanding PPI claims',
		'requestType' : 1
	  };
    };

    self.submit = function() {
	  console.log('User clicked submit with ', 
	    self.username, self.password);
    };
if (typeof foo !== 'undefined') {
    self.user = foo.user;
    if (typeof foo.data !== 'undefined') {
	    self.data = foo.data;
	    self.data.pathology = self.data.pathologyDetails == '' ? false : true;
	    self.data.diagnosis = self.data.diagnosisDetails == '' ? false : true;
	    self.data.radiology = self.data.radiologyDetails == '' ? false : true;
	    self.data.pharmacy = self.data.pharmacyDetails == '' ? false : true;
	    self.data.episode = self.data.episodeDetails == '' ? false : true;
	    self.data.theatre = self.data.theatreDetails == '' ? false : true;
	    self.data.cardiology = self.data.cardiologyDetails == '' ? false : true;
	    self.data.chemotherapy = self.data.chemotherapyDetails == '' ? false : true;
	    self.data.other = self.data.otherDetails == '' ? false : true;
   } else {
	    self.data = {'pathology' : false,
		'diagnosis' : false,
		'radiology' : false,
		'pharmacy' : false,
		'episode' : false,
		'theatre' : false,
		'cardiology' : false,
		'chemotherapy' : false,
		'other' : false
	    };
   }
}

  }]);
