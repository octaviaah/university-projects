#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
#include <malloc.h>
#include <pthread.h>

void * function(void* ptr);
 
int main() {
  int s;
  struct sockaddr_in server, client;
  int c, l;
  pthread_t thr;  
  s = socket(AF_INET, SOCK_STREAM, 0);
  if (s < 0) {
    printf("Eroare la crearea socketului server\n");
    return 1;
  }
  
  memset(&server, 0, sizeof(server));
  server.sin_port = htons(1234);
  server.sin_family = AF_INET;
  server.sin_addr.s_addr = INADDR_ANY;
  
  if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) {
    printf("Eroare la bind\n");
    return 1;
  }
 
  listen(s, 5);
  
  l = sizeof(client);
  memset(&client, 0, sizeof(client));
  
  while (1) {
    c = accept(s, (struct sockaddr *) &client, &l);
    printf("S-a conectat un client.\n");

	int* arg= (int*)malloc(sizeof(int));
	*arg=c;
	// deservirea clientului
	pthread_create(&thr,NULL,function,(void*)arg);
	// sfarsitul deservirii clientului;
  }
}

void * function(void* ptr)
{
	uint16_t a,b,suma;
	int c=*(int*)ptr;
	recv(c, &a, sizeof(a), MSG_WAITALL);
	recv(c, &b, sizeof(b), MSG_WAITALL);
	a = ntohs(a);
	b = ntohs(b);
	suma = a + b;
	suma = htons(suma);
	send(c, &suma, sizeof(suma), 0);
	close(c);
	free(ptr);
}
