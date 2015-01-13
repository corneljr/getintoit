$(document).on('ready', function() {
	$('.account-creation-container').on('change','#player-teams-form', function() {
		var sport = $('#sport_select').val();
		var team = $('#team-name').val();
		var division = $('#division-name').val();
		var league = $('#league-name').val();
		console.log(sport.length)
		console.log(team.length)
		console.log(division.length)
		console.log(league.length)
		if (sport.length > 0 && team.length > 0 && division.length > 0 && league.length > 0) {
			$('#add-team-button').removeClass('disabled');
		};
	});
});