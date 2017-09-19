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

]);
