package test;

import static org.junit.Assert.*;

import java.util.ArrayList;

import grammar.DerivationMode;
import grammar.RightPartSelector;

import org.junit.Test;

import grammar.*;
public class GrammarTestRightLast {

	@Test
	public void test() {
		Grammar grammar = new Grammar();
		
		DerivationMode derivationMode = DerivationMode.Right;
		RightPartSelector rightPartSelector = RightPartSelector.Last;
		
		
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
		rules.add("A:");
		
		grammar.setDerivatioRules(rules);

		assertEquals("AAAAAA",grammar.derivateAll(false));
		
		
	}

}
