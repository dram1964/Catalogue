angular.module('igadmin', [])
  .controller('Purpose', [function() {
    var self = this;
    self.edit = 0;
    self.score = self.rating * self.likely;

    self.addScores = function() {
	self.edit = self.edit == 1 ? 0 : 1;
    };
  }

])
  .controller('Handling', [function() {
    var self = this;
    self.edit = 0;
    if (typeof verify !== 'undefined') {
      self.rec_comment = verify.rec_comment;
      self.population_comment = verify.population_comment;
      self.id_comment = verify.id_comment;
      self.storing_comment = verify.storing_comment;
      self.completion_comment = verify.completion_comment;
      self.publish_comment = verify.publish_comment;
      self.additional_comment = verify.additional_comment;
    }

    self.addComments = function() {
	self.edit = self.edit == 1 ? 0 : 1;
    };
  }
])
  .controller('DataRequest', [function() {
    var self = this;
    self.edit = 0;
    if (typeof verify !== 'undefined') {
      self.cardiology_comment = verify.cardiology_comment;
      self.diagnosis_comment = verify.diagnosis_comment;
      self.episode_comment = verify.episode_comment;
      self.other_comment = verify.other_comment;
      self.pathology_comment = verify.pathology_comment;
      self.pharmacy_comment = verify.pharmacy_comment;
      self.radiology_comment = verify.radiology_comment;
      self.theatre_comment = verify.theatre_comment;
    }

    self.addComments = function() {
	self.edit = self.edit == 1 ? 0 : 1;
    };
  }
]);
