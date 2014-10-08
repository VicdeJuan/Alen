package test;

import static org.junit.Assert.*;
import grammar.DerivationMode;
import grammar.Grammar;
import grammar.RightPartSelector;

import java.util.ArrayList;

import org.junit.Test;

public class GrammarTestRandom {

	@Test
	public void test() {
		Grammar grammar = new Grammar();
		
		DerivationMode derivationMode = DerivationMode.Right;
		RightPartSelector rightPartSelector = RightPartSelector.Random;
		
		
		grammar.setAxiom('S');
		grammar.setMaxDepth(4);
		grammar.setDerivationMode(derivationMode);
		grammar.setRightPartSelector(rightPartSelector);
		grammar.setNoTerminals("SAB");
		grammar.setTerminals("ab");
		
		ArrayList<String> rules = new ArrayList<String>();
		rules.add("S:BAAABBBA");
		rules.add("A:aBBb");
		rules.add("B:BbAa");
		rules.add("A:");
		
		grammar.setDerivatioRules(rules);

		assertNotEquals(grammar.derivateAll(false),grammar.derivateAll(false));
		
		
	}

}
