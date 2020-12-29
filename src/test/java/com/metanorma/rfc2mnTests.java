package com.metanorma;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.apache.commons.cli.ParseException;

import org.junit.BeforeClass;
import org.junit.Rule;
import org.junit.Test;
import static org.junit.Assert.assertTrue;

import org.junit.contrib.java.lang.system.EnvironmentVariables;
import org.junit.contrib.java.lang.system.ExpectedSystemExit;
import org.junit.contrib.java.lang.system.SystemOutRule;
import org.junit.rules.TestName;

public class rfc2mnTests {

    static String XMLFILE_MN;
    
    @Rule
    public final ExpectedSystemExit exitRule = ExpectedSystemExit.none();

    @Rule
    public final SystemOutRule systemOutRule = new SystemOutRule().enableLog();

    @Rule
    public final EnvironmentVariables envVarRule = new EnvironmentVariables();

    @Rule public TestName name = new TestName();
    
    @BeforeClass
    public static void setUpBeforeClass() throws Exception {
        XMLFILE_MN = "test.v2.xml"; //System.getProperty("inputXML");        
    }
    
    @Test
    public void notEnoughArguments() throws ParseException {
        System.out.println(name.getMethodName());
        exitRule.expectSystemExitWithStatus(-1);
        String[] args = new String[]{""};
        rfc2mn.main(args);

        assertTrue(systemOutRule.getLog().contains(rfc2mn.USAGE));
    }

    
    @Test
    public void xmlNotExists() throws ParseException {
        System.out.println(name.getMethodName());
        exitRule.expectSystemExitWithStatus(-1);

        String[] args = new String[]{"nonexist.xml"};
        rfc2mn.main(args);

        assertTrue(systemOutRule.getLog().contains(
                String.format(rfc2mn.INPUT_NOT_FOUND, rfc2mn.XML_INPUT, args[1])));
    }


    @Test
    public void successCheckXMLv2() throws ParseException, Exception {
        System.out.println(name.getMethodName());
        ClassLoader classLoader = getClass().getClassLoader();
        String xml = classLoader.getResource("test.v2.xml").getFile();
        RELAXNGValidator rngValidator = new RELAXNGValidator();
        String xmlString = new rfc2mn().serialize(new File(xml));
        //boolean isValid = rngValidator.validate(new File(xml), "V2");
        boolean isValid = rngValidator.validate(xmlString, "V2");

        assertTrue(isValid);        
    }

    @Test
    public void successCheckXMLv3() throws ParseException, Exception {
        System.out.println(name.getMethodName());
        ClassLoader classLoader = getClass().getClassLoader();
        String xml = classLoader.getResource("antioch.v3.xml").getFile();
        RELAXNGValidator rngValidator = new RELAXNGValidator();
        String xmlString = new rfc2mn().serialize(new File(xml));
        //boolean isValid = rngValidator.validate(new File(xml), "V3.7991");
        boolean isValid = rngValidator.validate(xmlString, "V3.7991");

        assertTrue(isValid);        
    }
    
}
