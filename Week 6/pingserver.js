/*
 * Server to process ping requests over UDP.
 */

var LOSS_RATE = 0.3,
    AVERAGE_DELAY = 100, // milliseconds
    dgram = require('dgram');

// Get command line argument.
if (process.argv.length < 3) {
	console.log("Required arguments: port");
	process.exit(1);
}
var port = parseInt(process.argv[2]);

// Create a datagram socket for receiving and sending UDP packets
// through the port specified on the command line.
var server = dgram.createSocket('udp4');

// Request handler.
server.on('message', function (msg, rinfo) {
	// Print the received data.
	console.log(msg.toString());

	// Decide whether to reply, or simulate packet loss.
	if (Math.random() < LOSS_RATE) {
		console.log("    Reply not sent.");
		return;
	}

	// Simulate network delay.
	var delay = Math.random()*2*AVERAGE_DELAY;

	setTimeout(function () {
		// Send reply.
		server.send(msg, 0, msg.length, rinfo.port, rinfo.address);
		console.log("    Reply sent.");
	}, delay);
});

server.bind(port);
