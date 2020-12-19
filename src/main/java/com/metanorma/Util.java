package com.metanorma;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.jar.Attributes;
import java.util.jar.Manifest;

/**
 *
 * @author Alexander Dyuzhev
 */
public class Util {
   
    public static String getAppVersion() {
        String version = "";
        try {
            Enumeration<URL> resources = rfc2mn.class.getClassLoader().getResources("META-INF/MANIFEST.MF");
            while (resources.hasMoreElements()) {
                Manifest manifest = new Manifest(resources.nextElement().openStream());
                // check that this is your manifest and do what you need or get the next one
                Attributes attr = manifest.getMainAttributes();
                String mainClass = attr.getValue("Main-Class");
                if(mainClass != null && mainClass.contains("com.metanorma.rfc2mn")) {
                    version = manifest.getMainAttributes().getValue("Implementation-Version");
                }
            }
        } catch (IOException ex)  {
            version = "";
        }
        
        return version;
    }
 
    // get file from classpath, resources folder
    public static InputStream getStreamFromResources(ClassLoader classLoader, String fileName) throws Exception {        
        InputStream stream = classLoader.getResourceAsStream(fileName);
        if (stream == null) {
            throw new Exception("Cannot get resource \"" + fileName + "\" from Jar file.");
        }
        return stream;
    }
    
    public static void FlushTempFolder(Path tmpfilepath) {
        if (Files.exists(tmpfilepath)) {
            //Files.deleteIfExists(tmpfilepath);
            try {
                Files.walk(tmpfilepath)
                    .sorted(Comparator.reverseOrder())
                        .map(Path::toFile)
                            .forEach(File::delete);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    
    public static String getJavaTempDir() {
        return System.getProperty("java.io.tmpdir");
    }    
    
    
    public static boolean isUrlExists(String urlname){
    try {
        HttpURLConnection.setFollowRedirects(false);        
        HttpURLConnection con = (HttpURLConnection) new URL(urlname).openConnection();
        con.setRequestMethod("HEAD");
        return (con.getResponseCode() == HttpURLConnection.HTTP_OK ||
                con.getResponseCode() == HttpURLConnection.HTTP_MOVED_TEMP);
    }
    catch (Exception e) {
       e.printStackTrace();
       return false;
    }
  }
    
}
