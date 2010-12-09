var TIMEOUT = 1000, // milliseconds
    DELAY = 1000, // milliseconds
		PACKETS = 10,
    dgram = require('dgram'),
    dns = require('dns');

if (process.argv.length < 4) {
	console.log("Required arguments: host port");
	process.exit(1);
}

var hostname = process.argv[2],
    port = parseInt(process.argv[3], 10),
		address;

var client = dgram.createSocket('udp4');

var sent = 0, timeouttimer = null;

function generateMessage() {
	return "message";
}

function sendpacket() {
	var msg = generateMessage();
	console.log("Sending "+JSON.stringify(msg)+" to "+address+":"+port);
	client.send(new Buffer(msg), 0, msg.length, port, address);
	++sent;
	if (sent >= PACKETS) {return;}
	timeouttimer = setTimeout(handletimeout, TIMEOUT);
}

function handletimeout() {
	console.log("Timeout from server");
	timeouttimer = null;
	setTimeout(sendpacket, DELAY);
}

client.on('message', function (msg, rinfo) {
	if (timeouttimer !== null) {
		clearTimeout(timeouttimer);
		timeouttimer = null;
	}
	console.log("Received reply from server");
	setTimeout(sendpacket, DELAY);
});

console.log("Looking up "+hostname);
dns.lookup(hostname, null, function (err, addresses) {
	if (err) {throw err;}
	address = addresses;
	console.log(hostname+" = "+address);
	sendpacket();
});
