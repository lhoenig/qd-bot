NSLog_ = dlsym(RTLD_DEFAULT, "NSLog")
NSLog = function() { var types = 'v', args = [], count = arguments.length; for (var i = 0; i != count; ++i) { types += '@'; args.push(arguments[i]); } new Functor(NSLog_, types).apply(null, args); }


var p = [FEOPost new];
var dt = [QFUtil getApnToken];
var id = [[Datasource sharedDatasource] getCurrentUserID];
var ny = [QFUtil nyckel];
[p addObject:dt key:@"dt"];
[p addObject:id key:@"id"];
var af = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://qkgermany.feomedia.se/"]];
var path = @"users/current_user_games_is";
var req = [af requestWithMethod:@"POST" path:path parameters:[p params]];
[FEOUtil requestHash:req post:[p params] key:ny];

[[GAEConnectionHandler sharedGAEConnectionHandler] postRequest:path post:p selector:@selector(showGamesFinished:) failSEL:@selector(showGamesFailed) spinner:1];