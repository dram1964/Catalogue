angular.module('igadmin', [])
  .controller('ScoreCard', [function() {
    var self = this;
    var risks = rs;

    self.risks = [];
    var getColour = function(score) {
	    return score < 8 ? 'green' : score > 14 ? 'red' : 'yellow';
    };

    if (risks.length > 0 ) {
        for (row of risks) {
	    var suffix = self.risks.length + 1;
	    self.risks.push({
	  	name : 'risk' + suffix,
	  	rating : {name : 'rating' + suffix, value : row.rating},
		likely : {name : 'likely' + suffix, value : row.likelihood},
		category : {name : 'category' + suffix, value : row.risk_category},
		score : row.score,
		col : getColour( row.score)
		});
	    console.log(suffix + ") Added a row: " + row.request_id);
	};
    } else {
        self.risks = [{ 
	  name : 'risk1',
	  rating : {name : 'rating1', value : ''}, 
	  likely : {name : 'likely1', value : ''},
	  category : {name : 'category1', value : ''},
	  score : ''
        }];
    };
  }
]);
