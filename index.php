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
		</style>
	</head>
	<body>

		<div class="row">
			<div class="large-12 columns">
				<h1>Perfect Hair is Coming</h1>
			</div>
		</div>

		<div class="row">
			<div class="large-12 columns" id="iscoming">
				in <span id="remaining">...</span>
			</div>
		</div>

		<div class="row">
			<div class="large-12 columns">
				<img id="perfecthair" src="img/hair.jpg">
			</div>
		</div>

		<script src="js/vendor/jquery.js"></script>
		<script src="js/foundation.min.js"></script>
		<script>
			$(document).foundation();

			$(function () {
				var start, end, data;

				start = new Date('2014-07-11T09:00:00');
				end = new Date('2014-07-28T09:00:00');

				<?php if (1 == $_GET['demo']) { ?>
					start = new Date();
					//end = new Date(start.getTime() + 100000);
					end = new Date(start.getTime() + 10000);
				<?php } ?>


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
