import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
import java.io.FileReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;;
public class ReadExcelFile {
	List<String> attributeHeaders;
	public ArrayList<List<String>> readFile(String file)  throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(new File(file)));;
		String line = "";
		String splitBy = ",";
		ArrayList<List<String>> dataArr = new ArrayList<List<String>>();
		//ArrayList<List<String>> transposeArr = new ArrayList<List<String>>();
		String[] attr = br.readLine().split(splitBy);
		attributeHeaders = Arrays.asList(attr);
       	while ((line = br.readLine()) != null) 
       		{
				List<String> fileRow;
				String[] elements = line.split(splitBy);
				fileRow = Arrays.asList(elements);
			    dataArr.add(fileRow);
       		}
       	br.close();
		return dataArr;
   }
       	
}
