package grammar;

import java.util.ArrayList;

import utils.RandomGenerator;

import utils.TablaDerivaciones;

public class Grammar {
	private String terminals;
	private String noTerminals;
	private DerivationMode derivationMode;
	private RightPartSelector rightPartSelector;
	private int maxDepth;
	private ArrayList<String> derivationRules;
	private char Axiom;
	private String word;
	private TablaDerivaciones drawer;

	public Grammar() {
		derivationRules = new ArrayList<String>();
		setTerminals(new String());
		noTerminals = new String();
		word=null;
		drawer = null;
		
	}

	/**
	 * Derivates the given word just once.
	 * 
	 * @param	draw boolean to indicate if we are testing or in main execution.
	 * @return	null if word can't be derivated or the result of derivating
	 *         following the rules of the grammar.
	 */
	
	public String derivateAll(Boolean draw){
		ArrayList <String>  list = new ArrayList<String>();
		list.add(""+getAxiom());
		drawer = new TablaDerivaciones(list);
				
		for(int i=0; i< this.getMaxDepth();i++){
			this.derivate(draw);
		}
		
		if (draw)
			drawer.dibuja();
		return this.getWord();
	}

	/**
	 * One step in the derivation process.
	 * @param	draw boolean to indicate if we are testing or in main execution.
	 * @return	the derivation string if draw or the whole word if not draw.
	 */
	public String derivate(Boolean draw) {		
		if(word==null){
			word="";
			word+= this.getAxiom();
		}
		
		int index;
		if (getDerivationMode() == DerivationMode.Left) {
			for (int i = 0; i < word.length(); i++) {
				index = getNoTerminals().indexOf(word.charAt(i));
				if (index >= 0)
					return auxiliarDerivate(i,draw);
			}
		} else {
			for (int i = word.length()-1; i >= 0; i--) {
				index = getNoTerminals().indexOf(word.charAt(i));
				if (index >= 0)
					return auxiliarDerivate(i,draw);				
			}
		}
		return null;
	}

	/**
	 * Auxiliary function to concatenate the result of the derivation and
	 * the word pre-derivated.
	 * @param	i the index of the no-terminal character to be derivated.
	 * @param	draw false if we are testing or true in main execution.
	 * @return	the derivation string if draw or the whole word if not draw.
	 */
	private String auxiliarDerivate(int i,Boolean draw){
		String leftToConcat;
		String rightToConcat = new String();
		String derivated = new String();
		ArrayList <String>  list = new ArrayList<String>();
		leftToConcat = word.substring(0, i);
		rightToConcat = word.substring(i + 1);
		derivated = this.getDerivation(word.charAt(i));
		word = leftToConcat + derivated + rightToConcat;
		if (draw){
			if(derivated != null){
				for (int j = 0; j < derivated.length(); j++) {
					list.add(String.valueOf(derivated.charAt(j)));
				}
				drawer.deriva(i, list);
			}
		}
		if (draw){
			return derivated;
		}else {
			return word;
		}
	}
	/**
	 * Gets one derivation from one no-terminal node following the rules given by
	 * the grammar.
	 * 
	 * @param no-terminal node.
	 * @return the result of the derivation.
	 */
	private String getDerivation(Character NT) {
		ArrayList<String> derivationRules = getRules();
		ArrayList<Integer> positions = new ArrayList<Integer>();
		int cont=0,aleat,index;
		
		if (getRightPartSelector() == RightPartSelector.First) {
			for (int i = 0; i < derivationRules.size(); i++) {
				if (derivationRules.get(i).charAt(0) == NT) {
					return derivationRules.get(i).substring(2);
				}
			}
			return "";
		} else if (getRightPartSelector() == RightPartSelector.Last) {
			for (int i = derivationRules.size()-1; i >= 0; i--) {
				if (derivationRules.get(i).charAt(0) == NT) {
					return derivationRules.get(i).substring(2);
				}
			}
			return "";

		} else {
			for (int i = 0; i < derivationRules.size()-1; i++) {
				if (derivationRules.get(i).charAt(0) == NT) {
					positions.add(i);
					cont++;
				}
			}
			aleat = RandomGenerator.randInt(0,cont-1);
			index = positions.get(aleat);
			return derivationRules.get(index).substring(2);	
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
		return derivationRules;
	}

	public void setRules(ArrayList<String> rules) {
		this.derivationRules = rules;
	}

	public void setAxiom(char axiom) {
		Axiom = axiom;
	}
	
	public char getAxiom() {
		return Axiom;
	}
	
	public void setDerivatioRules(ArrayList<String> derivatioRules) {
		this.derivationRules = derivatioRules;
	}
	
	public ArrayList<String> getDerivatioRules() {
		return derivationRules;
	}
	
	public String getWord() {
		return word;
	}
}
