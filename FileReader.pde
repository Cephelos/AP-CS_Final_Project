import java.io.*;


BufferedReader reader;
public String[] a = new String[6];
String line;


void fileReader() {

  try {
    for (int i = 0; i < a.length; i++) {
      a[i] = reader.readLine();
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  try {
    reader.close();
  }
  catch(IOException e) {
  }
}

void fileWriter(String fileName, String playerName, int score) {

  String[] a = loadStrings(fileName);
  //System.out.println("help");
  String[] splitStr;
  for (int i = 1; i < a.length; i++) {
    splitStr = a[i].split(": ");

    if ((Integer.parseInt(splitStr[1])) <score) {
      a[i] = playerName + ": " + score;
      break;
    }
  }

  saveStrings("scores.txt", a);
  flush();
  // The name of the file to open.
}