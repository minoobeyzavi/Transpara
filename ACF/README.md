#### Application Configuration File (ACF)
There may be aspects of your distributed application that affect one component, but have nothing to do with another. For example, an object may contain a large, complex data structure and pass the contents of this data structure to another object. The exact layout of this data structure may be meaningless to the receiving application. Also, the structure may contain data types that the MIDL compiler does not recognize and cannot generate marshaling and unmarshaling code.
Client applications may share the same interface but run on different platforms; they may each need their own set of marshaling routines. Finally, individual clients may not always need the same set of functions. It is inefficient to generate stub code for functions that will never be implemented in a particular client application.
By defining these local aspects of your interface in an application configuration file (ACF), you can separate the differences between the client interfaces from their network representation, allowing the server to send and receive data in a consistent format, and making your stub code more compact and efficient.
The structure and syntax of an ACF interface definition are identical to the IDL definition:
```
[ interface-attribute-list] interface interface-name {. . .}
```
 
[ACF Attributes](https://msdn.microsoft.com/en-us/library/windows/desktop/aa366717(v=vs.85).aspx)</br>
[What is an ACF File?](https://www.lifewire.com/acf-file-2619468)</br>
[Programs that can open .acf files](http://extension.nirsoft.net/acf)