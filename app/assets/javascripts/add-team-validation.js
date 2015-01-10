$(document).on('ready', function() {
	$('.account-creation-container').on('change','#player-teams-form', function() {
		var sport = $('#sport_select').val();
		console.log(sport)
		var team = $('#team').val();
		console.log(team)
		var division = $('#division').val();
		console.log(division)
		var league = $('#league').val();
		console.log(league)
		if (sport.length > 0 && team.length > 0 && division.length > 0 && league.length > 0) {
			$('#add-team-button').removeClass('disabled');
		};
	});
});