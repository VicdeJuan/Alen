package test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;


@RunWith(Suite.class)
@SuiteClasses({ GrammarTestLeftFirst.class, GrammarTestLeftLast.class,
		GrammarTestRandom.class, GrammarTestRightFirst.class,
		GrammarTestRightLast.class, ParserTest.class })
public class AllTests {

}
