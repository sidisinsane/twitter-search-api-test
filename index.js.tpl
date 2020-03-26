const fs = require('fs');
const Twit = require('twit');
const moment = require('moment');

function parseTwitterDate(tdate) {
    var system_date = new Date(Date.parse(tdate));
    var user_date = new Date();

    var diff = Math.floor((user_date - system_date) / 1000);
    if (diff <= 1) {return "just now";}
    if (diff < 20) {return diff + " seconds ago";}
    if (diff < 40) {return "half a minute ago";}
    if (diff < 60) {return "less than a minute ago";}
    if (diff <= 90) {return "one minute ago";}
    if (diff <= 3540) {return Math.round(diff / 60) + " minutes ago";}
    if (diff <= 5400) {return "1 hour ago";}
    if (diff <= 86400) {return Math.round(diff / 3600) + " hours ago";}
    if (diff <= 129600) {return "1 day ago";}
    if (diff < 604800) {return Math.round(diff / 86400) + " days ago";}
    if (diff <= 777600) {return "1 week ago";}
    return "on " + system_date;
}

let q = 'from:worldwidejs #javascript';
let count = 3;
let lang = 'en';

const T = new Twit({
    consumer_key: 'YOUR_API_KEY',
    consumer_secret: 'YOUR_API_SECRET',
    access_token: 'YOUR_ACCESS_TOKEN',
    access_token_secret: 'YOUR_TOKEN_SECRET',
    timeout_ms: 60 * 1000
});

(async () => {
    try {
        // search twitter for tweets matching query
        T.get('search/tweets', { q: q, count: count, lang: lang, result_type: 'recent' })
            .catch(function (err) {
                console.error('caught error:', err.stack)
            })
            .then(function (response) {
                response.data.statuses.forEach(function(status) {
                    var tdate = moment(new Date(status.created_at));

                    console.log('---');
                    console.log('created_at:', status.created_at);
                    console.log('created_at formatted:', parseTwitterDate(tdate));

                    if (status.user) {
                        console.log('name:', status.user.name);
                        console.log('link to tweet:', 'https://twitter.com/' + status.user.screen_name + '/status/' + status.id_str);
                        console.log('profile_image_url_https:', status.user.profile_image_url_https);
                    }
                    if (status.text) {
                        console.log('text:', status.text);
                    }
                    if (status.entities.media) {
                        status.entities.media.forEach(function(media) {
                            if (media.type == 'photo') {
                                if (media.sizes.thumb) {
                                    console.log('photo thumb:', media.media_url + ':thumb');
                                }
                                if (media.sizes.large) {
                                    console.log('photo large:', media.media_url + ':large');
                                }
                                if (media.sizes.small) {
                                    console.log('photo small:', media.media_url + ':small');
                                }
                                if (media.sizes.medium) {
                                    console.log('photo medium:', media.media_url + ':medium');
                                }
                            }
                        });
                    }
                });

                // for testing purpose, write the response to a file
                let responseFormatted = JSON.stringify(response, null, 2);
                let writeStream = fs.createWriteStream('response.log');
                writeStream.write(responseFormatted);
                writeStream.on('finish', () => {
                    console.log(responseFormatted);
                });
                writeStream.end();
            });
    } catch (e) {
        throw e;
    }
})();
