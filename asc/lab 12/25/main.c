
#include <stdio.h>

int maxim(int a, int b);

int main()
{
    int sir[100], n, i, maximum;
    printf("n=");
    scanf("%d", &n);
    scanf("%d", &sir[0]);
    maximum = sir[0];
    for (i=1; i<n; i++)
    {
        scanf("%d", &sir[i]);
        maximum = maxim(sir[i], maximum);
    }
    FILE *fp;
    fp = fopen("max.txt", "w");
    fprintf(fp, "the maximum is: %x", maximum);
    fclose(fp);
    return 0;
}