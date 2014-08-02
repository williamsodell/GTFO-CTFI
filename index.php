<!doctype html>
<html class="no-js" lang="en">
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<title>Perfect Hair is Coming</title>
		<link rel="stylesheet" href="css/foundation.min.css" />
		<script src="js/vendor/modernizr.js"></script>
		<style>
			#perfecthair { opacity: 0; filter: alpha(0); }
			#iscoming { display: none; margin-bottom: 1em; }
			body { text-align: center; }
			#quote-container { margin-top: 10px; }
			#quotes > div { width: 100%; }
		</style>
	</head>
	<body>

		<div class="row">
			<div class="large-12 columns">
				<h1>Get the F*** Out</h1>
			</div>
		</div>

		<div class="row">
			<div class="large-12 columns" id="iscoming">
				in <span id="remaining">...</span>
			</div>
		</div>

		<div class="row">
			<div class="large-12 columns"><?php //brandonmont ?>
				<img id="perfecthair" src="http://graph.facebook.com/<?= htmlspecialchars($_GET['facebook_profile']) ?>/picture?type=large">
			</div>
		</div>

		<div class="row">
			<div class="large-12 columns" id="quote-container">
				<div id="quotes" class="cycle-slideshow" data-cycle-fx="scrollHorz" data-cycle-timeout="4000" data-cycle-slides="> div"></div>
			</div>
		</div>

		<script src="js/vendor/jquery.js"></script>
		<script src="js/foundation.min.js"></script>
		<script src="js/vendor/jquery.cycle2.min.js"></script>
		<script>
			$(document).foundation();

			$(function () {
				var start, end, data;

				start = new Date('2014-07-20T09:00:00');
				end = new Date('2014-07-28T09:00:00');

				<?php if (1 == @$_GET['demo']) { ?>
				start = new Date();
				end = new Date(start.getTime() + 10000);
				<?php } ?>

				var loadQuotes = function () {

					$.ajax({
						dataType: "json",
						url: 'quotes.json',
						success: function(data) {
							var item;
							$.each(data, function(key, quote) {
								item = '<div id="quote-' + key + '">"' + quote.content + '" <br>&nbsp;&nbsp;-- <span class="author">' + quote.author + '</span></div>';
								$('#quotes').cycle('add', item);
							});
						},
							error: function (jqXHR, textStatus, errorThrown) { console.log( {textStatus: textStatus, error: errorThrown}); }
					});
				};

				var getData = function (now) {
					var total, remaining;

					if ('undefined' == typeof(now)) {
						now = new Date();
					}

					total = end.getTime() - start.getTime();
					remaining = end.getTime() - now.getTime();

					return {
						percent: Math.floor((1 - (remaining / total)) * 100),
						remaining: remaining
					};
				};

				var getTimeString = function (milli) {
					var d, h, m, s;

					s = Math.floor(milli / 1000);

					m = Math.floor(s / 60);
					s -= m * 60;

					h = Math.floor(m / 60);
					m -= h * 60;

					d = Math.floor(h / 24);
					h -= d * 24;

					return d + ' days, ' + h + ' hours, ' + m + ' minutes, ' + s + ' seconds';
				};

				var updateElements = function (percent, timeRemaining) {
					if (percent < 100) {
						$('#perfecthair').css('opacity', percent / 100).css('filter', 'alpha(opacity=' + percent  + ')');
						$('#remaining').text(timeRemaining);
						$('#iscoming').show();
					} else {
						$('#perfecthair').css('opacity', percent / 100).css('filter', 'alpha(opacity=' + percent  + ')');
						finish();
					}
				};

				var go = function() {
					var interval = setInterval(function() {
						data = getData(new Date());
						//console.log(data);
						if (data.remaining <= 0) {
							// Stop the countdown
							clearInterval(interval);
							updateElements(data.percent, getTimeString(data.remaining));
							finish();
						}
						updateElements(data.percent, getTimeString(data.remaining));
					}, 1000);

					$('#iscoming').fadeIn()

				};

				var finish = function () {
					$('#iscoming').hide();
					$('h1').text('Perfect Hair is Here!');
				};

				//

				loadQuotes();

				if (start >= end) {
					finish();
				}
				else {
					go();
				}

			});
		</script>
	</body>
</html>
