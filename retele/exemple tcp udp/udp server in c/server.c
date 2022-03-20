#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

int main() {
  int s;
  struct sockaddr_in server, client;
  int c, l;
  printf("Creating socket...\n");
  s = socket(AF_INET, SOCK_DGRAM, 0);
  if (s < 0) {
    printf("Eroare la crearea socketului server\n");
    return 1;
  }
  else printf("Socket created successfully!\n");
  server.sin_family = AF_INET;
  server.sin_port = htons(7777);
  server.sin_addr.s_addr = inet_addr("0.0.0.0");

  if (bind(s, &server, sizeof(struct sockaddr_in)) < 0) {
    printf("Eroare la bind\n");
    return 1;
  }

  while (1)
  {
        l = sizeof(client);
        memset(&client, 0, sizeof(client));
        printf("Waiting for a client to connect...\n");
        uint16_t a, b, suma;
        printf("Waiting to receive the data...\n");
        recvfrom(s, &a, sizeof(a), MSG_WAITALL, (struct sockaddr*) &client, &l);
        recvfrom(s, &b, sizeof(b), MSG_WAITALL, (struct sockaddr*) &client, &l);
        a = ntohs(a);
        b = ntohs(b);
        suma = a + b;
        printf("Received '%hu' and '%hu'\n", a, b, suma);
        printf("Sending '%hu' to client...\n", suma);
        suma = htons(suma);
        sendto(s, &suma, sizeof(suma), 0, (struct sockaddr*) &client, &l);
        printf("Sum sent to client\n");
        printf("Closing connection...\n");
  }
  close(s);
}