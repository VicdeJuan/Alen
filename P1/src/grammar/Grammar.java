package grammar;

import java.util.ArrayList;
import java.util.Random;

import utils.RandomGenerator;

public class Grammar {
	private String terminals;
	private String noTerminals;
	private DerivationMode derivationMode;
	private RightPartSelector rightPartSelector;
	private int maxDepth;
	private ArrayList<String> derivatioRules;
	private char Axiom;
	private String word;

	public Grammar() {
		derivatioRules = new ArrayList<String>();
		setTerminals(new String());
		noTerminals = new String();
		word=null;
	}

	/**
	 * Derivates the given word just once.
	 * 
	 * @param word
	 * @return null if word can't be derivated or the result of derivating
	 *         following the rules of the grammar.
	 */
	
	public String derivateAll(){
		
		for(int i=0; i< this.getMaxDepth();i++)
			this.derivate();
		return this.getWord();
	}

	public void derivate() {
		String leftToConcat;
		String rightToConcat = new String();
		String derivated = new String();
		int index;
		
		
		if(word==null){
			word="";
			word+= this.getAxiom();
		}
		
		if (getDerivationMode() == DerivationMode.Left) {
			for (int i = 0; i < word.length(); i++) {
				index = getNoTerminals().indexOf(word.charAt(i));
				if (index >= 0) {
					leftToConcat = word.substring(0, i);
					rightToConcat = word.substring(i + 1);
					derivated = this.getDerivation(word.charAt(i));
					word = leftToConcat + derivated + rightToConcat;
				}
			}
		} else {
			for (int i = word.length()-1; i >= 0; i--) {
				index = getNoTerminals().indexOf(word.charAt(i));
				if (index >= 0) {
					leftToConcat = word.substring(0, i);
					rightToConcat = word.substring(i + 1);
					derivated = this.getDerivation(word.charAt(i));
					word = leftToConcat + derivated + rightToConcat;
				}
			}
		}
		return;
	}

	/**
	 * Gets one derivation from one no-terminal node.
	 * 
	 * @param no
	 *            -terminal node.
	 * @return derivation.
	 */
	private String getDerivation(Character NT) {
		ArrayList<String> derivatioRules = getRules();
		ArrayList<Integer> positions = new ArrayList<Integer>();
		int cont=0;
		
		if (getRightPartSelector() == RightPartSelector.First) {
			for (int i = 0; i < derivatioRules.size(); i++) {
				if (derivatioRules.get(i).charAt(0) == NT) {
					return derivatioRules.get(i).substring(2);
				}
			}
			return "";
		} else if (getRightPartSelector() == RightPartSelector.Last) {
			for (int i = derivatioRules.size()-1; i >= 0; i--) {
				if (derivatioRules.get(i).charAt(0) == NT) {
					return derivatioRules.get(i).substring(2);
				}
			}
			return "";

		} else {
			for (int i = 0; i < derivatioRules.size(); i++) {
				if (derivatioRules.get(i).charAt(0) == NT) {
					positions.add(i);
					cont++;
				}
			}
			return derivatioRules.get(RandomGenerator.randInt(0,cont));
				
		}
	}
		
	
	public String getTerminals() {
		return terminals;
	}

	public void setTerminals(String terminals) {
		this.terminals = terminals;
	}

	public int getMaxDepth() {
		return maxDepth;
	}

	public void setMaxDepth(int maxDepth) {
		this.maxDepth = maxDepth;
	}

	public String getNoTerminals() {
		return noTerminals;
	}

	public void setNoTerminals(String noTerminals) {
		this.noTerminals = noTerminals;
	}

	public RightPartSelector getRightPartSelector() {
		return rightPartSelector;
	}

	public void setRightPartSelector(RightPartSelector rightPartSelector) {
		this.rightPartSelector = rightPartSelector;
	}

	public DerivationMode getDerivationMode() {
		return derivationMode;
	}

	public void setDerivationMode(DerivationMode derivationMode) {
		this.derivationMode = derivationMode;
	}

	public ArrayList<String> getRules() {
		return derivatioRules;
	}

	public void setRules(ArrayList<String> rules) {
		this.derivatioRules = rules;
	}

	public void setAxiom(char axiom) {
		Axiom = axiom;
	}
	
	public char getAxiom() {
		return Axiom;
	}
	
	public void setDerivatioRules(ArrayList<String> derivatioRules) {
		this.derivatioRules = derivatioRules;
	}
	
	public ArrayList<String> getDerivatioRules() {
		return derivatioRules;
	}
	
	public String getWord() {
		return word;
	}
}
