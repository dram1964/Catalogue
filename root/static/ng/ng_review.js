angular.module('datareview', [])
  .controller('Purpose', [function() {
    var self = this;
    self.edit = 0;

    self.addComments = function() {
	self.edit = self.edit == 1 ? 0 : 1;
    };
    if (typeof verify !== 'undefined') {
      self.area_comment = verify.area_comment;
      self.objective_comment = verify.objective_comment;
      self.benefits_comment = verify.benefits_comment;
    }
  }

])
  .controller('Handling', [function() {
    var self = this;
    self.edit = 0;

    self.addComments = function() {
	self.edit = self.edit == 1 ? 0 : 1;
    };
    if (typeof verify !== 'undefined') {
      self.rec_comment = verify.rec_comment;
      self.population_comment = verify.population_comment;
      self.id_comment = verify.id_comment;
      self.storing_comment = verify.storing_comment;
      self.completion_comment = verify.completion_comment;
      self.publish_comment = verify.publish_comment;
      self.additional_comment = verify.additional_comment;
    }
  }
]);
