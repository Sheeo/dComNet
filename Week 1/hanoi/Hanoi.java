public class Hanoi {
	public static void towers(int n, int i, int j) {
		if (n == 1) {
			System.out.println("Move a disk from "+i+" to "+j);
			return;
		}
		int k = 6 - i - j;
		towers(n-1, i, k);
		towers(1, i, j);
		towers(n-1, k, j);
	}
	public static void main(String[] args) {
		towers(2, 1, 2);
		towers(1, 1, 3);
		towers(2, 2, 3);
	}
}
