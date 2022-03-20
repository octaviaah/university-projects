#include <stdio.h>
#include <string.h>

int search(char sir[], char sirR[], int length);

int main()
{	
	printf("%s", "Type the first word: ");
	char first_word[100];
	int i;
	char second_word[100] = " ";
	char second_word_part[100] = "";
	scanf("%s", first_word);
	printf("%s\n", "Type $ to end the program.");
	while(1)
	{	
		printf("%s", "Type another word: ");
		scanf("%s", second_word);
		if (strcmp(second_word, "$") == 0) { printf("%s\n", "Bye!"); break; }
		if(strlen(second_word) < strlen(first_word))
			printf("%s\n", "No, the first word is not a subsequence of this one, because it is longer.");
		else
			for ( i = 0; i <= strlen(second_word) - strlen(first_word); i++)
			{
				strncpy(second_word_part, second_word + i, strlen(first_word));
				int rez = search(first_word, second_word_part, strlen(first_word));
				//printf("%d\n", rez);
				if (rez)
				{
					printf("%s\n", "The first word appears as a subsequence of this word.");
					break;
				}
			}
		if(i> strlen(second_word) - strlen(first_word))
			printf("%s\n", "No, the first word is not a subsequence of this one.");

	}
	//printf("%s\n", "end");
	return 0;
}