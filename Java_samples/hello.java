package glwsses1.Java_samples;
public class hello{
    public static void main(String args[]){
        System.out.println("Hello Java");
        int [] a = new int [660];
        int i = 0;
        while(i < a.length){
            a[i] = 42;
            i++;
        }
        System.out.println(a[50]);
    }
}
