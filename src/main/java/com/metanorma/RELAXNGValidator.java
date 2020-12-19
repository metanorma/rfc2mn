package com.metanorma;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.StringReader;
import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.sax.SAXSource;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;
import org.xml.sax.XMLReader;
import org.xml.sax.helpers.XMLReaderFactory;

/**
 *
 * @author Alexander Dyuzhev
 */
public class RELAXNGValidator {
    
    String sMessage = "";
    
    
    
    public RELAXNGValidator() {
        
    }
    
    public boolean isValid(File xmlFile) {
        
        boolean isValid = checkAgainstV2(xmlFile);
        if (!isValid) {
            isValid = checkAgainstV3(xmlFile);
        }
        
        return isValid;
    }
    
    public String getValidationInfo() {
        return sMessage;
    }
    
    public boolean checkAgainstV2(File xmlFile) {
        try {
            // https://stackoverflow.com/questions/1541253/how-to-validate-an-xml-document-using-a-relax-ng-schema-and-jaxp
            System.setProperty(SchemaFactory.class.getName() + ":" + XMLConstants.RELAXNG_NS_URI, "com.thaiopensource.relaxng.jaxp.CompactSyntaxSchemaFactory");
            SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.RELAXNG_NS_URI);
            Source srcRNG = new StreamSource(Util.getStreamFromResources(getClass().getClassLoader(), "xml2rfcv2.rng"));
            Schema schema = factory.newSchema(srcRNG);
            Validator validator = schema.newValidator();
            
            
            // skip DTD validating 
            //found here: https://moleshole.wordpress.com/2009/10/08/ignore-a-dtd-when-using-a-transformer/
            XMLReader rdr = XMLReaderFactory.createXMLReader();
            rdr.setEntityResolver(new EntityResolver() {
		@Override
		public InputSource resolveEntity(String publicId, String systemId) throws SAXException, IOException {
                    if (systemId.endsWith(".dtd")) {
                            StringReader stringInput = new StringReader(" ");
                            return new InputSource(stringInput);
                    }
                    else {
                            return null; // use default behavior
                    }
		}
            });
            
            Source src = new SAXSource(rdr, new InputSource(new FileInputStream(xmlFile)));
            
            try
            {
                validator.validate(src);
                return true;
            }
            catch (SAXException ex)
            {
                sMessage = xmlFile + " is not valid because: " + ex.getMessage();
            }
        } catch (Exception ex) {
            sMessage = ex.toString();
        }
        
        return false;
    }
    
    public boolean checkAgainstV3(File xmlFile) {
        
        return true;
    }
    
}
