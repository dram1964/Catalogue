angular.module('igadmin', [])
  .controller('ScoreCard', [function() {
    var self = this;
    self.msg = "cooking with gas";
    self.risks = [ { 
	name : 'risk1',
	rating : {name : 'rating1', value : 1}, 
	likely : {name : 'likely1', value : 1},
	score : 1
    }];

    self.addRisk = function() {
	var suffix = self.risks.length + 1;
	self.risks.push({
	name : 'risk' + suffix,
	rating : {name : 'rating' + suffix, value : suffix},
	likely : {name : 'likely' + suffix, value : suffix} 
	});
    };
    self.updateScore = function(risk) {
	    risk.score = risk.rating.value * risk.likely.value;
    };

  }

])
  .controller('Handling', [function() {
    var self = this;
    self.edit = 0;
    self.score = self.rating * self.likely;

    self.addScores = function() {
	self.edit = self.edit == 1 ? 0 : 1;
    };
    self.updateScore = function() {
	if (self.rating >= 1 && self.likely >= 1) {
	    self.score = self.rating * self.likely;
	}
    };

  }
]);
