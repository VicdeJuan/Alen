package utils;

import grammar.*;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Iterator;

public class Parser {
	private Grammar grammar;
	
	public Parser() {
		grammar= new Grammar();
	}
	
	public Grammar getGrammar() {
		return grammar;
	}
	
	public void ParseFile(String fileName){
	try{
		BufferedReader br = new BufferedReader(new FileReader(fileName));

		String line;
		int num;
		String terminals = "",rules="", noTerminals = "";
		DerivationMode derivationMode = DerivationMode.Right;
		RightPartSelector rightPartSelector = RightPartSelector.Last;
		int maxDepth = 4,numRightPartSymbols;
		ArrayList <String> listDerivationRules = new ArrayList<String>();

		
		line=br.readLine();
		num = Integer.parseInt(line);	
		for (int i=0; i<num; i++)
			terminals += br.readLine();
		
		line=br.readLine();
		num = Integer.parseInt(line);	
		for (int i=0; i<num; i++)
			noTerminals += br.readLine();
		
		line=br.readLine();
		num = Integer.parseInt(line);	
		for (int i=0; i<num; i++){
			rules+=br.readLine();
			rules+=":";
			line=br.readLine();
			numRightPartSymbols = Integer.parseInt(line);	
			for(int j = 0; j<numRightPartSymbols;j++){
				rules+=br.readLine();
			}
			listDerivationRules.add(rules);
			rules="";
		}
		grammar.setAxiom(br.readLine().charAt(0));
		grammar.setRules(listDerivationRules);
		grammar.setMaxDepth(maxDepth);
		grammar.setNoTerminals(noTerminals);
		grammar.setTerminals(terminals);
		grammar.setRightPartSelector(rightPartSelector);
		grammar.setDerivationMode(derivationMode);
		
		br.close();
	}catch(Exception e){} //or write your own exceptions
	
	}

}

