angular.module('igadmin', [])
  .controller('ScoreCard', [function() {
    var self = this;
    self.msg = "cooking with gas";
    self.risks = [ {rating : {name : 'rating1'}, likely : {name : 'likely1'}}
    ];

    self.addRisk = function() {
	var suffix = self.risks.length + 1;
	self.risks.push({
	rating : {name : 'rating' + suffix},
	likely : {name : 'likely' + suffix} 
	});
    };
    self.updateScore = function(rating) {
	if (self.likely >= 1) {
	    self.score = rating * self.likely;
	}
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
