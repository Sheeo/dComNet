import java.net.*;
import java.util.Date;
import java.text.SimpleDateFormat;
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
		final String hostSig = hostname+" ("+host+")";

		try {
			socket = new DatagramSocket();
			socket.setSoTimeout(TIMEOUT);
		} catch (SocketException e) {
			e.printStackTrace();
			return;
		}

		int seq = 1;

		while (true) {
			String sendString = generateSendString(seq);
			byte[] sendData = sendString.getBytes();
			DatagramPacket sendPacket = new DatagramPacket(sendData, sendData.length, host, port);
			long sendTime = System.nanoTime();
			long ping;
			try {
				socket.send(sendPacket);
			} catch (IOException e) {
				System.err.println("In sending ping request to "+hostSig+": "+e);
			}
			
			byte[] receiveData = new byte[1024];
			DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
			try {
				socket.receive(receivePacket);
				ping = System.nanoTime()-sendTime;
				System.out.println(receiveData.length+" bytes from "+hostSig+": ping_seq="+seq+" time="+ping+"ns");
			} catch (SocketTimeoutException e) {
				System.out.println("Timeout from "+hostSig);
			} catch (IOException e) {
				System.err.println("In receiving ping response from "+hostSig+": "+e);
			}
			++seq;
			--packets;
			if (packets == 0) break;
			try {
				Thread.sleep(DELAY);
			} catch (InterruptedException e) {
				System.err.println("Grr, my beauty sleep!");
			}
		}
	}

	private static String generateSendString(int seq) {
		StringBuffer buf = new StringBuffer("PING ");
		buf.append(seq);
		buf.append(' ');
		SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
		buf.append(fmt.format(new Date()));
		buf.append('\n');
		return buf.toString();
	}
}
