NSLog_ = dlsym(RTLD_DEFAULT, "NSLog")
NSLog = function() { var types = 'v', args = [], count = arguments.length; for (var i = 0; i != count; ++i) { types += '@'; args.push(arguments[i]); } new Functor(NSLog_, types).apply(null, args); }


function nextAnswer() {
    //return 0;
    return Math.floor((Math.random() * 10) + 1) > 1 ? 0 : 1;
}

var user = [[UIApplication sharedApplication].keyWindow.rootViewController.topViewController user];

var games_count = [[user games] count];

for (var i = 0; i < games_count; i++) {

	var game = [[user games] objectAtIndex:i];
	if ([game isMyTurn]) {

		var answ = [[NSMutableArray alloc] initWithArray:[game getMyAnswers]];

		if ([answ count] == 15 || ([answ count] == 0 && [[game opponentAnswerArray] count] == 0 && [game isMyTurn])) {
			
			var newAnswers = [NSArray arrayWithObjects: nextAnswer(), 
													    nextAnswer(), 
													    nextAnswer(), nil];
			[answ addObjectsFromArray:newAnswers];
		
		} else {
			
			var newAnswers = [NSArray arrayWithObjects: nextAnswer(),
														nextAnswer(), 
														nextAnswer(), 
														nextAnswer(), 
														nextAnswer(), 
														nextAnswer(), nil];
			[answ addObjectsFromArray:newAnswers];
		}

		var cat = [game lastRoundCat];
		if (!cat) cat = 0;

		var pst = [FEOPost post:cat key:@"cat_choice"];
		var gid = [game gameID];
		[pst addArray:answ key:@"answers"];
		[pst addObject:gid key:@"game_id"];
		[[GAEConnectionHandler sharedGAEConnectionHandler] postRequest:@"games/upload_round_answers" post:pst selector:@selector(uploadRoundFinished:) failSEL:@selector(uploadRoundFailed)];
		
		NSLog(@"Uploading answers against %@", [game getOpponentName]);
	}
}
