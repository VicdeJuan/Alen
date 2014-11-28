package test;

import static org.junit.Assert.*;
import grammar.Grammar;


import org.junit.Test;

import utils.Parser;

public class ParserTest {

	@Test
	public void testParseFile() {
		
		String fileName="g2.txt";
		
		Parser fileParser = new Parser();
		fileParser.ParseFile(fileName);
		
		Grammar grammar = fileParser.getGrammar();
		
		assertEquals('S',grammar.getAxiom());
		assertEquals("SAB",grammar.getNoTerminals());
		assertEquals("ab",grammar.getTerminals());
		assertEquals(4, grammar.getMaxDepth());
		assertEquals(4, grammar.getDerivatioRules().size());
		
	}

}
