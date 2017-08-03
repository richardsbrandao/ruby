$(document).ready(function() {
	$('div[id*=goal_]').each(function() {
		new Morris.Line({
		  element: $(this).attr('id'),
		  data: $(this).data('forecast'),
		  xkey: 'year',
		  ykeys: ['inflaction', 'interest', 'optimism', 'goal_line'],
		  labels: ['Inflação', 'SELIC', 'Otimista', 'Minimo'],
		  preUnits: 'R$'
		});
	});
})