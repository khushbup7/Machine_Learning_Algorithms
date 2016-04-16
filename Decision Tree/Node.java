import java.util.ArrayList;
import java.util.List;

public class Node {
	ArrayList<List<String>> trainData;
	String attributeHeader;
	Node leftChild, rightChild;
	int value;
	Node()
	{}
	Node(ArrayList<List<String>> trainData,String attributeHeader,int value,Node leftchild, Node rightchild)
	{
		this.attributeHeader = attributeHeader;
		this.trainData = trainData;
		this.value = value;
		this.leftChild = leftchild;
		this.rightChild = rightchild;
	}
	
	public void setHeader(String atrheader)
	{
		this.attributeHeader = atrheader;
	}
	
	public void settrainData(ArrayList<List<String>> data)
	{
		this.trainData = data;
	}
	
	public void setleftChild(Node left)
	{
		this.leftChild = left;
	}
	public void setrightChild(Node left)
	{
		this.rightChild = left;
	}
	public Node getleftchild()
	{
		return this.leftChild;
	}
	public Node getrightchild()
	{
		return this.rightChild;
	}
	public String getHeader()
	{
		return this.attributeHeader;
	}
	public void setValue(int value)
	{
		this.value = value;
	}
	public int getValue()
	{
		return this.value;
	}
	public ArrayList<List<String>> gettraindata()
	{
		return this.trainData;
	}
}

