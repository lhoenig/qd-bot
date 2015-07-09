NSLog_ = dlsym(RTLD_DEFAULT, "NSLog")
NSLog = function() { var types = 'v', args = [], count = arguments.length; for (var i = 0; i != count; ++i) { types += '@'; args.push(arguments[i]); } new Functor(NSLog_, types).apply(null, args); }

var max_games = 120
var to_open = max_games - [[[[Datasource sharedDatasource] currentUser] games] count];

if (to_open > 0) {
	
	NSLog(@"Starting random games");
	var ny = [QFUtil nyckel];

	for (var i = 0; i < to_open; i++) {

		req = [GAEConnectionHandler requestWithSubURL:@"games/start_random_game"];
		[FEOUtil requestHash:req post:nil key:ny];

		[[GAEConnectionHandler sharedGAEConnectionHandler] startAFRequest:req selector:@selector(startRandomGameFinished:) failSEL:@selector(startRandomGameFinished:) spinner:1];
	}

}