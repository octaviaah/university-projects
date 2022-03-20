#include <stdio.h>

int main(int argc, char** argv){
	int i
	printf("Some C code succesfully compiled and running here. \n");
	if (argc<2)
		printf("The program has no arguments\n");
	else 
		for (i=1; i<argc; i++)
			printf("Arg[%d]=%s, ",i, argv[i]);
	printf("\n");
	return 0; 
}