$(document).ready(function() {
	$('div[id*=goal_]').each(function() {
		new Morris.Line({
		  element: $(this).attr('id'),
		  data: $(this).data('forecast'),
		  xkey: 'year',
		  ykeys: ['inflaction', 'interest', 'optimism'],
		  labels: ['Inflação', 'SELIC', 'Otimista'],
		  preUnits: 'R$'
		});
	});
})