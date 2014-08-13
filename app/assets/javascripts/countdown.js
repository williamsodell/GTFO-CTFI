$(document).foundation();

function getTimeString(milli) {
	var d, h, m, s;

	s = Math.floor(milli / 1000);

	m = Math.floor(s / 60);
	s -= m * 60;

	h = Math.floor(m / 60);
	m -= h * 60;

	d = Math.floor(h / 24);
	h -= d * 24;

	return d + ' days, ' + h + ' hours, ' + m + ' minutes, ' + s + ' seconds';
}

$(function() {
	if ($("#countdowns").length > 0) {
		var interval = setInterval(function() {
			var now = new Date();
			$('#countdowns tbody tr td:nth(1)').each(function() {
				var date = new Date(parseInt($(this).attr('data:end_date')));

				if (date > now) {
					$(this).text(getTimeString(date.getTime() - now.getTime()));
				} else {
					$(this).text("DONE");
				}
			});
		}, 1000);
	}
});

$(function () {
	if (typeof start == 'undefined' || typeof end == 'undefined') return;
	
	var data;

	var loadQuotes = function () {
		setTimeout(function() {
			var item;
			$.each(hashtags, function(key, hash) {
				item = '<div id="quote-' + key + '">"' + hash.text + '" <br>&nbsp;&nbsp;-- <span class="author">' + hash.name + '</span></div>';
				$('#quotes').cycle('add', item);
			});
		}, 2000);
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

	var updateElements = function (percent, timeRemaining) {
		if (percent < 100) {
			if ($("#fader").hasClass('GTFO')) percent = 100 - percent;
			$('#fader').css('opacity', percent / 100).css('filter', 'alpha(opacity=' + percent  + ')');
			$('#description').text(start_description);
			$('#remaining').text(timeRemaining);
			$('#iscoming').show();
		} else {
			$('#fader').css('opacity', percent / 100).css('filter', 'alpha(opacity=' + percent  + ')');
			$('#description').text(end_description);
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
	};

	loadQuotes();

	if (start >= end) {
		finish();
	}
	else {
		go();
	}

});