var dgram = require('dgram'),
    dns = require('dns');

function pingclient(argv) {
	var pingcli = this;

	if (argv.length < 4) {
		console.log("Required arguments: host port");
		process.exit(1);
	}

	var hostname = this.hostname = process.argv[2];
	this.port = parseInt(process.argv[3], 10);
	var client = this.client = dgram.createSocket('udp4');
	this.sent = 0;
	this.timeouttimer = null;

	client.on('message', function (msg, rinfo) {
		pingcli.onMessage(msg, rinfo);
	});

	console.log("Looking up "+hostname);
	dns.lookup(hostname, null, function (err, addresses) {
		if (err) {throw err;}
		var address = pingcli.address = addresses;
		console.log(pingcli.hostname+" = "+address);
		pingcli.sendpacket();
	});
}

pingclient.TIMEOUT = 1000; // milliseconds
pingclient.DELAY = 1000; // milliseconds
pingclient.PACKETS = 10;

pingclient.prototype.generateMessage = function () {
	return "message";
};

pingclient.prototype.sendpacket = function () {
	this.clearPacketTimer();
	var msg = this.generateMessage();
	console.log("Sending "+JSON.stringify(msg)+" to "+this.address+":"+this.port);
	this.client.send(new Buffer(msg), 0, msg.length, this.port, this.address);
	++this.sent;
	this.setTimeoutTimer();
};

pingclient.prototype.clearTimeoutTimer = function () {
	if (!this.timeouttimer) {return;}
	clearTimeout(this.timeouttimer);
	this.timeouttimer = null;
};

pingclient.prototype.setTimeoutTimer = function () {
	var pingcli = this;
	this.clearTimeoutTimer();
	this.timeouttimer = setTimeout(function () {
		pingcli.handletimeout();
	}, pingclient.TIMEOUT);
};

pingclient.prototype.clearPacketTimer = function () {
	if (!this.packettimer) {return;}
	clearTimeout(this.packettimer);
	this.packettimer = null;
};

pingclient.prototype.setPacketTimer = function () {
	var pingcli = this;
	this.clearPacketTimer();
	this.packettimer = setTimeout(function () {
		pingcli.sendpacket();
	}, pingclient.DELAY);
};

pingclient.prototype.handletimeout = function () {
	this.clearTimeoutTimer();
	console.log("Timeout from server");
	this.setPacketTimer();
};

pingclient.prototype.onMessage = function (msg, rinfo) {
	this.clearTimeoutTimer();
	console.log("Received reply from server");
	if (this.sent >= pingclient.PACKETS) {
		this.shutdown();
		return;
	}
	this.setPacketTimer();
};

pingclient.prototype.shutdown = function () {
	this.client.close();
};

var c = new pingclient(process.argv);
