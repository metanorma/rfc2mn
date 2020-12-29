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
    
    public boolean isValid(String xmlString) {
        
        boolean isValid = validate(xmlString, "V2");
        if (!isValid) {
            isValid = validate(xmlString, "V3.7991");
            if (!isValid) {
                isValid = validate(xmlString, "V3.7991.draft");
            }
        }
        
        return isValid;
    }
    
    public String getValidationInfo() {
        return sMessage;
    }
    
    public boolean validate(String xmlString, String version) {
        try {
            // https://stackoverflow.com/questions/1541253/how-to-validate-an-xml-document-using-a-relax-ng-schema-and-jaxp
            System.setProperty(SchemaFactory.class.getName() + ":" + XMLConstants.RELAXNG_NS_URI, "com.thaiopensource.relaxng.jaxp.CompactSyntaxSchemaFactory");

            SchemaFactory factory = SchemaFactory.newInstance(XMLConstants.RELAXNG_NS_URI);
            
            String rngFilename = "";
            if (version.toLowerCase().equals("v2")) {
                rngFilename = "xml2rfcv2.rnc";
            } else if (version.toLowerCase().equals("v3.7991")) {
                rngFilename = "xml2rfcv3.rfc7991.rnc";
            } else
            {
                rngFilename = "xml2rfcv3.rfc7991bis-03.rnc";
            }
                        
            Source srcRNG = new StreamSource(Util.getStreamFromResources(getClass().getClassLoader(), rngFilename));
            Schema schema = factory.newSchema(srcRNG);
            Validator validator = schema.newValidator();
            
            /*
            // skip DTD validating 
            //found here: https://moleshole.wordpress.com/2009/10/08/ignore-a-dtd-when-using-a-transformer/
            
            EntityResolver entityResolver = new EntityResolver() {
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
            };*/
            
            XMLReader rdr = XMLReaderFactory.createXMLReader();
            /*rdr.setEntityResolver(new EntityResolver() {
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
            });*/
            
            Source src = new SAXSource(rdr, new InputSource(new StringReader(xmlString))); //new FileInputStream(xmlFile)
            
            try
            {
                validator.validate(src);
                return true;
            }
            catch (SAXException ex)
            {
                sMessage = "XML is not valid because: " + ex.toString();
            }
        } catch (Exception ex) {
            sMessage = ex.toString();
        }
        
        return false;
    }
}
