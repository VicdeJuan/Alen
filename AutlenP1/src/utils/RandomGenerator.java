package utils;


import java.util.Random;

public class RandomGenerator {
	
	/**
	 * Generates random integer in range (min,max)
	 * @param min	the minimum value that can be generated.
	 * @param max	the maximum value that can be generated.
	 * @return	random integer 
	 */
	public static int randInt(int min, int max){	
	    Random rand = new Random(System.currentTimeMillis());    
	    return rand.nextInt((max - min) + 1) + min;
	}


}
