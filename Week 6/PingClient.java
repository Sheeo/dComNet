import java.net.*;
import java.io.IOException;

public class PingClient implements Runnable {
	private static final int TIMEOUT = 1000; // milliseconds
	private static final int DELAY = 1000; // milliseconds
	private static final int PACKETS = 10;

	public static void main(String[] args) {
		String host = args[0];
		int port = Integer.parseInt(args[1]);

		Runnable c = new PingClient(host, port);
		c.run();
	}

	private String hostname;
	private InetAddress host;
	private int port;
	private DatagramSocket socket;
	private int packets;

	public PingClient(String hostname, int port) {
		this.hostname = hostname;
		this.port = port;
		packets = PACKETS;
	}

	public void run() {
		if (host == null) {
			try {
				host = InetAddress.getByName(hostname);
			} catch (UnknownHostException e) {
				System.err.println(hostname+": Host name lookup failure");
				return;
			}
		}
		final String sendString = "Ping request";
		final String hostSig = hostname+" ("+host+")";
		System.out.println("PING "+hostSig+" "+sendString.length()+" characters of data.");

		try {
			socket = new DatagramSocket();
			socket.setSoTimeout(TIMEOUT);
		} catch (SocketException e) {
			e.printStackTrace();
			return;
		}

		int seq = 1;

		while (packets-- > 0) {
			byte[] sendData = sendString.getBytes();
			DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, host, port);
			try {
				socket.send(sendPacket);
			} catch (IOException e) {
				System.err.println("In sending ping request to "+hostSig+": "+e);
			}
			
			byte[] receiveData = new byte[1024];
			DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
			try {
				socket.receive(receivePacket);
				System.out.println(receiveData.length+" bytes from "+hostSig+": icmp_seq="+seq+"");
			} catch (SocketTimeoutException e) {
				System.out.println("Timeout from "+hostSig);
			} catch (IOException e) {
				System.err.println("In receiving ping response from "+hostSig+": "+e);
			}
			++seq;
			try {
				Thread.sleep(DELAY);
			} catch (InterruptedException e) {
				System.err.println("Grr, my beauty sleep!");
			}
		}
	}
}
