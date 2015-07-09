NSLog_ = dlsym(RTLD_DEFAULT, "NSLog")
NSLog = function() { var types = 'v', args = [], count = arguments.length; for (var i = 0; i != count; ++i) { types += '@'; args.push(arguments[i]); } new Functor(NSLog_, types).apply(null, args); }

var u = [[Datasource sharedDatasource] currentUser];

[[QKStatsVC withUser:u modal:0] viewDidLoad];

[NSThread sleepForTimeInterval:15]

NSLog(@"Games played: %@   Ranking: %@   Points: %@", [[u nGamesPlayed] intValue], [[Datasource rank] intValue], [[u rating] intValue]);