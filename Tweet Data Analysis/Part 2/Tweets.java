import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class Tweets {
	private String text;
	private Long id;
	private int clusterId;
	
	public Tweets()
	{}
	
	public Tweets(Long id, String text)
	{
		this.setId(id);
		this.setText(text);
	}
	
	public void setText(String value)
	{
		this.text = value;
	}
	
	public String getText()
	{
		return this.text;
	}

	public void setId(Long value)
	{
		this.id = value;
	}
	
	public Long getId()
	{
		return this.id;
	}
	public void setClusterId(int value)
	{
		this.clusterId = value;
	}
	
	// Calculate Jacard Distance
	public static double calcJacardDistance(Tweets t1, Tweets t2) 
	{
		List<String> X = Arrays.asList(t1.getText().toLowerCase().replaceAll("[.!:,'\\''/']", "").split(" "));
		List<String> Y = Arrays.asList(t2.getText().toLowerCase().replaceAll("[.!:,'\\''/']", "").split(" "));
		
		Set<String> unionXY = new HashSet<String>(X);
        unionXY.addAll(Y);

        Set<String> intersectionXY = new HashSet<String>(X);
        intersectionXY.retainAll(Y);
        
        return (double)(1- (intersectionXY.size() / (double) unionXY.size()));

	}
	 
}
