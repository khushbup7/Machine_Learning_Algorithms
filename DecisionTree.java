import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class DecisionTree {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		String trainingfile = args[2];
		String testfile = args[4];
		String validationfile =  args[3];
		String toprint = args[5];
		int L = Integer.parseInt(args[0]);
		int K = Integer.parseInt(args[1]);
		ReadExcelFile readfile = new ReadExcelFile();
		ArrayList<List<String>> traindata;
		traindata = readfile.readFile(trainingfile);
		Node root = new Node();
		root = Buildtree(traindata, readfile.attributeHeaders);
		if(toprint.equalsIgnoreCase("yes"))
		printTree(root, 0);
		double accuracy = calcAccuracy(root,testfile);
		System.out.println("Accuracy with test data: " + accuracy);
		Node pruned = new Node();
		pruned = prunetree(root,validationfile,L,K);
		System.out.println("Accuracy with validation data: " + calcAccuracy(pruned,validationfile));
		for(int i=0;i<9;i++)
		{
			L = (1 + (int) (Math.random() * (9)));
			K = (1 + (int) (Math.random() * (9)));
			pruned = prunetree(root,validationfile,L,K);
		}
	}
	
	public static Node Buildtree(ArrayList<List<String>> trainData, List<String> atrHeaders)
	{
		double classentropy = 0;
		double pos=0,neg=0,total;
		for(List<String> str : trainData)
		{
			if(Integer.parseInt(str.get(str.size()- 1)) == 1)
				pos++;
			else
				neg++;
		}
		total = pos + neg;
		classentropy= -(pos/total)*calclog(pos/total) - (neg/total)*calclog(neg/total);
		
		Node root = new Node();
		//root = 
		root = GenerateNode(trainData, atrHeaders,new ArrayList<String>(), classentropy, "",0);
		System.out.println("Built tree:");
		//printTree(root,0);
		return root;
	}
	public static Node GenerateNode(ArrayList<List<String>> trainData, List<String> atrHeaders,List<String> treeHeaders, double classentropy, 
			String splitattrname, int value)
	{
		List<String> treeheaders = new ArrayList<String>(treeHeaders);
		int zeroes = 0, ones = 0;
		if(treeheaders.size() == atrHeaders.size() - 1 || trainData.isEmpty())
		{
			Node leaf = new Node();
			leaf.setValue(value);
			return leaf;
		}
		if(classentropy == 0)
		{
			Node leaf = new Node();
			leaf.setValue(value);
			leaf.setValue(Integer.parseInt((trainData.get(0).get(trainData.get(0).size() - 1))));
			return leaf;
		}
		
		for(List<String> str : trainData)
		{
			int end = str.size() - 1;
			
			if(Integer.parseInt(str.get(end)) == 1)
				ones++;
			
			if(Integer.parseInt(str.get(end)) == 0)
				zeroes++;
		}
		if(ones == (ones + zeroes))
		{
			Node leaf = new Node();
			leaf.setHeader(splitattrname);
			leaf.settrainData(trainData);
			leaf.setValue(1);
			return leaf;
		}
		if(zeroes == (ones + zeroes))
		{
			Node leaf = new Node();
			leaf.setHeader(splitattrname);
			leaf.settrainData(trainData);
			leaf.setValue(1);
			return leaf;				
		}
		
		if(ones == 0 && zeroes == 0)
		{
			return null;
		}
		
		else
		{
			double childentropy0 = 0, childentropy1=0,infogain=0;
			String splitattr ="";
			int index = 0;
			double maxgain = 0,splitattren0=0,splitattren1=0;
			for(int i=0;i < atrHeaders.size()-1;i++)
			{
				double positivezero =0, negativezero=0,positiveone=0,negativeone=0,ones1=0,zeroes1=0;
				if(!treeheaders.contains(atrHeaders.get(i)))
				{
					for(List<String> str : trainData)
					{
						int last = str.size() - 1;
						if(Integer.parseInt(str.get(i)) == 1)
							ones1++;
						else
							zeroes1++;
						if(Integer.parseInt(str.get(last)) == 1 && Integer.parseInt(str.get(i)) == 1)
							positiveone++;
						else if(Integer.parseInt(str.get(last)) == 1 && Integer.parseInt(str.get(i)) == 0)
							positivezero++;
						else if(Integer.parseInt(str.get(last)) == 0 && Integer.parseInt(str.get(i)) == 0)
							negativezero++;
						else if(Integer.parseInt(str.get(last)) == 0 && Integer.parseInt(str.get(i)) == 1)							
							negativeone++;
					}
					if(positiveone == 0 || negativeone == 0)
						childentropy1 = 0;				
					else childentropy1 = -(positiveone/(positiveone+negativeone))*calclog(positiveone/(positiveone+negativeone)) +
							-(negativeone/(positiveone+negativeone))* calclog(negativeone/(positiveone+negativeone)) ;
					
					if(positivezero == 0 || negativezero == 0)
						childentropy0 = 0;	
					else childentropy0 = -(positivezero/(positivezero+negativezero))*calclog(positivezero/(positivezero+negativezero)) +
							-(negativezero/(positivezero+negativezero))* calclog(negativezero/(positivezero+negativezero)) ;
					
					double entropy = (ones1/(ones1+zeroes1))*childentropy1 + (zeroes1/(ones1+zeroes1))*childentropy0;
					infogain = classentropy - entropy;
					if(infogain > maxgain)
					{
						maxgain = infogain;
						index = i;
						splitattren0 = childentropy0;
						splitattren1 = childentropy1;
					}
				}
			}
			ArrayList<List<String>> leftnodedata = new ArrayList<List<String>>();
			ArrayList<List<String>> rightnodedata = new ArrayList<List<String>>();
			splitattr = atrHeaders.get(index);
			treeheaders.add(splitattr);
			
			Node n = new Node();
			n.setHeader(atrHeaders.get(index));
			n.settrainData(trainData);
			
			for(List<String> str : trainData)
			{
				if(Integer.parseInt(str.get(index)) == 0)
					leftnodedata.add(str);
				else
					rightnodedata.add(str);
			}
		
		n.setleftChild(GenerateNode(leftnodedata,atrHeaders, treeheaders,splitattren0,splitattr,0));
		n.setrightChild(GenerateNode(rightnodedata,atrHeaders,treeheaders,splitattren1,splitattr,1));
		return n;
		}
	}
	
	public static double calclog(double prob)
	{
		double logvalue = Math.log(prob)/Math.log(2);
		return logvalue;
	}
	
	public static void printTree(Node root, int level)
	{
		if(root == null)
			return;
		if(root.getleftchild()!=null)
		{
			for(int i = 0; i< level; i++)
				System.out.print("  |  ");
			
			String s = "";
			
			if(root.getleftchild().getleftchild() == null)
				s = " : " + root.getleftchild().getValue();
			
			System.out.println(root.getHeader() + " = 0" + s);
		}
		printTree(root.getleftchild(), level + 1);

		if(root.getrightchild()!=null)
		{
			for(int i = 0; i< level; i++)
				System.out.print("  |  ");
				
			String s = "";
				
			if(root.getrightchild().getrightchild() == null)
				s = " : " + root.getrightchild().getValue();
				
			System.out.println(root.getHeader() + " = 1" + s);

			}
		printTree(root.getrightchild(), level + 1);
	}
	public static double calcAccuracy(Node root, String testfile) throws IOException
	{
		String line = "";
		ArrayList<List<String>> testData = new ArrayList<List<String>>();
		double correct = 0, incorrect = 0;
		
		BufferedReader br = new BufferedReader(new FileReader(new File(testfile)));;
	
		String[] attributeheaders = br.readLine().split(",");
		while ((line = br.readLine()) != null) 
		{
			List<String> fileRow;
			String[] elements = line.split(",");
			fileRow = Arrays.asList(elements);
			testData.add(fileRow);
		}
		br.close();
		
		for(int i = 0; i< testData.size(); i++)
		{
			List<String> str = testData.get(i);
			int value = traversetree(str, root, attributeheaders);
			if(value == Integer.parseInt(str.get(str.size()-1)))
				correct++;
			else
				incorrect++;
		}
		double accuracy = correct/(correct + incorrect)* 100;
		return accuracy;
	}
	public static int traversetree(List<String> str, Node node, String[] attributeheaders)
	{
		int val = 0;
		
		if(node == null)
			return 0;
		 
		if(node.getleftchild() == null && node.getrightchild() == null)
			return node.getValue();
		
		else
		{
			String header = node.getHeader();
			for(int i = 0; i< attributeheaders.length; i++)
			{
				if(attributeheaders[i].equals(header))
				{
					val = Integer.parseInt(str.get(i));
					break;
				}
			}
			if(val == 0)
				return traversetree(str, node.getleftchild(), attributeheaders);
			else
				return traversetree(str, node.getrightchild(), attributeheaders);
		}
	}
	public static Node prunetree(Node D, String validationfile, int L, int K) throws IOException
	{
		double bestaccuracy =0;
		Node Dbest = new Node();
		Dbest = copytree(D);
		double accuracy = calcAccuracy(Dbest, validationfile);
		for(int i=1;i<=L;i++)
		{
			Node Ddash = new Node();
			Ddash = copytree(Dbest);
			int M = (1 + (int) (Math.random() * K));
			for(int j=1;j<=M;j++)
			{
				int N = calcNonleafNodes(Ddash);
				ArrayList<Node> nodes = new ArrayList<Node>();
				nodes = orderNodes(nodes,Ddash);
				int P = (1 + (int) (Math.random() * (N-2)));
				Node replaceNode = null;
				if (P != 0 && nodes.size() >= 2) 
				{
					int pos=0,neg=0;
					replaceNode = nodes.get(P);
					//System.out.println("Node to be deleted:"+ replaceNode.attributeHeader);
					Ddash = replaceNode(Ddash, replaceNode);
					//printTree(Ddash, 0);
				}
				bestaccuracy = calcAccuracy(Ddash, validationfile);
				//System.out.println("Accuracy after deleting node :" + bestaccuracy);
				if (bestaccuracy > accuracy)
				{
					Dbest = copytree(Ddash);
					accuracy = bestaccuracy;
					//System.out.println("Node: " + replaceNode.attributeHeader + " deleted");
				}
				//else System.out.println(String.format("Node: %s not deleted since it does not improve the tree",replaceNode.attributeHeader));
			}
		}
		System.out.println(String.format("Accuracy of pruned tree = " + accuracy + " for L = %d and K = %d",L,K));
		return Dbest;
	}
	public static int calcNonleafNodes(Node root)
	{
		if(root == null)
			return 0;
		if(root.getleftchild() == null && root.getrightchild() == null)
			return 1;
		else
		{
			int left = calcNonleafNodes(root.getleftchild());
			int right = calcNonleafNodes(root.getrightchild());		
			return left + right;
		}
	}
	public static Node copytree(Node root)
	{
		Node temp;
		if(root.getleftchild() == null && root.getrightchild() == null)
			temp = new Node(root.gettraindata(),root.getHeader(),root.getValue(),root.getleftchild(),root.getrightchild());
		else
		{
			temp = new Node(root.gettraindata(),root.getHeader(),root.getValue(),root.getleftchild(),root.getrightchild());
			temp.setleftChild(copytree(root.leftChild));
			temp.setrightChild(copytree(root.getrightchild()));
		}
		return temp;
	}
	public static ArrayList<Node> orderNodes(ArrayList<Node> nodes, Node root)
	{
		if(root != null && root.getleftchild() == null && root.getrightchild()== null)
			return nodes;
		else
		{
			nodes.add(root);
			orderNodes(nodes,root.getleftchild());
			orderNodes(nodes,root.getrightchild());
		}
		return nodes;
	}
	public static Node replaceNode(Node root, Node replacenode)
	{
		//int val = 0;
			if(root.leftChild == null || root.rightChild == null)
				return null;
		
			//System.out.println(root);
			if(root.leftChild.attributeHeader == null && root.rightChild.attributeHeader == null)
				return null;
			if(root.leftChild.attributeHeader == replacenode.attributeHeader)
			{
				root.setleftChild(new Node(null,null,0,null,null));
				return root;
			}
			else if(root.rightChild.attributeHeader == replacenode.attributeHeader)
			{
				root.setrightChild(new Node(null,null,1,null,null));
				return root;
			}
			else
			{
				Node node = replaceNode(root.leftChild,replacenode); 
				if(node == null)
					node = replaceNode(root.rightChild,replacenode);
				return root;
			}
		
	}
}
