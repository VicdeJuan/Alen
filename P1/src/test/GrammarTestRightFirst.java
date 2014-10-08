package test;

import static org.junit.Assert.*;
import grammar.DerivationMode;
import grammar.Grammar;
import grammar.RightPartSelector;

import java.util.ArrayList;

import org.junit.Test;

public class GrammarTestRightFirst {

	@Test
	public void test() {
		Grammar grammar = new Grammar();
		
		DerivationMode derivationMode = DerivationMode.Right;
		RightPartSelector rightPartSelector = RightPartSelector.First;
		
		
		grammar.setAxiom('S');
		grammar.setMaxDepth(4);
		grammar.setDerivationMode(derivationMode);
		grammar.setRightPartSelector(rightPartSelector);
		grammar.setNoTerminals("SAB");
		grammar.setTerminals("ab");
		
		ArrayList<String> rules = new ArrayList<String>();
		rules.add("S:AAAAAAAAA");
		rules.add("A:a");
		rules.add("A:b");
		rules.add("B:");
		
		grammar.setDerivatioRules(rules);
		assertEquals("AAAAAAaaa",grammar.derivateAll(false));
	}

}
