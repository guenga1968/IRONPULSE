const https = require('https');

const token = 'sbp_03a43acd9a88a9861bd24ae6a7b020e1097aadc9';

const options = {
    hostname: 'api.supabase.com',
    port: 443,
    path: '/v1/organizations',
    method: 'GET',
    headers: {
        'Authorization': `Bearer ${token}`
    }
};

const req = https.request(options, (res) => {
    console.log(`Status: ${res.statusCode}`);
    let body = '';
    res.on('data', (d) => body += d);
    res.on('end', () => console.log(body));
});

req.on('error', (e) => console.error(e));
req.end();
