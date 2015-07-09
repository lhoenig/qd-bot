NSLog_ = dlsym(RTLD_DEFAULT, "NSLog")
NSLog = function() { var types = 'v', args = [], count = arguments.length; for (var i = 0; i != count; ++i) { types += '@'; args.push(arguments[i]); } new Functor(NSLog_, types).apply(null, args); }


function nextAnswer() {
    //return 0;
    return Math.floor((Math.random() * 10) + 1) > 1 ? 0 : 1;
}

var u = [[UIApplication sharedApplication].keyWindow.rootViewController.topViewController user];

var games_count = [[u games] count];

for (var i = 0; i < games_count; i++) {

	var g = [[u games] objectAtIndex:i];
	if ([g isMyTurn]) {

		var a = [[NSMutableArray alloc] initWithArray:[g getMyAnswers]];

		if ([a count] == 15 || ([a count] == 0 && [[g opponentAnswerArray] count] == 0 && [g isMyTurn])) {
			
			var newAnswers = [NSArray arrayWithObjects: nextAnswer(), 
													    nextAnswer(), 
													    nextAnswer(), nil];
			[a addObjectsFromArray:newAnswers];
		
		} else {
			
			var newAnswers = [NSArray arrayWithObjects: nextAnswer(),
														nextAnswer(), 
														nextAnswer(), 
														nextAnswer(), 
														nextAnswer(), 
														nextAnswer(), nil];
			[a addObjectsFromArray:newAnswers];
		}

		var c = [g lastRoundCat];
		if (!c) c = 0;

		var p = [FEOPost post:c key:@"cat_choice"];
		var id = [g gameID];
		[p addArray:a key:@"answers"];
		[p addObject:id key:@"game_id"];
		[[GAEConnectionHandler sharedGAEConnectionHandler] postRequest:@"games/upload_round_answers" post:p selector:@selector(uploadRoundFinished:) failSEL:@selector(uploadRoundFailed)];
		
		NSLog(@"Uploading answers against %@", [g getOpponentName]);
	}
}