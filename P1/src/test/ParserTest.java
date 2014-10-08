package test;

import static org.junit.Assert.*;
import grammar.DerivationMode;
import grammar.Grammar;
import grammar.RightPartSelector;

import org.junit.Test;

import utils.Parser;

public class ParserTest {

	@Test
	public void testParseFile() {
		
		String fileName="g2.txt";
		
		Parser fileParser = new Parser();
		fileParser.ParseFile(fileName);
		
		Grammar grammar = fileParser.getGrammar();
		
		assertEquals(grammar.getAxiom(), 'S');
		assertEquals(grammar.getNoTerminals(), "SAB");
		assertEquals(grammar.getTerminals(),"ab");
		assertEquals(grammar.getMaxDepth(), 4);
		assertEquals(grammar.getDerivatioRules().size(), 4);
		
	}

}
