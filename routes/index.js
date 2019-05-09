var express = require('express');
var router = express.Router();
var exec = require('child_process').exec;
var fs = require('fs');
/* GET home page. */
router.get('/', function(req, res, next) {
	res.render('index', { title: 'Online Lex Compiler!' });
});

router.post('/', function(req, res, next){
	var code = req.body.code;
//console.log(code);
			exec('lex new.l', function(error, stderr, stdout){
				if(error) throw error;
				else{
					exec('yacc -d new.y', function(error, stderr, stdout){
						if(error) throw error;
						else{
					exec('gcc y.tab.c', function(error, stderr, stdout){
						if(error) throw error;
						else{
							fs.writeFile('input.txt', code, function(error){
								if(error) throw error;
								else{
									//console.log(code);
									exec('./a.out < input.txt', function(error, stderr, stdout){
										if(error) throw error;
										else{
											//console.log("1");
											//res.send("done");
											//console.log("12");
											console.log(stdout);
											console.log(stderr);
											res.send(stderr);
										}
									});
								}
							});
						}
					});
				}
			});
		}
	});

});

module.exports = router;
