package main;

import grammar.*;

import utils.Parser;


public class Main {
	
	public static void main(String[] args){
		Parser fileParser = new Parser();
		
		DerivationMode derivationMode;
		RightPartSelector rightPartSelector;
		
		String fileName = args[0];
			
		if(args[1].equals("i")){
			derivationMode=DerivationMode.Left;
		} else {
			derivationMode=DerivationMode.Right;
		}
		
		if(args[2].equals("p")){
			rightPartSelector = RightPartSelector.First;
		} else if(args[2].equals("a")){
			rightPartSelector = RightPartSelector.Random;
		} else{
			rightPartSelector = RightPartSelector.Last;
		}
		
		
		
		fileParser.ParseFile(fileName);
		fileParser.getGrammar().setDerivationMode(derivationMode);
		fileParser.getGrammar().setRightPartSelector(rightPartSelector);
		fileParser.getGrammar().setMaxDepth(Integer.parseInt(args[3]));
		System.out.println(fileParser.getGrammar().derivateAll(true));
		
	}
	
}
